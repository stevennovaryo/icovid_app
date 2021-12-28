import 'package:flutter/material.dart';
import 'package:icovid_app/modules/tracker/widgets/statistic_card.dart';
import 'package:icovid_app/modules/tracker/services/services.dart';

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

  @override
  void initState(){
    super.initState();
    _namaProvinsiController = TextEditingController();
    _getDataNasional();
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
}