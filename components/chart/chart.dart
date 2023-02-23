import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<charts.Series> seriesList = [
    charts.Series<Entity, String>(
      id: 'mydata',
      domainFn: (Entity data, _) => data.label,
      measureFn: (Entity data, _) => data.roi,
      data: [
        Entity('A', 5),
        Entity('B', 25),
        Entity('C', 100),
        Entity('D', 75),
      ],
    ),
  ];

  LineChartWidget(List<charts.Series> seriesList, {required bool animate});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My Chart')),
        body: Center(
          child: LineChartWidget(seriesList, animate: true),
        ),
      ),
    );
  }
}

// List<int> roi = [100, 50, 150, 200];
// List<int> label = [1, 2, 3, 4];
// List<Entity> data = [
//   Entity(100, 1),
//   Entity(150, 2),
//   entity(50, 3),
//   entity(10, 4)
// ];

class Entity {
  String label;
  int roi;
  Entity(this.label, this.roi);
}
