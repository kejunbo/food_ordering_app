import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_ordering_app/core/common/view_model.dart';
import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';
import 'package:food_ordering_app/screens/customer/retaurant/service/food_service.dart';

class FoodModel extends ViewModel {
  final Restaurant restaurant;
  List<Food> foodList = [];

  FoodModel({this.restaurant});

  init() async {
    setLoading();
    foodList = await FoodService.getAllFoodByRestaurantId(restaurant.id);
    foodList.forEach((food) => food.restaurant = restaurant);
    setIdle();
  }

  deleteFood(num foodId) async {
    EasyLoading.show();
    bool success = await FoodService.deleteFood(foodId);
    if (success) {
      EasyLoading.showSuccess("Food successfully deleted!");
      this.init();
    } else {
      EasyLoading.showError("An error has occurred, please try again");
    }
  }

  updateFood(Food food) async {
    EasyLoading.show();
    bool success = await FoodService.updateFood(food);
    if (success) {
      EasyLoading.showSuccess("Food successfully updated!");
      this.init();
    } else {
      EasyLoading.showError("An error has occurred, please try again");
    }
  }

  addFood(Food food, num restaurantId) async {
    EasyLoading.show();
    bool success = await FoodService.addFood(food, restaurantId);
    if (success) {
      EasyLoading.showSuccess("Food successfully created!");
      this.init();
    } else {
      EasyLoading.showError("An error has occurred, please try again");
    }
  }
}
