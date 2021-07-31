import 'package:flutter/material.dart';
import 'package:flutter_sqflite_app/Data/database_helper.dart';
import 'package:flutter_sqflite_app/Models/user.dart';
import 'package:flutter_sqflite_app/Pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  late BuildContext _ctx;
  late bool _isLoading;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String? _username, _password;

  late LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }
  void _submit() {
    final form = formKey.currentState;

    if (form!.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username!, _password!);
      });
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("login"),
      color: Colors.green,
    );
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Text(
          "Sqflite App Login",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: Column(
            children: [
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(
                    labelText: ("Username"),
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(
                    labelText: ("Password"),
                  ),
                ),
              ),
            ],
          ),
        ),
        loginBtn,
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      key: scaffoldKey,
      body: Container(
        child: Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    _showSnackBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }
}
