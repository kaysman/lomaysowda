import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lomaysowdamuckup/constaints.dart';
import 'package:lomaysowdamuckup/provider/session.dart';
import 'package:lomaysowdamuckup/screens/app_bar/appBar.dart';
import 'package:lomaysowdamuckup/screens/login/login_screen.dart';
import 'package:lomaysowdamuckup/screens/profile/profile_pages/my_brands/brands.dart';
import 'package:provider/provider.dart';
import 'package:lomaysowdamuckup/utils.dart';

class AddBrandPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Session>(
      builder: (_, session, child) {
        return session.authenticatedUser == null
            ? LoginScreen()
            : Scaffold(
                appBar: homeAppBar(context, title: 'Haryt Gos'),
                body: AddBrandScreen(),
              );
      },
    );
  }
}

class AddBrandScreen extends StatefulWidget {
  @override
  _AddBrandScreenState createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  String _ady, _keywords, _desc;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // images
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
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

  imgSelectContainer(File image) {
    return image == null
        ? GestureDetector(
            onTap: () => getImage(),
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
            onTap: () => getImage(),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
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
    var addBrand = () async {
      final form = formkey.currentState;
      if (form.validate()) {
        form.save();
        bool isAdded = await session.addBrand(
          data: {
            'name': _ady,
            'keywords': _keywords,
            'desc': _desc,
          },
          files: {'logo': _image},
        );
        if (isAdded) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => UserBrands()),
            ModalRoute.withName('/'),
          );
        }
      } else {
        print('register form yalnys');
      }
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
                    doLogin: addBrand,
                    color: kPrimaryColor,
                    text: 'Haryt gos',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
