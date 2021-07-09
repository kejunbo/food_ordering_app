import 'package:food_ordering_app/core/common/view_model.dart';
import 'package:food_ordering_app/screens/admin/order_detail/model/entity/order_detail.dart';
import 'package:food_ordering_app/screens/admin/order_detail/service/order_detail_service.dart';

class OrderDetailModel extends ViewModel {
  final num orderId;
  List<OrderDetail> orderDetailList = [];
  OrderDetailModel({this.orderId});

  init() async {
    setLoading();
    orderDetailList = await OrderDetailService.getAllFoodByOrderId(orderId);
    setIdle();
  }
}
