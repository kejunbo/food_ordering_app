import 'package:flutter/material.dart';
import 'package:food_ordering_app/core/common/custom_shimmer.dart';
import 'package:food_ordering_app/screens/admin/order_detail/model/view_model/order_detail_model.dart';
import 'package:food_ordering_app/screens/admin/order_detail/ui/widget/order_detail_card.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/widget/section_label.dart';
import 'package:food_ordering_app/screens/customer/order_history/model/entity/order.dart';
import 'package:provider/provider.dart';
import 'package:food_ordering_app/util/formatter_util.dart';

class OrderDetailScreenArgs {
  final Order order;
  OrderDetailScreenArgs({this.order});
}

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = "orderDetailScreen";
  final OrderDetailScreenArgs args;
  const OrderDetailScreen({Key key, this.args}) : super(key: key);

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  OrderDetailModel _orderDetailModel;

  @override
  void initState() {
    super.initState();
    _orderDetailModel = new OrderDetailModel(orderId: widget.args.order.id);
    _orderDetailModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _orderDetailModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Details"),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
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
                          "Order: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("#${widget.args.order.id}"),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(FormatterUtil.getFormattedPrice(widget.args.order.totalPrice)),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Status: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        widget.args.order.paymentMade == 1
                            ? Text(
                                "Paid",
                                style: TextStyle(color: Colors.green),
                              )
                            : Text(
                                "Unpaid",
                                style: TextStyle(color: Colors.red),
                              ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Time of Order: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(FormatterUtil.getDateStringFromMilliseconds(widget.args.order.timestamp)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SectionLabel(sectionTitle: "Order Details"),
              ),
              Expanded(
                child: Consumer<OrderDetailModel>(
                  builder: (context, model, child) {
                    if (model.isLoading) {
                      return CustomShimmer();
                    } else if (model.orderDetailList.isEmpty) {
                      return Center(
                          child: Text(
                        "- Order Details Unavailable -",
                        style: TextStyle(color: Colors.white),
                      ));
                    }
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: model.orderDetailList.length + 1,
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        if (index == model.orderDetailList.length) {
                          return SizedBox(height: 10);
                        }
                        return OrderDetailCard(orderDetail: model.orderDetailList[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
