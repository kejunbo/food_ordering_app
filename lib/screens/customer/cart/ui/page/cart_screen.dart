import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/customer/cart/model/view_model/cart_model.dart';
import 'package:food_ordering_app/screens/customer/cart/ui/page/widget/cart_item_card.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/page/checkout_screen.dart';
import 'package:food_ordering_app/util/formatter_util.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Consumer<CartModel>(
          builder: (context, model, child) {
            log("cartItemList => ${model.cartItemList}");
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Items: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("${model.getTotalQuantity}"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(FormatterUtil.getFormattedPrice(model.getTotalPrice)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white, thickness: 2)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Your Orders",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: "DancingScript",
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.white, thickness: 2)),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (model.cartItemList.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text("- Nothing is in your cart -", style: TextStyle(color: Colors.white),)
                        ),
                      ),
                    if (model.cartItemList.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: model.cartItemList.length + 1,
                          separatorBuilder: (context, index) => SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            if (index != model.cartItemList.length) {
                              return CartItemCard(
                                item: model.cartItemList[index],
                              );
                            }
                            return SizedBox(height: 30);
                          },
                        ),
                      ),
                  ],
                ),
                if (model.cartItemList.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, CheckoutScreen.routeName),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                        ),
                        child: Text(
                          "Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
