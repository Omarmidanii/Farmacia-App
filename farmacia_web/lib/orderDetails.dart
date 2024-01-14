import 'package:farmacia_web/models/medicineModel.dart';
import 'package:farmacia_web/models/ordersModel.dart';
import 'package:farmacia_web/services/ordersService.dart';
import 'package:flutter/material.dart';


class orderDetails extends StatefulWidget {
  final int orderId;
  orderDetails({super.key, required this.orderId});

  @override
  State<orderDetails> createState() => _orderDetailsState();
}

class _orderDetailsState extends State<orderDetails> {
  late Future<Order> orderFuture;
  final AllOrdersServices allOrdersServices = AllOrdersServices();
  late final int orderId;

  Future<Order> fetchOrderDetails(int orderID) async {
    // Fetch data for a specific medicine
    print('inside fetch order details');
    return await allOrdersServices.getOrderDet(orderID);
  }
  @override
  void initState() {
    super.initState();
    orderId = widget.orderId;
    orderFuture = fetchOrderDetails(orderId);
    print('inside init order details');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 255, 252),
      body: FutureBuilder<Order?>(
        future: orderFuture,
        builder: (BuildContext context, AsyncSnapshot<Order?> snapshot) {
          if (snapshot.hasData) {
            print('inside future order details');
            Order? order = snapshot.data;
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  generateIconText('Customer name: ','${order?.name}', Icon(Icons.person)),
                  SizedBox(height: 10),
                  generateIconText('Order ID: ', '${order?.orderId}', Icon(Icons.label)),
                  SizedBox(height: 10),
                  generateIconText('Payment status: ','${order?.paymentState}', Icon(Icons.payments_sharp)),
                  SizedBox(height: 10),
                  generateIconText('Creation date: ','${order?.creationDate}', Icon(Icons.date_range)),
                  SizedBox(height: 10),
                  generateIconText('Total: ','${order?.totalPrice}', Icon(Icons.price_check)),
                  SizedBox(height: 10),
                  generateIconText('Medicines List:', ' ', Icon(Icons.medical_services)),
                  SizedBox(height: 5),

                  Column(
                    children: order!.medicines
                        .map(
                          (medicine) =>
                          generateIconText('     ','${medicine.medicineName}: ${medicine.requiredQuantity}', Icon(Icons.add)),
                    ).toList(),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: LinearProgressIndicator());
          }
        },
      ),
    );
  }

  ListTile generateIconText(String text, String text2,  Icon icon){
    return ListTile(
      leading: icon,
      title: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
      Text(
        text2,
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
        ],
      ),
    );
  }
}

