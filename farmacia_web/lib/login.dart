import 'dart:convert';

import 'package:farmacia_web/homepage.dart';
import 'package:farmacia_web/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

//TODO: validate phone number == 10 digits and numeric chars,
//TODO: password >= 8 digits,

class login extends StatefulWidget{
  const login({super.key});

  String getAuthKey (){
    return _loginState().auth;
  }
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  var auth;
  Future loginFun(String phonenumber, String password) async {
    var response = await http.post(
      Uri.parse("$baseurl/api/login"),
      //url
      //headers
      body: <String, String>{
        "Phonenumber": phonenumber,
        "Password": password,
      },
    );
    //هون بعمل طباعة قبل ما افوت بالشرط
    print("before condition");
    print("response is ${response.body}");
    print("resopnse is ${response.statusCode}");
    //الشرط
    if (response.statusCode == 200) {
      print("login Success");
      var js = jsonDecode(response.body);

        auth = json.decode(response.body)['token'];
        authToken = json.decode(response.body)['token'];
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', auth);
      print('the token is $authToken');
      var admin = js["user"]["Is_admin"];
      print(admin);
      if (admin == 1) {
        print('YESSSS');
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const homepage()));

        //Get.offAll(() => homepage());
      }
    } else {
      print("\n\n\nLogin failed with status code: ${response.statusCode}");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
            child: Text("Error: Login failed with status code: ${response.statusCode} and ${response.reasonPhrase}"),
            ),
          );
        }
      );
    }
  }

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool hiddenPassword=true;

  late String authToken;
  late var admin;
  final TextEditingController _phoneController =
  TextEditingController(text: "0955555555");
  final TextEditingController _passwordController =
  TextEditingController(text: "12345678");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237,255, 252),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: Form(
              key: formstate,
              child: Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height:200.0,
                      width:400.0,child: Image(image:AssetImage('assets/images/adminLogin.png'),),),
                    Text('Login',
                      style: TextStyle(
                        fontSize:30.0,
                        fontWeight:FontWeight.bold,
                        color:Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height:20,),
                    TextFormField(
                      controller: _phoneController,
                      onFieldSubmitted: (value){
                        FocusScope.of(context).nextFocus();
                      },
                      validator: (String ?value){
                        if(value!.isEmpty)
                        {
                          return " phone number must not be empty";
                        }
                        if(value.length>10)
                        {
                          return "phone number must be exactly 10 digits";
                        }
                        return null;
                      },
                      cursorColor:Colors.black,
                      decoration:InputDecoration(
                        labelStyle:const TextStyle(
                            color:Colors.grey),
                        focusedBorder:OutlineInputBorder(
                          borderSide: const BorderSide(
                            color:Colors.grey,
                          ),
                          borderRadius:BorderRadius.circular(15),
                        ) ,
                        labelText:'Enter phone number',
                        prefixIcon:const Icon(Icons.phone),
                        prefixIconColor:Colors.grey,
                        suffixIconColor:Colors.grey,
                        border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(15),
                        ),

                      ),
                      keyboardType:TextInputType.number,
                    ),
                    const SizedBox(height:20,),
                    TextFormField(
                      controller: _passwordController,
                      onFieldSubmitted: (value){
                        FocusScope.of(context).nextFocus();
                      },
                      keyboardType:TextInputType.visiblePassword,
                      obscureText:hiddenPassword,
                      validator: (String? value){
                        value!.isEmpty ? "Password must not be empty" : value.length < 8 ? "Password must be at least 8 characters" : null;
                        return null;
                      },
                      cursorColor:Colors.black,
                      decoration:InputDecoration(
                        labelStyle:const TextStyle(
                            color:Colors.grey),
                        focusedBorder:OutlineInputBorder(borderSide: const BorderSide(
                          color:Colors.grey,
                        ),
                          borderRadius:BorderRadius.circular(15),
                        ) ,
                        labelText:'Enter password',

                        suffixIcon:IconButton(
                          onPressed:(){
                            setState(() {
                              hiddenPassword=!hiddenPassword;
                            });
                          },
                          icon: hiddenPassword?const Icon(Icons.visibility ) :const Icon( Icons.visibility_off),
                        ),
                        suffixIconColor:Colors.grey,
                        prefixIcon:const Icon(Icons.lock),
                        prefixIconColor:Colors.grey,
                        border:OutlineInputBorder(
                          borderRadius:BorderRadius.circular(15),
                        ),


                      ),

                    ),
                    const SizedBox(height:30,),
                    Container(
                      width:250,
                      decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(20.0),
                          gradient:const LinearGradient(
                            colors: [
                              Color.fromARGB(196, 41, 185, 114),//green
                              Color.fromARGB(255, 109, 161, 245),//blue
                            ],)),
                      child: RawKeyboardListener(
                        focusNode: FocusNode(),
                        onKey: (RawKeyEvent event) async {
                          if(event.logicalKey == LogicalKeyboardKey.enter){
                            print("hello");
                            if(formstate.currentState!.validate()) {
                              print("helloooo");
                              await loginFun(_phoneController.text,
                              _passwordController.text);
                            }
                          }
                        },
                        child: MaterialButton(
                          height: 50,
                          onPressed: () async {
                            print('pressssssed');
                            if(formstate.currentState!.validate()) {
                              await loginFun(_phoneController.text,
                              _passwordController.text);
                            }
                          },
                          child: const Text('Log In',
                            style:TextStyle(
                              fontSize:20.0,
                              color:Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                      ],
                    ),

              ),
            ),

          ),
        ),

    );
  }


}