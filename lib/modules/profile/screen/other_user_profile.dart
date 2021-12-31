import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icovid_app/core/services/request.dart';
import 'package:icovid_app/modules/profile/widgets/app_bar.dart';

// void main() {
//   // menjalankan
//   runApp(MaterialApp(
//     title: 'iCovid - Profile',
//     theme: ThemeData(
//       brightness: Brightness.light,
//       fontFamily: 'Montserrat',
//       textTheme: const TextTheme(
//         headline6: TextStyle(fontSize: 26.0),
//       ),
//     ),
//     home: Profile(),
//   ));
// }

class OtherUserProfile extends StatefulWidget {
  const OtherUserProfile({Key? key}) : super(key: key);

  @override
  _OtherProfileState createState() => _OtherProfileState();
}


Future<List<dynamic>> fetchProfile() async {
  final response = await http.get(
      Uri.parse('https://icovid-id.herokuapp.com/profileapp/profile-datas/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> profiles = jsonDecode(response.body);
    return profiles;
  } else {
    throw Exception('Failed to load your profile');
  }
}

class _OtherProfileState extends State<OtherUserProfile> {
  late Future<List<dynamic>> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size / 12,
        child: AppBariCovid(),
      ),
      body: 
        FutureBuilder<List<dynamic>>(
            future: futureProfile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.all(25.0),
                        child: Card(
                          child: Column(children: [(
                              const Text(
                                '\n' + 'Profile' + '\n',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
                                textAlign: TextAlign.center,
                              )
                            ),
                            Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: ExactAssetImage(
                                        'lib/modules/profile/assets/avatar_2.png'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Icon(Icons.person_rounded,
                                        color: Colors.blue.shade300),
                                  ),
                                  Expanded(
                                    child: Text(
                                    snapshot.data![index]['fields']['name'],
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                      ),
                                  ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Icon(Icons.contact_phone_rounded,
                                        color: Colors.blue.shade300),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index]['fields']['phone'],
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Icon(Icons.location_pin,
                                        color: Colors.blue.shade300),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index]['fields']['city'],
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Icon(Icons.health_and_safety_rounded,
                                        color: Colors.blue.shade300),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index]['fields']['status'],
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Icon(Icons.healing_rounded,
                                        color: Colors.blue.shade300),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index]['fields']['vaccinated_status'],
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Icon(Icons.contact_mail_rounded,
                                        color: Colors.blue.shade300),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index]['fields']['bio'],
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )));
                  },
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: [Text('${snapshot.error}')],
                );
              }
              return const CircularProgressIndicator();
            })
    );
  }
}
