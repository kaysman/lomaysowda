import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/login/login_screen.dart';
import 'package:lomaysowdamuckup/screens/profile/profile.dart';
import 'package:lomaysowdamuckup/utils.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File _image;
  final picker = ImagePicker();
  final formKey = new GlobalKey<FormState>();
  String _name, _email, _phone, _password, _password_confirmation;
  String _cityId, _typeId;

  Future getImage(int i) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 25,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image selected');
      }
    });
  }

  imgSelectContainer(File image, int i) {
    return image == null
        ? GestureDetector(
            onTap: () => getImage(i),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Center(
                    child: Icon(
                  Icons.photo_library,
                  size: 25,
                  color: Colors.black45,
                )),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => getImage(i),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.file(File(_image.path)),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final Session session = Provider.of<Session>(context, listen: false);
    final nameField = TextFormField(
      autofocus: false,
      validator: validatePassword,
      onSaved: (value) => _name = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );
    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Confirm password", Icons.email),
    );
    final phoneField = TextFormField(
      autofocus: false,
      validator: validatePassword,
      onSaved: (value) => _phone = value,
      decoration: buildInputDecoration("Confirm password", Icons.phone),
    );
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: validatePassword,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );
    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => validatePasswordConfir(value, _password),
      onSaved: (value) => _password_confirmation = value,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );
    final cityId = TextFormField(
      autofocus: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: buildInputDecoration("Confirm password", Icons.location_city),
    );
    final typeId = TextFormField(
      autofocus: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: buildInputDecoration("Confirm password", Icons.location_city),
    );

    Function onChanged = (String value) {
      setState(() {
        _typeId = value;
      });
    };

    Function onChanged2 = (String value) {
      setState(() {
        _cityId = value;
      });
    };

    // var loading = Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: <Widget>[
    //     CircularProgressIndicator(),
    //     Text(" Registering ... Please wait")
    //   ],
    // );

    var doRegister = () async {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        await session.register(
          data: {
            'name': _name,
            'email': _email,
            'phone': _phone,
            'password': _password,
            'password_confirmation': _password_confirmation,
            'city_id': 1,
            'type_id': 1,
          },
          files: {'photo': _image},
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => Profile(),
          ),
          ModalRoute.withName('/'),
        );
      } else {
        print('register form yalnys');
      }
    };
    final delegate = S.of(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.0),
                      imgSelectContainer(_image, 1),
                      SizedBox(height: 15.0),
                      label(delegate.register_activity),
                      SizedBox(height: 10.0),
                      formField(
                        context,
                        registerActivity["en"],
                        onChanged,
                        _typeId,
                      ),
                      SizedBox(height: 15.0),
                      label(delegate.register_provider_name),
                      SizedBox(height: 10.0),
                      nameField,
                      // next
                      SizedBox(height: 15.0),
                      label(delegate.register_email_address),
                      SizedBox(height: 10.0),
                      emailField,
                      SizedBox(height: 15.0),
                      label(delegate.register_phone),
                      SizedBox(height: 10.0),
                      phoneField,
                      SizedBox(height: 15.0),
                      label(delegate.register_password),
                      SizedBox(height: 10.0),
                      passwordField,
                      SizedBox(height: 15.0),
                      label(delegate.register_password_confirm),
                      SizedBox(height: 10.0),
                      confirmPassword,
                      SizedBox(height: 15.0),
                      label(delegate.register_location),
                      SizedBox(height: 10.0),
                      formField(
                        context,
                        registerLocation["en"],
                        onChanged2,
                        _cityId,
                      ),
                      SizedBox(height: 20.0),
                      session.isLogging
                          ? Center(child: CircularProgressIndicator())
                          : CustomWidget(
                              doLogin: doRegister,
                              color: Colors.blue,
                              text: delegate.register,
                            ),
                      SizedBox(height: 5.0),
                      CustomWidget(
                        doLogin: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                        color: Colors.green,
                        text: delegate.login,
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
