import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomaysowda/models/order.dart';
import 'package:lomaysowda/pages/detail/detail.dart';
import 'package:lomaysowda/utils/navigator.dart';

class GridOrders extends StatelessWidget {
  final String label;
  final List<OrderModel> orders;
  const GridOrders({Key key, @required this.orders, this.label})
      : super(key: key);

  //
  List<Widget> _buildGridItem(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    List<Widget> gridItemList = [];
    for (int i = 0; i < orders.length; i++) {
      gridItemList.add(
        InkWell(
          onTap: () {
            MyNavigator.push(
              ProductDetailPage(
                id: orders[i].id,
              ),
            );
          },
          child: Container(
            width: _screenWidth - 20,
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    left: 8,
                    top: 10,
                    right: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // orders[i].getName(code),
                        "name: ${orders[i].name}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        // orders[i].getName(code),
                        "phone: ${orders[i].phone}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          // orders[i].getName(code),
                          "message: ${orders[i].message}",
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Text(
                        // orders[i].getName(code),
                        "product_id: ${orders[i].productId}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        // orders[i].getName(code),
                        "user_id: ${orders[i].userId}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        // orders[i].getName(code),
                        orders[i].status == 0
                            ? 'Tassyklanmadyk'
                            : 'Tassyklanan',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 12,
                              color: orders[i].status == 0
                                  ? Colors.red[300]
                                  : Colors.greenAccent,
                            ),
                      ),
                      Text(
                        // orders[i].getName(code),
                        "date: ${orders[i].createdAt.substring(0, 10)}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return gridItemList;
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    // final _containerHeight = _screenWidth <= 414 ? 228.0 : 108.0;
    final _crossAxisCount = 1;
    final _childAspectRatio = _screenWidth / _crossAxisCount / 200;
    return Container(
      // height: _containerHeight,
      width: _screenWidth - 20,
      // padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildGridItem(context),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label.tr,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
