// ignore_for_file: non_constant_identifier_names

import 'package:icovid_app/core/services/request.dart';
import 'package:icovid_app/modules/tracker/screen/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DataCovid {
  final int positif;
  final int sembuh;
  final int meninggal;

  DataCovid({
    required this.positif,
    required this.sembuh,
    required this.meninggal,
  });
}

class DataHarianCovid {
  final List<Map<String, dynamic>> dataset;

  DataHarianCovid({
    required this.dataset,
  });
}

Future<DataCovid> fetchDataCovid(String tipe) async {
  if (tipe == 'Nasional'){
    final response = await http.get(Uri.parse(URL_NASIONAL));
    if (response.statusCode == 200){
      Map<String, dynamic> json = jsonDecode(response.body);
      return DataCovid(
        positif: json['positif'],
        sembuh: json['sembuh'],
        meninggal: json['meninggal'],
      );
    }
    else{
      throw Exception('Failed to get national data');
    }
  }
  else{
    final response = await http.get(Uri.parse(URL_PROVINSI));
    if (response.statusCode == 200){
      final json = jsonDecode(response.body);
      // for (int i = 0; i <= 33; i++){
      //   if (json[i]!['provinsi'] == tipe.toUpperCase()){
      //     return DataCovid(
      //       positif: json[i]!['positif'],
      //       sembuh: json[i]!['sembuh'],
      //       meninggal: json[i]!['meninggal'],
      //     );
      //   }
      // }
      for (Map<String, dynamic> i in json){
        String nama = i['provinsi'];
        if (nama == tipe.toUpperCase()){
          return DataCovid(
            positif: i['kasus'],
            sembuh: i['sembuh'],
            meninggal: i['meninggal'],
          );
        }
      }
      return DataCovid(
        positif: -1,
        sembuh: -1,
        meninggal: -1,
      );
    }
    else{
      throw Exception('Failed to get province data');
    }
  }
}

Future<DataHarianCovid> fetchDataHarianCovid(int count) async {
  final response = await http.get(Uri.parse(URL_HARIAN));
  if (response.statusCode == 200){
    final tmp = jsonDecode(response.body);
    List<Map<String, dynamic>> dataset = List.filled(count, {});
    List<Map<String, dynamic>> json = [];
    for (Map<String, dynamic> i in tmp){
      json.add(i);
    }
    int cnt = 0;
    for (int i = json.length-count; i < json.length; i++){
      dataset[cnt] = json[i];
      cnt++;
    }
    return DataHarianCovid(dataset: dataset);
  }
  else{
    throw Exception('Failed to get daily data');
  }
}

Future<dynamic> updateFilter(int chart_type, String number_of_data) async {
  Map<String, String> postData = {
    "username": networkService.username,
    "chart_type": chart_type.toString(),
    "number_of_data": number_of_data,
  };

  return await networkService.csrfProtectedPost(URL_UPDATE, postData, null);
}

Future<dynamic> getFilter() async {
  Map<String, String> postData = {
    "username": networkService.username,
  };

  return await networkService.csrfProtectedPost(URL_GET, postData, null);
}