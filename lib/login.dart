import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
 /* Intialize FirebaseAuth & GoogleSignIn and give an instance */

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /* Creating key to check FormState(status) */

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _email, _passwaord;

  /* Checking whether the user is logged in or not when App starts */

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  /* Method for Navigation to Sign Up page (optional) */

  navigateToSignUpScreen() {
    Navigator.pushReplacementNamed(context, '/signup');
  }

  /* Whenever App starts/restarts i.e. a lifecylce finishes 
     and starts again following methods are executed   
  */
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    this.checkAuthentication();

  }
   void signin() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      try {
        // ignore: unused_local_variable
        AuthResult user = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _passwaord,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Warning"),
              content: Text('Wrong email or passeword'),
            );
          },
        );
      
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff6bceff),
                    Color(0xff6bceff)
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 32,
                          right: 32
                        ),
                        child: Text('Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                      ),
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                      top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5
                        )
                      ]
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.person,
                            color: Color(0xff6bceff),
                        ),
                          hintText: 'E-mail',
                      ),
                      onSaved: (input) => _email = input,
                    ),
                  ),
                  
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.vpn_key,
                          color: Color(0xff6bceff),
                        ),
                        hintText: 'Password',
                      ),
                        onSaved: (input) => _passwaord = input,
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16, right: 32
                      ),
                      child: Text('Forgot Password ?',
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ),
                  ),
                  Spacer(),

                  InkWell(
                      onTap: (){
                       signin;
                      },
                      child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff6bceff),
                            Color(0xFF00abff),
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        )
                      ),
                      child: Center(
                        child: Text('Login'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account ?"),
                  Text("Sign Up",style: TextStyle(color: Color(0xff6bceff)),),
                ], 
              ),
              onTap: (){
                Navigator.pushNamed(context, '/signup');
              },
            ),           
          ],
          
        ),
      ),
    );
  }
}