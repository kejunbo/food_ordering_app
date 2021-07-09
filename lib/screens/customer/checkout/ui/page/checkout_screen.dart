import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/screens/customer/checkout/model/view_model/checkout_model.dart';
import 'package:food_ordering_app/screens/customer/checkout/service/checkout_service.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/widget/section_label.dart';
import 'package:food_ordering_app/util/form_util.dart';
import 'package:food_ordering_app/util/formatter_util.dart';
import 'package:provider/provider.dart';
import 'package:food_ordering_app/screens/customer/cart/model/view_model/cart_model.dart';

import '../../constant.dart';

enum ServiceType {
  delivery,
  pickup,
}

class CheckoutScreen extends StatefulWidget {
  static const routeName = "checkoutScreen";

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();
  ServiceType _serviceType = ServiceType.delivery;
  AuthModel _authModel;
  CartModel _cartModel;
  CheckoutModel _checkoutModel;

  get _serviceTypeString => _serviceType == ServiceType.delivery ? "DELIVERY" : "PICKUP";

  Widget get _getButtonRow => Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _serviceType = ServiceType.delivery),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  _serviceType == ServiceType.delivery ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 15)),
              ),
              child: Text(
                "Delivery",
                style: TextStyle(color: Colors.white, fontFamily: "DancingScript", fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _serviceType = ServiceType.pickup),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  _serviceType == ServiceType.pickup ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 15)),
              ),
              child: Text(
                "Pick Up",
                style: TextStyle(color: Colors.white, fontFamily: "DancingScript", fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          )
        ],
      );

  _checkout() async {
    if (_serviceType == ServiceType.delivery) {
      if (_fbKey.currentState.saveAndValidate()) {
        bool success = await _checkoutModel.checkout(FormUtil.getFormValue(_fbKey, CheckoutForm.DELIVERY_ADDRESS), _serviceTypeString);
        if (success) {
          EasyLoading.showSuccess("Your order has been placed successfully!");
          Navigator.pop(context);
        }
      }
    } else {
      bool success = await _checkoutModel.checkout(null, _serviceTypeString);
      if (success) {
        EasyLoading.showSuccess("Your order has been placed successfully!");
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _authModel = Provider.of<AuthModel>(context, listen: false);
    _cartModel = Provider.of<CartModel>(context, listen: false);
    _checkoutModel = new CheckoutModel(authModel: _authModel, cartModel: _cartModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Column(
                  children: [
                    SectionLabel(sectionTitle: "Summary"),
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
                              Text("${_cartModel.getTotalQuantity}"),
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
                              Text(FormatterUtil.getFormattedPrice(_cartModel.getTotalPrice)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SectionLabel(sectionTitle: "Select Service Type"),
                    _getButtonRow,
                    SizedBox(height: 20),
                    if (_serviceType == ServiceType.delivery)
                      SectionLabel(
                        sectionTitle: "Delivery Address",
                      ),
                    if (_serviceType == ServiceType.delivery)
                      FormBuilder(
                        key: _fbKey,
                        child: FormBuilderTextField(
                          name: CheckoutForm.DELIVERY_ADDRESS,
                          validator: FormBuilderValidators.required(context),
                          decoration: InputDecoration(
                            hintText: "No 1, Jalan Mooheedeen, Taman Ultraman, 11100 Atlantis...",
                            isDense: true,
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            errorMaxLines: 2,
                          ),
                          maxLines: 7,
                        ),
                      )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: _checkout,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 15)),
                  ),
                  child: Text(
                    "Place Order",
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
