import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/screens/customer/account/service/account_service.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/widget/section_label.dart';
import 'package:food_ordering_app/util/form_util.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class UpdateAccountDetailsScreen extends StatefulWidget {
  static const String routeName = "updateAccountDetailsScreen";
  @override
  _UpdateAccountDetailsScreenState createState() => _UpdateAccountDetailsScreenState();
}

class _UpdateAccountDetailsScreenState extends State<UpdateAccountDetailsScreen> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();
  AuthModel _authModel;

  @override
  void initState() {
    super.initState();
    _authModel = Provider.of<AuthModel>(context, listen: false);
  }

  _updateAccountDetails() async {
    if (_fbKey.currentState.saveAndValidate()) {
      EasyLoading.show();
      bool success = await AccountService.updateAccountDetails(
        _authModel.user.id,
        FormUtil.getFormValue(_fbKey, UpdateAccountDetailsFormField.NAME),
        FormUtil.getFormValue(_fbKey, UpdateAccountDetailsFormField.EMAIL),
        adminUpdate: _authModel.isAdmin,
      );
      if (success) {
        EasyLoading.showSuccess("Account Updated Succesfully, you will be logged out for security reasons");
        Navigator.popUntil(context, (route) => route.isFirst);
        _authModel.logout();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Account Details"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
        child: FormBuilder(
          key: _fbKey,
          initialValue: {
            UpdateAccountDetailsFormField.NAME: _authModel.user.name,
            UpdateAccountDetailsFormField.EMAIL: _authModel.user.email,
          },
          child: Column(
            children: [
              SectionLabel(sectionTitle: "Name"),
              FormBuilderTextField(
                name: UpdateAccountDetailsFormField.NAME,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                ]),
                decoration: InputDecoration(
                  hintText: "Name",
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
              SizedBox(height: 15),
              SectionLabel(sectionTitle: "Email"),
              FormBuilderTextField(
                name: UpdateAccountDetailsFormField.EMAIL,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.email(context),
                ]),
                decoration: InputDecoration(
                  hintText: "Email",
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
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _updateAccountDetails,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
