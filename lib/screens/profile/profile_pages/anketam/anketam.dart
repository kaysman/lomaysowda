import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lomaysowdamuckup/constaints.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/model/user.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/login/login_screen.dart';
import 'package:lomaysowdamuckup/screens/profile/profile.dart';
import 'package:lomaysowdamuckup/utils.dart';
import 'package:provider/provider.dart';

class Antekam extends StatefulWidget {
  @override
  _AntekamState createState() => _AntekamState();
}

class _AntekamState extends State<Antekam> {
  UserPreferences userPreferences = UserPreferences();
  FlutterSecureStorage _storage = FlutterSecureStorage();
  User _user;

  Future<User> geT() async {
    String _token;
    await _storage.read(key: "token").then((value) {
      _token = value;
    });
    _user = await userPreferences.getUser(_token);
    return _user;
  }

  @override
  void initState() {
    geT();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, title: 'Anketam'),
      body: FutureBuilder<User>(
        future: geT(),
        builder: (_, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return AnketamPage();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Getting user info'),
                  SizedBox(height: 15),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class AnketamPage extends StatefulWidget {
  @override
  _AnketamPageState createState() => _AnketamPageState();
}

class _AnketamPageState extends State<AnketamPage> {
  Session session;
  String _name,
      _phone,
      _phone2,
      _email,
      _email2,
      _address,
      _website,
      _keywords,
      _desc;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // images
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
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

  imgSelectContainer(File image) {
    return image == null
        ? GestureDetector(
            onTap: () => getImage(),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: CachedNetworkImage(
                  imageUrl: session.authenticatedUser.image,
                  placeholder: (context, url) => Container(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => getImage(),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }

  @override
  void initState() {
    session = Provider.of<Session>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      initialValue: session.authenticatedUser.name,
      autofocus: false,
      validator: validatePassword,
      onSaved: (value) => _name = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );

    final emailField = TextFormField(
      initialValue: session.authenticatedUser.email,
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _email = value,
      decoration: buildInputDecoration("Email address", Icons.email),
    );

    final emailField2 = TextFormField(
      autofocus: false,
      onSaved: (value) => _email2 = value,
      decoration: buildInputDecoration("Email address", Icons.email),
    );

    final phoneField = TextFormField(
      initialValue: session.authenticatedUser.phone,
      autofocus: false,
      validator: validatePassword,
      onSaved: (value) => _phone = value,
      decoration: buildInputDecoration("Confirm password", Icons.phone),
    );
    final phoneField2 = TextFormField(
      autofocus: false,
      onSaved: (value) => _phone2 = value,
      decoration: buildInputDecoration("Confirm password", Icons.phone),
    );

    final address = TextFormField(
      autofocus: false,
      onSaved: (value) => _address = value,
      decoration: buildInputDecoration("Confirm password", Icons.phone),
    );

    final website = TextFormField(
      initialValue: session.authenticatedUser.website,
      autofocus: false,
      onSaved: (value) => _website = value,
      decoration: buildInputDecoration("Confirm password", Icons.phone),
    );

    final keywords = TextFormField(
      autofocus: false,
      onSaved: (value) => _keywords = value,
      decoration: buildInputDecoration("Confirm password", Icons.phone),
    );

    final desc = TextFormField(
      onSaved: (value) => _desc = value,
      autofocus: false,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      minLines: 3,
      decoration: buildInputDecoration("Confirm password", Icons.phone),
    );

    final login = FlatButton(
      padding: EdgeInsets.all(0.0),
      child: Text(
        'Login',
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/login');
      },
    );

    var updateDetails = () async {
      final form = _formkey.currentState;
      if (form.validate()) {
        form.save();
        Map<String, File> map = _image == null ? null : {'image': _image};
        bool updated = await session.updateMe(
          id: session.authenticatedUser.id,
          data: <String, String>{
            'name': _name,
            'phone': _phone,
            'phone2': _phone2,
            'email': _email,
            'email2': _email2,
            'address': _address,
            'website': _website,
            'keywords': _keywords,
            'desc': _desc,
          },
          files: map,
        );
        if (updated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => Profile()),
            ModalRoute.withName('/'),
          );
        }
      } else {
        print('register form yalnys');
      }
    };

    return ListView(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.0),
                imgSelectContainer(_image),
                SizedBox(height: 20.0),
                label("Adynyz: "),
                SizedBox(height: 5.0),
                nameField,
                SizedBox(height: 15.0),
                label("Telefon: "),
                SizedBox(height: 5.0),
                phoneField,
                SizedBox(height: 15.0),
                label("Telefon 2: "),
                SizedBox(height: 5.0),
                phoneField2,
                SizedBox(height: 15.0),
                label("Email: "),
                SizedBox(height: 5.0),
                emailField,
                SizedBox(height: 15.0),
                label("Email 2: "),
                SizedBox(height: 5.0),
                emailField2,
                SizedBox(height: 15.0),
                label("Salgy: "),
                SizedBox(height: 5.0),
                address,
                SizedBox(height: 15.0),
                label("Website: "),
                SizedBox(height: 5.0),
                website,
                SizedBox(height: 15.0),
                label("Degisli sozler: "),
                SizedBox(height: 5.0),
                keywords,
                SizedBox(height: 15.0),
                label("Maglumat: "),
                SizedBox(height: 5.0),
                desc,
                SizedBox(height: 30.0),
                CustomWidget(
                  doLogin: updateDetails,
                  color: kPrimaryColor,
                  text: 'Register',
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hasabyñ barmy?'),
                    SizedBox(width: 30),
                    login,
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
