import 'package:firebase_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app/services/auth.dart';


class Register extends StatefulWidget {

  final Function toggleView;

  Register({required this.toggleView});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;



  //text field state
  String email = "";
  String password = "";
  String error = "";


  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
        title: Text("Sign Up to Brew Crew"),
        centerTitle: true,

        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Sign In")
          )
        ],
      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          //creating a form to take in email and password
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
              SizedBox(height: 20,),
                    // Form field to input the email
            TextFormField(
              //decoration to customize the form field of the email input
              decoration: InputDecoration(
                hintText: "Email",
                labelText: "Enter e-mail.",
                labelStyle: TextStyle(color: Colors.brown),

                prefixIcon: const Icon(
                Icons.email_rounded,
                color: Colors.brown,
                ),

                fillColor: Colors.white54,
                filled: true,
                //this border is when the email form field is not in focus
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown,width: 4.0)
                ),
                //this border is for when the email form field is in focus
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:Colors.white,width:4.0)
                ),
              ),

              validator: (val) {
                return val!.isEmpty ? 'Enter an email' : null;
              },
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },

            ),

            SizedBox(height: 20.0,),
            //Form field for the password which will be obscure
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
                labelText:"Enter Password",
                labelStyle: TextStyle(color: Colors.brown),

                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.brown,
                ),

                filled: true,
                fillColor: Colors.white54,

                enabledBorder: OutlineInputBorder(
                  borderSide:BorderSide(color: Colors.brown,width: 4)
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white,width: 4)
                ),



              ),


              obscureText: true,
              validator: (val) {
                return val!.length < 8
                    ? 'Enter a password of 8 characters'
                    : null;
              },
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
            ),

            SizedBox(height: 20.0,),

            RaisedButton(

                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),

                ),

                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error = "Please Register correctly";
                        loading = false;
                      }
                      );
                    }
                  }
                }


            ),

            SizedBox(height: 12.0),
              Text(
            error,
            style:
            TextStyle(color: Colors.red,
              fontSize: 14,
            )
              ),
              ],
      ),
    ),
      ),
    );
  }
}
