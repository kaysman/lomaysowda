import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/profile/provider/user_provider.dart';
import 'package:lomaysowda/widgets/custom_dialog.dart';
import 'package:lomaysowda/widgets/my_cached_image.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class LoggedProfileTop extends StatelessWidget {
  final BuildContext current_context;

  const LoggedProfileTop({Key key, this.current_context}) : super(key: key);
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
            Colors.lightBlue,
            Colors.blueAccent,
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
                Divider(height: 5),
                Text(
                  'Mysal HJ - Telekeci',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 14,
                  ),
                ),
                Divider(height: 5),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: current_context,
                        builder: (_) {
                          return CustomDialog(
                            title: 'logout'.tr,
                            content: Text(
                              'logout_content'.tr,
                            ),
                            confirmContent: 'yes'.tr,
                            cancelContent: 'no'.tr,
                            outsideDismiss: true,
                            confirmCallback: () async {
                              UserProvider state = Provider.of<UserProvider>(
                                context,
                                listen: false,
                              );
                              await state.logout();
                            },
                            dismissCallback: () {
                              // MyNavigator.pop();
                            },
                          );
                        });
                  },
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
}
