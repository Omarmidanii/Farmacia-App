import 'package:flutter/material.dart';
import 'package:farmacia/models/categories_mod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'med.dart';
import 'med_details.dart';

class MedicinSearchScreen extends StatelessWidget {
  var searchResults;
  MedicinSearchScreen({required this.searchResults});

  @override
  Widget build(BuildContext context) {
    print("searchResults: :  $searchResults");
    return Scaffold(
     // backgroundColor:Colors.white,
      appBar: AppBar(
        elevation:0.0,
        iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
      //  backgroundColor:Colors.white,
        title: Text('59'.tr,
          style:TextStyle(
              color:Colors.black
          ),),
      ),
      body: searchResults!.length ==0?
      Center(child: Text('60'.tr),)
          :
      Container(
        height: 200,
        width: double.infinity,
        margin: EdgeInsets.all(30),
        // height:10.0,
        // width: 30.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17.0),
            color: const Color.fromARGB(255, 244, 255, 251),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 3,
              )
            ],
            border: Border.all(width: 0.5, color: Colors.grey.shade200)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Icon(Icons.medication,color:Colors.green,),
                          Text(
                            searchResults['commercial_name'],
                            style: const TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:4,),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Icon(Icons.attach_money,color:Colors.amber,),
                          Text(
                           "${searchResults['price']}",
                            style: const TextStyle(
                              color:Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: 90.0,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(196, 41, 185, 114), //green
                              Color.fromARGB(255, 109, 161, 245), //blue
                            ],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.to(Med_Details(id: searchResults["id"]));
                          },
                          child: const Text(
                            'Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
