import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomaysowda/models/product.dart';
import 'package:lomaysowda/pages/detail/detail.dart';
import 'package:lomaysowda/utils/navigator.dart';
import 'package:lomaysowda/widgets/my_cached_image.dart';

class GridProducts extends StatelessWidget {
  final String label;
  final List<ProductItemModel> products;
  final bool auth;
  const GridProducts({
    Key key,
    @required this.products,
    this.label,
    this.auth = false,
  }) : super(key: key);

  //
  List<Widget> _buildGridItem(BuildContext context) {
    final String code = Get.locale.languageCode;
    final _screenWidth = MediaQuery.of(context).size.width;
    List<Widget> gridItemList = [];
    for (int i = 0; i < products.length; i++) {
      gridItemList.add(
        InkWell(
          onTap: () {
            MyNavigator.push(
              ProductDetailPage(
                id: products[i].id,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    height: _screenWidth * 0.47,
                    width: _screenWidth * 0.47,
                    // padding: EdgeInsets.only(bottom: 2),
                    child: MyCachedNetworkImage(
                      imageurl: products[i].picurl,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      // products[i].getName(code),
                      "${products[i].getName(code)}",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 13,
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      // products[i].getName(code),
                      products[i].price ?? 'negotiable'.tr,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.orangeAccent,
                            fontSize: 13,
                          ),
                    ),
                  ),
                ),
                if (auth)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Edit',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontSize: 12,
                                      color: Colors.blueAccent,
                                    ),
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Delete',
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      fontSize: 12,
                                      color: Colors.red[300],
                                    ),
                          ),
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
    return gridItemList;
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    // final _containerHeight = _screenWidth <= 414 ? 228.0 : 108.0;
    final _crossAxisCount = 2;
    final _childAspectRatio = _screenWidth / _crossAxisCount / 300;
    return Container(
      // height: _containerHeight,
      width: _screenWidth - 20,
      // padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          if (label != null) _buildLabel(context, label),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 10.0,
            crossAxisCount: _crossAxisCount,
            childAspectRatio: _childAspectRatio,
            children: _buildGridItem(context),
          ),
        ],
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
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
