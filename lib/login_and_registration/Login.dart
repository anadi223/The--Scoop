import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:news_app/login_and_registration/register.dart';
import 'package:news_app/ui/news_page.dart';

const kButtonTextStyle = TextStyle(
    fontSize: 26.0,
    fontFamily: "VarelaRound",
    fontWeight: FontWeight.w600,
    color: Colors.white);

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall:showSpinner,
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
                          "Welcome Back",
                          style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "VarelaRound"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image.asset('assets/group.png'),
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
                              hoverColor: Color(0xff18afa5),
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
                              "Login",
                              style: kButtonTextStyle,
                            ),
                            onPressed: () async {
                              setState(() {
                                showSpinner = true;
                              });
                              try{
                                final newUser = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
                                if(newUser !=null){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>NewsPage()));
                                }
                                setState(() {
                                  showSpinner=false;
                                });
                              }catch(e){
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
                          GestureDetector(

                            onTap: () async{
                              setState(() {
                                showSpinner = true;
                              });
                              try{
                                GoogleSignIn googleSignIn = new GoogleSignIn();
                                GoogleSignInAccount account = await googleSignIn.signIn();
                                final result = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
                                    idToken: (await account.authentication).idToken,
                                    accessToken: (await account.authentication).accessToken,));
                                if(result != null){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>NewsPage()));
                                }setState(() {
                                  showSpinner = false;
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
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(3.0, 3.0),
                                        spreadRadius: 0.0,
                                        blurRadius: 7.0)
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        AssetImage('assets/google.png'),
                                    radius: 25.0,
                                  ),
                                  Text(
                                    "Sign In with Google",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "VarelaRound",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                        },
                        child: Text(
                    "New User? Register Now",
                    style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                          fontFamily: "VarelaRound",
                          color: Colors.blue[700]),
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
      {Key key,this.onPressed, this.text})
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
            color: Colors.black,
//              gradient: gradient,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(3.0, 2.0),
                  spreadRadius: 1.0,
                  blurRadius: 4.0,
                )
              ]),
        ),
      ),
    );
  }
}
