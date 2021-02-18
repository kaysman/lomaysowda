import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/login/login_screen.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_products/products.dart';
import 'package:provider/provider.dart';

import '../../../../constaints.dart';
import '../../../../utils.dart';

class MyProductEdit extends StatefulWidget {
  final String name;
  final List images;
  final int price;
  final int min_qua;
  final String desc;

  const MyProductEdit({
    Key key,
    this.name,
    this.images,
    this.price,
    this.min_qua,
    this.desc,
  }) : super(key: key);

  @override
  _MyProductEditState createState() => _MyProductEditState();
}

class _MyProductEditState extends State<MyProductEdit> {
  String _ady, _bahasy, _minQua, _keywords, _desc, _bolumi, _markasy, _unit;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  List<String> categories = [];
  List<String> units = [];
  List<String> userBrands = [];
  // images
  File _image1, _image2, _image3;
  List<File> images = <File>[];
  final picker = ImagePicker();

  bool loading = false;

  void deleteConfirm(int id, int imgId) async {
    final Session session = Provider.of<Session>(context, listen: false);
    bool deleted = await session.updateProductDeleteImage(id: id, imgId: imgId);
    if (deleted) {
      Navigator.of(context).pushNamed('/my_product_edit');
    } else {
      debugPrint('pozulmady');
    }
  }

  Widget imgContainer() {
    return Row(
      children: widget.images.map((image) {
        return Container(
          margin: EdgeInsets.all(5),
          child: Stack(
            children: [
              CachedNetworkImage(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.27,
                imageUrl: image['image'],
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    child: AlertDialog(
                      content: Text('Harydyñ suradyny pozyarsyñyz?'),
                      actions: [
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Yok'),
                        ),
                        FlatButton(
                          onPressed: () {},
                          // deleteConfirm(widget.images[i]['image']),
                          child: Text(
                            'Hawa',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                    color: Colors.red,
                    child: Text(
                      'Poz',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'Montserrat-Bold'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getUnits();
  }

  Future<void> getUnits() async {
    // units
    var list = await Provider.of<MyProvider>(context, listen: false).getUnits();
    setState(() {
      units = list.map((e) => e.name_tm).toList();
    });
    print(units);
    // categories
    var categs =
        await Provider.of<MyProvider>(context, listen: false).getCategories();
    setState(() {
      categories = categs.map((categ) => categ.name_tm).toList();
    });
    print(categories);
    var brands =
        await Provider.of<Session>(context, listen: false).getUserBrands();
    setState(() {
      userBrands = brands.map((brand) => brand.name).toList();
    });
    print(userBrands);
  }

  @override
  Widget build(BuildContext context) {
    final Session session = Provider.of<Session>(context, listen: false);
    final ady = TextFormField(
      autofocus: false,
      validator: validatePassword,
      onSaved: (value) => _ady = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );
    final bahasy = TextFormField(
      autofocus: false,
      validator: validatePrice,
      onSaved: (value) => _bahasy = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );
    final min_qua = TextFormField(
      autofocus: false,
      validator: validatePrice,
      onSaved: (value) => _minQua = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );
    final keywords = TextFormField(
      autofocus: false,
      onSaved: (value) => _keywords = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );
    final desc = TextFormField(
      autofocus: false,
      onSaved: (value) => _desc = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );
    var addProduct = () async {
      setState(() {
        loading = true;
      });
      final form = formkey.currentState;
      if (form.validate()) {
        form.save();
        bool isAdded = await session.addProduct(
          data: {
            'name_tm': _ady,
            'cat_id': categories.indexOf(_bolumi),
            'brand_id': userBrands.indexOf(_markasy),
            'unit_id': units.indexOf(_unit),
          },
          files: {'images': images},
        );
        if (isAdded) {
          setState(() {
            loading = false;
          });
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => UserProducts()),
            ModalRoute.withName('/'),
          );
        }
      } else {
        setState(() {
          loading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("HARYT GOŞMAK AMALA AŞMADY :/"),
        ));
        print('add product form yalnys');
      }
    };

    Function onChanged1 = (String value) {
      setState(() {
        _bolumi = value;
      });
    };
    Function onChanged2 = (String value) {
      setState(() {
        _markasy = value;
      });
    };
    Function onChanged3 = (String value) {
      setState(() {
        _unit = value;
      });
    };

    final delegate = S.of(context);

    return Scaffold(
      appBar: homeAppBar(context, title: 'Harydy Uytget'),
      body: Center(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    label(delegate.add_category),
                    SizedBox(height: 10.0),
                    formField(
                      context,
                      categories,
                      onChanged1,
                      _bolumi,
                    ),
                    SizedBox(height: 15.0),
                    label(delegate.add_brand),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: formField(
                            context,
                            userBrands,
                            onChanged2,
                            _markasy,
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: FlatButton(
                            color: Colors.green,
                            onPressed: () {},
                            child: Text(
                              delegate.add_brand_add,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat-Regular',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    label(delegate.add_name),
                    SizedBox(height: 10.0),
                    ady,
                    SizedBox(height: 15.0),
                    label(delegate.add_price),
                    SizedBox(height: 10.0),
                    bahasy,
                    SizedBox(height: 15.0),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              label(delegate.add_min),
                              min_qua,
                            ],
                          ),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              label(delegate.add_unit),
                              formField(context, units, onChanged3, _unit),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    label(delegate.add_keywords),
                    SizedBox(height: 10.0),
                    keywords,
                    SizedBox(height: 15.0),
                    label(delegate.add_desc),
                    SizedBox(height: 10.0),
                    desc,
                    SizedBox(height: 25.0),
                    loading == false
                        ? CustomWidget(
                            doLogin: addProduct,
                            color: kPrimaryColor,
                            text: "Uytget",
                          )
                        : Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
