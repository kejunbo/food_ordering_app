import 'package:flutter/material.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/screens/admin/shop/ui/widget/food_form.dart';
import 'package:food_ordering_app/screens/admin/shop/ui/widget/update_restaurant_details_form.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/widget/section_label.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/view_model/food_model.dart';
import 'package:provider/provider.dart';

enum Action {
  updateRestaurantDetails,
  addFood,
}

class ShopSettingsScreenArgs {
  final FoodModel foodModel;

  ShopSettingsScreenArgs({this.foodModel});
}

class ShopSettingsScreen extends StatefulWidget {
  static const String routeName = "shopSettingsScreen";
  final ShopSettingsScreenArgs args;
  const ShopSettingsScreen({Key key, this.args}) : super(key: key);
  @override
  _ShopSettingsScreenState createState() => _ShopSettingsScreenState();
}

class _ShopSettingsScreenState extends State<ShopSettingsScreen> {
  AuthModel _authModel;
  Action _action = Action.updateRestaurantDetails;

  @override
  void initState() {
    super.initState();
    _authModel = Provider.of(context, listen: false);
  }

  Widget get _getActionSelection => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _action = Action.updateRestaurantDetails),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  _action == Action.updateRestaurantDetails ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
              ),
              child: Text(
                "Update Restaurant",
                style: TextStyle(color: Colors.white, fontFamily: "DancingScript", fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => _action = Action.addFood),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  _action == Action.addFood ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
              ),
              child: Text(
                "Add Food",
                style: TextStyle(color: Colors.white, fontFamily: "DancingScript", fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      );

  Widget get _getForm {
    switch (_action) {
      case Action.updateRestaurantDetails:
        return UpdateRestaurantDetailsForm(restaurant: _authModel.user.restaurant);
      case Action.addFood:
        return FoodForm(
          foodModel: widget.args.foodModel,
          mode: FoodFormMode.add,
          onSubmitCallback:() => Navigator.pop(context),
        );
      default:
        return UpdateRestaurantDetailsForm(restaurant: _authModel.user.restaurant);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Settings"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SectionLabel(
              sectionTitle: "Select an Action",
            ),
            Container(
              height: 50,
              child: _getActionSelection,
            ),
            SectionLabel(sectionTitle: "Form"),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: _getForm,
            ),
          ],
        ),
      ),
    );
  }
}
