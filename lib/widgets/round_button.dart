

import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading; 
  final VoidCallback onTap;

  const RoundButton({super.key, 
  required this.title,
    this.loading = false,
   required this.onTap
 
   
   });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), // Add padding for better appearance
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading ? const CircularProgressIndicator(strokeWidth: 3, color: Colors.white,) :
           Text(  title,
            style: TextStyle(color: Colors.white, fontSize: 16.0), // Optional: Adjust font size
          ),
        ),
      ),
    );
  }
}
