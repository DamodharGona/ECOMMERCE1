import 'package:ecommerce/src/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:ecommerce/src/core/utils/extensions/string_extensions.dart';
import 'package:ecommerce/src/features/admin/service/admin_service.dart';
import 'package:ecommerce/src/shared/model/dropdown_model.dart';
import 'package:ecommerce/src/shared/model/merchant_model.dart';
import 'package:ecommerce/src/shared/service/common_service.dart';

class ShopsScreen extends StatefulWidget {
  final bool isApprovalScreen;
  const ShopsScreen({super.key, required this.isApprovalScreen});

  @override
  State<ShopsScreen> createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  List<MerchantModel> merchantsList = [];
  List<DropdownModel> statesList = [];

  bool isLoading = false;
  bool isApprovalLoading = false;
  int selectedIndex = -1;

  @override
  void initState() {
    fetchShopsData();
    super.initState();
  }

  Future<void> fetchShopsData() async {
    setState(() => isLoading = true);
    statesList = await CommonService.instance.fetchAllStates();
    merchantsList = await AdminService.instance.fetchAllShops(
      isApproved: widget.isApprovalScreen,
    );
    setState(() => isLoading = false);
  }

  Future<void> updateStatus({
    required String docId,
    required bool approved,
    required int index,
  }) async {
    try {
      setState(() {
        isApprovalLoading = true;
        selectedIndex = index;
      });

      await AdminService.instance.approveOrRejectShop(
        approve: approved,
        id: docId,
      );

      if (mounted) {
        showSnackBar(context: context, content: 'Shop Approved Successfully');
        fetchShopsData();
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context: context, content: e.toString());
      }
    } finally {
      setState(() {
        isApprovalLoading = false;
        selectedIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isApprovalScreen ? 'Approved Stores' : 'Pending Approval',
        ),
        actions: [
          IconButton(
            onPressed: fetchShopsData,
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: isLoading
          ? _ShimmerListTile()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: merchantsList.length,
              itemBuilder: (context, index) {
                final merchant = merchantsList[index];
                final store = merchant.store;
                final state = statesList.firstWhere(
                  (state) => state.id.isEqualTo(store.stateId),
                  orElse: () => const DropdownModel(),
                );
                return ListTile(
                  titleAlignment: ListTileTitleAlignment.top,
                  title: Text(store.name),
                  subtitle: Text(
                    "${store.pinCode}, ${state.value}",
                  ),
                  trailing: Visibility(
                    visible: widget.isApprovalScreen == false,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        isApprovalLoading && selectedIndex == index
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : GestureDetector(
                                onTap: () => updateStatus(
                                  docId: store.id,
                                  approved: true,
                                  index: index,
                                ),
                                child: Container(
                                  height: 40,
                                  color: Colors.green,
                                  padding: const EdgeInsets.all(10),
                                  child: const Center(
                                    child: Text(
                                      'Approve',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _ShimmerListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            title: Container(
              width: 50,
              height: 20.0,
              color: Colors.white,
            ),
            subtitle: Container(
              width: 50,
              height: 20.0,
              color: Colors.white,
              margin: const EdgeInsets.only(top: 5.0),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 50,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
