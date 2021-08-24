import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/brew.dart';
import 'package:firebase_app/models/user1.dart';
import 'package:firebase_app/screen/home/settings_form.dart';
import 'package:firebase_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app/services/database.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  //const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user= Provider.of<User1?>(context);

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){return Container(
        padding: EdgeInsets.symmetric(horizontal: 7.0,vertical: 60.0),
        child:Provider(
          create: (_)=>User1(uid: user!.uid),
          child:SettingsForm(),


        ),





      );
      }
      );
    }

    return StreamProvider<List<Brew?>?>.value(
      value: DatabaseService().brews,
      initialData: [],
      catchError: (_,__)=>null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Brew Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
                onPressed: ()async{
                return  _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("Log Out")
            ),

            FlatButton.icon(
              onPressed: (){_showSettingsPanel();},

                icon: Icon(Icons.settings),
                label: Text('Settings'),

            ),

          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Roasted_coffee_beans.jpg'),
                fit: BoxFit.cover,

              ),
            ),

            child: BrewList()
        ),
      ),
    );
  }
}
