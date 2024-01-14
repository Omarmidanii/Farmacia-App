import 'package:flutter/material.dart';
import 'package:farmacia/models/categories_mod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'med.dart';

class ClassficationSearchScreen extends StatelessWidget {
   var searchResults;
  ClassficationSearchScreen({required this.searchResults});

  @override
  Widget build(BuildContext context) {
    print("searchResults $searchResults");
    return Scaffold(
     // backgroundColor:Colors.white,
      appBar: AppBar(
        elevation:0.0,
        iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
       // backgroundColor:Colors.white,
        title: Text('59'.tr,
        style:TextStyle(
          color:Colors.black
        ),),
      ),
    body:

    searchResults!.length ==0?
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
          padding: const EdgeInsets.all(30.0),
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
                        Icon(Icons.category_rounded,color:Colors.green,size: 30,),
                        SizedBox(width:5,),
                        Text(
                          searchResults['name'],
                          style: const TextStyle(
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
                      width: 100.0,
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

                          Get.to(Med(id: searchResults["id"]));
                        },
                        child: const Text(
                          'View',
                          style: TextStyle(
                            fontSize:18,
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
