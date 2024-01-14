import 'package:farmacia_web/models/ordersModel.dart';
import 'package:farmacia_web/orderDetails.dart';
import 'package:farmacia_web/services/ordersService.dart';
import 'package:flutter/material.dart';
import 'package:farmacia_web/responsive/layout.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? selectedStatus = '';
  String? selectedPaymentStatus = '';
  String? currentStatus;
  String? currentPaymentStatus;
  bool showButton = false;
  final AllOrdersServices allOrdersServices = AllOrdersServices();
  late Future<List<ordersModel>?> orders; // List of orders retrieved from the internet

  @override
  void initState() {
    super.initState();
   orders = allOrdersServices.getAllOrder();
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Column(
      children: [
        //Expanded(child: Text('data')),
        Expanded(child: buildListView()),
      ],
    ),));
  }

  Widget buildListView() {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return FutureBuilder<List<ordersModel>?>(
      future: allOrdersServices.getAllOrder(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ordersModel>?> snapshot) {
        if (snapshot.hasData) {
          List<ordersModel> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return buildOrderTile(data[index]);
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildOrderTile(ordersModel order){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    currentStatus = order.status;
    currentPaymentStatus = order.paymentStatus;
    Color color = _getTileColor(order);
    return SizedBox(
      width: screenWidth / 3,
      height: screenHeight / 7,
      child: Card(
        color: color,
        borderOnForeground: true,
        margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
        child: ListTile(
          title: Text('Order ID: ${order.id}'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Creation date: ${order.creationDate}'),
              Text('Customer name: ${order.customerName}'),
              Row(
                children: <Widget>[
                  const Text('Status: '),
                  DropdownButton<String>(
                    dropdownColor: Colors.white,
                    focusColor: Colors.white,
                    value: currentStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        print('sdeedeieiub');
                        // Update the status and toggle the visibility of the button
                        showButton = true;
                        selectedStatus = newValue;
                        if(order.status == selectedStatus){
                          print('we are in condition and they are equal!!!');
                          selectedStatus = 'invalid';
                        } else {
                          print('we are in condition and they are not equal!!!');
                          selectedStatus = newValue;
                          currentStatus = newValue;
                          color = _getTileColor(order);
                        }
                      });
                    },
                    items: <String>['preparing', 'has been sent', 'recived']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Text('Total price: ${order.totalPrice}'),
              Visibility(
                visible: currentStatus == 'recived'? true : false,
                child: Row(
                  children: <Widget>[
                    const Text('Payment status: '),
                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                      focusColor: Colors.white,
                      value: currentPaymentStatus,
                      onChanged: (String? newValue) {
                        // Update the payment status and toggle the visibility of the button
                        setState(() {
                          print('ioioiiouoi');
                          showButton = true;
                          selectedPaymentStatus = newValue;
                          currentPaymentStatus = newValue;
                          color = _getTileColor(order);
                        });
                      },
                      items: <String>['Unpaid','paid']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              //Text('Updated date: ${order.updatedDate}'),
            ],
          ),
                onTap: () {
    // Open alert dialog with order details
                    _showOrderDetailsDialog(order.id, context);
    },
          trailing: Visibility(
            visible: showButton, // Set visibility based on dropdown list selection
            child: IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                // Send post method with the modification on the order
                await sendPostRequest(order.id, selectedStatus!, selectedPaymentStatus!);
                setState(() {
                  showButton = false;
                });
                  },
                ),
            ),
          //tileColor: color,

        ),
      ),
    );
}

Color _getTileColor(ordersModel order) {
  if (order.status == 'preparing' && order.paymentStatus == 'Unpaid') {
    return Colors.blueAccent.shade100;
  } else if (order.status == 'has been sent' && order.paymentStatus == 'Unpaid') {
    return Colors.yellowAccent.shade100;
  } else if (order.status == 'recived' && order.paymentStatus == 'Unpaid') {
    return Colors.orangeAccent.shade100;
  } else if (order.status == 'recived' && order.paymentStatus == 'paid') {
    return Colors.lightGreen.shade200;
  } else if (order.status == 'Denied' && order.paymentStatus == 'Unpaid') {
    return Colors.red.shade300;
  } else {
    return Colors.white70;
  }
}

Future sendPostRequest(int orderId, String status, String paymentStatus) async {
  // Send a post request with the modified status and payment status
  // Implement the logic to send the post request
  int Status = -1;
  String PStatus = '-1';
  print('\n\n\n\n\n\n\n\nSending post request for orderId: $orderId, status: $status, paymentStatus: $paymentStatus\n\n\n\n');
  status == 'has been sent' ? Status = 1 : status == 'recived' ? Status = 2 : status == 'invalid'? Status = 0 : print('invalid status');
  print('Status is: $Status and status is: $status');

  paymentStatus == 'paid'? PStatus = '1' : paymentStatus == 'Unpaid'? PStatus = '0' : print('invalid payment');

  if(Status == -1){
    await allOrdersServices.set_payemnt(orderId, PStatus);
  } else if (Status == 0){
    showDialog(context: context, builder: (context) {
      return const AlertDialog(
          title: Text('Warning!'),
          content:  Text('You either tried to put an invalid status \nor you submitted an unchanged input'),);},);
  } else {
    await allOrdersServices.set_State(orderId, Status);

  }
}

// Displaying Data in an Alert Dialog with ID Parameter
void _showOrderDetailsDialog(int id, BuildContext context) {
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
            content: SingleChildScrollView(
              child: SizedBox(
                  width: layout.isDesktop(context)
                      ? screenWidth * 0.4
                      : layout.isTablet(context)
                      ? screenWidth / 2
                      : screenWidth * 0.8,
                  height: screenHeight * 0.8,
                  child: orderDetails(orderId: id)),
            ));
      },
    );
  }
}

}
