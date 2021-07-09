import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/admin/order/ui/page/orders_screen.dart';
import 'package:food_ordering_app/screens/admin/shop/ui/page/shop_screen.dart';
import 'package:food_ordering_app/screens/customer/account/ui/page/account_settings_screen.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final _pageList = [
    OrdersScreen(),
    ShopScreen(),
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
      body: IndexedStack(children: _pageList, index: _currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt, color: Colors.white),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store, color: Colors.white),
            label: 'Shop',
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
