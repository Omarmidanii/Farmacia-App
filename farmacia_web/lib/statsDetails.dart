import 'package:farmacia_web/models/statsModel.dart';
import 'package:farmacia_web/services/statsService.dart';
import 'package:flutter/material.dart';

class statsDetails extends StatefulWidget {
  @override
  _statsDetailsState createState() => _statsDetailsState();
}

class _statsDetailsState extends State<statsDetails> with TickerProviderStateMixin{
  final statsService _pharmacyStatisticsService = statsService();
  late Future<statsModel> _statisticsFuture;
  late Future<statsModel> _statisticsOtherFuture;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _statisticsFuture = _pharmacyStatisticsService.fetchStats();
    _statisticsOtherFuture = _pharmacyStatisticsService.fetchOtherStats();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
              tabs: [
            Tab(text: 'First Report', icon: Icon(Icons.looks_one_sharp),),
            Tab(text: 'Second Report', icon: Icon(Icons.looks_two_sharp),),
          ]),

      ),
      body: TabBarView(
        controller: _tabController,
        children:[
          Center(
          child: FutureBuilder<statsModel>(
            future: _statisticsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Profits: ${snapshot.data!.profits}'),
                    Text('Quantity of Medication: ${snapshot.data!.quantityOfMedication}'),
                    Text('Number of Users: ${snapshot.data!.numberOfUsers}'),
                    Text('Number of Orders: ${snapshot.data!.numberOfOrders}'),
                  ],
                );
              }
            },
          ),
        ),
          Center(
            child: FutureBuilder<statsModel>(
              future: _statisticsOtherFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Profits: ${snapshot.data!.profits}'),
                      Text('Quantity of Medication: ${snapshot.data!.quantityOfMedication}'),
                      Text('Number of Users: ${snapshot.data!.numberOfUsers}'),
                      Text('Number of Orders: ${snapshot.data!.numberOfOrders}'),
                    ],
                  );
                }
              },
            ),
          ),
    ]
      ),
    );
  }
}
