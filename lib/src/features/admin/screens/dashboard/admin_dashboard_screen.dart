import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
import 'package:flutter/material.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({super.key});

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen> {
  int categorisCount = 0;
  int userCount = 0;

  @override
  void initState() {
    super.initState();
    getCategoriesCount();
  }

  Future<void> getCategoriesCount() async {
    categorisCount = await FirestoreService.instance.getDocumentCount(
      'categories',
    );

    userCount = await FirestoreService.instance.getDocumentCount(
      'users',
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin',
          style: TextStyle(fontSize: 26),
        ),
        actions: [
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {
              AppSharedPrefs.instance.setCurrentUser('');
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteConstants.adminLoginScreenRoute,
                (route) => false,
              );
            },
            icon: const Icon(Icons.power_settings_new_outlined, size: 30),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Merchant's Shop Approval",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCard(title: '0', subTitle: 'Pending'),
                    CustomCard(title: '0', subTitle: 'Approved'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "User's & Merchants",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCard(title: userCount.toString(), subTitle: 'Users'),
                    CustomCard(title: '0', subTitle: 'Merchants'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteConstants.addOrEditCategoryScreenRoute,
                      ),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: const [5, 10],
                        radius: const Radius.circular(12),
                        child: const SizedBox(
                          width: 195,
                          height: 120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'New Category',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CustomCard(
                      title: categorisCount.toString(),
                      subTitle: 'Categories',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget CustomCard({
    required String title,
    required String subTitle,
  }) {
    return Container(
      width: 200,
      height: 130,
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 50),
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
