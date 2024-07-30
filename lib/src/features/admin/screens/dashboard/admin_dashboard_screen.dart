import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/core/routes/router.dart';
import 'package:ecommerce/src/core/service/firebase_service.dart';
import 'package:ecommerce/src/features/admin/service/admin_service.dart';
import 'package:ecommerce/src/shared/widgets/log_out_widget.dart';

class AdminDashBoardScreen extends StatefulWidget {
  const AdminDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashBoardScreen> createState() => _AdminDashBoardScreenState();
}

class _AdminDashBoardScreenState extends State<AdminDashBoardScreen>
    with RouteAware {
  int categoriesCount = 0;
  int brandCount = 0;
  int userCount = 0;

  int merchantCount = 0;
  int approvedShops = 0;
  int pendingShops = 0;

  bool isLoading = false;
  bool isSeedDataLoading = false;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
        this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    setState(() => isLoading = true);

    categoriesCount =
        await FirebaseService.instance.getDocumentCount('categories');
    brandCount = await FirebaseService.instance.getDocumentCount('brands');
    userCount = await FirebaseService.instance.getDocumentCount('users');
    merchantCount =
        await FirebaseService.instance.getDocumentCount('merchants');

    Map<String, dynamic> shopsData =
        await AdminService.instance.fetchShopsStatus();
    approvedShops = shopsData['approved'];
    pendingShops = shopsData['pending'];

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin', style: TextStyle(fontSize: 26)),
        actions: const [
          LogOutWidget(),
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: 'Create',
                      children: [
                        _buildAddWidget(
                          text: 'Categories',
                          onTap: () => navigateUser(
                            RouteConstants.addOrEditCategoryScreenRoute,
                          ),
                        ),
                        _buildAddWidget(
                          text: 'Brands',
                          onTap: () => navigateUser(
                            RouteConstants.addOrEditBrandsScreenRoute,
                          ),
                        ),
                      ],
                    ),
                    _buildSection(title: 'View', children: [
                      _buildAddWidget(
                        text: 'Categories',
                        count: categoriesCount,
                        onTap: () => navigateUser(
                          RouteConstants.viewCategoresScreenRoute,
                        ),
                      ),
                      _buildAddWidget(
                        text: 'Brands',
                        count: brandCount,
                        onTap: () => navigateUser(
                          RouteConstants.viewBrandsScreenRoute,
                        ),
                      ),
                      _buildAddWidget(
                        text: 'Users',
                        iconData: Icons.grid_view_outlined,
                        onTap: () => navigateUser(
                          RouteConstants.viewAllUsersScreenRoute,
                        ),
                      ),
                      _buildAddWidget(
                        text: 'Merchants',
                        iconData: Icons.grid_view_outlined,
                        onTap: () => navigateUser(
                          RouteConstants.viewAllMerchantsScreenRoute,
                        ),
                      ),
                    ]),
                    _buildSection(title: 'Shops', children: [
                      _buildAddWidget(
                        text: 'Active',
                        count: approvedShops,
                        onTap: () => navigateUser(
                          RouteConstants.shopsScreenRoute,
                        ),
                      ),
                      _buildAddWidget(
                        text: 'Pending',
                        count: pendingShops,
                        onTap: () => navigateUser(
                          RouteConstants.pendingShopsScreenRoute,
                        ),
                      ),
                    ]),
                    _buildSection(
                        title: 'Seed Initial Data to Firestore',
                        children: [
                          _buildAddWidget(
                            text: 'Categories',
                            iconData: categoriesCount > 0
                                ? Icons.check
                                : Icons.play_arrow_outlined,
                            isLoading: isSeedDataLoading && selectedIndex == 9,
                            onTap: categoriesCount != 0
                                ? null
                                : () async {
                                    _handleSeedDataLoading(
                                        index: 9, isCategories: true);
                                  },
                          ),
                          _buildAddWidget(
                            text: 'Brands',
                            isLoading: isSeedDataLoading && selectedIndex == 10,
                            iconData: brandCount > 0
                                ? Icons.check
                                : Icons.play_arrow_outlined,
                            onTap: brandCount != 0
                                ? null
                                : () async {
                                    _handleSeedDataLoading(index: 10);
                                  },
                          ),
                        ]),
                  ],
                ),
              ),
      ),
    );
  }

  void _handleSeedDataLoading(
      {required int index, bool isCategories = false}) async {
    setState(() {
      selectedIndex = index;
      isSeedDataLoading = true;
    });

    await AdminService.instance.uploadData(isCategories: isCategories);

    setState(() {
      isSeedDataLoading = false;
      selectedIndex = -1;
    });
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        Wrap(runSpacing: 20, spacing: 20, children: children),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
      ],
    );
  }

  void navigateUser(String route) {
    switch (route) {
      case RouteConstants.viewCategoresScreenRoute:
        Navigator.pushNamed(context, RouteConstants.viewCategoresScreenRoute);
        break;

      case RouteConstants.viewBrandsScreenRoute:
        Navigator.pushNamed(
          context,
          RouteConstants.viewCategoresScreenRoute,
          arguments: true,
        );
        break;

      case RouteConstants.shopsScreenRoute:
        Navigator.pushNamed(
          context,
          RouteConstants.shopsScreenRoute,
          arguments: true,
        );
        break;

      case RouteConstants.pendingShopsScreenRoute:
        Navigator.pushNamed(
          context,
          RouteConstants.shopsScreenRoute,
          arguments: false,
        );
        break;

      case RouteConstants.viewAllMerchantsScreenRoute:
        Navigator.pushNamed(
            context, RouteConstants.viewAllMerchantsScreenRoute);
        break;

      case RouteConstants.viewAllUsersScreenRoute:
        Navigator.pushNamed(context, RouteConstants.viewAllUsersScreenRoute);
        break;

      case RouteConstants.addOrEditCategoryScreenRoute:
        Navigator.pushNamed(
          context,
          RouteConstants.addOrEditCategoryScreenRoute,
        );
        break;

      case RouteConstants.addOrEditBrandsScreenRoute:
        Navigator.pushNamed(
          context,
          RouteConstants.addOrEditCategoryScreenRoute,
          arguments: true,
        );
        break;
    }
  }

  Widget _buildAddWidget({
    required String text,
    Function()? onTap,
    IconData iconData = Icons.add,
    int? count,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        height: 40,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.amber,
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              color: Colors.indigoAccent,
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : count != null
                        ? Text(
                            count.toString(),
                            style: const TextStyle(
                                fontSize: 22, color: Colors.white),
                          )
                        : Icon(iconData, size: 30, color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
