import 'package:farmacia_web/Warehouse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'medDetails.dart';
import 'services/medicineService.dart';
import 'SearchBar.dart';
import 'models/medicineModel.dart';
import 'package:farmacia_web/responsive/layout.dart';

class categorizedMed extends StatefulWidget {
  final int categoryId;
  final String categoryName;
   var content;
   categorizedMed({super.key, required this.categoryId, required this.categoryName, required this.content});

  @override
  State<categorizedMed> createState() => _categorizedMedState();
}

class _categorizedMedState extends State<categorizedMed> {
  viewMode view = viewMode.grid;
  late final int categoryId;
  late final String categoryName;
  late var content;
  final medicineService allMedicineServices = medicineService();

  final Warehouse warehouse = Warehouse();
  @override
  void initState() {
    super.initState();
    categoryId = widget.categoryId;
    categoryName = widget.categoryName;
    content = widget.content;
  }

  Future<List<medMod>?> fetchMedicineByCategory(int categoryID) async {
    // Fetch data for a specific category
    return await allMedicineServices.getMedicines(categoryID);
  }

  Future<List<medicineModel>?> fetchMedicineDetails(int medicineID) async {
    // Fetch data for a specific medicine
    return await allMedicineServices.getMedDetails(medicineID);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

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
                width: screenWidth / 2,
                child: searchBar(mode: browseMode.byMedicine, categoryId: categoryId,),
              ),
              SizedBox(
                  width: 20),
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
            ],
          ),
          Expanded(
            child: buildGridView(fetchMedicineByCategory(categoryId), browseMode.byMedicine, true),
          ),
        ],
      ),
    );
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
                return buildMedGridTile('${data[index].commercialName}', data[index].id);
                },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
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

}
