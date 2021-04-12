import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/results.dart';
import 'component/suggestions.dart';

class SearchPage extends SearchDelegate {
  SearchPage()
      : super(
          searchFieldLabel: 'search_bar_label'.tr,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    // ThemeData(
    //   primaryColor: Theme.of(context).canvasColor,
    //   inputDecorationTheme: InputDecorationTheme(
    //     hintStyle: Theme.of(context).textTheme.headline6.copyWith(
    //           fontSize: 16,
    //           color: Theme.of(context).accentColor.withOpacity(0.5),
    //         ),
    //   ),
    //   textTheme:
    // );
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
