import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomaysowda/models/brand.dart';
import 'package:lomaysowda/pages/detail/detail.dart';
import 'package:lomaysowda/utils/navigator.dart';
import 'package:lomaysowda/widgets/my_cached_image.dart';

class GridBrands extends StatelessWidget {
  final String label;
  final List<BrandModel> brands;
  const GridBrands({Key key, @required this.brands, this.label})
      : super(key: key);

  //
  List<Widget> _buildGridItem(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    List<Widget> gridItemList = [];
    for (int i = 0; i < brands.length; i++) {
      gridItemList.add(
        InkWell(
          onTap: () {
            MyNavigator.push(
              ProductDetailPage(
                id: brands[i].id,
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
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: _screenWidth * 0.25,
                      width: _screenWidth * 0.3,
                      // padding: EdgeInsets.only(bottom: 2),
                      child: MyCachedNetworkImage(
                        imageurl: brands[i].image,
                      ),
                    ),
                  ),
                ),
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
                        // brands[i].getName(code),
                        "${brands[i].preview} views",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 10,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          // brands[i].getName(code),
                          brands[i].name,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Text(
                        // brands[i].getName(code),
                        brands[i].status == 0
                            ? 'Tassyklanmadyk'
                            : 'Tassyklanan',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 12,
                              color: brands[i].status == 0
                                  ? Colors.red[300]
                                  : Colors.greenAccent,
                            ),
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
    final _crossAxisCount = 3;
    final _childAspectRatio = _screenWidth / _crossAxisCount / 155;
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
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
