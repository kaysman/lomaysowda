import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/config/validators.dart';
import 'package:lomaysowda/pages/profile/provider/user_provider.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_custom_button.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:lomaysowda/widgets/my_textformfield.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        leadingType: AppBarBackType.None,
      ),
      body: SafeArea(
        child: LoginPageContainer(),
      ),
    );
  }
}

class LoginPageContainer extends StatefulWidget {
  @override
  _LoginPageContainerState createState() => _LoginPageContainerState();
}

class _LoginPageContainerState extends State<LoginPageContainer> {
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // login function
    var doLogin = () async {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        Map<String, String> data = {
          'email': _usernameController.text,
          'password': _passwordController.text,
        };
        final state = Provider.of<UserProvider>(context, listen: false);
        await state.login(data: data);
        // if (state.getUser) {
        //   Future.delayed(Duration(milliseconds: 250), () {
        //     MyNavigator.pop();
        //   });
        // } else {
        //   print('tazeden synansh (login).');
        // }
      } else {
        print('form validation failed');
      }
    };
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            MyTextFormField(
              controller: _usernameController,
              validator: validateName,
              hintText: 'login_email'.tr,
              onChanged: (v) {},
              onSaved: (v) {},
            ),
            MyTextFormField(
              controller: _passwordController,
              validator: validatePassword,
              hintText: 'login_password'.tr,
              onChanged: (v) {},
              onSaved: (v) {},
            ),
            Consumer<UserProvider>(
              builder: (_, state, child) {
                return state.loading
                    ? MyLoadingWidget()
                    : MyCustomButton(
                        onTap: doLogin,
                        text: 'login'.tr,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
