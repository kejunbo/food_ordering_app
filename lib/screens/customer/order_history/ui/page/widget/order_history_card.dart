import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/customer/order_history/model/entity/order.dart';
import 'package:food_ordering_app/util/formatter_util.dart';

class OrderHistoryCard extends StatelessWidget {
  final Order order;
  const OrderHistoryCard({Key key, this.order}) : super(key: key);

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
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order #${order.id}",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  if(order.paymentMade == 1 )
                    Text("Payment Made", style:TextStyle(color:Colors.green, fontSize:15)),
                  if(order.paymentMade == 0 )
                    Text("Payment Pending", style:TextStyle(color:Colors.red, fontSize:15)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment Made: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(FormatterUtil.getFormattedPrice(order.totalPrice)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Type: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(FormatterUtil.upperFirstCharacter(order.type)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Address: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        order.address ?? "-",
                        textAlign: TextAlign.right,
                      )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Time: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(FormatterUtil.getDateStringFromMilliseconds(order.timestamp)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
