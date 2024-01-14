import 'package:farmacia_web/main.dart';
import 'package:farmacia_web/models/categoriesModel.dart';
import 'package:date_field/date_field.dart';
import 'package:farmacia_web/services/categoriesService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class medicine extends StatefulWidget {
  const medicine({super.key});

  @override
  State<medicine> createState() => _medicineState();
}

class _medicineState extends State<medicine> {

    final AllCategoriesServices allCategoriesServices = AllCategoriesServices();


  @override
  void initState() {
    super.initState();
  }


  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  var auth;
  Future submit(String sciname, String commname, String vendorname, int quantity, String expDate, int price, int catId) async{
    String? token;
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    print('clicked');
    print('response: scientific_name $sciname \ncommercial_name $commname \nmanufacture_company $vendorname \nAvailable_quantity $quantity \nExpiration_date $expDate \nprice $price \nclassification_id $catId');
    print('token is: $token');
    var response = await http.post(
      Uri.parse("${baseurl}/api/medicine/create/"),
      headers: {'Authorization': 'Bearer $token'},
      body: <String, String> {
        "scientific_name": sciname,
        "commercial_name": commname,
        "manufacture_company": vendorname,
        "Available_quantity": quantity.toString(),
        "Expiration_date": expDate,
        "price": price.toString(),
        "classification_id": catId.toString(),
      },
    );

    print(response.reasonPhrase);
    if(response.statusCode == 200){
      print('Added med!');
      Navigator.of(context).pop();
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:Text("Something's wrong!\n error: ${response.statusCode}"),
            );
          }
      );
    }
  }
  final TextEditingController _scinameController =
  TextEditingController(text: 'oool');
  final TextEditingController _commercialController =
  TextEditingController(text: 'panadol');
  final TextEditingController _manuCompanyController =
  TextEditingController(text: 'asia');
  final TextEditingController _quantityController =
  TextEditingController(text: '70');
  late DateTime _selectedDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  final TextEditingController _priceController =
  TextEditingController(text: '3000');
  final TextEditingController _catController =
  TextEditingController(text: '1');
  //late categoriesModel _selectedCategory;
  int? _selectedCategory;
  final TextEditingController _dateController =
  TextEditingController(text: '2023-3-22');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 255, 252),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formstate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Add a new medicine',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[400],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                        child: generateTextFormField(
                          _scinameController,
                            'Scientific Name',
                            'Enter scientific name',
                            const Icon(Icons.science_sharp),
                            TextInputType.name,
                            FilteringTextInputFormatter(('  '), allow: false))),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                        child: generateTextFormField(
                          _commercialController,
                            'Commercial Name',
                            'Enter commercial name',
                            const Icon(Icons.shopping_bag_sharp),
                            TextInputType.name,
                            FilteringTextInputFormatter(('  '), allow: false)))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      /*child: generateTextFormField(
                        _catController,
                        'Category',
                        'Choose category',
                        const Icon(Icons.category_sharp),
                        TextInputType.name,
                        FilteringTextInputFormatter((' '), allow: false),
                      ),*/
                      child: buildDropDownMenu(),
                      ),
                            const SizedBox(
                            width: 50,
                            ),
                            Expanded(
                            child: generateTextFormField(
                              _manuCompanyController,
                            'Vendor',
                            'Enter vendor name',
                            const Icon(Icons.business),
                            TextInputType.name,
                            FilteringTextInputFormatter(('  '), allow: false),
                            ),
                            ),
                            ],
                            ),
                            const SizedBox(
                            height: 20,
                            ),
                            Row(
                            children: [
                            Expanded(
                            child: generateTextFormField(
                              _quantityController,
                            'Quantity',
                            'Enter available quantity',
                            const Icon(Icons.numbers_sharp)
                            ,
                            const TextInputType.numberWithOptions(decimal: false),
                            FilteringTextInputFormatter.digitsOnly)),
                    const SizedBox(
                      width: 50,
                    ),
                    Expanded(
                        child: generateTextFormField(
                          _priceController,
                            'Price',
                            'Enter current price',
                            const Icon(Icons.sell),
                            const TextInputType.numberWithOptions(decimal: false),
                            MaskTextInputFormatter(
                              mask: "########",
                              filter: {"#": RegExp(r'[0-9.]')},
                            )))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Expanded(
                            child: generateDateField(
                                'Expiration date', 'yyyy-mm-dd', const Icon(Icons
                                .date_range_sharp)),
                          )
                        /*child: generateTextFormField(
                            _dateController,
                            'Exp. date',
                            'Enter exp date',
                            const Icon(Icons.sell),
                            const TextInputType.numberWithOptions(decimal: false),
                            MaskTextInputFormatter(
                              mask: "####-##-##",
                              filter: {"#": RegExp(r'[0-9.]')},
                            )))*/

                    ],
                  ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))),
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton(
                        onPressed: () async {
                          print("waiting for submission");
                          if (formstate.currentState!.validate()) {
                            await submit(
                                _scinameController.text,
                                _commercialController.text,
                                _manuCompanyController.text,
                                int.parse(_quantityController.text),
                                _selectedDate.toString(),
                                int.parse(_priceController.text),
                                _selectedCategory!);
                          }
                        },
                        child: Container(
                            width: 100,
                            height: 45,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(196, 41, 185, 114),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: const Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )))),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField generateTextFormField(TextEditingController controller, String label, String hint, Icon icon,
      TextInputType inputType, TextInputFormatter formatter) {
    return TextFormField(
      onFieldSubmitted: (value) {
        FocusScope.of(context).nextFocus();
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return "$label required!";
        }
        return null;
      },
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: label,
        prefixIcon: icon,
        prefixIconColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      keyboardType: inputType,
      inputFormatters: [
        formatter,
        FilteringTextInputFormatter.singleLineFormatter,
      ],
    );
  }

//date picker form field
  DateTimeFormField generateDateField(String label, String hint, Icon icon) {
    return DateTimeFormField(
      onDateSelected: (DateTime value) {setState(() {
        _selectedDate = DateTime(value.year, value.month, value.day);
        //_selectedDate = value;
      });},
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: label,
        prefixIcon: icon,
        prefixIconColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      initialValue: DateTime.now(),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      validator: (DateTime? expirationDate) {
        (expirationDate!.isBefore(DateTime.now())) ? 'invalid date' : null;
        return null;
      },
    );
  }


  Widget buildDropDownMenu() {
    return FutureBuilder<List<categoriesModel>?>(
      future: allCategoriesServices.getAllCategories(),
      builder: (BuildContext context, AsyncSnapshot<List<categoriesModel>?> snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField<int>(
            value: _selectedCategory,
            items: snapshot.data!.map((categoriesModel category) {
              return DropdownMenuItem<int>(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Select a Category',
            ),
            validator: (int? value) {
              if (value == null) {
                return 'Please select a category';
              }
              return null;
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return const LinearProgressIndicator();  // Show a loading spinner while waiting for the categories to load
      },
    );
  }

}
