import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/login/login_screen.dart';
import 'package:provider/provider.dart';

import '../../../../constaints.dart';
import '../../../../utils.dart';
import 'brands.dart';

class EditBrandPage extends StatefulWidget {
  final int id;
  final String url;
  final String name;

  const EditBrandPage({Key key, this.id, this.url, this.name})
      : super(key: key);
  @override
  _EditBrandPageState createState() => _EditBrandPageState();
}

class _EditBrandPageState extends State<EditBrandPage> {
  String _ady, _keywords, _desc;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      maxHeight: 500,
      imageQuality: 25,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image selected');
      }
    });
  }

  Future brandDetails(int id) async {}

  imgSelectContainer(File image) {
    return image == null
        ? GestureDetector(
            onTap: () => getImage(),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  color: Colors.black12,
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.url,
                  placeholder: (context, url) => Container(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => getImage(),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.6,
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final Session session = Provider.of<Session>(context, listen: false);
    final ady = TextFormField(
      initialValue: widget.name,
      autofocus: false,
      validator: validatePassword,
      onSaved: (value) => _ady = value,
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
    var storeBrand = () async {
      final form = formkey.currentState;
      if (form.validate()) {
        form.save();
        Map<String, File> map = _image == null ? null : {'image': _image};
        bool edited = await session.editBrand(
          id: widget.id,
          data: {
            'name': _ady,
            'keywords': _keywords,
            'desc': _desc,
          },
          files: map,
        );
        if (edited) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => UserBrands()),
            ModalRoute.withName('/'),
          );
        }
      } else {
        print('register form yalnys');
      }
    };
    return Scaffold(
      appBar: homeAppBar(context, title: 'Edit Brand'),
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
                    imgSelectContainer(_image),
                    SizedBox(height: 20.0),
                    label('Ady'),
                    SizedBox(height: 10.0),
                    ady,
                    SizedBox(height: 15.0),
                    label('Degisli sozler'),
                    SizedBox(height: 10.0),
                    keywords,
                    SizedBox(height: 15.0),
                    label('Maglumat'),
                    SizedBox(height: 10.0),
                    desc,
                    SizedBox(height: 25.0),
                    CustomWidget(
                      doLogin: storeBrand,
                      color: kPrimaryColor,
                      text: 'Üytget',
                    ),
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
