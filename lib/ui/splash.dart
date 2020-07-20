
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/login_and_registration/Login.dart';
import 'package:news_app/login_and_registration/register.dart';



class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Color.fromARGB(140, 10, 20, 30),
                BlendMode.srcOver,
              ),
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/news.jpg',
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text.rich(
                  TextSpan(
                      text: "The ",
                      style: TextStyle(
                          fontSize: 60.0,
                          color: Colors.white,
                          fontFamily: "Pacifico"),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Scoop",
                            style: TextStyle(
                                fontSize: 60.0,
                                color: Colors.white,
                                fontFamily: "Pacifico",
                                decoration: TextDecoration.underline))
                      ]),
                ),
              ),
              SizedBox(height: 60.0,),
              ReusableMaterialButton(
                text: Text("Login",style: TextStyle(fontSize: 22.0,fontFamily: "VarelaRound",color: Colors.white),),
                color: Colors.black,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
              ),
              ReusableMaterialButton(
                text: Text("Register",style: TextStyle(fontFamily: "VarelaRound",fontSize: 22.0,color: Colors.black),),
                color: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                },
              ),
            ],
          )),
    );
  }
}

class ReusableMaterialButton extends StatelessWidget {
  final Text text;
  final Function onPressed;
  final Color color;

  const ReusableMaterialButton({Key key, this.text, this.onPressed, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:20.0,right: 20.0,bottom: 20.0),
      child: MaterialButton(
          elevation: 7.0,
          child: text,
          color: color,
          onPressed: onPressed,
          height: 60.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))
      ),
    );
  }
}
