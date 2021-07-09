import 'package:food_ordering_app/core/common/view_model.dart';
import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';
import 'package:food_ordering_app/screens/customer/dashboard/service/restaurant_service.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';
import 'package:food_ordering_app/screens/customer/retaurant/service/food_service.dart';

class RestaurantModel extends ViewModel {
  List<Restaurant> restaurantList = [];
  List<Restaurant> filteredList = [];
  Restaurant restaurant;
  List<Food> foodList;
  init() async {
    setLoading();
    restaurantList = await RestaurantService.getAllRestaurants();
    restaurant = restaurantList.first;
    foodList = await FoodService.getAllFoodByRestaurantId(restaurant.id);
    foodList.forEach((food) => food.restaurant = restaurant);
    // filteredList = restaurantList;
    setIdle();
  }

  // filterByName(String name) async {
  //   setLoading();
  //   if (name.isEmpty) {
  //     filteredList = restaurantList;
  //   }
  //   filteredList = restaurantList.where((restaurant) => restaurant.name.toLowerCase().contains(name)).toList();
  //   setIdle();
  // }
}
