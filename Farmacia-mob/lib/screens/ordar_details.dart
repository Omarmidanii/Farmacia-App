import 'package:farmacia/models/ordar_details_mod.dart';

import 'package:farmacia/services/order_details_ser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdarDetails extends StatefulWidget {
  final int id;
  const OrdarDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<OrdarDetails> createState() => _OrdarDetailsState();
}

class _OrdarDetailsState extends State<OrdarDetails> {
  final OrderDetailsServices orderDetailsServices = OrderDetailsServices();
  v() async {
    final x = await orderDetailsServices.getOrderDet(widget.id);
    // ignore: avoid_print
    print('----------------------------------');

    // ignore: avoid_print
    print(x);
  }

  @override
  void initState() {
    v();
    super.initState();
  }

  ord(orderDet) {
    return SizedBox(
      height: 120,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color.fromARGB(255, 244, 255, 252),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 1,
                    )
                  ],
                  border: Border.all(width: 0.5, color: Colors.grey.shade200)),
              margin: const EdgeInsets.all(3.0),

              child: Row(children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.medical_services,
                              color: Color.fromARGB(255, 92, 168, 95),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '25'.tr,
                              overflow:TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(223, 39, 39, 39),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                ' : ${orderDet.medicine_name}',
                                overflow:TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Color.fromARGB(223, 39, 39, 39),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Color.fromARGB(255, 236, 119, 111),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    ' ${'26'.tr} ',
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Color.fromARGB(223, 39, 39, 39),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    ": ${orderDet.quantity.toString()}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      color: Color.fromARGB(223, 39, 39, 39),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
        title: Text(
          '${'23'.tr} : ${widget.id}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 23.0,
          ),
        ),
      //  backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<OrdarDetMod>?>(
          future: orderDetailsServices.getOrderDet(widget.id),
          builder: (BuildContext context,
              AsyncSnapshot<List<OrdarDetMod>?> snapshot) {
            if (snapshot.hasData) {
              List<OrdarDetMod> orderDet = snapshot.data!;
              return ListView.separated(
                  shrinkWrap: true,
                  itemCount: orderDet.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ord(orderDet[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                        height: 2.0,
                      ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
