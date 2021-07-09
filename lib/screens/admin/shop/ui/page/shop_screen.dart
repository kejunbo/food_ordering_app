import 'package:flutter/material.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/core/common/custom_shimmer.dart';
import 'package:food_ordering_app/screens/admin/shop/ui/page/edit_food_screen.dart';
import 'package:food_ordering_app/screens/admin/shop/ui/page/shop_settings_screen.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/widget/section_label.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/view_model/food_model.dart';
import 'package:food_ordering_app/screens/customer/retaurant/ui/widget/food_card.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  AuthModel _authModel;
  FoodModel _foodModel;
  @override
  void initState() {
    super.initState();
    _authModel = Provider.of(context, listen: false);
    _foodModel = FoodModel(restaurant: _authModel.user.restaurant);
    _foodModel.init();
  }

  _onFoodCardTap(Food food) async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an Action'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('What would you like to do?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete Food'),
              onPressed: () async {
                return await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Action Confirmation'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Are you sure to delete this food?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () async {
                            await _foodModel.deleteFood(food.id);
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            TextButton(
              child: Text('Edit Food'),
              onPressed: () async {
                await Navigator.pushNamed(context, EditFoodScreen.routeName, arguments: EditFoodScreenArgs(food: food, foodModel: _foodModel)).then((_) {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(builder: (context, authModel, child) {
      return ChangeNotifierProvider.value(
        value: _foodModel,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Manage Shop"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, ShopSettingsScreen.routeName, arguments: ShopSettingsScreenArgs(foodModel: _foodModel)),
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Column(
              children: [
                SectionLabel(
                  sectionTitle: "Restaurant Details",
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
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
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Picture:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Image.network(
                              authModel.user.restaurant.imageUrl,
                              width: 200,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Name:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${authModel.user.restaurant.name}",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Description: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${authModel.user.restaurant.description}",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Address: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${authModel.user.restaurant.address}",
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SectionLabel(
                    sectionTitle: "All Foods",
                  ),
                ),
                Consumer<FoodModel>(
                  builder: (context, model, child) {
                    if (model.isLoading) {
                      return CustomShimmer();
                    } else if (model.foodList.isEmpty) {
                      return Center(
                        child: Text(
                          "- You have no food in your shop -",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return Column(
                      children: [
                        ...List.generate(
                          model.foodList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () => _onFoodCardTap(model.foodList[index]),
                              child: FoodCard(
                                food: model.foodList[index],
                                readOnly: true,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
