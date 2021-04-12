import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/profile/profile_page.dart';
import 'package:lomaysowda/pages/profile/provider/user_provider.dart';
import 'package:lomaysowda/utils/navigator.dart';
import 'package:lomaysowda/widgets/custom_dialog.dart';

class LoggedProfileTop extends StatelessWidget {
  const LoggedProfileTop({
    Key key,
    @required this.state,
  }) : super(key: key);

  final UserProvider state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.network(
            'https://yanxuan.nosdn.127.net/4cb504b640d917efcccf5fe6c73f6428.png',
            height: 80,
            width: 80,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, left: 10),
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
              CupertinoButton(
                padding: EdgeInsets.only(
                  bottom: 8,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return CustomDialog(
                          title: 'Logout?',
                          content: Text(
                              'Do you want to log out? Message: Reference to an enclosing class method cannot be extracted.'),
                          confirmContent: 'Yes',
                          cancelContent: 'No',
                          outsideDismiss: true,
                          confirmCallback: () async {
                            await state.logout();
                            MyNavigator.pushAndRemove(ProfilePage());
                          },
                          dismissCallback: () {
                            MyNavigator.pop();
                          },
                        );
                      });
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
