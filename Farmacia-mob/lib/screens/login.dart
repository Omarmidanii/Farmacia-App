
import 'dart:convert';
import 'package:farmacia/helper/api.dart';
import 'package:farmacia/screens/categories.dart';
import 'package:farmacia/screens/register.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/login_ser.dart';
import '../services/logout.ser.dart';

// ignore: camel_case_types
class Test_LoginE extends StatefulWidget {
  const Test_LoginE({super.key});
  @override
  State<Test_LoginE> createState() => _Test_LoginState();
}

class _Test_LoginState extends State<Test_LoginE> {
@override


//here we cheek if i have token i will be in the app
// i call it here because initstate run firstly
     initState() {
      readtoken();
    super.initState();}


  @override
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool hiddenPassword = true;
  late var admin;
  final TextEditingController _phoneController = TextEditingController(text: '0944444444');
  final TextEditingController _passwordController = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Center(
            child: Form(
              key: formstate,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 200.0,
                      width: 400.0,
                      child:
                          Image(image: AssetImage('assets/images/pharma.png')),
                    ),
                    Text(
                      '27'.tr,
                      style: TextStyle(
                       // letterSpacing:2.0,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _phoneController,
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
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hiddenPassword,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "36".tr;
                        }
                        if (value.length < 8) {
                          // ignore: unnecessary_string_escapes
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
                      height: 30,
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
                          onPressed: () async {
                            if (formstate.currentState!.validate()) {
                              await login(_phoneController.text,
                                  _passwordController.text);
                            }
                          },
                          child: Text(
                            '27'.tr,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      '30'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.keyboard_double_arrow_right,
                          color: Colors.red,
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(() =>  Register());
                            },
                            child: Text(
                              '31'.tr,
                              style: const TextStyle(
                                color:
                                    Color.fromARGB(255, 109, 161, 245), //blue
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                decoration: TextDecoration.underline,
                              ),
                            )),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
