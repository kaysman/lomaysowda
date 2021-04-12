import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lomaysowda/models/detail.dart';
import 'package:get/get.dart';

class DetailDataTable extends StatelessWidget {
  final DetailItemModel product;

  const DetailDataTable({Key key, this.product}) : super(key: key);
  Widget build(BuildContext context) {
    final langCode = Get.locale.languageCode;
    List args = [
      {
        "icon": 'assets/icons/view.svg',
        "label": 'productd_preview',
        "data": product.preview,
      },
      {
        "icon": 'assets/icons/tag.svg',
        "label": 'productd_price',
        "data": product.price ?? 'negotiable'.tr,
      },
      {
        "icon": 'assets/icons/doc.svg',
        "label": 'productd_desc',
        "data": product.getDesc(langCode),
      },
    ];
    return Column(
      children: args.map((arg) {
        if (arg == args.last) {
          return ListTile(
            dense: true,
            leading: SvgPicture.asset(
              arg["icon"],
              color: Theme.of(context).accentColor,
            ),
            title: Text(arg["data"] ?? 'no_info'.tr),
          );
        }
        return CustomDataRow(
          icon: arg["icon"],
          label: arg["label"],
          data: arg["data"] ?? 'empty'.tr,
        );
      }).toList(),
    );
  }
}

class CustomDataRow extends StatelessWidget {
  const CustomDataRow({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.data,
  }) : super(key: key);

  final String label;
  final dynamic data;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: SvgPicture.asset(
        icon,
        color: Theme.of(context).accentColor.withOpacity(0.9),
      ),
      title: Text(
        label.tr ?? 'girizilmedik',
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: Text(
        data.toString(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
