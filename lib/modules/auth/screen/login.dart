import 'package:flutter/material.dart';
import 'package:icovid_app/core/form/validator.dart';
import 'package:icovid_app/core/services/request.dart';
import 'package:icovid_app/modules/auth/services/services.dart';
import 'package:icovid_app/modules/auth/widgets/snack_bar.dart';
import './constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _formKey = GlobalKey<FormState>();

  String? _username = "";
  String? _password = "";
  bool _isLoading = false;
  String? _errorMsg = "";

  @override
  Widget build(BuildContext context) {
    Widget buildMessageText() {
      if (_isLoading) return const Text("Please wait");
      if (_errorMsg != "") return Text(_errorMsg!, style: const TextStyle(color: Colors.red),);
      return const Text("");
    }

    return Scaffold(
      backgroundColor: BG_COLOR,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(25.0),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Login", 
                  style: TextStyle(
                    fontSize: 35, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 45),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'username',
                  ),
                  onChanged: (input) => _username = input,
                  validator: noEmptyValidator
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: 'password',
                  ),
                  obscureText: true,
                  onChanged: (input) => _password = input,
                  validator: noEmptyValidator
                ),
                const SizedBox(height: 5),
                buildMessageText(),
                const SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  
                  onPressed: () async {
                    setState(() { _errorMsg = ""; });
                    if (_isLoading) return;
                    if (!_formKey.currentState!.validate()) return;
                    setState(() { _isLoading = true; });

                    try {
                      dynamic response = await login(_username!, _password!);

                      if (response['status'] == 200) {
                        networkService.username = _username;
                        Navigator.pushReplacementNamed(context, "/home");
                      } else {
                        setState(() { _errorMsg = response['data']['message'];} );
                      }
                    } catch (e) {
                      showSnackBar(context, e.toString());
                    }

                    setState(() { _isLoading = false; });
                  }, 
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Login", 
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {Navigator.pushReplacementNamed(context, '/register');}, 
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(double.infinity, 25)),
                    foregroundColor: MaterialStateProperty.all<Color?>(Colors.grey[200]),
                    overlayColor: MaterialStateProperty.all<Color?>(Colors.grey[400]),
                  ),
                  child: const Text("I have yet to register", 
                    style: TextStyle(
                      color: Colors.blue, 
                      fontWeight: FontWeight.bold, 
                      fontSize: 20,
                    )
                  )
                )
              ],
            )
          ),
        ),
      )
    );
  }
}