import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/widget/section_label.dart';
import 'package:food_ordering_app/screens/customer/register/constant.dart';
import 'package:food_ordering_app/screens/customer/register/service/register_service.dart';
import 'package:food_ordering_app/util/form_util.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "registerScreen";
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();

  _register() async {
    if (_fbKey.currentState.saveAndValidate()) {
      EasyLoading.show();
      if (FormUtil.getFormValue(_fbKey, RegisterFormField.PASSWORD) == FormUtil.getFormValue(_fbKey, RegisterFormField.CONFIRM_PASSWORD)) {
        bool success = await RegisterService.registerAccount(
          FormUtil.getFormValue(_fbKey, RegisterFormField.NAME),
          FormUtil.getFormValue(_fbKey, RegisterFormField.EMAIL),
          FormUtil.getFormValue(_fbKey, RegisterFormField.PASSWORD),
        );
        if (success) {
          EasyLoading.showSuccess("Account Created Succesfully");
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
              SectionLabel(sectionTitle: "Welcome to ChngRojak"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Image.asset("assets/images/splash.png"),
              ),
              SizedBox(height: 10),
              Text(
                "- Register an account today -",
                style: TextStyle(
                  fontFamily: "DancingScript",
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              FormBuilderTextField(
                name: RegisterFormField.NAME,
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
              FormBuilderTextField(
                name: RegisterFormField.EMAIL,
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
                name: RegisterFormField.PASSWORD,
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
                name: RegisterFormField.CONFIRM_PASSWORD,
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
                  onPressed: _register,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    "Register",
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
