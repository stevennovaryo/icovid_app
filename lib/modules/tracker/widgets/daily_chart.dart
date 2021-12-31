// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
//import 'package:bezier_chart/bezier_chart.dart';

class DailyChart extends StatelessWidget {
  final List<Map<String, dynamic>> dataset;
  final String dataname;
  final String datasettype;

  // ignore: use_key_in_widget_constructors
  DailyChart({
    required this.dataset,
    required this.dataname,
    required this.datasettype,
  });

  @override
  Widget build(BuildContext context) {
    if (dataset.isEmpty){
      return const Center(
        child: Text('No Data Found'),
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      // child: BezierChart(
      //   fromDate: _getFromDate(),
      //   toDate: _getToDate(),
      //   bezierChartScale: BezierChartScale.WEEKLY,
      //   selectedDate: _getToDate(),
      //   series: [
      //     BezierLine(
      //       label: dataname,
      //       data: _getData(dataname),
      //     ),
      //   ],
      // ),
      child: charts.TimeSeriesChart(
        _getDataSeries(),
        animate: true,
        // defaultRenderer: charts.BarRendererConfig<DateTime>(),
        // defaultInteractions: true,
        // behaviors: [charts.SelectNearest(), charts.DomainHighlighter()],
        defaultRenderer: charts.LineRendererConfig(),
        dateTimeFactory: const charts.LocalDateTimeFactory(),
      ),
    );
  }

  DateTime _getFromDate(){
    String tmp = dataset[0]['tanggal'];
    tmp = tmp.split("T")[0];
    List<String> date = tmp.split("-");
    return DateTime(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]));
  }

  // DateTime _getToDate(){
  //   DateTime cur = _getFromDate();
  //   return cur.add(Duration(days: dataset.length-1));
  // }

  List<charts.Series<TimeSeriesSales, DateTime>> _getDataSeries() {
    List<TimeSeriesSales> data = List.filled(dataset.length, TimeSeriesSales(DateTime.now(), 0));
    DateTime cur = _getFromDate();
    for (int i = 0; i < dataset.length; i++){
      int val = 0;
      if (datasettype == "harian"){
        if (dataname == "Positif"){
          val = dataset[i]['positif'];
        }
        else if (dataname == "Sembuh"){
          val = dataset[i]['sembuh'];
        }
        else{
          val = dataset[i]['meninggal'];
        }
      }
      else{
        if (dataname == "Positif"){
          val = dataset[i]['positif_kumulatif'];
        }
        else if (dataname == "Sembuh"){
          val = dataset[i]['sembuh_kumulatif'];
        }
        else{
          val = dataset[i]['meninggal_kumulatif'];
        }
      }
      data[i] = TimeSeriesSales(cur.add(Duration(days: i)), val);
    }
    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: dataname,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

//   List<DataPoint<DateTime>> _getData(String dataName){
//     List<DataPoint<DateTime>> ret = List.filled(dataset.length, DataPoint<DateTime>(value: 0, xAxis: DateTime.now()));
//     DateTime cur = _getFromDate();
//     for (int i = 0; i < dataset.length; i++){
//       int val = 0;
//       if (datasettype == "harian"){
//         if (dataName == "Positif"){
//           val = dataset[i]['positif'];
//         }
//         else if (dataname == "Sembuh"){
//           val = dataset[i]['sembuh'];
//         }
//         else{
//           val = dataset[i]['meninggal'];
//         }
//       }
//       else{
//         if (dataName == "Positif"){
//           val = dataset[i]['positif_kumulatif'];
//         }
//         else if (dataname == "Sembuh"){
//           val = dataset[i]['sembuh_kumulatif'];
//         }
//         else{
//           val = dataset[i]['meninggal_kumulatif'];
//         }
//       }
//       ret[i] = DataPoint<DateTime>(value: val.toDouble(), xAxis: cur.add(Duration(days: i)));
//     }

//     return ret;
//   }
// }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}