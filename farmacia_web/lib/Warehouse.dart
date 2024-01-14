import 'package:farmacia_web/categorizedMed.dart';
import 'package:farmacia_web/medDetails.dart';
import 'package:farmacia_web/models/medicineModel.dart';
import 'package:farmacia_web/responsive/layout.dart';
import 'package:farmacia_web/services/categoriesService.dart';
import 'package:farmacia_web/services/medicineService.dart';
import 'package:flutter/material.dart';
import 'package:farmacia_web/SearchBar.dart';
import 'package:farmacia_web/medicine.dart';
import 'header.dart';

enum viewMode {
  grid,
  list,
}
enum browseMode {
  byCategory,
  byMedicine,
}

viewMode selectedMode = viewMode.grid;
browseMode preferedMode = browseMode.byCategory;

class Warehouse extends StatefulWidget {
  const Warehouse({super.key});

  static _WarehouseState? of(BuildContext context) {
    final _WarehouseState? result = context.findAncestorStateOfType<_WarehouseState>();
    if(result != null) {
      return result;
    }
  }
  Future<void> fetchPublicMedicineDetailsAndShowDialog(int id) {
    return _WarehouseState().fetchMedicineDetailsAndShowDialog(id);
  }
  Widget buildPublicGridView(Future<List<dynamic>?> future, browseMode mode, bool newTab){
    return _WarehouseState().buildGridView(future, mode, newTab);
  }
  @override
  _WarehouseState createState() => _WarehouseState();
}

class _WarehouseState extends State<Warehouse> {
  final AllCategoriesServices allCategoriesServices = AllCategoriesServices();
  final medicineService allMedicineServices = medicineService();
  final TabsPane tabsPane = const TabsPane();
  var chosenCategory;
  var chosenMed;
  late Future<List<dynamic>?> future = getFutureData();

  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>?> fetchByCategoryData() async {
    // Fetch data for a specific category
    return await allCategoriesServices.getAllCategories();
  }
  Future<List<dynamic>?> fetchByMedicineData() async {
    // Fetch data for all medicines
    return await allMedicineServices.getAllMedicines();
  }
  Future<List<medMod>?> fetchMedicineByCategory(int categoryID) async {
    // Fetch data for a specific category
    return await allMedicineServices.getMedicines(categoryID);
  }
  Future<List<medicineModel>?> fetchMedicineDetails(int medicineID) async {
    // Fetch data for a specific medicine
    return await allMedicineServices.getMedDetails(medicineID);
  }
  Future<List<dynamic>?> getFutureData() {
    if (preferedMode == browseMode.byCategory) {
      return fetchByCategoryData(); // Use chosenCategory or any relevant identifier
    } else {
      return fetchByMedicineData(); // Use chosenMedicine or any relevant identifier
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      /*appBar: AppBar(
        title:
      ),*/
      body: Column(
        children: [
          //searchBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  margin: const EdgeInsets.all(10.0),
                  height: 50,
                  width: layout.isDesktop(context)
                      ? screenWidth / 2
                      : screenWidth / 3,
                  child: Visibility(
                    visible: preferedMode == browseMode.byCategory? true : false,
                      child: searchBar(mode: preferedMode, categoryId: 0,))),

              SizedBox(
                  width: layout.isDesktop(context)
                      ? 20
                      : layout.isTablet(context)
                          ? 5
                          : 2),

              SizedBox(
                  width: layout.isDesktop(context)
                      ? 20
                      : layout.isTablet(context)
                      ? 5
                      : 2),
              const Text('View:'),
              Container(
                decoration: BoxDecoration(
                    color: selectedMode == viewMode.grid
                        ? Colors.lightBlue[200]
                        : Colors.transparent),
                child: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          selectedMode = viewMode.grid;
                        },
                      );
                    },
                    icon: const Icon(Icons.grid_view_sharp)),
              ),
              Container(
                decoration: BoxDecoration(
                    color: selectedMode == viewMode.list
                        ? Colors.lightBlue[200]
                        : Colors.transparent),
                child: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          selectedMode = viewMode.list;
                        },
                      );
                    },
                    icon: const Icon(Icons.view_list_sharp)),
              ),
              SizedBox(
                  width: layout.isDesktop(context)
                      ? 20
                      : layout.isTablet(context)
                          ? 5
                          : 2),
              const Text('Sort by:'),
              Container(
                decoration: BoxDecoration(
                    color: preferedMode == browseMode.byCategory
                        ? Colors.lightGreen[200]
                        : Colors.transparent),
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        preferedMode = browseMode.byCategory;
                        future = allCategoriesServices.getAllCategories();
                      });
                    },
                    icon: const Icon(Icons.category_sharp)),
              ),
              Container(
                decoration: BoxDecoration(
                    color: preferedMode == browseMode.byMedicine
                        ? Colors.lightGreen[200]
                        : Colors.transparent),
                child: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          preferedMode = browseMode.byMedicine;
                          future = allMedicineServices.getAllMedicines();
                        },
                      );
                    },
                    icon: const Icon(Icons.medication)),
              ),
              SizedBox(
                width: layout.isDesktop(context)
                    ? 20
                    : layout.isTablet(context)
                        ? 5
                        : 2,
              ),
              Container(
                width: screenWidth * 0.09,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: Colors.pink[400], //blue
                ),
                child: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 237, 255, 252),
                                contentPadding: const EdgeInsets.all(50),
                                content: SizedBox(
                                    width: layout.isDesktop(context)
                                        ? screenWidth * 0.4
                                        : layout.isTablet(context)
                                            ? screenWidth / 2
                                            : screenWidth * 0.8,
                                    height: screenHeight * 0.6,
                                    child: const medicine()),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: const Center(
                        child: Icon(
                      Icons.add_sharp,
                      color: Colors.white,
                      size: 30,
                    ))),
              ),
            ],
          ),
          Expanded(
            child: selectedMode == viewMode.grid
                ? buildGridView(future, preferedMode, false)
                : buildListView(future, preferedMode),
          ),
        ],
      ),
    );
  }

  Widget buildListView(Future<List<dynamic>?> future, browseMode mode) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder<List<dynamic>?>(
        future: future,
        builder:
            (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                if(mode == browseMode.byCategory){
                  return buildCatGridTile(data[index].name, data[index].id);
                } else if(mode == browseMode.byMedicine){
                  return buildMedGridTile('${data[index]['name']}', index+1);
                };
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildGridView(Future<List<dynamic>?> future, browseMode mode, bool newTab) {
    //grid view
    return FutureBuilder<List<dynamic>?>(
        future: future,
        builder:
            (BuildContext context, AsyncSnapshot<List<dynamic>?> snapshot) {
          if (snapshot.hasData) {
            List data = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: layout.isDesktop(context)
                    ? 5
                    : layout.isTablet(context)
                        ? 4
                        : 2,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                if(mode == browseMode.byCategory && newTab == false){
                return buildCatGridTile(data[index].name, data[index].id);
                } else if(mode == browseMode.byMedicine && newTab == false){
                  return buildMedGridTile('${data[index]['name']}', index+1);
                } else if(mode == browseMode.byMedicine && newTab == true){
                  return buildMedGridTile('${data[index].commercialName}', index+1);
                };
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
  Widget buildCatGridTile(String? text, int id){
    return Card(
      color: Colors.blue[300],
      child: TextButton(
        onPressed: () {
          setState(() async {
            TabsPane.of(context)?.addTab(
              (text) ?? 'error',
              categorizedMed(
                categoryId: id,
                categoryName: text,
                content: await fetchMedicineByCategory(id),
              ),
            );
          });
        },
        child:
        Text(text!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildMedGridTile(String? text, int id){
    return Card(
      color: Colors.white70,
      child: TextButton(
        onPressed: () async {
          print('im pressed mister');

          //await fetchMedicineDetailsAndShowDialog(id);
          _showMedDialog(context, id);
           /* TabsPane.of(context)?.addTab(
              (text) ?? 'error',
                medDetails(med: id, fromSearch: true),
              );*/

        },
        child:
        Text(text!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  void _showMedDialog(BuildContext context, int id) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (context != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor:
              const Color.fromARGB(255, 237, 255, 252),
              contentPadding: const EdgeInsets.all(50),
              content: SizedBox(
                  width: layout.isDesktop(context)
                      ? screenWidth * 0.4
                      : layout.isTablet(context)
                      ? screenWidth / 2
                      : screenWidth * 0.8,
                  height: screenHeight * 0.6,
                  child: medDetails(med: id, fromSearch: false)));
        },
      );
    }
  }
  Future<void> fetchMedicineDetailsAndShowDialog(int id) async {
    print('inside fetch');
    if (mounted) {
      print('mounted1');
      await fetchMedicineDetails(id).then((med) {
        if (mounted) {
          print('mounted2');
          showDialog(
            context: context,
            builder: (context) {
              return buildAlertDialog(med!);
            },
          );
        }
      });
    }
  }
  Widget buildAlertDialog(List<medicineModel> data) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
        backgroundColor:
        const Color.fromARGB(255, 237, 255, 252),
    contentPadding: const EdgeInsets.all(50),
    content: SizedBox(
    width: layout.isDesktop(context)
    ? screenWidth * 0.4
        : layout.isTablet(context)
    ? screenWidth / 2
        : screenWidth * 0.8,
    height: screenHeight * 0.8,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 237, 255, 252),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: data.map<Widget>((item) {
                return Column(
                  children: <Widget>[
                        Text('Classification ID: ${item.classificationId}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromARGB(196, 41, 185, 114),
                          ),),
                    const SizedBox(
                      height: 50,
                    ),
                        const Text('Scientific Name:',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color.fromARGB(196, 41, 185, 114)
                        ),),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(item.scientificName),
                    const SizedBox(
                      height: 50,
                    ),
                        Text('Commercial Name: ${item.commercialName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                              color: Color.fromARGB(196, 41, 185, 114)
                          ),),
                    const SizedBox(
                      height: 50,
                    ),
                        Text('Vendor: ${item.manufactureCompany}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                              color: Color.fromARGB(196, 41, 185, 114)
                          ),),
                        const SizedBox(
                          width: 50,
                        ),
                        Text('Quantity: ${item.availableQuantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                              color: Color.fromARGB(196, 41, 185, 114)
                          ),),
                    const SizedBox(
                      height: 50,
                    ),
                        Text('Expiration Date: ${item.expirationDate}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                              color: Color.fromARGB(196, 41, 185, 114)
                          ),),
                        const SizedBox(
                          width: 50,
                        ),
                        Text('Price: ${item.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                              color: Color.fromARGB(196, 41, 185, 114)
                          ),),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    )
    );
  }

}
