import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/brew.dart';
import 'package:firebase_app/models/user1.dart';
import 'package:firebase_app/screen/wrapper.dart';
import 'package:firebase_app/services/auth.dart';
import 'package:firebase_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        StreamProvider<List<Brew?>?>.value(

            value: DatabaseService().brews,
            initialData:[],
           catchError: (_,__)=>null,
        ),

        StreamProvider<User1?>.value(
          catchError: (_,__)=>null,
          value: AuthService().user,
          initialData: null,
        ),

      ],

        child: MaterialApp(
         home: Wrapper(),
        ),

    );
  }
}
