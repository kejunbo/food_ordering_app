import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/core/common/view_model.dart';
import 'package:food_ordering_app/screens/admin/order/service/order_service.dart';
import 'package:food_ordering_app/screens/customer/order_history/model/entity/order.dart';

class OrderModel extends ViewModel {
  final AuthModel authModel;
  List<Order> orderList = [];
  OrderModel({this.authModel});

  init() async {
    setLoading();
    orderList = await OrderService.getAllOrderByRestaurantId(authModel.user.restaurant.id);
    setIdle();
  }

  confirmPayment(int index) async {
    EasyLoading.show();
    if (index < orderList.length && index >= 0) {
      bool success = await OrderService.confirmPayment(orderList[index].id);
      if (success) {
        EasyLoading.showSuccess("Payment Confirmed!");
        orderList[index].paymentMade = 1;
        notifyListeners();
        return;
      }
    }
    EasyLoading.showError("An error has occurred, please try again");
  }

  int get getTotalOrderCount => orderList.length;
  double get getTotalRevenue => orderList.fold(0, (prev, order) => prev + order.totalPrice);
  int get getTotalPendingPayment => orderList.where((order) => order.paymentMade == 0).toList().length;
  int get getTotalMadePayment => orderList.where((order) => order.paymentMade == 1).toList().length;
}
