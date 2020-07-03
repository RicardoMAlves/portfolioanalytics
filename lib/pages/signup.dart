import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final _nameField = TextFormField(
      validator: (text) {
        if (text.isEmpty)
          return "Invalid Name.";
      },
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final _emailField = TextFormField(
      validator: (text) {
        if (text.isEmpty || !text.contains("@"))
          return "Invalid Email.";
      },
      keyboardType: TextInputType.emailAddress,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final _passwordField = TextFormField(
      validator: (text) {
        if (text.isEmpty || text.length < 6)
          return "Invalid Password.";
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final _createButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text("Create",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () {
          if (_formKey.currentState.validate()) {}
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
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
                      SizedBox(height: 15.0),
                      _nameField,
                      SizedBox(height: 20.0),
                      _emailField,
                      SizedBox(height: 20.0),
                      _passwordField,
                      SizedBox(height: 20.0),
                      _createButon,
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