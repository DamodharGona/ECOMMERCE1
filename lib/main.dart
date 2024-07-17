import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/src/core/routes/route_constants.dart';
import 'package:ecommerce/src/shared/providers/auth_provider.dart';
import 'package:ecommerce/src/shared/service/app_shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce/src/core/routes/router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await AppSharedPrefs.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
        ),
      ),
      onGenerateRoute: Routes.generateRoute,
      navigatorObservers: [routeObserver],
      initialRoute: RouteConstants.initialRoute,
    );
  }
}
