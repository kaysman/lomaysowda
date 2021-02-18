import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lomaysowdamuckup/constaints.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';
import 'package:lomaysowdamuckup/provider/provider.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/login/login_screen.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_products/products.dart';
import 'package:provider/provider.dart';

import '../../utils.dart';

class AddProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final delegate = S.of(context);
    return Consumer<Session>(
      builder: (_, session, child) {
        return session.authenticatedUser == null
            ? LoginScreen()
            : Scaffold(
                appBar: homeAppBar(context, title: delegate.add_product_add),
                body: AddProductScreen(),
              );
      },
    );
  }
}

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
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

  Future getImage(int i) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 25,
    );
    setState(() {
      if (pickedFile != null) {
        if (i == 1) {
          _image1 = File(pickedFile.path);
        } else if (i == 2) {
          _image2 = File(pickedFile.path);
        } else if (i == 3) {
          _image3 = File(pickedFile.path);
        }
        images.add(File(pickedFile.path));
      } else {
        print('no image selected');
      }
    });
  }

  imgSelectContainer(File image, int i) {
    return image == null
        ? GestureDetector(
            onTap: () => getImage(i),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.28,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: Center(
                    child: Icon(
                  Icons.photo_library,
                  size: 25,
                  color: Colors.black45,
                )),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => getImage(i),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.28,
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    this.getUnits();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
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
    final delegate = S.of(context);
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

    return Center(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      imgSelectContainer(_image1, 1),
                      Spacer(),
                      imgSelectContainer(_image2, 2),
                      Spacer(),
                      imgSelectContainer(_image3, 3),
                    ],
                  ),
                  // buildGridView(),
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
                          text: delegate.add_product_add,
                        )
                      : Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
