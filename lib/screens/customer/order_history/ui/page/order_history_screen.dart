import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/core/common/custom_shimmer.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/widget/section_label.dart';
import 'package:food_ordering_app/screens/customer/order_history/model/view_model/order_history_model.dart';
import 'package:food_ordering_app/screens/customer/order_history/ui/page/widget/order_history_card.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  AuthModel _authModel;
  OrderHistoryModel _orderHistoryModel;

  @override
  void initState() {
    super.initState();
    _authModel = Provider.of<AuthModel>(context, listen: false);
    _orderHistoryModel = new OrderHistoryModel(authModel: _authModel);
    _orderHistoryModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _orderHistoryModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order History"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () async {
                  EasyLoading.show();
                  await _orderHistoryModel.init();
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: Column(
            children: [
              SectionLabel(
                sectionTitle: "Order History",
              ),
              SizedBox(height: 10),
              Consumer<OrderHistoryModel>(
                builder: (context, model, child) {
                  if (model.isLoading) return CustomShimmer();
                  if (model.orderList.isEmpty)
                    return Center(
                      child: Text(
                        "You have not placed any orders",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    );
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: model.orderList
                        .map(
                          (order) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: OrderHistoryCard(order: order),
                          ),
                        )
                        .toList(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
