import 'dart:convert';
import 'package:farmacia/screens/login.dart';
import 'package:farmacia/services/register_ser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class Register extends StatefulWidget {

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool hiddenPassword = true;
  final TextEditingController username = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  bool test = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(50.0),
      child: SingleChildScrollView(
        child: Form(
          key: formstate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Text(
                  '41'.tr,
                  style: TextStyle(
                   // letterSpacing:2.0,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              TextFormField(
                controller: username,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "43".tr;
                  }
                  return null;
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: '42'.tr,
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: Colors.grey,
                  suffixIconColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: phonenumber,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "33".tr;
                  }
                  if (value.length > 10) {
                    return "34".tr;
                  }
                  if (value.length < 10) {
                    return "35".tr;
                  }
                  return null;
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: '28'.tr,
                  prefixIcon: const Icon(Icons.phone),
                  prefixIconColor: Colors.grey,
                  suffixIconColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hiddenPassword,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "36".tr;
                  }
                  if (value.length < 8) {
                    return "37".tr;
                  }
                  return null;
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: '29'.tr,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hiddenPassword = !hiddenPassword;
                      });
                    },
                    icon: hiddenPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  suffixIconColor: Colors.grey,
                  prefixIcon: const Icon(Icons.lock),
                  prefixIconColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFormField(
                controller: confirmpassword,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hiddenPassword,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "36".tr;
                  }
                  if (value.length < 8) {
                    return "37".tr;
                  }
                  return null;
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: '44'.tr,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hiddenPassword = !hiddenPassword;
                      });
                    },
                    icon: hiddenPassword
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  prefixIcon: const Icon(Icons.check),
                  prefixIconColor: Colors.grey,
                  suffixIconColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(196, 41, 185, 114), //green
                        Color.fromARGB(255, 109, 161, 245), //blue
                      ],
                    )),
                child: MaterialButton(
                  onPressed: () {
                    if (formstate.currentState!.validate()) {
                      if (password.text == confirmpassword.text) {
                        test = true;
                      }
                      if (password.text != confirmpassword.text) {
                        Get.defaultDialog(
                            title: "38".tr,
                            middleText: "45".tr,
                            buttonColor: Colors.blueAccent,
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Get.back();
                            });
                      }
                      if (test == true) {
                        {
                          Register_f(username.text, phonenumber.text, password.text);
                        }
                      }
                    }
                  },
                  child: Text(
                    '41'.tr,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
