import 'package:flutter/material.dart';
import 'package:icovid_app/modules/tracker/widgets/statistic_card.dart';
import 'package:icovid_app/modules/tracker/services/services.dart';
import 'package:icovid_app/modules/tracker/widgets/daily_chart.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({ Key? key }) : super(key: key);

  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {

  late TextEditingController _namaProvinsiController;
  int _positif = 0;
  int _sembuh = 0;
  int _meninggal = 0;
  String _namaData = 'NASIONAL';
  List<Map<String, dynamic>> _dataHarian = List.empty();

  String _dataname = "Positif";
  String _datasettype = "harian";
  int _datacount = 7;
  int _radioValue = 0;

  Future _getDataNasional() async {
    dynamic response = await fetchDataCovid('Nasional');
    setState(() {
      _positif = response.positif;
      _sembuh = response.sembuh;
      _meninggal = response.meninggal;
      _namaData = 'NASIONAL';
    });
  }

  Future _getDataProvinsi(String nama) async {
    dynamic response = await fetchDataCovid(nama);
    if (response.positif != -1){
      setState(() {
        _positif = response.positif;
        _sembuh = response.sembuh;
        _meninggal = response.meninggal;
        _namaData = nama.toUpperCase();
      });
    }
  }

  Future _getDataHarian(int count) async {
    dynamic response = await fetchDataHarianCovid(count);
    setState(() {
      _dataHarian = response.dataset;
    });
  }

  @override
  void initState(){
    super.initState();
    _namaProvinsiController = TextEditingController();
    _getDataNasional();
    _getDataHarian(_datacount);
  }

  @override
  void dispose(){
    _namaProvinsiController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('iCovid - Tracker'),
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
            ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text("GRAFIK " + _datasettype.toUpperCase(), style: TextStyle(fontSize: 22),),
                  ),
                ),
                DailyChart(
                  dataset: _dataHarian,
                  dataname: _dataname,
                  datasettype: _datasettype,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 0, 
                      groupValue: _radioValue, 
                      onChanged: _onRadioChanged,
                    ),
                    Text(
                      'Positif',
                      style: TextStyle(fontSize: 16),
                    ),
                    Radio(
                      value: 1, 
                      groupValue: _radioValue, 
                      onChanged: _onRadioChanged,
                    ),
                    Text(
                      'Sembuh',
                      style: TextStyle(fontSize: 16),
                    ),
                    Radio(
                      value: 2, 
                      groupValue: _radioValue, 
                      onChanged: _onRadioChanged,
                    ),
                    Text(
                      'Meninggal',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            ListView(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text("DATA " + _namaData, style: TextStyle(fontSize: 22),),
                  ),
                ),
                StatisticCard(
                  color: Colors.orange,
                  text: 'Total Positif',
                  icon: Icons.timeline,
                  stats: _positif,
                ),
                StatisticCard(
                  color: Colors.green,
                  text: 'Total Sembuh',
                  icon: Icons.whatshot,
                  stats: _sembuh,
                ),
                StatisticCard(
                  color: Colors.red,
                  text: 'Total Meninggal',
                  icon: Icons.airline_seat_individual_suite,
                  stats: _meninggal,
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                        onPressed: _getDataNasional,
                        child: const Text('Cek Data Nasional'),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () async {
                          final name = await _openDialog();
                          if (!(name == null || name.isEmpty)){
                            _getDataProvinsi(name);
                          }
                        },
                        child: const Text('Cek Data Provinsi'),
                      ),
                      const SizedBox(height: 5),
                    ],
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<String?> _openDialog() => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Nama Provinsi'),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: 'Masukan nama provinsi'),
        controller: _namaProvinsiController,
      ),
      actions: [
        TextButton(    
          child: Text('SUBMIT'),
          onPressed: () {
            Navigator.of(context).pop(_namaProvinsiController.text);
            _namaProvinsiController.clear();
          }, 
        ),
      ],
    ),
  );

  void _onRadioChanged(int? value){
    setState(() {
      _radioValue = value!;
      if (value == 0) _dataname = 'Positif';
      if (value == 1) _dataname = 'Sembuh';
      if (value == 2) _dataname = 'Meninggal';
    });
  }
}