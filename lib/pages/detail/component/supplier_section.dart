import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lomaysowda/pages/detail/provider/product_provider.dart';
import 'package:lomaysowda/pages/supplier/supplier_page.dart';
import 'package:lomaysowda/utils/navigator.dart';
import 'package:lomaysowda/widgets/label_section.dart';
import 'package:lomaysowda/widgets/my_custom_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'data_table.dart';
import 'images_swiper.dart';
import 'order_dialog.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductDetailProvider>(context);
    final images = state.productDetail.images;
    final String code = Get.locale.languageCode;
    return Container(
        child: ListView(
      children: [
        ImagesSwiper(imagesList: images),
        SuppierPart(),
        LabelSection(
          name: state.productDetail.getName(code),
        ),
        DetailDataTable(product: state.productDetail),
      ],
    ));
  }
}

class SuppierPart extends StatelessWidget {
  const SuppierPart({Key key}) : super(key: key);

  Widget buildAvatar(String avatarUrl) {
    return CircleAvatar(
      radius: 25,
      backgroundImage: _checkForExtension(avatarUrl),
    );
  }

  _checkForExtension(String url) {
    if (url.substring(url.length - 3, url.length) == 'svg') {
      return AssetImage('assets/images/no_photo.png');
    }
    return NetworkImage(url);
  }

  _buildOrderForm(BuildContext context, ProductDetailProvider state) {
    return showDialog(
        context: context,
        builder: (_) {
          return CustomOrderDialog(state: state);
        });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ProductDetailProvider>(context);
    final avatar = state.productDetail.supplier_image;
    final name = state.productDetail.supplier_name;
    final phone = state.productDetail.supplier_phone;
    final email = state.productDetail.supplier_email;
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffeeeeee),
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        leading: buildAvatar(avatar),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(phone),
            Text(email),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => UrlLauncher.launch("tel:+$phone"),
                    child: SvgPicture.asset(
                      'assets/icons/call.svg',
                      height: 28,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyCustomButton(
                      onTap: () => _buildOrderForm(context, state),
                      text: 'productd_order'.tr,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyCustomButton(
                      onTap: () {
                        MyNavigator.push(
                          SupplierPage(
                            id: state.productDetail.supplier_id,
                          ),
                        );
                      },
                      text: 'productd_all_products'.tr,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
