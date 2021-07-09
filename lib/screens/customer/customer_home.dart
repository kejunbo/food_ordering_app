import 'package:flutter/material.dart';

import 'account/ui/page/account_settings_screen.dart';
import 'cart/ui/page/cart_screen.dart';
import 'dashboard/ui/page/dashboard_screen.dart';
import 'order_history/ui/page/order_history_screen.dart';

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  final _pageList = [
    DashboardScreen(),
    CartScreen(),
    OrderHistoryScreen(),
    AccountSettingsScreen(),
  ];

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pageList,
        index: _currentIndex
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard, color: Colors.white),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.white),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings, color: Colors.white),
            label: 'Account',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}