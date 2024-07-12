import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/features/admin/screens/auth/admin_login_screen.dart';
import 'package:ecommerce/src/features/admin/screens/categories/add_edit_category_screen.dart';
import 'package:ecommerce/src/features/admin/screens/categories/view_categores_screen.dart';
import 'package:ecommerce/src/features/admin/screens/dashboard/admin_dashboard_screen.dart';
import 'package:ecommerce/src/features/admin/screens/users_and_merchants/view_all_users_screen.dart';
import 'package:ecommerce/src/features/merchants/auth/screens/merchant_login_screen.dart';
import 'package:ecommerce/src/features/merchants/auth/screens/merchant_register_screen.dart';
import 'package:ecommerce/src/features/user/screens/auth/user_login_screen.dart';
import 'package:ecommerce/src/features/user/screens/auth/user_register_screen.dart';
import 'package:ecommerce/src/features/user/screens/dashboard/user_dashboard_screen.dart';
import 'package:ecommerce/src/shared/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.initialRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      /* USER ROUTES */
      case RouteConstants.userLoginScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const UserLoginScreen(),
        );

      case RouteConstants.userRegisterScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const UserRegisterScreen(),
        );

      case RouteConstants.userDashboardScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const UserDashboardScreen(),
        );

      /* MERCHANT ROUTES */
      case RouteConstants.merchantLoginScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const MerchantLoginScreen(),
        );
      case RouteConstants.merchantRegisterScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const MerchantRegisterScreen(),
        );

      /* ADMIN ROUTES */
      case RouteConstants.adminLoginScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const AdminLoginScreen(),
        );

      case RouteConstants.adminDashboardScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const AdminDashBoardScreen(),
        );

      case RouteConstants.addOrEditCategoryScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const AddEditCategoryScreen(),
        );

      case RouteConstants.viewCategoresScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const ViewCategoresScreen(),
        );

      case RouteConstants.viewAllUsersScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const ViewAllUsersScreen(),
        );

      /* DEFAULT ROUTES */
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
