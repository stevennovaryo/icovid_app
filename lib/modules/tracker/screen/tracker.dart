import 'package:flutter/material.dart';
import 'package:icovid_app/modules/tracker/widgets/statistic_card.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({ Key? key }) : super(key: key);

  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Covid Tracker'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.analytics_outlined),
              ),
              Tab(
                icon: Icon(Icons.assessment_outlined),
              )
            ]
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: Text('Chart will be here'),
            ),
            ListView(
              children: <Widget>[
                StatisticCard(
                  color: Colors.orange,
                  text: 'Total cases',
                  icon: Icons.timeline,
                  stats: 0,
                ),
                StatisticCard(
                  color: Colors.green,
                  text: 'Total recovered',
                  icon: Icons.whatshot,
                  stats: 0,
                ),
                StatisticCard(
                  color: Colors.red,
                  text: 'Total deaths',
                  icon: Icons.airline_seat_individual_suite,
                  stats: 0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}