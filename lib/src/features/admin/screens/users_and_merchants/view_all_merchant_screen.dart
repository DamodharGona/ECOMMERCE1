import 'package:ecommerce/src/features/admin/service/admin_service.dart';
import 'package:ecommerce/src/shared/model/user_model.dart';
import 'package:flutter/material.dart';

class ViewAllMerchantsScreen extends StatefulWidget {
  const ViewAllMerchantsScreen({super.key});

  @override
  State<ViewAllMerchantsScreen> createState() => _ViewAllMerchantsScreenState();
}

class _ViewAllMerchantsScreenState extends State<ViewAllMerchantsScreen> {
  List<UserModel> merchantsList = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    merchantsList = await AdminService.instance.fetchAllMerchants();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('merchants'),
      ),
      body: ListView.builder(
        itemCount: merchantsList.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Text(
              merchantsList[index].name[0],
              style: const TextStyle(fontSize: 20),
            ),
          ),
          title: Text(merchantsList[index].name),
          subtitle: Text(merchantsList[index].emailId),
        ),
      ),
    );
  }
}
