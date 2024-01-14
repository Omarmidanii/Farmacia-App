import 'package:farmacia_web/Warehouse.dart';
import 'package:farmacia_web/categorizedMed.dart';
import 'package:farmacia_web/medDetails.dart';
import 'package:farmacia_web/services/searchService.dart';
import 'package:flutter/material.dart';
import 'package:farmacia_web/responsive/layout.dart';
import 'header.dart';
import 'models/medicineModel.dart';
class searchBar extends StatefulWidget {
  final browseMode mode;
  final int categoryId;
  //searchBar({required this.selectedBMode});
  const searchBar({super.key, required this.mode, required this.categoryId});

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  late final browseMode mode;
  late final int categoryId;
  @override
  void initState() {
    super.initState();
    mode = widget.mode; // Accessing the mode from the widget
    categoryId = widget.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: 'Minerals');

    return SizedBox(
      height: 50,
      child: TextField(
        controller: searchController,
        cursorColor: Colors.black,
        decoration:
        InputDecoration(
          labelStyle: const TextStyle(
              color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),
          hintText: 'Search',
          prefixIcon: IconButton(
            onPressed: () {
              showSearchResults(context, searchController.text, mode, categoryId);
            },
            icon: Icon(Icons.search),
          ),
          prefixIconColor: Colors.grey,
          suffixIconColor: Colors.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
        ),
      ),
    );
  }
  Future<void> showSearchResults(BuildContext context, String query, browseMode mode, int id) async {
    //make object of my class
    var results;

    Warehouse warehouse = Warehouse();
    print("alllllloooooo");
    if(mode == browseMode.byCategory) {
       results = await searchService().searchCat(query);
       print('results are: $results');
       TabsPane.of(context)?.addTab(
         (query) ?? 'error',
         categorizedMed(categoryId: results['id'], categoryName: results['name'], content: results),
       );
    } else {
      results = await searchService().searchforMed(query, id);
      results.toString();
      var data = medMod.fromJson(results);
      print('by med resultssssssssss');
      TabsPane.of(context)?.addTab(
          (query) ?? 'error', medDetails(med: data.id, fromSearch: true));
    }
    print ("_____________");
    print (results);

  }

}