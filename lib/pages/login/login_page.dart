import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/config/validators.dart';
import 'package:lomaysowda/pages/profile/profile_page.dart';
import 'package:lomaysowda/pages/profile/provider/user_provider.dart';
import 'package:lomaysowda/utils/navigator.dart';
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

class LoginPageContainer extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        await state.login(data: data);
        if (state.isLoggedIn) {
          Future.delayed(Duration(milliseconds: 250), () {
            MyNavigator.pushAndRemove(ProfilePage());
          });
        } else {
          print('tazeden synansh (login).');
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
                  hintText: 'Username',
                ),
                MyTextFormField(
                  controller: _passwordController,
                  validator: validatePassword,
                  hintText: 'Password',
                ),
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
