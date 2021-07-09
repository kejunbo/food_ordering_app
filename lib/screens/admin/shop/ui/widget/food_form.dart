import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/view_model/food_model.dart';
import 'package:food_ordering_app/util/form_util.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

enum FoodFormMode {
  add,
  edit,
}

class FoodForm extends StatefulWidget {
  final Food food;
  final FoodModel foodModel;
  final FoodFormMode mode;
  final Function onSubmitCallback;
  FoodForm({Key key, this.foodModel, this.mode, this.onSubmitCallback, this.food}) : super(key: key);

  @override
  _FoodFormState createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  AuthModel _authModel;
  final GlobalKey<FormBuilderState> fbKey = new GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _authModel = Provider.of<AuthModel>(context, listen: false);
  }

  _submit() async {
    if (fbKey.currentState.saveAndValidate()) {
      Food _food = widget.food;
      if (_food == null) _food = new Food();
      _food.name = FormUtil.getFormValue(fbKey, FoodFormField.NAME).toString().trim();
      _food.price = double.tryParse(FormUtil.getFormValue(fbKey, FoodFormField.PRICE));
      _food.imageUrl = FormUtil.getFormValue(fbKey, FoodFormField.IMAGE_URL).toString().trim();
      _food.description = FormUtil.getFormValue(fbKey, FoodFormField.DESCRIPTION).toString().trim();
      if (widget.mode == FoodFormMode.add) {
        await widget.foodModel.addFood(_food, _authModel.user.restaurant.id);
      } else {
        await widget.foodModel.updateFood(_food);
      }
      widget.onSubmitCallback.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FormBuilder(
        key: fbKey,
        initialValue: widget.food != null
            ? {
                FoodFormField.NAME: widget.food.name,
                FoodFormField.PRICE: widget.food.price.toString(),
                FoodFormField.IMAGE_URL: widget.food.imageUrl,
                FoodFormField.DESCRIPTION: widget.food.description,
              }
            : null,
        child: Column(
          children: [
            Text(
              "Enter Food Details",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            FormBuilderTextField(
              name: FoodFormField.NAME,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
              ]),
              decoration: InputDecoration(
                hintText: "Food Name",
                isDense: true,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
                errorMaxLines: 2,
              ),
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              name: FoodFormField.PRICE,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.numeric(context),
                FormBuilderValidators.min(context, 0.01),
              ]),
              decoration: InputDecoration(
                hintText: "Unit Price",
                isDense: true,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
                errorMaxLines: 2,
              ),
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: FoodFormField.IMAGE_URL,
              decoration: InputDecoration(
                hintText: "Image URL",
                isDense: true,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
                errorMaxLines: 2,
              ),
            ),
            SizedBox(height: 10),
            FormBuilderTextField(
              name: FoodFormField.DESCRIPTION,
              decoration: InputDecoration(
                hintText: "Description",
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submit,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
