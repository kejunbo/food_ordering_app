import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_ordering_app/screens/customer/forgot_password/service/reset_password_service.dart';
import 'package:food_ordering_app/util/form_util.dart';
import '../../constant.dart';

class ForgotPasswordScreenArgs{
 final bool isAdmin;
  ForgotPasswordScreenArgs({this.isAdmin = false});
}

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = "forgotPasswordScreen";
  final ForgotPasswordScreenArgs args;
  const ForgotPasswordScreen({Key key, this.args}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();

  _resetPassword() async {
    if (_fbKey.currentState.saveAndValidate()) {
      EasyLoading.show();
      if (FormUtil.getFormValue(_fbKey, ForgotPasswordFormField.PASSWORD) == FormUtil.getFormValue(_fbKey, ForgotPasswordFormField.CONFIRM_PASSWORD)) {
        bool success = await ResetPasswordService.resetPassword(
          FormUtil.getFormValue(_fbKey, ForgotPasswordFormField.EMAIL),
          FormUtil.getFormValue(_fbKey, ForgotPasswordFormField.PASSWORD),
          isAdmin: widget.args.isAdmin,
        );
        if (success) {
          EasyLoading.showSuccess("Password Reset Succesfully");
          Navigator.pop(context);
        }
      } else {
        EasyLoading.showError("The password provided did not match one another, please try again");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
        child: FormBuilder(
          key: _fbKey,
          child: Column(
            children: [
              Text(
                "- Reset your password -",
                style: TextStyle(
                  fontFamily: "DancingScript",
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              SizedBox(height: 15),
              FormBuilderTextField(
                name: ForgotPasswordFormField.EMAIL,
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
              SizedBox(height: 15),
              FormBuilderTextField(
                name: ForgotPasswordFormField.PASSWORD,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.minLength(context, 8),
                ]),
                decoration: InputDecoration(
                  hintText: "Password",
                  isDense: true,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  errorMaxLines: 2,
                ),
                obscureText: true,
              ),
              SizedBox(height: 15),
              FormBuilderTextField(
                name: ForgotPasswordFormField.CONFIRM_PASSWORD,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.minLength(context, 8),
                ]),
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  isDense: true,
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  errorMaxLines: 2,
                ),
                obscureText: true,
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _resetPassword,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    "Reset Password",
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
