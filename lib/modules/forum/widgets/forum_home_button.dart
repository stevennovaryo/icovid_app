import 'package:flutter/material.dart';

class ForumHomeButton extends StatelessWidget {
  const ForumHomeButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { 
        Navigator.pushNamed(context, '/forumHome');
      }, 
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: const Text("Forum Home"),
    );
  }
}
