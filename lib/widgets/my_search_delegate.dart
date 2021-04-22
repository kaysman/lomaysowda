import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomaysowda/pages/search/component/results.dart';

class MySearchDelegate extends SearchDelegate {
  MySearchDelegate()
      : super(
          searchFieldLabel: 'search_hint'.tr,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchPageContainer(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: Text(''),
    );
  }
}
