import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/screens/customer/forgot_password/ui/page/forgot_password_screen.dart';
import 'package:food_ordering_app/screens/customer/login/constant.dart';
import 'package:food_ordering_app/screens/customer/register/ui/page/register_screen.dart';
import 'package:food_ordering_app/util/form_util.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/customerLoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum LoginMode { admin, customer }

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();
  LoginMode _loginMode = LoginMode.customer;
  AuthModel _authModel;

  _login() {
    if (_fbKey.currentState.saveAndValidate()) {
      _authModel.login(
        FormUtil.getFormValue(_fbKey, LoginFormField.EMAIL),
        FormUtil.getFormValue(_fbKey, LoginFormField.PASSWORD),
        adminLogin: _loginMode == LoginMode.admin,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _authModel = Provider.of<AuthModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _fbKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(40, 80, 40, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/splash.png"),
              SizedBox(height: 20),
              Text(
                _loginMode == LoginMode.admin ? "Welcome Admin" : "Welcome to Chng Rojak",
                style: TextStyle(color: Colors.white, fontFamily: "DancingScript", fontSize: 30),
              ),
              SizedBox(height: 20),
              Text(
                _loginMode == LoginMode.admin ? "- Manage your restaurant, orders, customer and more -" : "- It's your favourite food, delivered -",
                style: TextStyle(color: Colors.white, fontFamily: "DancingScript", fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              FormBuilderTextField(
                name: LoginFormField.EMAIL,
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
              SizedBox(height: 20),
              FormBuilderTextField(
                name: LoginFormField.PASSWORD,
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
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _login,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              if (_loginMode == LoginMode.customer) ...[
                SizedBox(height: 10),
                Center(
                  child: TextButton(
                    child: Text(
                      "Register an Account",
                      style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: () => Navigator.pushNamed(context, RegisterScreen.routeName),
                  ),
                ),
              ],
              Center(
                child: TextButton(
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () => Navigator.pushNamed(
                    context,
                    ForgotPasswordScreen.routeName,
                    arguments: ForgotPasswordScreenArgs(isAdmin: _loginMode == LoginMode.admin),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  child: Text(
                    _loginMode == LoginMode.admin ? "Login as Customer" : "Login as Admin",
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () => setState(() => _loginMode == LoginMode.admin ? _loginMode = LoginMode.customer : _loginMode = LoginMode.admin),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
