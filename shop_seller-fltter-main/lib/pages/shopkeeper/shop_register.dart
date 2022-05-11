import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:shop_seller/utils/get_location.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/image_selector.dart';
import 'package:shop_seller/widget/input_field.dart';
import 'package:shop_seller/widget/outlined_button.dart';
// import '../utils/get_location.dart';
// import '../utils/network_service.dart';
// import '../widget/image_selector.dart';
// import '../widget/input_field.dart';
// import '../widget/outlined_button.dart';

class SimpleRegisterScreenShop extends StatefulWidget {
  const SimpleRegisterScreenShop({Key? key}) : super(key: key);

  @override
  _SimpleRegisterScreenShopState createState() =>
      _SimpleRegisterScreenShopState();
}

class _SimpleRegisterScreenShopState extends State<SimpleRegisterScreenShop> {
  late String email, password, confirmPassword;
  String? emailError, passwordError;

  String? name;

  String? address;

  String? mobile;

  File? imageFile;

  TextEditingController latlong = TextEditingController();

  @override
  void initState() {
    super.initState();
    determinePosition();
    email = "";
    name = "";
    address = "";

    mobile = "";
    password = "";
    confirmPassword = "";

    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();

    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (email.isEmpty || !emailExp.hasMatch(email)) {
      setState(() {
        emailError = "Email is invalid";
      });
      isValid = false;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        passwordError = "Please enter a password";
      });
      isValid = false;
    }
    if (password.isEmpty) {
      setState(() {
        passwordError = "Please enter address";
      });
      isValid = false;
    }
    if (password != confirmPassword) {
      setState(() {
        passwordError = "Passwords do not match";
      });
      isValid = false;
    }

    return isValid;
  }

  Future<void> submit() async {
    // Position? position = await determinePosition();
    // print(position.latitude);

    if (validate()) {
      register(email, password, name, address, mobile, imageFile!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * .025),
                  const Text(
                    "Create Account,",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * .01),
                  Text(
                    "Sign up to get started!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(.6),
                    ),
                  ),
                  SizedBox(height: screenHeight * .025),
                  ImageSelector(
                    imageData: (file) {
                      imageFile = file;
                    },
                  ),
                  SizedBox(height: screenHeight * .025),
                  InputField(
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    labelText: "Name",
                    // errorText: ageError,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: screenHeight * .025),
                  InputField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    labelText: "Email",
                    errorText: emailError,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autoFocus: true,
                  ),
                  SizedBox(height: screenHeight * .025),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                            onChanged: ((value) {
                              setState(() {
                                address = value;
                              });
                            }),
                            controller: latlong),
                      ),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed: () {
                                determinePosition().then((value) {
                                  setState(() {
                                    address = latlong.text =
                                        "${value.latitude},${value.longitude}";
                                  });
                                });
                              },
                              icon: const Icon(Icons.pin_drop)))
                    ],
                  ),
                  SizedBox(height: screenHeight * .025),
                  InputField(
                    onChanged: (value) {
                      setState(() {
                        mobile = value;
                      });
                    },
                    labelText: "mobile",
                    // errorText: ageError,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: screenHeight * .025),
                  InputField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    labelText: "Password",
                    errorText: passwordError,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: screenHeight * .025),
                  InputField(
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                    onSubmitted: (value) => submit(),
                    labelText: "Confirm Password",
                    errorText: passwordError,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: screenHeight * .025,
                  ),
                  SimpleOutlinedButton(
                    child: const Text("Sign Up"),
                    onPressed: submit,
                  ),
                  SizedBox(
                    height: screenHeight * .025,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: RichText(
                      text: const TextSpan(
                        text: "I'm already a member, ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  register(String? email, String? password, String? name, String? address,
      String? mobile, File logo) {
    getData("user_reg.php", params: {
      "email": email,
      "password": password,
      "role": "1",
    }).then((value) {
      if (value['status'] as bool) {
        String loginId = value['id'].toString();
        var params = {
          "name": name!,
          "location": address!,
          "email": email!,
          "mobile": mobile!,
          "login_id": loginId,
        };
        print(params);
        Upload(logo, "add_shop.php", params).then((value) {
          Fluttertoast.showToast(msg: "Registration successfull.")
              .then((value) => Navigator.pop(context));
        });
      }
    });
  }
}
