import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_seller/utils/get_location.dart';
import 'package:shop_seller/utils/network_service.dart';

class AllRegister extends StatefulWidget {
  const AllRegister({Key? key}) : super(key: key);

  @override
  State<AllRegister> createState() => _AllRegisterState();
}

class _AllRegisterState extends State<AllRegister> {
  final GlobalKey<FormState> fkey = GlobalKey<FormState>();
  var role = '1';
  var name = '';
  var email = '';
  var address = '';
  final coordinatesController = TextEditingController();
  var mobile = '';
  var password = '';
  var upiId = '';

  trySubmit() {
    if (fkey.currentState!.validate()) {
      fkey.currentState!.save();

      // print(
      //     'name $name\nrole $role\nemail $email\naddress $address\ncoordinates ${coordinatesController.text}\nmobile $mobile \npassword $password\nupi $upiId');
      register(
          address: address,
          email: email,
          mobile: mobile,
          name: name,
          password: password,
          upiId: upiId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: fkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      name = newValue!;
                    },
                    decoration: InputDecoration(
                      label: Text('Name'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      email = newValue!;
                    },
                    decoration: InputDecoration(
                      label: Text('email'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "email cannot be empty";
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return "email is badly formatted";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      address = newValue!;
                    },
                    decoration: InputDecoration(
                      label: Text('address'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Address cannot be empty";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (role == '1')
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: coordinatesController,
                            decoration: InputDecoration(
                              label: Text('coordinates'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "coordinates cannot be empty";
                              }
                            },
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: IconButton(
                                onPressed: () {
                                  determinePosition().then((value) {
                                    print(value);
                                    setState(() {
                                      coordinatesController.text =
                                          "${value.latitude},${value.longitude}";
                                    });
                                  });
                                },
                                icon: const Icon(Icons.pin_drop)))
                      ],
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      mobile = newValue!;
                    },
                    decoration: InputDecoration(
                      label: Text('mobile'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "enter mobile number";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (newValue) {
                      password = newValue!;
                    },
                    decoration: InputDecoration(
                      label: Text('password'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "enter password";
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (role == '1')
                    TextFormField(
                      onSaved: (newValue) {
                        upiId = newValue!;
                      },
                      decoration: InputDecoration(
                        label: Text('upi id'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "upi id cannot be empty";
                        }
                      },
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: trySubmit,
                    child: Text('SignUp'),
                  ),
                ],
              ),
            ),
          ),
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
        'registering with name $name, address $address, mobile $mobile, username $email,password $password,email $email, role $role, upi Id $upiId,coordinates ${coordinatesController.text}');
    getData("add_user.php", params: {
      "name": name,
      "address": address,
      "phone": mobile,
      "username": email,
      'coordinates': coordinatesController.text.isEmpty
          ? 'nil'
          : coordinatesController.text,
      "password": password,
      "email": email,
      "role": role,
      "upi_id": upiId!.isEmpty ? 'shanunanminda27-1@oksbi' : upiId,
    }).then((value) {
      Fluttertoast.showToast(msg: value['message'])
          .then((value) => Navigator.pop(context));
    });
  }
}
