// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:icovid_app/modules/profile/screen/profile.dart';
// import 'package:icovid_app/modules/profile/widgets/app_bar.dart';

// class EditProfile extends StatefulWidget {
//   List<dynamic> getData;

//   EditProfile({Key? key, required this.getData}) : super(key: key);

//   @override
//   _EditProfileState createState() => _EditProfileState();
// }

// Future<List<dynamic>> fetchProfile() async {
//   final response = await http.get(
//       Uri.parse('https://icovid-id.herokuapp.com/profileapp/profile-datas/'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     List<dynamic> profile_data = jsonDecode(response.body);
//     return profile_data;
//   } else {
//     throw Exception('Failed to load your profile');
//   }
// }

// class _EditProfileState extends State<EditProfile> {
//   // final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController();
//   final TextEditingController _hsController = TextEditingController();
//   final TextEditingController _vsController = TextEditingController();
//   // final TextEditingController _createdacc = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // _usernameController.text = widget.getData[0]['fields']['name'];
//     _nameController.text = widget.getData[0]['fields']['name'].toString();
//     _emailController.text = widget.getData[0]['fields']['email'].toString();
//     _phoneController.text = widget.getData[0]['fields']['phone'].toString();
//     _cityController.text = widget.getData[0]['fields']['city'].toString();
//     _bioController.text = widget.getData[0]['fields']['bio'].toString();
//     _hsController.text = widget.getData[0]['fields']['status'].toString();
//     _vsController.text = widget.getData[0]['fields']['vaccinated_status'].toString();
//     // _createdacc.text = widget.getData[0]['fields']['created_at'];
//   }

//   final _formKey = GlobalKey<FormState>();

//   // Initial Selected Value for Healthy Status
//   String dropdownHSValue = "Not Infected";

//   // List of items in our dropdown menu for Healthy Status
//   var itemsHS = [
//     'Infected',
//     'Not Infected',
//   ];

//   // Initial Selected Value for Vaccination Status
//   String dropdownVSValue = "Fully Vaccinated";

//   // List of items in our dropdown menu for Vaccination Status
//   var itemsVS = [
//     'Fully Vaccinated',
//     'First Dose',
//     'Not Vaccinated',
//   ];

//   String currVS = '';
//   String currsHS = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: MediaQuery.of(context).size / 12,
//           child: AppBariCovid(),
//         ),
//         body: SingleChildScrollView(
//             padding: const EdgeInsets.all(25.0),
//             physics: const ScrollPhysics(),
//             key: _formKey,
//             child: Column(children: [
//               Container(
//                 alignment: Alignment.center,
//                 height: 10.0,
//                 child: const Text(
//                   'Edit Profile',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Column(children: [
//                 Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Stack(
//                       fit: StackFit.loose,
//                       children: <Widget>[
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Container(
//                                 width: 140.0,
//                                 height: 140.0,
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   image: DecorationImage(
//                                     image: ExactAssetImage(
//                                         'lib/modules/profile/assets/avatar_2.png'),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 )),
//                           ],
//                         )
//                       ],
//                     )),
//                 Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20.0, right: 20.0, top: 10.0),
//                     child: Column(children: [
//                       TextField(
//                         controller: _nameController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your name",
//                           labelText: "Name",
//                           icon: const Icon(Icons.people),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                         ),
//                       )
//                     ])),
//                 Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20.0, right: 20.0, top: 10.0),
//                     child: Column(children: [
//                       TextField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your email",
//                           labelText: "Email",
//                           icon: const Icon(Icons.email),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                         ),
//                       )
//                     ])),
//                 Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20.0, right: 20.0, top: 10.0),
//                     child: Column(children: [
//                       TextField(
//                         controller: _phoneController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your phone number",
//                           labelText: "Phone Number",
//                           icon: const Icon(Icons.contact_phone_rounded),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                         ),
//                       )
//                     ])),
//                 Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20.0, right: 20.0, top: 10.0),
//                     child: Column(children: [
//                       TextField(
//                         controller: _cityController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your city",
//                           labelText: "City",
//                           icon: const Icon(Icons.location_pin),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                         ),
//                       )
//                     ])),
//                 Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20.0, right: 20.0, top: 10.0),
//                     child: Column(children: [
//                       TextField(
//                         controller: _bioController,
//                         maxLines: 4,
//                         decoration: InputDecoration(
//                           hintText: "Enter your bio",
//                           labelText: "Bio",
//                           icon: const Icon(Icons.notes_rounded),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0)),
//                         ),
//                       )
//                     ])),
//                 Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20.0, right: 20.0, top: 20.0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Expanded(
//                           child: Container(
//                             child: const Text(
//                               'Healthy Status',
//                               style: TextStyle(
//                                 fontSize: 15.0,
//                               ),
//                             ),
//                           ),
//                           flex: 2,
//                         ),
//                         Expanded(
//                           child: Container(
//                             child: const Text(
//                               'Vaccination Status',
//                               style: TextStyle(
//                                 fontSize: 15.0,
//                               ),
//                             ),
//                           ),
//                           flex: 2,
//                         ),
//                       ],
//                     )),
//                 Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20.0, right: 20.0, top: 10.0),
//                     child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Flexible(
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: <Widget>[
//                                 DropdownButton(
//                                   value: dropdownHSValue,
//                                   icon: const Icon(Icons.keyboard_arrow_down),
//                                   items: itemsHS.map((String items) {
//                                     return DropdownMenuItem(
//                                       value: items,
//                                       child: Text(items),
//                                     );
//                                   }).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(() {
//                                       currsHS = (dropdownHSValue = newValue!);
//                                     });
//                                   },
//                                 )
//                               ],
//                             ),
//                             flex: 2,
//                           ),
//                           Flexible(
//                             child: Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   DropdownButton(
//                                     value: dropdownVSValue,
//                                     icon: const Icon(Icons.keyboard_arrow_down),
//                                     items: itemsVS.map((String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(items),
//                                       );
//                                     }).toList(),
//                                     onChanged: (String? newValue) {
//                                       setState(() {
//                                         currVS = (dropdownVSValue = newValue!);
//                                       });
//                                     },
//                                   ),
//                                 ]),
//                             flex: 2,
//                           ),
//                         ])),
//                 Container(
//                   child: Column(
//                     children: [
//                       ElevatedButton(
//                           child: const Text(
//                             "Save Changes",
//                             style: TextStyle(fontSize: 18),
//                           ),
//                           onPressed: () async {
//                             final http.Response response = await http.post(
//                                 Uri.parse(
//                                     'https://icovid-id.herokuapp.com/profileapp/profile-datas/'),
//                                 body: {
//                                   "name": _nameController.text,
//                                   "email": _emailController.text,
//                                   "phone": _phoneController.text,
//                                   "city": _cityController.text,
//                                   "bio": _bioController.text,
//                                   "status": _hsController.text,
//                                   "vaccinated_status": _vsController.text,
//                                 });
//                             if (response.statusCode == 200) {
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) =>
//                                       const AlertDialog(
//                                         title: Text(
//                                             'Your profile has been changes!'),
//                                       ));
//                             } else {
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) =>
//                                       const AlertDialog(
//                                         title: Text('Something went wrong!'),
//                                       ));
//                             }
//                             Navigator.push(
//                                 context,
//                                 CupertinoPageRoute(
//                                     builder: (context) => Profile()));
//                           })
//                     ],
//                   ),
//                 ),
//               ])
//             ])));
//   }
// }
