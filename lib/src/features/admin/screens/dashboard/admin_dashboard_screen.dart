import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/routes/router.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/features/admin/widgets/custom_card_widget.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
import 'package:flutter/material.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({super.key});

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen>
    with RouteAware {
  int categorisCount = 0;
  int userCount = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoriesCount();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to the RouteObserver
    routeObserver.subscribe(
      this,
      ModalRoute.of(context)! as PageRoute<dynamic>,
    );
  }

  @override
  void dispose() {
    // Unsubscribe from the RouteObserver
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // This method is called when the current route is popped back to
    getCategoriesCount();
  }

  Future<void> getCategoriesCount() async {
    setState(() => isLoading = true);
    categorisCount = await FirestoreService.instance.getDocumentCount(
      'categories',
    );

    userCount = await FirestoreService.instance.getDocumentCount(
      'users',
    );

    setState(() => isLoading = false);
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
                    CustomCardWidget(
                      isLoading: isLoading,
                      count: 0,
                      text: 'Pending',
                    ),
                    CustomCardWidget(
                      isLoading: isLoading,
                      count: 0,
                      text: 'Approved',
                    ),
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
                    CustomCardWidget(
                      isLoading: isLoading,
                      count: userCount,
                      text: 'Users',
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteConstants.viewAllUsersScreenRoute,
                      ),
                    ),
                    CustomCardWidget(
                      isLoading: isLoading,
                      count: 0,
                      text: 'Merchants',
                    ),
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
                    CustomCardWidget(
                      isLoading: isLoading,
                      count: categorisCount,
                      text: 'Categories',
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteConstants.viewCategoresScreenRoute,
                      ),
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
}
