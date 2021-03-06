import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_seller/utils/get_location.dart';
import 'package:shop_seller/utils/network_service.dart';
import '/widget/form_button.dart';
import '/widget/input_field.dart';

class SimpleRegisterScreen extends StatefulWidget {
  const SimpleRegisterScreen({Key? key}) : super(key: key);

  @override
  _SimpleRegisterScreenState createState() => _SimpleRegisterScreenState();
}

class _SimpleRegisterScreenState extends State<SimpleRegisterScreen> {
  late String email, password, confirmPassword;
  String? emailError, passwordError;

  String? name;

  String? address;

  String? mobile;

  String role = "1";

  TextEditingController latlong = TextEditingController();
  TextEditingController upiIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
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

  void submit() {
    if (validate()) {
      register(
          email: email,
          password: password,
          name: name,
          address: address,
          mobile: mobile);
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
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Shop'),
                          leading: Radio<String>(
                            value: "1",
                            groupValue: role,
                            onChanged: (String? value) {
                              setState(() {
                                role = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Customer'),
                          leading: Radio<String>(
                            value: "2",
                            groupValue: role,
                            onChanged: (String? value) {
                              setState(() {
                                role = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * .025),
                  InputField(
                    key: Key('name'),
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
                    key: Key('mail'),
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
                  InputField(
                    key: Key('address'),
                    onChanged: (value) {
                      setState(() {
                        address = value;
                      });
                    },
                    labelText: "Address",
                    // errorText: addressError,
                    minLine: 1,
                    maxLine: 5,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    autoFocus: true,
                  ),
                  if (role == '1') SizedBox(height: screenHeight * .025),
                  if (role == '1')
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "coordinates",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              onChanged: ((value) {
                                setState(() {
                                  // address = value;
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
                    key: Key('mobile'),
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
                    key: Key('password'),
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
                    key: Key('cpass'),
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
                  if (role == '1')
                    SizedBox(
                      height: screenHeight * .025,
                    ),
                  if (role == '1')
                    TextField(
                      controller: upiIdController,
                      decoration: InputDecoration(
                        label: Text('upi id'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: screenHeight * .025,
                  ),
                  FormButton(
                    text: "Sign Up",
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

  register(
      {String? email,
      String? password,
      String? name,
      String? address,
      String? mobile,
      String? upiId}) {
    print(
        'registering with name $name, address $address, mobile $mobile, username $email,password $password,email $email, role $role, upi Id ${upiIdController.text},coordinates ${latlong.text}');
    getData("add_user.php", params: {
      "name": 'name',
      "address": 'address',
      "phone": 1111111111,
      "username": 'email@asdd.csf',
      'coordinates': 12345654321,
      // latlong.text.isEmpty ? 'nil' : latlong.text,
      "password": 'password',
      "email": 'email@asd.asd',
      "role": 1,
      "upi_id": 'asdfgn',
      //  upiIdController.text.isEmpty
      // ?
      // 'shanunanminda27-1@oksbi'
      // : upiIdController.text,
    }).then((value) {
      Fluttertoast.showToast(msg: value['message'])
          .then((value) => Navigator.pop(context));
    });
  }
}
