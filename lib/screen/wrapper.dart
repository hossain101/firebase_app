import 'package:firebase_app/models/user1.dart';
import 'package:firebase_app/screen/authenticate/authenticate.dart';
import 'package:firebase_app/screen/authenticate/register.dart';
import 'package:firebase_app/screen/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User1?>(context);
    print(user);
    //return either home or authenticate widget
    if (user== null){
      return  Authenticate();
    }
    else{
      return Home();
    }

  }
}
