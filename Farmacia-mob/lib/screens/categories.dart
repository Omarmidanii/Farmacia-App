import 'package:farmacia/local/local_controller.dart';
import 'package:farmacia/screens/med.dart';
import 'package:farmacia/models/categories_mod.dart';
import 'package:farmacia/screens/result_search_classfication.dart';
import 'package:farmacia/screens/set_page.dart';
import 'package:farmacia/services/categoriesArab_ser.dart';
import 'package:farmacia/services/categories_ser.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/search_all_ser.dart';
import 'drawer.dart';

// ignore: must_be_immutable
class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final AllCategoriesServices allCategoriesServices = AllCategoriesServices();
  final AllCategoriesArabServices allCategoriesArabServices=AllCategoriesArabServices();
   var _search_cat ;



  v() async {
    final x = await allCategoriesServices.getAllCateogires();

    // ignore: avoid_print
    print('----------------------------------yutyu');
    // ignore: avoid_print
    print(x);

  }

//  late List<Map<String,dynamic>>results;
   show_search_results(String query) async {
    //make object of my class
     print("alllllloooooo");
     var  results= await SearchCatService().searchCat(query);
     print ("_____________");
     print (results);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>ClassficationSearchScreen(searchResults:results),
        ),
      );



  }

  @override
  void initState() {
    _search_cat=TextEditingController();
    v();
    super.initState();
  }

  MyLocaleController controllerlang = Get.find();

  n() {
    if (Get.locale?.languageCode == 'en') {
      return allCategoriesServices.getAllCateogires();
    } else {
      return allCategoriesArabServices.getAllCateogires();
    }
  }

  // ignore: non_constant_identifier_names
  CustomCard(cate, index) {
    var id = cate.id;
    return Container(
      height:10.0,
      width: 30.0,
      margin: EdgeInsets.all(1.5),
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
                    Text(
                      cate.name,
                      style: const TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 70.0,
                      height: 35,
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
                          print ("go to ${cate.id}");
                          Get.to(()=>Med(id: cate.id));
                        },
                        child: Text(
                          '12'.tr,
                          style: const TextStyle(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: AppBar(
      //  backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
        title: Text(
          '1'.tr,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left:10),
            child: IconButton(onPressed:(){
              Get.to(()=>Setting_asmaa());
            }, icon:Icon(Icons.settings ,size:33,)),
          )
        ],

      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
      scrollDirection:Axis.vertical,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              height: 50.0,
              width: double.infinity,
              child: TextField(
                controller:_search_cat,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {
                      show_search_results(_search_cat.text);
                    },
                    icon: Icon(Icons.search),
                  ),
                  hintText: '13'.tr,
                  prefixIconColor: Colors.grey,
                  suffixIconColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<List<CategoriesMod>?>(
                future: n(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CategoriesMod>?> snapshot) {
                  if (snapshot.hasData) {
                    List<CategoriesMod>   cate = snapshot.data!;
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                       //scrollDirection:Axis.vertical,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                        ),
                        itemCount: cate.length,
                        itemBuilder: (BuildContext context, int index) =>
                            CustomCard(cate[index], index));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ]),
      ),

    );
  }
}
