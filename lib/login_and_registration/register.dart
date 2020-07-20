import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:news_app/login_and_registration/Login.dart';
import 'package:news_app/ui/news_page.dart';


const kButtonTextStyle = TextStyle(
    fontSize: 26.0,
    fontFamily: "VarelaRound",
    fontWeight: FontWeight.w600,
    color: Colors.white);

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
        backgroundColor: Color(0xff4fc3f7),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.only(top: 60.0, left: 25, right: 25),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Let's get you set up",
                            style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "VarelaRound"),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset('assets/group2.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 2.0,
                      width: MediaQuery.of(context).size.width - 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.0,
                            blurRadius: 7.0,
                            offset: Offset(4.0, 4.0),
                          )
                        ],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Enter your Email",
                                hoverColor: Color(0xff18afa5),
                              ),
                              onChanged: (value) {
                                _email = value;
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Enter your password",
                              ),
                              onChanged: (value) {
                                _password = value;
                              },
                            ),
                            SizedBox(
                              height: 40.0,
                            ),
                            ReusableMaterialButton(
                              text: Text(
                                "Register",
                                style: kButtonTextStyle,
                              ),
                              onPressed: () async{
                                setState(() {
                                  showSpinner = true;
                                });
                                try{
                                  final newUser = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
                                  if(newUser !=null){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage()));
                                  }
                                  setState(() {
                                    showSpinner=false;
                                  });
                                }catch(e){
                                  print(e);
                                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    backgroundColor: Colors.red[800],
                                    content: Text("Something went wrong! Try again"),
                                    duration: Duration(seconds: 10),
                                  ));
                                }
                              },
                            ),
                            SizedBox(
                              height: 14.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Center(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>LoginPage()));
                          },
                          child: Text(
                            "Already have account? Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                fontFamily: "VarelaRound",
                                color: Colors.black),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}


class ReusableMaterialButton extends StatelessWidget {
  final Function onPressed;
  final Text text;
  const ReusableMaterialButton(
      {Key key, this.onPressed, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 60.0,
          child: Center(child: text),
          decoration: BoxDecoration(
            color: Colors.blue[800],
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(3.0, 2.0),
                  spreadRadius: 0.0,
                  blurRadius: 4.0,
                )
              ]),
        ),
      ),
    );
  }
}