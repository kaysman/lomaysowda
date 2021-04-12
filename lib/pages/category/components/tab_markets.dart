import 'package:flutter/material.dart';
import 'package:lomaysowda/pages/category/provider/markets_provider.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:provider/provider.dart';

class MarketsPage extends StatefulWidget {
  const MarketsPage({Key key}) : super(key: key);
  @override
  _MarketsPageState createState() => _MarketsPageState();
}

class _MarketsPageState extends State<MarketsPage> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<MarketsProvider>(context);
    return state.loading
        ? MyLoadingWidget()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: state.provinces.map((province) {
                  return Card(
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.only(left: 10),
                      expandedCrossAxisAlignment: CrossAxisAlignment.center,
                      title: Text(province.name),
                      children: province.cities.list.map<Widget>((city) {
                        return ExpansionTile(
                          childrenPadding: EdgeInsets.only(left: 15),
                          title: Text(city.name),
                          children: city.markets.list.map((market) {
                            return ListTile(
                              title: Text(market.name),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
  }
}
