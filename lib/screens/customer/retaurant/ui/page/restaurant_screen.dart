import 'package:flutter/material.dart';
import 'package:food_ordering_app/core/common/custom_shimmer.dart';
import 'package:food_ordering_app/screens/customer/cart/model/view_model/cart_model.dart';
import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/view_model/food_model.dart';
import 'package:food_ordering_app/screens/customer/retaurant/ui/widget/food_card.dart';
import 'package:provider/provider.dart';

class RestaurantScreenArgs {
  final Restaurant restaurant;
  RestaurantScreenArgs({this.restaurant});
}

class RestaurantScreen extends StatefulWidget {
  static const String routeName = "restaurantScreen";

  final RestaurantScreenArgs args;
  const RestaurantScreen({Key key, this.args}) : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  CartModel _cartModel;
  FoodModel _model;

  @override
  void initState() {
    super.initState();
    _model = new FoodModel(restaurant: widget.args.restaurant);
    _model.init();
    _cartModel = Provider.of<CartModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.args.restaurant.name),
        ),
        body: SafeArea(
          child: Consumer<FoodModel>(
            builder: (context, model, child) {
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Image.network(widget.args.restaurant.imageUrl),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          widget.args.restaurant.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(widget.args.restaurant.address),
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
              );
            },
          ),
        ),
      ),
    );
  }
}


              // Container(
              //   color: Theme.of(context).primaryColor,
              //   child: Row(
              //     children: [
              //       Spacer(),
              //       Expanded(
              //         flex: 5,
              //         child: ElevatedButton(
              //           onPressed: () => null,
              //           style: ButtonStyle(
              //             backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              //           ),
              //           child: Text(
              //             "Done",
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ),
              //       ),
              //       Spacer(),
              //     ],
              //   ),
              // ),