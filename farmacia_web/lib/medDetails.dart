import 'package:farmacia_web/models/medicineModel.dart';
import 'package:farmacia_web/services/medicineService.dart';
import 'package:flutter/material.dart';


class medDetails extends StatefulWidget {
  final int med;
  final bool fromSearch;
  medDetails({super.key, required this.med, required this.fromSearch});

  @override
  State<medDetails> createState() => _medDetailsState();
}

class _medDetailsState extends State<medDetails> {
  final medicineService allMedicineServices = medicineService();
  late final int med;
  late final bool fromSearch;
  
  Future<List<medicineModel>?> fetchMedicineDetails(int medicineID) async {
    // Fetch data for a specific medicine
    return await allMedicineServices.getMedDetails(medicineID);
  }
  v() async {
    final data = await fetchMedicineDetails(med);
    // ignore: avoid_print
    print('----------------------------------');

    // ignore: avoid_print
    print(data);
  }
  
  @override
  void initState() {
    v();
    super.initState();
    med = widget.med;
    fromSearch = widget.fromSearch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 255, 252),
      body: FutureBuilder<List<medicineModel>?>(
        future: fetchMedicineDetails(med),
        builder: (BuildContext context, AsyncSnapshot<List<medicineModel>?> snapshot) {
    if (snapshot.hasData) {
      List<medicineModel>? data = snapshot.data;
      return Center(
        child: Column(
        children: data!.map<Widget>((item) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Medicine details',
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
                      child: generateIconText(
                          'Scientific name: ${item.scientificName}',
                          const Icon(Icons.science_sharp),
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: generateIconText(
                          'Commercial name: ${item.commercialName}',
                          const Icon(Icons.shopping_bag_sharp),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child:
                      generateIconText(
                          'Category ID: ${item.classificationId}',
                          Icon(Icons.category)),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: generateIconText(
                          'Vendor: ${item.manufactureCompany}',
                        const Icon(Icons.business),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: generateIconText(
                          'Available quantity: ${item.availableQuantity}',
                        const Icon(Icons.numbers_sharp),
                      )),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: generateIconText(
                          'Price: \$${item.price}',
                        const Icon(Icons.sell),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Expanded(
                    child: generateIconText(
                        'Exp. date: :${item.expirationDate}',
                        const Icon(Icons.date_range_sharp),
                    )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: !fromSearch,
                    child: TextButton(
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
                                'OK',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))),
                  ),
                ],
              )
            ],
          );
        },
        ).toList(),
      ),);
        } else {
          return const Center(child: LinearProgressIndicator());
    }
        },
      ),
    );
  }

  ListTile generateIconText(String text, Icon icon){
    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

