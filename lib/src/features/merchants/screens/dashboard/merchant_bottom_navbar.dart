import 'package:ecommerce/src/features/merchants/service/merchant_service.dart';
import 'package:ecommerce/src/shared/model/merchant_model.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
import 'package:ecommerce/src/shared/widgets/log_out_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ecommerce/src/features/merchants/screens/dashboard/merchant_dashboard_screen.dart';
import 'package:ecommerce/src/features/merchants/screens/orders/merchant_orders_screen.dart';
import 'package:ecommerce/src/features/merchants/screens/products/merchant_product_screen.dart';

class MerchantBottomNavbar extends StatefulWidget {
  const MerchantBottomNavbar({Key? key}) : super(key: key);

  @override
  State<MerchantBottomNavbar> createState() => _MerchantBottomNavbarState();
}

class _MerchantBottomNavbarState extends State<MerchantBottomNavbar> {
  int _selectedIndex = 0;
  bool isLoading = true;

  MerchantModel merchantStore = const MerchantModel();

  bool showLayout = false;
  bool? hasDataFromSharedPrefs;

  static const List<Widget> _pages = <Widget>[
    MerchantDashboardScreen(),
    MerchantProductScreen(),
    MerchantOrdersScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    fetchDataFromSharedPrefs();
    super.initState();
  }

  Future<void> fetchDataFromSharedPrefs() async {
    setState(() => isLoading = true);

    hasDataFromSharedPrefs =
        await AppSharedPrefs.instance.getMerchantApprovalStatus();

    if (hasDataFromSharedPrefs != null) {
      showLayout = hasDataFromSharedPrefs!;

      merchantStore = await AppSharedPrefs.instance.getMerchantData();

      if (merchantStore.store.id.isEmpty || merchantStore.id.isEmpty) {
        merchantStore = await MerchantService.instance.fetchStoreDetails();
      }
    } else {
      await fetchMerchantStatus();
    }

    setState(() => isLoading = false);
  }

  Future<void> fetchMerchantStatus() async {
    merchantStore = await MerchantService.instance.fetchStoreDetails();
    showLayout = merchantStore.store.isStoreVerified;

    AppSharedPrefs.instance.setMerchantData(merchantModel: merchantStore);

    AppSharedPrefs.instance.setMerchantApprovalStatus(
      status: merchantStore.store.isStoreVerified,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : showLayout
              ? _pages[_selectedIndex]
              : SafeArea(
                  child: Stack(
                    children: [
                      Positioned(
                        right: 10,
                        top: 0,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: fetchMerchantStatus,
                              icon: const Icon(
                                Icons.refresh,
                                size: 30,
                              ),
                            ),
                            const LogOutWidget(),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              color: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('hi ${merchantStore.name}'),
                                      const Text(
                                        'you account is sent for verification, please wait until verification',
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'We will reach out to the following address',
                                      ),
                                      const SizedBox(height: 20),
                                      Text(merchantStore.store.address1),
                                      Text(merchantStore.store.stateId),
                                      Text(merchantStore.store.pinCode
                                          .toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: Visibility(
        visible: showLayout,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/action_key.svg',
                width: 26,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? Colors.indigoAccent : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Products',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Orders',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigoAccent,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
