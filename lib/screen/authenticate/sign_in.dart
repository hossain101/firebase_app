import 'package:firebase_app/screen/authenticate/register.dart';
import 'package:firebase_app/services/auth.dart';
import 'package:firebase_app/shared/constants.dart';
import 'package:firebase_app/shared/loading.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {

   final  Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  //to initialize AuthService to be able to invoke anonSignIn

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title:Text('Sign In to Brew Crew'),
        centerTitle: true,
        actions:<Widget> [
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Register")
          )

        ],
      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children:<Widget> [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:"e-mail",labelText:"Enter e-mail.",prefixIcon:Icon(Icons.email,color: Colors.brown,)),

                validator: (val)=>val!.isEmpty? "Enter an Email":null,
                onChanged: (val){
                  setState(() =>email = val);
                },

              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Enter Password",
                  labelStyle: TextStyle(color:Colors.brown),


                  prefixIcon: Icon(Icons.password,color: Colors.brown,),

                  filled: true,
                  fillColor: Colors.white54,

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown,width: 4.0)
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,width: 4.0)
                  )


                ),

                validator:(val)=>val!.length<8? "Enter valid password":null,
                obscureText: true,
                onChanged: (val){
                  setState(() =>password=val);
                }
                ),
              SizedBox(height: 20.0,),

              RaisedButton(

                  color: Colors.pink[400],
                  child: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white),
                  ),
                  onPressed: ()async {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result= await _auth.signInWithEmailAndPassword(email, password);
                      if(result== null){
                        setState(() {
                          error="Please Sign in with a valid Email or Password";
                          loading = false;
                        });
                      }

                    }


                  }
              ),
              SizedBox(height: 12.0,),
              Text(
                  error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,

                ),

              )
            ],
          ),

        ),

      ),

    );
  }
}
