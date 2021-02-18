import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../utils.dart';
import 'components.dart/data_table.dart';
import 'components.dart/send_order.dart';

// ProductDetailsScreen -> ProductDetailsPage

class ProductDetailsScreen extends StatefulWidget {
  final int id;

  const ProductDetailsScreen({Key key, this.id}) : super(key: key);
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  MyProvider myProvider;

  @override
  void initState() {
    myProvider = Provider.of<MyProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: myProvider.getProductDetail(id: widget.id),
      builder: (_, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return ProductDetailPage();
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

// ---- Next ----

class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  FlutterSecureStorage _storage = FlutterSecureStorage();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _message = TextEditingController();

  checkImageExtension(myProvider, url) {
    if (url.substring(url.length - 3, url.length) == 'svg') {
      return AssetImage('assets/no_photo.png');
    } else {
      return NetworkImage(
        myProvider.productDetail.provider_image,
      );
    }
  }

  Widget ahliHarytlarButton(delegate, int id) {
    return FlatButton(
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ProviderGet(id: id))),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.green,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      child: Text(
        delegate.productd_all_products,
        style: TextStyle(
          fontFamily: 'Montserrat-Regular',
          fontSize: 12.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget sargaButton(delegate, int id) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(color: Colors.green),
      ),
      padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      onPressed: () {
        return showDialog(
          context: context,
          child: AlertDialog(
            elevation: 1.0,
            scrollable: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 24, vertical: 10.0),
            titlePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20.0),
            title: Text(
              delegate.productd_order_title,
              style: kProviderNameTextStyle.copyWith(
                  fontFamily: 'Montserrat-Bold'),
            ),
            content: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.27,
                child: ListView(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _name,
                            validator: validateName,
                            decoration: InputDecoration(
                              hintText: delegate.productd_order_name,
                              hintStyle:
                                  TextStyle(fontFamily: 'Montserrat-Regular'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _phone,
                            validator: validatePassword,
                            decoration: InputDecoration(
                              hintText: delegate.productd_order_phone,
                              hintStyle:
                                  TextStyle(fontFamily: 'Montserrat-Regular'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _message,
                            validator: validatePassword,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 3,
                            decoration: InputDecoration(
                              hintText: delegate.productd_order_message,
                              hintStyle:
                                  TextStyle(fontFamily: 'Montserrat-Regular'),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(delegate.productd_order_cancel,
                        style: TextStyle(
                            fontFamily: 'Montserrat-Regular',
                            color: Colors.black45)),
                  )),
              FlatButton(
                  onPressed: () async {
                    final form = _key.currentState;
                    if (form.validate()) {
                      form.save();
                      await sendData(
                        productId: id,
                        name: _name.text,
                        phone: _phone.text,
                        message: _message.text,
                      );
                      await _storage.write(key: "$id", value: "1");
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green,
                    ),
                    child: Text(delegate.productd_order,
                        style: TextStyle(
                            fontFamily: 'Montserrat-Regular',
                            color: Colors.white)),
                  )),
            ],
          ),
        );
      },
      child: Text(
        delegate.productd_order,
        style: TextStyle(
          fontFamily: 'Montserrat-Regular',
          fontSize: 16.0,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget imagesCheck(int len, {MyProvider myProvider}) {
    if (len == 1) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.45,
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
          height: MediaQuery.of(context).size.height * 0.5,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          autoPlay: false,
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _name.clear();
    _phone.clear();
    _message.clear();
  }

  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    final String defaultLocale = Platform.localeName;
    print(defaultLocale);
    return Consumer<MyProvider>(
      builder: (_, myProvider, child) {
        return Scaffold(
          appBar: homeAppBar(context, title: myProvider.productDetail.name_tm),
          body: SafeArea(
            child: Center(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        imagesCheck(myProvider.productDetail.images.length,
                            myProvider: myProvider),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 25,
                                  backgroundImage: checkImageExtension(
                                      myProvider,
                                      myProvider.productDetail.provider_image),
                                ),
                                title: Text(
                                    myProvider.productDetail.provider_name,
                                    style: kProviderNameTextStyle),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        myProvider.productDetail.provider_phone,
                                        style: kProviderNameTextStyle),
                                    Text(
                                        myProvider.productDetail.provider_email,
                                        style: kProviderNameTextStyle),
                                  ],
                                ),
                                trailing: GestureDetector(
                                  onTap: () => UrlLauncher.launch(
                                      "tel:+${myProvider.productDetail.provider_phone}"),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    child: Icon(Icons.call,
                                        color: Colors.white, size: 30),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: sargaButton(delegate,
                                          myProvider.productDetail.id),
                                    ),
                                    SizedBox(width: 5.0),
                                    Expanded(
                                      flex: 2,
                                      child: ahliHarytlarButton(delegate,
                                          myProvider.productDetail.provider_id),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
