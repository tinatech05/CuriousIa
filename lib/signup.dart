import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Service/dbservice.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Db db = new Db();
  int credit = 10;
  String _name, _email, _password, _id;
  List<String> votedfor = [];
  checkAuthincation() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  navigateToSignInScreen() {
    Navigator.pushReplacementNamed(context, '/signin');
  }

  signup() async {
    
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      try {
        AuthResult user = await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        final FirebaseUser users = user.user;
        _id = users.uid;


        if (user != null) {
          UserUpdateInfo userUpdateInfo = UserUpdateInfo();
          userUpdateInfo.displayName = _name;
          user.user.updateProfile(userUpdateInfo);
          print('hi');
        }
        
        setState(() {
          _id = _id;
          _name = _name;
          _email = _email;
        });
        db.addUser(context,
            id: _id,
            username: _name,
            mail: _email,
            credit: credit,
            votedfor: votedfor);
            Navigator.pushReplacementNamed(context, '/home');
      } 
      catch (e) {
        showError(e.toString());
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
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    this.checkAuthincation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff6bceff), Color(0xff6bceff)],
                  ),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32, right: 32),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formkey,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 62),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Username',
                        ),
                        onSaved: (input) => _name = input,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                        onSaved: (input) => _password = input,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                     // ignore: deprecated_member_use
                     RaisedButton(
                                padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(30),
                                ),
                                onPressed: signup,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                   /* InkWell(
                      child: GestureDetector(
                        onTap: () {
                          // ignore: unnecessary_statements
                          signup;
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff6bceff),
                                  Color(0xFF00abff),
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: Text(
                              'Sign Up'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Have an account ?"),
                  Text(
                    "Login",
                    style: TextStyle(color: Color(0xff6bceff)),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
