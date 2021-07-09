import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/core/common/view_model.dart';
import 'package:food_ordering_app/screens/customer/order_history/model/entity/order.dart';
import 'package:food_ordering_app/screens/customer/order_history/service/order_history_service.dart';

class OrderHistoryModel extends ViewModel {
  final AuthModel authModel;
  List<Order> orderList = [];

  OrderHistoryModel({this.authModel});
  
  init() async {
    setLoading();
    orderList = await OrderHistoryService.getOrderHistoryByCustomerId(authModel.user.id);
    setIdle();
  }
}
