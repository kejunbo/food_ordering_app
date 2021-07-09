import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/screens/admin/shop/ui/service/restaurant_service.dart';
import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';
import 'package:food_ordering_app/util/form_util.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class UpdateRestaurantDetailsForm extends StatefulWidget {
  final Restaurant restaurant;

  UpdateRestaurantDetailsForm({Key key, this.restaurant}) : super(key: key);

  @override
  _UpdateRestaurantDetailsFormState createState() => _UpdateRestaurantDetailsFormState();
}

class _UpdateRestaurantDetailsFormState extends State<UpdateRestaurantDetailsForm> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();
  AuthModel _authModel;

  @override
  void initState() {
    super.initState();
    _authModel = Provider.of<AuthModel>(context, listen: false);
  }

  _submit() async {
    if (_fbKey.currentState.saveAndValidate()) {
      EasyLoading.show();
      Restaurant restaurant = new Restaurant(
        address: FormUtil.getFormValue(_fbKey, UpdateRestaurantDetailsFormField.ADDRESS),
        name: FormUtil.getFormValue(_fbKey, UpdateRestaurantDetailsFormField.RESTAURANT_NAME),
        description: FormUtil.getFormValue(_fbKey, UpdateRestaurantDetailsFormField.DESCRIPTION),
        imageUrl: FormUtil.getFormValue(_fbKey, UpdateRestaurantDetailsFormField.IMAGE_URL),
        id: _authModel.user.restaurant.id,
      );
      bool success = await RestaurantService.updateRestaurantDetails(restaurant);
      if (success) {
        _authModel.restaurant = restaurant;
        EasyLoading.showSuccess("Restaurant Details Updated!");
        Navigator.pop(context);
      } else {
        EasyLoading.showError("An error has occured, please try again");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      initialValue: {
        UpdateRestaurantDetailsFormField.RESTAURANT_NAME: widget.restaurant.name,
        UpdateRestaurantDetailsFormField.IMAGE_URL: widget.restaurant.imageUrl,
        UpdateRestaurantDetailsFormField.DESCRIPTION: widget.restaurant.description,
        UpdateRestaurantDetailsFormField.ADDRESS: widget.restaurant.address,
      },
      child: Column(
        children: [
          Text(
            "Update your Restaurant Details",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20),
          FormBuilderTextField(
            name: UpdateRestaurantDetailsFormField.RESTAURANT_NAME,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            decoration: InputDecoration(
              hintText: "Restaurant Name",
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
            name: UpdateRestaurantDetailsFormField.IMAGE_URL,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
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
            name: UpdateRestaurantDetailsFormField.ADDRESS,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
            decoration: InputDecoration(
              hintText: "Address",
              isDense: true,
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.white,
              filled: true,
              errorMaxLines: 2,
            ),
            maxLines: 5,
          ),
          SizedBox(height: 10),
          FormBuilderTextField(
            name: UpdateRestaurantDetailsFormField.DESCRIPTION,
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
            maxLines: 5,
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
    );
  }
}
