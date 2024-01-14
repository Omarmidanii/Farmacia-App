//here we will define a Screen to Show Your favorite
import 'package:farmacia/models/Favorite_model.dart';
import 'package:farmacia/services/fav_get_ser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'med_details.dart';

class Fav_Screen extends StatefulWidget{
  @override
  State<Fav_Screen> createState() => _Fav_ScreenState();
}
final Show_All_Fav show_all_fav=Show_All_Fav();
class _Fav_ScreenState extends State<Fav_Screen> {


  @override
  v() async {
    final x = await show_all_fav.getAllfav();
    print('----------------------------------yutyu');
  }
  @override
  initState() {
   v();
   super.initState();
  }

  bool isfill=true;
  Make_Fav_Med(fav){
    var id = fav.id;
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        color: const Color.fromARGB(255, 244, 255, 252),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 3,
          )
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    const Icon(Icons.medication,
                        color: Color.fromARGB(196, 41, 185, 114)),
                    Expanded(
                      child: Text(
                        fav.name,
                        overflow:TextOverflow.ellipsis,
                        style: const TextStyle(
                          color:Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  const Icon(Icons.attach_money_outlined,
                      color:Colors.amber),
                  Text(
                    fav.price.toString(),
                    style: const TextStyle(
                      color:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {

                      },
                      icon:isfill
                          ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 30.0,
                      )
                          : const Icon(Icons.favorite_border, size: 30.0),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      width: 70.0,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(196, 41, 185, 114), //green
                              Color.fromARGB(255, 109, 161, 245), //blue
                            ],
                          )),
                      child: TextButton(
                        onPressed: () {
                          Get.to(Med_Details(id: id));
                        },
                        child: Text(
                          '15'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
   return Scaffold(
     appBar:AppBar(
       backgroundColor:Colors.white,
       elevation:0.0,
       iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
       title:Text('61'.tr,
       style:TextStyle(
         color:Colors.black
       ),),
     ),
     body:SingleChildScrollView(
       child: Column(
         children: [
           SizedBox(
             height: 700,
             width: 700,
             child: Padding(
               padding: const EdgeInsets.all(12.0),
               child: FutureBuilder<List<Fav_Model>?>(
                 future: show_all_fav.getAllfav(),
                 builder: (BuildContext context,
                     AsyncSnapshot<List<Fav_Model>?> snapshot) {
                   if (snapshot.hasData) {
                     List<Fav_Model> Fav = snapshot.data!;
                     return GridView.builder(
                       scrollDirection: Axis.vertical,
                       gridDelegate:
                       const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2, // Number of columns
                         crossAxisSpacing: 10.0, // Spacing between columns
                         mainAxisSpacing: 10.0, // Spacing between rows
                       ),
                       itemBuilder: (BuildContext context, int index) =>Make_Fav_Med(Fav[index]),
                       itemCount:Fav.length,

                     );
                   } else {
                     return const Center(child: CircularProgressIndicator());
                   }
                 },
               ),
             ),
           ),
         ],
       ),
     ),
   );
  }
}

