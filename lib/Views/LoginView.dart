import 'package:flutter/material.dart';
import 'package:merchant_bill/Constants/AppColors.dart';
import 'package:merchant_bill/Constants/AppInputs.dart';
import 'package:merchant_bill/Constants/Buttons.dart';
import 'package:merchant_bill/Constants/HW.dart';
import 'package:merchant_bill/Constants/TextStyles.dart';
import 'package:merchant_bill/Controllers/AuthenticationController.dart';
import 'package:merchant_bill/Views/LandingView.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthenticationController>(
        builder: (context, authCtrl, child) {
      return Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: whiteClr,
                        image: DecorationImage(
                            image: AssetImage("assets/login.jpg"))),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  color: appColor.withOpacity(0.2),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sign in", style: TxtStls.headerStle),
                        Height(),
                        HalfHeight(),
                        EmailField(
                            controller: emailController,
                            labelText: "Email",
                            hintText: "Enter email"),
                        Height(),
                        HalfHeight(),
                        PasswordField(
                            controller: passwordController,
                            labelText: "Password",
                            hintText: "Enter Password",
                            obscureText: obsecure,
                            onPressed: () {
                              obsecure = !obsecure;
                              setState(() {});
                            }),
                        Height(),
                        HalfHeight(),
                        Center(
                          child: fillButton(context,
                              load: authCtrl.isLoading,
                              title: "Login", onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final postJson = {
                                "email": emailController.text.toString(),
                                "password": passwordController.text.toString()
                              };
                              Provider.of<AuthenticationController>(context, listen: false).Login(context, postJson: postJson);
                            }
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
