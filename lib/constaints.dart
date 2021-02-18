import 'package:flutter/material.dart';

const kSpacingUnit = 30;

// const kAppBarBgColor = Color(0xFF5F4F84);
// const kCons = Color(0xFFEEEEEE);
// const kDarkPrimaryColor = Color(0xFF212121);
// const kDarkSecondaryColor = Color(0xFF373737);
// const kAccentColor = Color(0xFFFFC107);

//
const kPrimaryColor = Color(0xFF5F4F84);
const kPrimaryLightColor = Color(0xFFF5F8FB);
const kSecondaryColor = Color(0xFF9098B1);
const kTextColor = Color(0xFF3F3F3F);
//

// final kTitleTextStyle = TextStyle(
//   color: kDarkPrimaryColor,
// );

class TitleText extends StatelessWidget {
  final String title;
  final String email;

  const TitleText({Key key, @required this.title, @required this.email})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
                fontSize: size.width * 0.05,
                color: Colors.white,
                fontFamily: 'Montserrat-Bold'),
          ),
          Text(
            email,
            style: TextStyle(
              fontSize: size.width * 0.03,
              color: Colors.white,
              fontFamily: 'Montserrat-Bold',
            ),
          )
        ],
      ),
    );
  }
}

// class UserPreferences {
//   static Future<User> getUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return User(
//       id: prefs.getInt('id'),
//       name: prefs.getString('name'),
//       email: prefs.getString('email'),
//       email2: prefs.getString('email2'),
//       phone: prefs.getString('phone'),
//       image: prefs.getString('image'),
//       phone2: prefs.getString('phone2'),
//       address: prefs.getString('address'),
//       website: prefs.getString('website'),
//       type_id: prefs.getInt('type_id'),
//       city_id: prefs.getInt('city_id'),
//       checked: prefs.getInt('checked'),
//       trusted: prefs.getInt('trusted'),
//       preview: prefs.getInt('preview'),
//       email_verified_at: prefs.getString('email_verified_at'),
//       created_at: prefs.getString('created_at'),
//     );
//   }
// }
