import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_ordering_app/core/common/custom_shimmer.dart';
import 'package:food_ordering_app/screens/customer/cart/model/view_model/cart_model.dart';
import 'package:food_ordering_app/screens/customer/dashboard/model/view_model/restaurant_model.dart';
import 'package:food_ordering_app/screens/customer/dashboard/ui/widget/restaurant_card.dart';
import 'package:food_ordering_app/screens/customer/retaurant/ui/widget/food_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = "dashboardScreen";
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final RestaurantModel _model = new RestaurantModel();
  CartModel _cartModel;

  @override
  void initState() {
    super.initState();
    _model.init();
    _cartModel = Provider.of<CartModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Consumer<RestaurantModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Dashboard"),
            ),
            body: model.isLoading
                ? Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomShimmer(),
                  )
                : SafeArea(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        if (model.restaurant?.imageUrl?.isNotEmpty ?? false) Image.network(model.restaurant.imageUrl),
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: Column(
                            children: [
                              Text(
                                model.restaurant?.name ?? "-",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(model.restaurant.address ?? "-"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Food",
                                  style: TextStyle(color: Colors.white, fontSize: 15),
                                ),
                              ),
                              SizedBox(height: 5),
                              Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              if (model.isLoading) CustomShimmer(),
                              if (!model.isLoading && model.foodList.isEmpty)
                                Center(
                                  child: Text(
                                    "- This restaurant has not uploaded any food yet -",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              if (!model.isLoading && model.foodList.isNotEmpty)
                                ...model.foodList
                                    .map((food) => Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15),
                                          child: FoodCard(
                                            food: food,
                                            count: _cartModel.getFoodCountById(food.id),
                                            incrementCallback: () {
                                              _cartModel.addFood(food, context);
                                              setState(() {});
                                            },
                                            decrementCallback: () {
                                              _cartModel.removeFood(food, context);
                                              setState(() {});
                                            },
                                          ),
                                        ))
                                    .toList()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
