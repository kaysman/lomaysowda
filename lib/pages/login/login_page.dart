import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/config/validators.dart';
import 'package:lomaysowda/pages/profile/profile_page.dart';
import 'package:lomaysowda/pages/profile/provider/user_provider.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_custom_button.dart';
import 'package:lomaysowda/widgets/my_textformfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: Scaffold(
        appBar: MyAppBar(
          context: context,
          leadingType: AppBarBackType.None,
        ),
        body: SafeArea(
          child: LoginPageContainer(),
        ),
      ),
    );
  }
}

class LoginPageContainer extends StatefulWidget {
  @override
  _LoginPageContainerState createState() => _LoginPageContainerState();
}

class _LoginPageContainerState extends State<LoginPageContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  String savedName;
  String nameError;

  final TextEditingController _passwordController = TextEditingController();
  String savedPassword;
  String passwordError;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<UserProvider>(context);
    // login function
    var doLogin = () async {
      if (_formKey.currentState.validate()) {
        Map<String, String> data = {
          'email': _usernameController.text,
          'password': _passwordController.text,
        };
        final res = await state.login(data: data);
        print(res);
        if (res) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => ProfilePage()),
              (route) => false);
        }
      } else {
        print('form validation failed');
      }
    };
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyTextFormField(
                  controller: _usernameController,
                  validator: validateName,
                  onChanged: (v) {
                    setState(() {});
                  },
                  onSaved: (v) => savedName = v,
                  hintText: 'Username',
                ),
                const SizedBox(height: 12),
                MyTextFormField(
                  controller: _passwordController,
                  validator: validatePassword,
                  onChanged: (v) {
                    if (passwordError != null) {
                      setState(() => passwordError = null);
                    }
                  },
                  onSaved: (v) => savedPassword = v,
                  hintText: 'Password',
                ),
                const SizedBox(height: 8),
                state.loading
                    ? CupertinoActivityIndicator()
                    : MyCustomButton(
                        onTap: doLogin,
                        text: 'Login',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
