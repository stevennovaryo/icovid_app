import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icovid_app/modules/tracker/widgets/statistic_card.dart';
import 'package:icovid_app/modules/tracker/services/services.dart';
import 'package:icovid_app/modules/tracker/widgets/daily_chart.dart';
import 'package:icovid_app/modules/auth/widgets/snack_bar.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({ Key? key }) : super(key: key);

  @override
  _TrackerScreenState createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {

  final _filterFormKey = GlobalKey<FormState>();

  late TextEditingController _namaProvinsiController;
  late TextEditingController _jumlahDataController;
  int _positif = 0;
  int _sembuh = 0;
  int _meninggal = 0;
  String _namaData = 'NASIONAL';
  List<Map<String, dynamic>> _dataHarian = List.empty();

  String _dataname = "Positif";
  String _datasettype = "harian";
  int _datacount = 7;
  int _radioValue = 0;
  // int _filterRadioValue = 2;

  bool _isLoading = false;

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
    _jumlahDataController = TextEditingController();
    _getDataNasional();
    _getFilter();
    // _getDataHarian(_datacount);
  }

  @override
  void dispose(){
    _namaProvinsiController.dispose();
    _jumlahDataController.dispose();

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
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text("GRAFIK " + _datasettype.toUpperCase(), style: const TextStyle(fontSize: 22),),
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
                    const Text(
                      'Positif',
                      style: TextStyle(fontSize: 16),
                    ),
                    Radio(
                      value: 1, 
                      groupValue: _radioValue, 
                      onChanged: _onRadioChanged,
                    ),
                    const Text(
                      'Sembuh',
                      style: TextStyle(fontSize: 16),
                    ),
                    Radio(
                      value: 2, 
                      groupValue: _radioValue, 
                      onChanged: _onRadioChanged,
                    ),
                    const Text(
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
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text("DATA " + _namaData, style: const TextStyle(fontSize: 22),),
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
        floatingActionButton: FloatingActionButton(
          onPressed: _openFilterDialog,
          tooltip: 'Chart Settings',
          child: const Icon(Icons.settings),
        ),
      ),
    );
  }

  String? formValidator(value){
    if (value == null || value.isEmpty) {
      return 'Please fill this form';
    }
    if (int.parse(value) < 7 || int.parse(value) > 30){
      return 'Tolong masukkan angka antara 7 sampai 30';
    }
    return null;
  }

  Future _openFilterDialog() => showDialog(
    context: context,
    builder: (BuildContext context) {
      int _filterRadioValue;
      if (_datasettype == 'harian'){
        _filterRadioValue = 2;
      }
      else {
        _filterRadioValue = 1;
      }
      return AlertDialog(
        title: const Text('Chart Settings'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Form(
              key: _filterFormKey,
              child: Column(
                children: [
                  Radio(
                    value: 1, 
                    groupValue: _filterRadioValue, 
                    onChanged: (int? value) {
                      setState(() {
                        _filterRadioValue = value!;
                      });
                    },
                  ),
                  const Text(
                    'Data Kumulatif',
                    style: TextStyle(fontSize: 16),
                  ),
                  Radio(
                    value: 2, 
                    groupValue: _filterRadioValue, 
                    onChanged: (int? value) {
                      setState(() {
                        _filterRadioValue = value!;
                      });
                    },
                  ),
                  const Text(
                    'Data Harian',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Jumlah Data',
                      hintText: 'Masukan antara 7-30 (inklusif)',
                    ),
                    controller: _jumlahDataController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: formValidator,
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          TextButton(
            child: const Text('SUBMIT'),
            onPressed: () async {
              if (_isLoading) return;
              setState(() {
                _isLoading = true;
              });

              try {
                dynamic response = await updateFilter(_filterRadioValue, _jumlahDataController.text);
                Map<String, dynamic> data = response['data'];
                if (response['status'] == 200){
                  setState(() {
                    _datacount = int.parse(_jumlahDataController.text);
                    if (_filterRadioValue == 2){
                      _datasettype = 'harian';
                    }
                    else{
                      _datasettype = 'kumulatif';
                    }
                  });
                  _getDataHarian(_datacount);
                  showSnackBar(context, data['message']);
                }
                else{
                  showSnackBar(context, data['message']);
                }
              } catch (e) {
                showSnackBar(context, e.toString());
              }
              setState(() {
                _isLoading = false;
              });
              Navigator.of(context).pop();
              _jumlahDataController.clear();
            },
          )
        ],
      );
    },
    
    // builder: (context) => AlertDialog(
    //   title: Text('Chart Settings'),
    //   content: Form(
    //     key: _filterFormKey,
    //     child: Column(
    //       children: [
    //         Radio(
    //           value: 1, 
    //           groupValue: _filterRadioValue, 
    //           onChanged: (int? value) {
    //             setState(() {
    //               _filterRadioValue = value!;
    //             });
    //           },
    //         ),
    //         Text(
    //           'Data Kumulatif',
    //           style: TextStyle(fontSize: 16),
    //         ),
    //         Radio(
    //           value: 2, 
    //           groupValue: _filterRadioValue, 
    //           onChanged: (int? value) {
    //             setState(() {
    //               _filterRadioValue = value!;
    //             });
    //           },
    //         ),
    //         Text(
    //           'Data Harian',
    //           style: TextStyle(fontSize: 16),
    //         ),
    //         TextFormField(
    //           decoration: const InputDecoration(
    //             labelText: 'Jumlah Data',
    //             hintText: 'Masukan antara 7-30 (inklusif)',
    //           ),
    //           controller: _jumlahDataController,
    //           keyboardType: TextInputType.number,
    //           inputFormatters: <TextInputFormatter>[
    //             FilteringTextInputFormatter.digitsOnly
    //           ],
    //           validator: formValidator,
    //         ),
    //       ],
    //     ),
    //   ),
      // actions: [
      //   TextButton(
      //     child: Text('SUBMIT'),
      //     onPressed: () async {
      //       if (_isLoading) return;
      //       setState(() {
      //         _isLoading = true;
      //       });

      //       try {
      //         dynamic response = await updateFilter(_filterRadioValue, _jumlahDataController.text);
      //         Map<String, dynamic> data = response['data'];
      //         if (response['status'] == 200){
      //           setState(() {
      //             _datacount = int.parse(_jumlahDataController.text);
      //             if (_filterRadioValue == 2){
      //               _datasettype = 'harian';
      //             }
      //             else{
      //               _datasettype = 'kumulatif';
      //             }
      //           });
      //           _getDataHarian(_datacount);
      //           showSnackBar(context, data['message']);
      //         }
      //         else{
      //           showSnackBar(context, data['message']);
      //         }
      //       } catch (e) {
      //         showSnackBar(context, e.toString());
      //       }
      //       setState(() {
      //         _isLoading = false;
      //       });
      //       Navigator.of(context).pop();
      //       _jumlahDataController.clear();
      //     },
      //   )
  );

  Future<String?> _openDialog() => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Nama Provinsi'),
      content: TextField(
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Masukan nama provinsi'),
        controller: _namaProvinsiController,
      ),
      actions: [
        TextButton(    
          child: const Text('SUBMIT'),
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

  void _getFilter() async {
    try {
      dynamic response = await getFilter();
      Map<String, dynamic> data = response['data'];
      if (response['status'] == 200){
        setState(() {
          _datacount = data['number_of_data'];
          //_filterRadioValue = data['chart_type'];
          if (data['chart_type'] == 2){
            _datasettype = 'harian';
          }
          else{
            _datasettype = 'kumulatif';
          }
        });
        _getDataHarian(_datacount);
        showSnackBar(context, data['message']);
      }
      else{
        showSnackBar(context, data['message']);
        _getDataHarian(7);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      _getDataHarian(7);
    }
    
  }
}