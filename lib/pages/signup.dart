import 'package:flutter/material.dart';
import 'package:portfolioanalytics/models/multilanguage.dart';
import 'package:portfolioanalytics/models/users.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  MultiLanguage _multiLanguage = MultiLanguage();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_multiLanguage.getLabelText("SignUp", "CreateAccount")),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ScopedModelDescendant<Users>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
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
                          TextFormField(
                            controller: _nameController,
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty)
                                return _multiLanguage.getLabelText("SignUp", "InvalidName");
                            },
                            style: style,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: _multiLanguage.getLabelText("SignUp", "Name"),
                                border:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: _emailController,
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty || !text.contains("@"))
                                return _multiLanguage.getLabelText("SignUp", "InvalidEmail");
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
                            controller: _passwordController,
                            // ignore: missing_return
                            validator: (text) {
                              if (text.isEmpty || text.length < 6)
                                return _multiLanguage.getLabelText("SignUp", "InvalidEmail");
                            },
                            obscureText: true,
                            style: style,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: _multiLanguage.getLabelText("SignUp", "Password"),
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
                              child: Text(_multiLanguage.getLabelText("SignUp", "Create"),
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white, fontWeight: FontWeight.bold)),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  Map<String, dynamic> userData = {
                                    "name": _nameController.text,
                                    "email": _emailController.text
                                  };
                                  model.signUp(
                                      userData: userData,
                                      pass: _passwordController.text,
                                      onSuccess: _onSuccess,
                                      onFail: _onFail);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "Usuário criado com sucesso",
          ),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 3),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            "Falha ao criar o usuário",
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        )
    );
  }

}
