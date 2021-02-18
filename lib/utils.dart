import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lomaysowdamuckup/model/user.dart';

import 'constaints.dart';

class Commons {
  static const baseURL = "http://lomaysowda.com.tm/api/";
  static const TextStyle headingTextStyle = TextStyle(
    fontFamily: 'Montserrat-Bold',
    fontSize: 19.0,
    color: Colors.black,
  );

  static const TextStyle productTitleStyle = TextStyle(
    fontFamily: 'Montserrat-Regular',
    fontSize: 9.0,
    color: Color(0xFF5F4F84),
  );
  static const TextStyle splashTextStyle = TextStyle(
    fontFamily: 'Montserrat-Regular',
    fontSize: 25.0,
    color: Color(0xFF5F4F84),
  );

  static Widget headingTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: headingTextStyle,
            )
          ],
        ),
      ),
    );
  }
}

class UserPreferences {
  FlutterSecureStorage secureStorage;
  UserPreferences() {
    this.secureStorage = FlutterSecureStorage();
  }
  // save user
  Future<void> saveUser(User user) async {
    await secureStorage.write(key: 'id', value: user.id.toString());
    await secureStorage.write(key: 'name', value: user.name.toString());
    await secureStorage.write(key: 'email', value: user.email.toString());
    await secureStorage.write(key: 'email2', value: user.email2.toString());
    await secureStorage.write(key: 'phone', value: user.phone.toString());
    await secureStorage.write(key: 'phone2', value: user.phone2.toString());
    await secureStorage.write(key: 'image', value: user.image.toString());
    await secureStorage.write(key: 'address', value: user.address.toString());
    await secureStorage.write(key: 'website', value: user.website.toString());
    await secureStorage.write(key: 'type_id', value: user.type_id.toString());
    await secureStorage.write(key: 'city_id', value: user.city_id.toString());
    await secureStorage.write(key: 'checked', value: user.checked.toString());
    await secureStorage.write(key: 'trusted', value: user.trusted.toString());
    await secureStorage.write(key: 'preview', value: user.preview.toString());
    await secureStorage.write(
        key: 'email_verified_at', value: user.email_verified_at.toString());
    await secureStorage.write(
        key: 'created_at', value: user.created_at.toString());
  }

  // get user
  Future<User> getUser(String token) async {
    // if (token != null) {
    int id, type_id, city_id, checked, trusted, preview;
    String name,
        email,
        email2,
        phone,
        phone2,
        image,
        address,
        website,
        email_verified_at,
        created_at;
    await secureStorage.read(key: 'id').then((value) => id = int.parse(value));
    await secureStorage.read(key: 'name').then((value) => name = value);
    await secureStorage.read(key: 'email').then((value) => email = value);
    await secureStorage.read(key: 'email2').then((value) => email2 = value);
    await secureStorage.read(key: 'phone').then((value) => phone = value);
    await secureStorage.read(key: 'phone2').then((value) => phone2 = value);
    await secureStorage.read(key: 'image').then((value) => image = value);
    await secureStorage.read(key: 'address').then((value) => address = value);
    await secureStorage.read(key: 'website').then((value) => website = value);
    await secureStorage
        .read(key: 'type_id')
        .then((value) => type_id = int.parse(value));
    await secureStorage
        .read(key: 'city_id')
        .then((value) => city_id = int.parse(value));
    await secureStorage
        .read(key: 'checked')
        .then((value) => checked = int.parse(value));
    await secureStorage
        .read(key: 'trusted')
        .then((value) => trusted = int.parse(value));
    await secureStorage
        .read(key: 'preview')
        .then((value) => preview = int.parse(value));
    await secureStorage
        .read(key: 'email_verified_at')
        .then((value) => email_verified_at = value);
    await secureStorage
        .read(key: 'created_at')
        .then((value) => created_at = value);
    print(id);
    print(name);
    print(phone);
    return User(
      id: id,
      name: name,
      email: email,
      email2: email2,
      phone: phone,
      phone2: phone2,
      image: image,
      address: address,
      website: website,
      type_id: type_id,
      city_id: city_id,
      checked: checked,
      trusted: trusted,
      preview: preview,
      email_verified_at: email_verified_at,
      created_at: created_at,
    );
    // } else {
    //   return null;
    // }
  }

  // remove user
  Future<void> removeUser() async {
    await secureStorage.delete(key: 'id');
    await secureStorage.delete(key: 'name');
    await secureStorage.delete(key: 'email');
    await secureStorage.delete(key: 'email2');
    await secureStorage.delete(key: 'phone');
    await secureStorage.delete(key: 'phone2');
    await secureStorage.delete(key: 'image');
    await secureStorage.delete(key: 'address');
    await secureStorage.delete(key: 'website');
    await secureStorage.delete(key: 'type_id');
    await secureStorage.delete(key: 'city_id');
    await secureStorage.delete(key: 'checked');
    await secureStorage.delete(key: 'trusted');
    await secureStorage.delete(key: 'preview');
    await secureStorage.delete(key: 'email_verified_at');
    await secureStorage.delete(key: 'created_at');
  }

  Future<String> getToken() async {
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'token');
  }

  Future<DateTime> getTokenTime() async {
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    DateTime time;
    await secureStorage
        .read(key: 'tokenTime')
        .then((value) => time = DateTime.parse(value));
    return time;
  }

  Future<void> removeToken() async {
    FlutterSecureStorage secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'token');
  }
}

String validateEmail(String value) {
  String _msg;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value.isEmpty) {
    _msg = "Bos goymaly dal";
  } else if (!regex.hasMatch(value)) {
    _msg = "Hayys dogry email salgy yazyn";
  }
  return _msg;
}

String validatePassword(String value) {
  String msg;
  if (value.isEmpty) {
    msg = 'Bos goymaly dal';
  } else if (value.length < 6) {
    msg = '6 sifrdan az bolmaly dal';
  }
  return msg;
}

String validatePrice(String value) {
  String msg;
  if (value.isEmpty) {
    msg = 'Bos goymaly dal';
  }
  return msg;
}

String validatePasswordConfir(String value, String pass) {
  String msg;
  if (value.isEmpty) {
    msg = 'Bos goymaly dal';
  } else if (value == pass) {
    msg = 'acar sozuni dogry yazyng';
  }
  return msg;
}

String validateIntFields(int value) {
  String msg;
  if (value == null) {
    msg = 'Bos goymaly dal';
  }
  return msg;
}

String validateName(String value) {
  String msg;
  if (value.isEmpty) {
    msg = 'Bos goymaly dal';
  } else if (value.length < 3) {
    msg = '3 sifrdan az bolmaly dal';
  }
  return msg;
}

MaterialButton longButtons(String title, Function fun, context,
    {Color color: kPrimaryColor, Color textColor: Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: MediaQuery.of(context).size.width * 0.4,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

label(String title) => Text(
      title,
      style: TextStyle(
        fontFamily: 'Montserrat-Regular',
      ),
    );

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    // prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );
}

const kProductNameTextStyle =
    TextStyle(fontSize: 20.0, fontFamily: 'Montserrat-Bold');

const kProductDataTextStyle =
    TextStyle(fontSize: 15.0, fontFamily: 'Montserrat-Regular');
// // // // / // // // / / // / // / / / //
const kProviderNameTextStyle = TextStyle(
  fontFamily: 'Montserrat-Regular',
  color: kPrimaryColor,
);
const kProviderDataTextStyle =
    TextStyle(fontSize: 15.0, fontFamily: 'Montserrat-Bold');

var currencies = [
  "Food",
  "Transport",
  "Personal",
  "Shopping",
  "Medical",
  "Rent",
  "Movie",
  "Salary"
];

Map<String, dynamic> registerActivity = {
  "en": ["Businessman", "Individual Enterprise", "Economical Society", "Others"]
};

Map<String, dynamic> registerLocation = {
  "en": ["Mary", "Ahal", "Balkan", "Abroad", "Ashgabat", "Lebap", "Dashoguz"]
};

Widget formField(BuildContext context, List<String> list, Function onChanged,
    String selected) {
  return Container(
    height: 50,
    // width: MediaQuery.of(context).size.width * 0.8,
    child: FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              labelStyle: TextStyle(
                fontFamily: 'Montserrat-Regular',
                fontSize: 12,
              ),
              errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          // isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selected,
              // isDense: true,
              isExpanded: true,
              onChanged: onChanged,
              items: list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Montserrat-Regular',
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    ),
  );
}
