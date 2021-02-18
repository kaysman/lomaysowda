import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/category_result/category_result.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    Key key,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future getCategories() async {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    await provider.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Scaffold(
      appBar: homeAppBar(context, title: delegate.categories),
      body: Consumer<MyProvider>(builder: (context, myProvider, child) {
        return myProvider.categories == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: myProvider.categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return CategoryResult(
                            catId: myProvider.categories[index].id,
                            catName: myProvider.categories[index].name_tm,
                          );
                        }),
                      );
                    },
                    child: ListTile(
                      tileColor: index % 2 == 1
                          ? Color(0xFF5F4F84).withOpacity(0.2)
                          : null,
                      title: Text(
                        myProvider.categories[index].name_tm,
                      ),
                    ),
                  );
                });
      }),
    );
  }
}
