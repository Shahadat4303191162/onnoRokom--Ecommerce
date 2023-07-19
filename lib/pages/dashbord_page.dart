
import 'package:flutter/material.dart';
import 'package:onno_rokom/models/dashboard_item_model.dart';
import 'package:onno_rokom/pages/category_page.dart';
import 'package:onno_rokom/pages/order_page.dart';
import 'package:onno_rokom/pages/product_page.dart';
import 'package:onno_rokom/pages/report_pages.dart';
import 'package:onno_rokom/pages/settings_page.dart';
import 'package:onno_rokom/pages/user_page.dart';
import 'package:onno_rokom/providers/order_provider.dart';
import 'package:onno_rokom/providers/product_porvider.dart';
import 'package:onno_rokom/widgets/dashboard_item_view.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    Provider.of<ProductProvider>(context,listen: false).getAllCategories();
    Provider.of<ProductProvider>(context,listen: false).getAllProducts();
    Provider.of<OrderProvider>(context,listen: false).getAllOrders();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dash board'),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: dashboardItem.length,
          itemBuilder: (context,index) => DashboardItemView(
              item: dashboardItem[index],
              onPressed: (value){
                final route = navigate(value);
                Navigator.pushNamed(context, route);
              },
          ),
      ),
    );
  }

  navigate(String value) {
    String route = '';
    switch(value){
      case DashboardItem.product:
        route = ProductPage.routeName;
        break;
      case DashboardItem.category:
        route = CategoryPage.routeName;
        break;
      case DashboardItem.order:
        route = OrderPage.routeName;
        break;
      case DashboardItem.user:
        route = User.routeName;
        break;
      case DashboardItem.setting:
        route = Settings.routeName;
        break;
      case DashboardItem.report:
        route = ReportPage.routeName;
        break;
    }
    return route;

  }
}
