import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(

  labelStyle: TextStyle(color: Colors.brown),
  filled:true,
  fillColor: Colors.white54,

  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.brown,
      width: 4.0
    )
  ),

    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
    color: Colors.white,
      width: 4.0
)
)
  



);