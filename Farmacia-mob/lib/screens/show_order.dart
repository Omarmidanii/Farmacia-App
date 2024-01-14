import 'package:farmacia/models/show_order_mod.dart';
import 'package:farmacia/screens/ordar_details.dart';
import 'package:farmacia/services/show_order_ser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowOrder extends StatefulWidget {
  const ShowOrder({super.key});

  @override
  State<ShowOrder> createState() => _ShowOrderState();
}

class _ShowOrderState extends State<ShowOrder> {
  final AllOrdersServices allOrdersServices = AllOrdersServices();
  v() async {
    final x = await allOrdersServices.getAllOrder();
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

  ord(order) {
    var id = order.orderNumber;
    return SizedBox(
      height: 150.0,
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
        margin: const EdgeInsets.all(13.0),
        child: InkWell(
          onTap: () {
            Get.to(OrdarDetails(
              id: id,
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Center(
              child: ListTile(
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(196, 108, 196, 172),
                  size: 35,
                ),
                title: Text(
                  '${'23'.tr} : ${order.orderNumber.toString()}',
                  style: const TextStyle(fontSize: 23.0, color:Colors.black,),
                ),
                subtitle: Text(
                  '${'24'.tr} : ${order.status}',
                  style: const TextStyle(fontSize: 23.0, color:Colors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '22'.tr,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 23.0,
          ),
        ),
       iconTheme: const IconThemeData(color: Colors.black, size: 30.0),
       // backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: FutureBuilder<List<ShowOrderMod>?>(
        future: allOrdersServices.getAllOrder(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ShowOrderMod>?> snapshot) {
          if (snapshot.hasData) {
            List<ShowOrderMod> orders = snapshot.data!;
            return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index) =>
                    ord(orders[index]));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
