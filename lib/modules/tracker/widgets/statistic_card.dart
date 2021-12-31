// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

// Taken From https://flutterawesome.com/flutter-application-for-showing-covid-19-stats/
// https://github.com/wal33d006/novel_covid_19

final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
//final Function mathFunc = (Match match) => '${match[1]},';

String mathFunc(Match match) => '${match[1]},';

class StatisticCard extends StatelessWidget {
  final String text;
  final int stats;
  final Color color;
  final IconData icon;

  StatisticCard({
    required this.color,
    required this.icon,
    required this.text,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      stats.toString().replaceAllMapped(reg, mathFunc),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    icon,
                    size: 100.0,
                    color: color,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}