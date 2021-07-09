import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/customer/cart/model/entity/cart_item.dart';
import 'package:food_ordering_app/util/formatter_util.dart';
import 'package:intl/intl.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;

  const CartItemCard({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(item.food.imageUrl),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.food.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(item.food.description),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${item.quantity}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(FormatterUtil.getFormattedPrice(item.food.price * item.quantity)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
