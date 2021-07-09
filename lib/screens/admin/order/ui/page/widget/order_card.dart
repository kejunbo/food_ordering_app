import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/admin/order_detail/ui/page/order_detail_screen.dart';
import 'package:food_ordering_app/screens/customer/order_history/model/entity/order.dart';
import 'package:food_ordering_app/util/formatter_util.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final Function confirmPaymentCallback;
  const OrderCard({Key key, this.order, this.confirmPaymentCallback}) : super(key: key);

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
              color: order.paymentMade == 1 ? Colors.green : Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order #${order.id}",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
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
                        "Total: ",
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
                  Divider(),
                  if (order.paymentMade == 0)
                    ElevatedButton(
                      onPressed: confirmPaymentCallback ?? () => null,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColorLight),
                      ),
                      child: Text(
                        "Confirm Payment",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      OrderDetailScreen.routeName,
                      arguments: OrderDetailScreenArgs(order: order),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                    ),
                    child: Text(
                      "View Details",
                      style: TextStyle(color: Colors.white),
                    ),
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
