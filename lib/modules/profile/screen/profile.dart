import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:icovid_app/modules/profile/widgets/app_bar.dart';

import 'edit_profile.dart';

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

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
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

class _ProfileState extends State<Profile> {
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Column(children: [(
                              const Text(
                                'Profile',
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
                                        'assets/images/infected_avatar.png'),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue.shade300,
                                  ),
                                  child: const Text('Edit Profile'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => EditProfile(
                                                  getData: snapshot.data!,
                                                )));
                                  },
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                snapshot.data![index]['fields']['bio'],
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              child: const Text(
                                'About',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(25.0),
                                    child: Icon(Icons.people,
                                        color: Colors.blue.shade300),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index]['fields']['name'],
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
                                    child: Icon(Icons.email,
                                        color: Colors.blue.shade300),
                                  ),
                                  Expanded(
                                    child: Text(
                                      snapshot.data![index]['fields']['email'],
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
                                      snapshot.data![index]['fields']
                                          ['vaccinated_status'],
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )]));
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