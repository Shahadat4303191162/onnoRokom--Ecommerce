import 'package:flutter/material.dart';

class DashboradPage extends StatelessWidget {
  static const String routeName = '/dashboard';
  const DashboradPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
    );
  }
}
