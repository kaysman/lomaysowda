import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/profile/provider/user_provider.dart';
import 'package:lomaysowda/utils/navigator.dart';
import 'package:lomaysowda/widgets/my_cached_image.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class LoggedProfileTop extends StatefulWidget {
  const LoggedProfileTop({Key key}) : super(key: key);

  @override
  _LoggedProfileTopState createState() => _LoggedProfileTopState();
}

class _LoggedProfileTopState extends State<LoggedProfileTop> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 20, top: 15),
      height: size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Background radial gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF79479f),
            Color(0xFF6D319B),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: MyCachedNetworkImage(
              imageurl:
                  'https://yanxuan.nosdn.127.net/4cb504b640d917efcccf5fe6c73f6428.png',
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Merdan Atayev',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                // Text(
                //   'Mysal HJ - Telekeci',
                //   style: TextStyle(
                //     color: Theme.of(context).accentColor,
                //     fontSize: 14,
                //   ),
                // ),
                Divider(height: 5),
                InkWell(
                  onTap: alertDialog,
                  child: Text(
                    'logout'.tr,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 18,
                          color: Colors.red[300],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  alertDialog() async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('logout'.tr),
            content: Text(
              'logout_content'.tr,
            ),
            actions: [
              TextButton(
                onPressed: () => MyNavigator.pop(),
                child: Text('no'.tr),
                style: ButtonStyle(foregroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  return Theme.of(context).backgroundColor;
                })),
              ),
              TextButton(
                onPressed: () async {
                  UserProvider state = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );
                  await state.logout();
                },
                child: Text('yes'.tr),
                style: ButtonStyle(foregroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  return Theme.of(context).accentColor;
                })),
              ),
            ],
          );
        });
  }
}
