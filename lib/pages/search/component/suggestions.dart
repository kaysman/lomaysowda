import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/home/provider/home_provider.dart';
import 'package:lomaysowda/widgets/my_cached_image.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class SearchSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langCode = Get.locale.languageCode;
    final state = Provider.of<HomeProvider>(context);
    final suggestions = state.vipProducts;
    return state.loading
        ? MyLoadingWidget()
        : Container(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                      width: 50,
                      height: 50,
                      child: MyCachedNetworkImage(
                        imageurl: suggestions[index].picurl,
                      )),
                  title: Text(
                    suggestions[index].getName(langCode),
                  ),
                );
              },
            ),
          );
  }
}
