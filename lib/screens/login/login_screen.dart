import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/profile/profile.dart';
import 'package:lomaysowdamuckup/screens/register/register.dart';
import 'package:lomaysowdamuckup/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final String message;

  const LoginScreen({Key key, this.message = ''}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;

  Widget message() {
    if (widget.message.isNotEmpty) {
      return Text(widget.message);
    }
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    final usernameField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Email address", Icons.email),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Password", Icons.lock),
    );
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait"),
      ],
    );
    final forgotLabel = FlatButton(
      padding: EdgeInsets.all(0.0),
      child: Text(delegate.forgot_password,
          style: TextStyle(fontWeight: FontWeight.w300)),
      onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
      },
    );
    var doLogin = () async {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        Session session = Provider.of<Session>(context, listen: false);
        await session.signIn(email: this._email, password: this._password);
        // Navigator.of(context).pop();
      } else {
        print("login form valid dal");
      }
    };

    return SafeArea(
      child: Scaffold(
        appBar: homeAppBar(context, title: delegate.login),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  message(),
                  SizedBox(height: 100.0),
                  label(delegate.login_email),
                  SizedBox(height: 5.0),
                  usernameField,
                  SizedBox(height: 20.0),
                  label(delegate.login_password),
                  SizedBox(height: 5.0),
                  passwordField,
                  SizedBox(height: 20.0),
                  CustomWidget(
                    doLogin: doLogin,
                    color: Colors.blue,
                    text: delegate.login,
                  ),
                  SizedBox(height: 5.0),
                  CustomWidget(
                    doLogin: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => RegisterScreen()));
                    },
                    color: Colors.green,
                    text: delegate.register,
                  ),
                  SizedBox(height: 5.0),
                  forgotLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    Key key,
    @required this.doLogin,
    @required this.color,
    @required this.text,
  }) : super(key: key);

  final Function() doLogin;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: RaisedButton(
        color: this.color,
        onPressed: this.doLogin,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
