import 'package:flutter/material.dart';
import 'package:icovid_app/modules/auth/services/services.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { 
        logout();
        Navigator.pushReplacementNamed(context, '/login');
      }, 
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: const Text("Logout"),
    );
  }
}
