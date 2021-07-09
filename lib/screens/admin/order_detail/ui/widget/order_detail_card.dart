import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/admin/order_detail/model/entity/order_detail.dart';
import 'package:food_ordering_app/util/formatter_util.dart';

class OrderDetailCard extends StatelessWidget {
  final OrderDetail orderDetail;
  const OrderDetailCard({Key key, this.orderDetail}) : super(key: key);

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
              Image.network(orderDetail.food.imageUrl),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderDetail.food.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${orderDetail.quantity}"),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(FormatterUtil.getFormattedPrice(orderDetail.quantity * orderDetail.food.price)),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}