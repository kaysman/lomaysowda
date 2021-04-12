import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomaysowda/pages/category/provider/category_provider.dart';
import 'package:lomaysowda/pages/category_products/category_products_page.dart';
import 'package:lomaysowda/utils/navigator.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:provider/provider.dart';

class CategoryPageContainer extends StatefulWidget {
  @override
  _CategoryPageContainerState createState() => _CategoryPageContainerState();
}

class _CategoryPageContainerState extends State<CategoryPageContainer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = Provider.of<CategoryProvider>(context);
    final langCode = Get.locale.languageCode;
    return state.loading
        ? MyLoadingWidget()
        : Container(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: SingleChildScrollView(
                child: Column(
                  children: state.categories.map((item) {
                    return InkWell(
                      onTap: () {
                        MyNavigator.push(
                          CategoryProductsPage(
                            categoryID: item.id,
                            categoryName: item.getName(langCode),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(
                            item.getName(langCode),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
