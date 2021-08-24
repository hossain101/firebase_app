import 'package:firebase_app/models/user1.dart';
import 'package:firebase_app/services/database.dart';
import 'package:firebase_app/shared/loading.dart';
import 'package:flutter/material.dart';

import 'package:firebase_app/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey= GlobalKey<FormState>();
  final List<String> sugars=['0','1','2','3','4'];

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User1?>(context);

    return StreamBuilder<UserData?>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            UserData? userData = snapshot.data;


            return Form(
              key: _formKey,
              child: Column(
                children:<Widget> [
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height:20.0),
                  TextFormField(

                    initialValue: userData!.name,

                    decoration: textInputDecoration.copyWith(hintText: 'Please Enter your name'),
                    validator: (val)=>val!.isEmpty? 'Please Enter a name':null,
                    onChanged: (val)=>setState(()=>_currentName=val),
                  ),

                  SizedBox(height: 20.0,),

                  //dropdown
                  DropdownButtonFormField(
                    value: _currentSugars?? userData.sugars ,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white54,
                      enabledBorder: OutlineInputBorder(

                          borderSide: BorderSide(
                              color: Colors.brown,
                              width: 3.0
                          )

                      ),


                    ),
                    isDense: true,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Text('Please Select Sugars'),
                    ),
                    style:TextStyle(
                      color: Colors.brown,

                    ) ,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );

                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val.toString()),
                  ),


                  //slider
                  Expanded(
                    flex: 3,
                    child: Slider(

                        min: 100,
                        max: 900,
                        divisions: 8,
                        activeColor: Colors.brown[_currentStrength??userData.strength],
                        // inactiveColor: Colors.brown[_currentStrength??100],

                        value: ((_currentStrength)??userData.strength).toDouble(),
                        onChanged: (val)=> setState(()=> _currentStrength=val.round())),
                  ),


                  //button to update
                  RaisedButton(
                      color: Colors.brown[600],
                      child: Text('Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: ()async{
                       if(_formKey.currentState!.validate()){
                         await DatabaseService(uid: user.uid).updateUserData(
                             _currentSugars??userData.sugars,
                             _currentName?? userData.name,
                             _currentStrength??userData.strength);
                         Navigator.pop(context);
                       }


                      }),

                ],

              ),


            );
          }

          else{
                return Loading();
          }

        }
    );
  }
}
