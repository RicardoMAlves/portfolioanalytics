import 'package:flutter/material.dart';
import 'package:portfolioanalytics/models/multilanguage.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  MultiLanguage _multiLanguage = MultiLanguage();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_multiLanguage.getLabelText("Login", "AppBar")),
        centerTitle: true,
        actions: [
          FlatButton(
            child: Text(
              _multiLanguage.getLabelText("Login", "FlatButton"),
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, "/signup");
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 140.0,
                        child: Image.asset(
                          "images/logo_viability3.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        // ignore: missing_return
                        validator: (text) {
                          if (text.isEmpty || !text.contains("@"))
                            return _multiLanguage.getLabelText("Login", "Email");
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: style,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Email",
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        // ignore: missing_return
                        validator: (text) {
                          if (text.isEmpty || text.length < 6)
                            return _multiLanguage.getLabelText("Login", "Password");
                        },
                        obscureText: true,
                        style: style,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: _multiLanguage.getLabelText("Login", "PasswordHint"),
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                      ),
                      SizedBox(height: 20.0),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xff01A0C7),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          child: Text(_multiLanguage.getLabelText("Login", "MaterialButton"),
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white, fontWeight: FontWeight.bold)),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Navigator.pushNamed(context, "/homepage");
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            _multiLanguage.getLabelText("Login", "AlignForgot"),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
