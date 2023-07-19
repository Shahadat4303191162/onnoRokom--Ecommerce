import 'package:flutter/material.dart';
import 'package:onno_rokom/pages/order_list_page.dart';
import 'package:onno_rokom/providers/order_provider.dart';
import 'package:onno_rokom/utils/constants.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  static const String routeName = '/order';
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Column(
                   children: [
                     Text('Today',style: Theme.of(context).textTheme.headline6,),
                     const SizedBox(height: 5,),
                     const Divider(height: 2,color: Colors.black),
                     const SizedBox(height: 5,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         Column(
                           children: [
                             const Text ('Total Order'),
                             const SizedBox(height: 5,),
                             Text('${provider.getFilteredListBySingleDay(DateTime.now()).length}',style: Theme.of(context).textTheme.headline5)
                           ],
                         ),
                         Column(
                           children: [
                             const Text ('Total Sell'),
                             const SizedBox(height: 5,),
                             Text('$currencysymbol ${provider.getTotalSaleBySingleDate(DateTime.now())}',style: Theme.of(context).textTheme.headline5)
                           ],
                         ),
                       ],
                     ),
                     TextButton(
                         onPressed: () =>
                             Navigator.pushNamed(
                               context,
                               OrderListPage.routeName,
                         arguments: OrderFilter.TODAY,),
                         child: const Text('View All'),
                     ),
                   ],
                 )
              ),
            const SizedBox(height: 15,),
            Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Text('Yesterday',style: Theme.of(context).textTheme.headline6,),
                    const SizedBox(height: 5,),
                    const Divider(height: 2,color: Colors.black),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text ('Total Order'),
                            const SizedBox(height: 5,),
                            Text('${provider
                                .getFilteredListBySingleDay(DateTime.now()
                                .subtract(const Duration(days: 1))).length}',
                            style: Theme.of(context).textTheme.headline5,)
                          ],
                        ),
                        Column(
                          children: [
                            const Text ('Total Sell'),
                            const SizedBox(height: 5,),
                            Text('$currencysymbol ${provider.getTotalSaleBySingleDate(DateTime.now().subtract(const Duration(days: 1)))}',
                                style: Theme.of(context).textTheme.headline5)
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(
                            context,
                            OrderListPage.routeName,
                            arguments: OrderFilter.YESTERDAY,),
                      child: const Text('View All'),
                    ),
                  ],
                )
            ),
            const SizedBox(height: 15,),
            Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Text('Last 7 days',style: Theme.of(context).textTheme.headline6,),
                    const SizedBox(height: 5,),
                    const Divider(height: 2,color: Colors.black),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text ('Total Order'),
                            const SizedBox(height: 5,),
                            Text('${provider.getFilteredListByWeek(DateTime.now().subtract(const Duration(days: 7))).length}',
                                style: Theme.of(context).textTheme.headline5)
                          ],
                        ),
                        Column(
                          children: [
                            const Text ('Total Sell'),
                            const SizedBox(height: 5,),
                            Text('$currencysymbol ${provider.getTotalSaleByWeek(DateTime.now().subtract(const Duration(days: 7)))}',
                                style: Theme.of(context).textTheme.headline5)
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(
                            context,
                            OrderListPage.routeName,
                            arguments: OrderFilter.SEVER_DAYS,),
                      child: const Text('View All'),
                    ),
                  ],
                )
            ),
            const SizedBox(height: 15,),
            Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Text('This Month',style: Theme.of(context).textTheme.headline6,),
                    const SizedBox(height: 5,),
                    const Divider(height: 2,color: Colors.black),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text ('Total Order'),
                            const SizedBox(height: 5,),
                            Text('${provider.getFilteredListByMonth(DateTime.now()).length}',
                                style: Theme.of(context).textTheme.headline5)
                          ],
                        ),
                        Column(
                          children: [
                            const Text ('Total Sell'),
                            const SizedBox(height: 5,),
                            Text('$currencysymbol ${provider.getTotalSaleByMonth(DateTime.now())}',
                                style: Theme.of(context).textTheme.headline5)
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(
                            context,
                            OrderListPage.routeName,
                            arguments: OrderFilter.THIS_MONTH,),
                      child: const Text('View All'),
                    ),
                  ],
                )
            ),
            const SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }
}
