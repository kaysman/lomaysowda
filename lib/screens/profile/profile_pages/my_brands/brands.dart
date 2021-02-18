import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/constaints.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_brands/edit_brand.dart';
import 'package:provider/provider.dart';

class UserBrands extends StatefulWidget {
  @override
  _UserBrandsState createState() => _UserBrandsState();
}

class _UserBrandsState extends State<UserBrands> {
  Session session;
  @override
  void initState() {
    super.initState();
    getUserBrands();
  }

  Future getUserBrands() async {
    session = Provider.of<Session>(context, listen: false);
    await session.getUserBrands();
  }

  popUp(id) {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Markany pozyarsyñyz?'),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Yok'),
          ),
          FlatButton(
            onPressed: () async {
              bool deleted = await session.deleteBrand(id: id);
              print(deleted);
              if (deleted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => UserBrands()),
                  ModalRoute.withName('/'),
                );
              } else {
                debugPrint('pozulmady');
              }
            },
            child: Text(
              'Hawa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);

    return Consumer<Session>(
        builder: (BuildContext context, Session session, Widget widget) {
      return session.userBrands == null
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: homeAppBar(context, title: 'Markalarym'),
              body: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.05,
                          padding: EdgeInsets.only(left: 6.0),
                          child: FlatButton(
                            color: kPrimaryColor.withOpacity(0.8),
                            child: Text(
                              'Marka gos',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat-Regular',
                                fontSize: 16.0,
                              ),
                            ),
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/add_brand'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: session.userBrands.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => EditBrandPage(
                                    id: item.id,
                                    url: item.image,
                                    name: item.name,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(item.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    // colors: [
                                    //   Colors.black.withOpacity(.4),
                                    //   Colors.black.withOpacity(.3),
                                    // ],
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      child: Container(
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat-Bold',
                                            fontSize: 30.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 1,
                                      top: 20,
                                      child: GestureDetector(
                                        onTap: () => popUp(item.id),
                                        child: Container(
                                          padding: EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            "Poz",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat-Bold',
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}

// Container(
//                                 padding: EdgeInsets.all(5.0),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     colors: [
//                                       Colors.black.withOpacity(.4),
//                                       Colors.black.withOpacity(.3),
//                                     ],
//                                   ),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           item.name,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: 'Montserrat-Bold',
//                                             fontSize: 30.0,
//                                           ),
//                                         ),
//                                         Spacer(),
//                                         Icon(
//                                           Icons.delete,
//                                           size: 25,
//                                           color: Colors.white,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
