import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
        title: Text('70'.tr,style:TextStyle(
          color:Colors.black
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("69".tr,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "62".tr,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 32.0),
              Text(
                "63".tr,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              DeveloperCard(
                name: '64'.tr,
                email: 'AsmaaMuffdi@gamil.com',

              ),
              SizedBox(height: 16.0),
              DeveloperCard(
                name: '65'.tr,
                email: 'EymanBazer@gmail.com',

              ),
              SizedBox(height: 16.0),
              DeveloperCard(
                name: '66'.tr,
                email: 'Salamafawal@gmail.com',

              ),

              SizedBox(height: 16.0),
              DeveloperCard(
                name: '67'.tr,
                email: 'OmarMedini@gmail.com',

              ),
              SizedBox(height: 16.0),
              DeveloperCard(
                name: '68'.tr,
                email: 'OmarSaker@gmail.com',



              ),

            ],
          ),
        ),
      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final String name;
  final String email;



  DeveloperCard({
    required this.name,
    required this.email,


  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 32.0,
            backgroundColor:Colors.grey,
             child:Icon(Icons.person,size:45,color:Colors.tealAccent,),
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  email,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
