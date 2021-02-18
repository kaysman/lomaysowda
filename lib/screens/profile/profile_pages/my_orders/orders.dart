import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/model/order.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:provider/provider.dart';

class UserOrders extends StatefulWidget {
  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  Session session;

  @override
  void initState() {
    session = Provider.of<Session>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return FutureBuilder<List<Order>>(
      future: session.getUserOrders(),
      builder: (_, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Scaffold(
            appBar: homeAppBar(context, title: delegate.my_request_me),
            body: UserOrdersPage(),
          );
        } else {
          return Scaffold(
            appBar: homeAppBar(context, title: delegate.my_request_me),
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class UserOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Consumer<Session>(
        builder: (BuildContext context, Session session, Widget widget) {
      return Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 10.0),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: session.userOrders.map((item) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Text(item.phone),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontFamily: 'Montserrat-Bold',
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('Status: '),
                                    statusCheck(delegate, item.id),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }

  statusCheck(delegate, int s) {
    return s == 1
        ? Text(delegate.my_product_active)
        : Text(delegate.my_product_deactive);
  }
}
