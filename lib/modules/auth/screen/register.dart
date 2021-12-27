import 'package:flutter/material.dart';
import 'package:icovid_app/core/core.dart';
import 'package:icovid_app/core/form/validator.dart';
import 'package:icovid_app/modules/auth/services/services.dart';
import 'package:icovid_app/modules/auth/widgets/snack_bar.dart';
import './constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final _formKey = GlobalKey<FormState>();

  String? _username = "";
  String? _password = "";
  String? _repeatPassword = "";
  bool _isLoading = false;
  String? _usernameErrorMsg = "";
  String? _passwordErrorMsg = "";

  @override
  Widget build(BuildContext context) {
    Widget buildUsernameErr() {
      if (_usernameErrorMsg != "") return Text(_usernameErrorMsg!, style: const TextStyle(color: Colors.red),);
      return const Text("", style: TextStyle(fontSize: 0),);
    }

    Widget buildPasswordErr() {
      if (_passwordErrorMsg != "") return Text(_passwordErrorMsg!, style: const TextStyle(color: Colors.red),);
      return const Text("", style: TextStyle(fontSize: 0),);
    }

    Widget buildLoadingMessage() {
      if (_isLoading) return const Text("Please wait");
      return const Text("", style: TextStyle(fontSize: 0),);
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
                const Text("Register", 
                  style: TextStyle(
                    fontSize: 35, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'username',
                    hintText: 'Letters, digits, and @/./+/-/_ only.',
                  ),
                  onChanged: (input) => _username = input,
                  validator: noEmptyValidator
                ),
                buildUsernameErr(),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: 'password',
                  ),
                  obscureText: true,
                  onChanged: (input) => _password = input,
                  validator: noEmptyValidator
                ),
                buildPasswordErr(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Text("\u2022 Password can't be too similar to username", style: TextStyle(color: Colors.grey),),
                      Text("\u2022 Password must contain at least 8 characters", style: TextStyle(color: Colors.grey)),
                      Text("\u2022 Password can't be a commonly used password", style: TextStyle(color: Colors.grey)),
                      Text("\u2022 Password can't be entirely numeric", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.vpn_key_outlined),
                    labelText: 'password confirmation',
                  ),
                  obscureText: true,
                  onChanged: (input) => _repeatPassword = input,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this form';
                    }
                    if (value != _password) {
                      return 'Password doesn\'t match';
                    }
                    return null;
                  }
                ),
                const SizedBox(height: 5),
                buildLoadingMessage(),
                const SizedBox(height: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  
                  onPressed: () async {
                    setState(() { _usernameErrorMsg = ""; });
                    setState(() { _passwordErrorMsg= ""; });
                    if (!_formKey.currentState!.validate()) return;
                    if (_isLoading) return;
                    setState(() { _isLoading = true; });

                    try {
                      dynamic response = await register(_username!, _password!, _repeatPassword!);

                      if (response['status'] == 200) {
                        networkService.username = _username;
                        Navigator.pushReplacementNamed(context, "/home");
                      } else {
                        if (response['data']['error']['username'] != null) {
                          setState(() { _usernameErrorMsg = response['data']['error']['username'][0];} );
                        }
                        if (response['data']['error']['password2'] != null) {
                          setState(() { _passwordErrorMsg = response['data']['error']['password2'][0];} );
                        }
                      }
                    } catch (e) {
                      showSnackBar(context, e.toString());
                    }

                    setState(() { _isLoading = false; });
                  }, 
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Register", 
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
                  onPressed: () {Navigator.pushReplacementNamed(context, '/login');}, 
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(double.infinity, 25)),
                    foregroundColor: MaterialStateProperty.all<Color?>(Colors.grey[200]),
                    overlayColor: MaterialStateProperty.all<Color?>(Colors.grey[400]),
                  ),
                  child: const Text("I have an account already", 
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
