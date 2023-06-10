import 'package:flutter/material.dart';
import 'package:onno_rokom/pages/category_page.dart';
import 'package:onno_rokom/pages/dashbord_page.dart';
import 'package:onno_rokom/pages/launcher_page.dart';
import 'package:onno_rokom/pages/login_page.dart';
import 'package:onno_rokom/pages/new_product_page.dart';
import 'package:onno_rokom/pages/product_details_page.dart';
import 'package:onno_rokom/pages/product_page.dart';
import 'package:onno_rokom/pages/report_pages.dart';
import 'package:onno_rokom/pages/settings_page.dart';
import 'package:onno_rokom/pages/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: LauncherPage.routeName,
      routes: {
        DashboradPage.routeName: (_) => DashboradPage(),
        LauncherPage.routeName: (_) => LauncherPage(),
        LoginPage.routeName: (_) => LoginPage(),
        CategoryPage.routeName: (_) => CategoryPage(),
        NewProductPage.routeName: (_) => NewProductPage(),
        ProductPage.routeName: (_) => ProductPage(),
        ProductDetailsPage.routeName: (_) => ProductDetailsPage(),
        ReportPage.routeName: (_) => ReportPage(),
        Settings.routeName: (_) => Settings(),
        User.routeName: (_) => User(),
        
      },
    );
  }
}


