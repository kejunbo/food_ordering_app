import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/core/common/custom_shimmer.dart';
import 'package:food_ordering_app/screens/admin/order/model/view_model/order_model.dart';
import 'package:food_ordering_app/screens/admin/order/ui/page/widget/order_card.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/widget/section_label.dart';
import 'package:food_ordering_app/util/formatter_util.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  AuthModel _authModel;
  OrderModel _orderModel;
  @override
  void initState() {
    super.initState();
    _authModel = Provider.of(context, listen: false);
    _orderModel = new OrderModel(authModel: _authModel);
    _orderModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () async {
                EasyLoading.show();
                await _orderModel.init();
                EasyLoading.dismiss();
              },
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: _orderModel,
        child: Consumer<OrderModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: model.isLoading
                  ? CustomShimmer()
                  : Column(
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
                                    "Total Orders: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("${model.getTotalOrderCount}"),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Revenue: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(FormatterUtil.getFormattedPrice(model.getTotalRevenue)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Paid Orders: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${model.getTotalMadePayment}",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Unpaid Orders: ",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${model.getTotalPendingPayment}",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SectionLabel(sectionTitle: "Orders"),
                        if (model.orderList.isEmpty)
                          Center(
                            child: Text(
                              "- Your have no orders yet -",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        if (model.orderList.isNotEmpty)
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: model.orderList.length + 1,
                              separatorBuilder: (context, index) => SizedBox(height: 15),
                              itemBuilder: (context, index) {
                                if (index == model.orderList.length) return SizedBox(height: 10);
                                return OrderCard(
                                  order: model.orderList[index],
                                  confirmPaymentCallback: () => model.confirmPayment(index),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
            );
          },
          // physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
