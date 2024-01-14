import 'package:farmacia/models/med_profile_mod.dart';
import 'package:farmacia/services/med_profile_ser.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class Med_Details extends StatefulWidget {
  final int id;
  const Med_Details({Key? key, required this.id}) : super(key: key);

  @override
  State<Med_Details> createState() => _Med_DetailsState();
}

// ignore: camel_case_types
class _Med_DetailsState extends State<Med_Details> {
  final MedProfile medProfile = MedProfile();
  v() async {
    final x = await medProfile.getDetailsForMed(widget.id);
    // ignore: avoid_print
    print('----------------------------------yutyu');

    // ignore: avoid_print
    print(x);
  }

  @override
  void initState() {
    v();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
     //   backgroundColor: Colors.white,
        elevation: 0.0,
      ),

      body: FutureBuilder<MedModProfile>(
          future: medProfile.getDetailsForMed(widget.id),
          builder:
              (BuildContext context, AsyncSnapshot<MedModProfile> snapshot) {
            if (snapshot.hasData) {
              // var med = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  margin: EdgeInsets.all(1.5),
                  height: 600,
                  width: 700,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                      )
                    ],
                   gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(196, 175, 236, 204),
                        Color.fromARGB(255, 165, 189, 224), //blue
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Text(
                          snapshot.data!.commercialName,
                          style: const TextStyle(
                            fontSize: 30.0,
                            letterSpacing:3,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.science,
                              color: Colors.teal,
                              size:25.0,
                            ),
                            Text(
                              '${'16'.tr} : ${snapshot.data!.scientificName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,

                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.medication_outlined,
                              color: Colors.purple,
                              size:25.0,
                            ),
                            Text(
                              '${'17'.tr}: ${snapshot.data!.commercialName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.attach_money,
                              color: Colors.yellow,
                              size:25.0,
                            ),
                            Text(
                              '${'18'.tr}:${snapshot.data!.price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.blue,
                              size:25.0,
                            ),
                            Text(
                              '${'19'.tr}:${snapshot.data!.expirationDate}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.local_pharmacy_outlined,
                              color: Colors.red,
                              size:25.0,
                            ),
                            Text(
                              '${'20'.tr}:${snapshot.data!.manufactureCompany}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 40.0,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.keyboard_double_arrow_left,
                            color: Colors.red,
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.of(context).pop(Med());
                              Get.back();
                            },

                            child: Text(
                              '21'.tr,
                              style: const TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.indigo,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
