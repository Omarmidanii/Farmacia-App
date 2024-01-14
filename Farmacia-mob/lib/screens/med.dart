

import 'package:farmacia/models/Favorite_model.dart';
import 'package:farmacia/models/med_mod.dart';
import 'package:farmacia/screens/Favorite_Screen.dart';
import 'package:farmacia/screens/result_search_medicins.dart';
import 'package:farmacia/screens/set_page.dart';
import 'package:farmacia/services/med_ser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/fav_delete_ser.dart';
import '../services/favorite_add_ser.dart';
import '../services/search_all_ser.dart';
import 'drawer.dart';
import 'med_details.dart';

class Med extends StatefulWidget {

  final int id;
  const Med({Key? key, required this.id}) : super(key: key);


  @override
  State<Med> createState() => _MedState();
}

final MedForCat medForCat = MedForCat();


class _MedState extends State<Med> {
  var _search_Med ;



  v() async {
    final x = await medForCat.getAllMedForCat(widget.id);
    print('----------------------------------yutyu');
    print (widget.id);
    print(x);

  }

  Map isFav = {};
  setFavorite(id, val){
    isFav[id] = val ;
    print("111111111111111111" +isFav[id].toString());

  }



  show_search_results_for_Medicin({required String query,required int id}) async {
    //make object of my class
    print("alllllloooooo");
    var  results_med= await SearchCatService().searchforMed(query,widget.id);
    print ("_____________");
    print (results_med);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>MedicinSearchScreen(searchResults:results_med),
      ),
    );


  }


  @override
  void initState() {
    _search_Med=TextEditingController();
    v();
    super.initState();
  }


  int count = 0;
  MakeMed(med, bool active) {
    var id = med.id;
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
                        med.commercialName,
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
                    med.price.toString(),
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
                      onPressed: (){
                        setState(() {
                          if(isFav[med.id] == true){
                            setState(() {
                              setFavorite(med.id, false);
                            });
                            deleteFavorites(med.id);
                          }
                          else if(isFav[med.id] == false){
                           setState(() {
                             setFavorite(med.id,true);
                           });
                            addToFavorites(med.id);

                          }
                          med.isfav = !med.isfav;
                        });
                           },
                      icon:isFav[med.id]
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

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    print("id is : ${widget.id}");
    return Scaffold(
    //  backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
       // backgroundColor: Colors.white,
        title: Text(
          '14'.tr,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left:10),
            child: IconButton(onPressed:(){
              Get.to(()=>Setting_asmaa());
            }, icon:Icon(Icons.settings ,size:33,)),
          )
        ],
        elevation: 0.0,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                height: 50.0,
                width: double.infinity,
                child: TextField(
                  controller:_search_Med,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                      hintText: '13'.tr,
                    prefixIcon: IconButton(
                      onPressed: () {
                        print("-- ");
                        print(widget.id);
                       show_search_results_for_Medicin(query:  _search_Med.text,id: widget.id);
                      },
                      icon: Icon(Icons.search ,color:Colors.grey,),
                  ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35.0))
                ),
              ),
            )),
             SizedBox(
              height: 700,
              width: 700,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder<List<MedMod>?>(
                  future: medForCat.getAllMedForCat(widget.id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MedMod>?> snapshot) {
                    if (snapshot.hasData) {
                      List<MedMod> med = snapshot.data!;

                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 10.0, // Spacing between columns
                          mainAxisSpacing: 10.0, // Spacing between rows
                        ),
                        itemBuilder: (BuildContext context, int index)
                        {
                          if(isFav[med[index].id] == null ) {
                            setFavorite(med[index].id , med[index].isfav);
                          }
                         return  MakeMed(med[index],isFav[med[index].id]);
                        },
                        itemCount:med.length,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            ],)
        ),
      );

  }
  /*child: FutureBuilder<List<CategoriesMod>?>(
                    future: allCategoriesServices.getAllCateogires(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CategoriesMod>?> snapshot) {
                      if (snapshot.hasData) {
                        List<CategoriesMod> cate = snapshot.data!;

                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: cate.length,
                            itemBuilder: (BuildContext context, int index) =>
                                CustomCard(cate[index]));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),*/
/*
  Widget BuildCardItem(CardList) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: const Color.fromARGB(255, 244, 255, 252),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 3,
              )
            ],
            border: Border.all(width: 0.5, color: Colors.grey.shade200)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Icon(Icons.medication,
                          color: Color.fromARGB(196, 41, 185, 114)),
                      Text(
                        ' Vitamine C',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
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
                    Icon(
                      Icons.attach_money_outlined,
                      color: Colors.yellow[800],
                    ),
                    const Text(
                      ' 25.00 s.p',
                      style: TextStyle(
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
                            setState(() {
                              isfill = !isfill;
                            });
                          },
                          icon: isfill
                              ? const Icon(
                                  Icons.favorite_border,
                                  size: 30.0,
                                )
                              : const Icon(Icons.favorite,
                                  color: Colors.red, size: 30.0)),
                      const SizedBox(
                        width: 20.0,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Med_Details()));
                          },
                          child: const Text(
                            'Details',
                            style: TextStyle(
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
      );*/
}
