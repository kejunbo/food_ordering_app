import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/admin/shop/ui/widget/food_form.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/view_model/food_model.dart';

class EditFoodScreenArgs {
  final Food food;
  final FoodModel foodModel;
  EditFoodScreenArgs({this.foodModel, this.food});
}

class EditFoodScreen extends StatefulWidget {
  static const String routeName = "editFoodScreen";
  final EditFoodScreenArgs args;
  const EditFoodScreen({Key key, this.args}) : super(key: key);

  @override
  _EditFoodScreenState createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Food"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: FoodForm(
          food: widget.args.food,
          foodModel: widget.args.foodModel,
          mode: FoodFormMode.edit,
          onSubmitCallback:() => Navigator.pop(context),
        ),
      ),
    );
  }
}
