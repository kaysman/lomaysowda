import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/product_detail/components.dart/data_table.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_products/products.dart';
import 'package:provider/provider.dart';
import '../../../../utils.dart';

class MyProductPage extends StatelessWidget {
  final int id;

  const MyProductPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyProvider myProvider = Provider.of<MyProvider>(context, listen: false);
    return FutureBuilder(
      future: myProvider.getProductDetail(id: id),
      builder: (_, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return MyProductScreen();
        } else {
          return Scaffold(
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}

class MyProductScreen extends StatefulWidget {
  @override
  _MyProductScreenState createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  Widget imagesCheck(int len, {MyProvider myProvider}) {
    if (len == 1) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 20),
        child: CachedNetworkImage(
          imageUrl: myProvider.productDetail.images[0]['image'],
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            child: Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );
    } else {
      return CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.4,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayCurve: Curves.easeIn,
        ),
        items: myProvider.productDetail.images.map((img) {
          return Builder(
            builder: (BuildContext context) {
              return CachedNetworkImage(
                imageUrl: img['image'],
                fit: BoxFit.contain,
                placeholder: (context, url) => Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              );
            },
          );
        }).toList(),
      );
    }
  }

  checkImageExtension(myProvider, url) {
    if (url.substring(url.length - 3, url.length) == 'svg') {
      return AssetImage('assets/no_photo.png');
    } else {
      return NetworkImage(
        myProvider.productDetail.provider_image,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    Session session = Provider.of<Session>(context, listen: false);
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    print(provider.productDetail.id);

    var popUp = () {
      return showDialog(
        context: context,
        child: AlertDialog(
          content: Text('Harydy pozyarsyñyz?'),
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Yok'),
            ),
            FlatButton(
              onPressed: () async {
                bool deleted =
                    await session.deleteProduct(id: provider.productDetail.id);
                print(deleted);
                if (deleted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => UserProducts()),
                    ModalRoute.withName('/my_products'),
                  );
                } else {
                  debugPrint('pozulmady');
                }
              },
              child: Text(
                'Hawa',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    };

    return Consumer<MyProvider>(
      builder: (_, myProvider, child) {
        return Scaffold(
          appBar: homeAppBar(context, title: myProvider.productDetail.name_tm),
          body: SafeArea(
            child: Center(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        imagesCheck(myProvider.productDetail.images.length,
                            myProvider: myProvider),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 10.0,
                              ),
                              child: Text(
                                myProvider.productDetail.name_tm,
                                style: kProductNameTextStyle,
                              ),
                            ),
                            Spacer(),
                            // GestureDetector(
                            //   onTap: () => Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //       builder: (_) => MyProductEdit(
                            //         images: myProvider.productDetail.images,
                            //         name: myProvider.productDetail.name_tm,
                            //         desc: myProvider.productDetail.desc_tm,
                            //         price: myProvider.productDetail.price,
                            //         min_qua: myProvider.productDetail.min_qua,
                            //       ),
                            //     ),
                            //   ),
                            //   child: Container(
                            //     padding: const EdgeInsets.only(right: 15.0),
                            //     child: Text(delegate.my_product_edit),
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: popUp,
                              child: Container(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  delegate.my_product_delete,
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        ProductDataTable(product: myProvider.productDetail),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
