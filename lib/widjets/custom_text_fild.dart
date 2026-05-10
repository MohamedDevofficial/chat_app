import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField( {super.key, required this.hintText, this.onChanged});
   String hintText ;
   Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
      },
      onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          );
       
       
  }
}