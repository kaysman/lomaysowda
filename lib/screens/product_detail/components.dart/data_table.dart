import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/model/product_detail.dart';

import '../../../utils.dart';

class ProductDataTable extends StatelessWidget {
  final ProductDetail product;

  const ProductDataTable({Key key, this.product}) : super(key: key);
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Column(
      children: [
        Divider(),
        ListTile(
          dense: true,
          leading: Icon(Icons.person),
          title: Text(delegate.productd_preview, style: kProductDataTextStyle),
          trailing: Text('${product.preview}', style: kProductDataTextStyle),
        ),
        Divider(),
        ListTile(
          dense: true,
          leading: Icon(Icons.money),
          title: Text(delegate.productd_price, style: kProductDataTextStyle),
          trailing: Text('${product.price}', style: kProductDataTextStyle),
        ),
        Divider(),
        if (product.min_qua != null)
          ListTile(
            dense: true,
            leading: Icon(Icons.confirmation_number),
            title: Text(delegate.productd_min, style: kProductDataTextStyle),
            trailing: Text('${product.min_qua}', style: kProductDataTextStyle),
          ),
        ListTile(
          dense: true,
          leading: Icon(Icons.info),
          title: Text(delegate.productd_desc, style: kProductDataTextStyle),
        ),
      ],
    );
  }
}
