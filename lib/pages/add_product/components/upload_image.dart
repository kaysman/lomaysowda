import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lomaysowda/pages/add_product/provider/image_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class UploadSection extends StatefulWidget {
  final int number;

  const UploadSection({
    Key key,
    @required this.number,
  }) : super(key: key);
  @override
  _UploadSectionState createState() => _UploadSectionState();
}

class _UploadSectionState extends State<UploadSection> {
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  dynamic _pickImageError;
  final picker = ImagePicker();
  String _retrieveDataError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        bottom: 8.0,
      ),
      child: Center(
        child: defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return onWaitingWidget();
                    case ConnectionState.done:
                      return _previewImage();
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return onWaitingWidget();
                      }
                  }
                },
              )
            : _previewImage(),
      ),
    );
  }

  Widget _previewImage() {
    final retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.28,
        height: MediaQuery.of(context).size.width * 0.24,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InteractiveViewer(
            child: Semantics(
                child: Image.file(
                  File(_imageFile.path),
                  fit: BoxFit.cover,
                ),
                label: 'image_picker_example_picked_image'),
          ),
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return onWaitingWidget();
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 100,
      );
      setState(() {
        _imageFile = pickedFile;
      });
      final state = Provider.of<MyImageProvider>(context, listen: false);
      await state.saveImgState(_imageFile, widget.number);
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text(
                    'gallery'.tr,
                  ),
                  onTap: () {
                    _onImageButtonPressed(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    'camera'.tr,
                  ),
                  onTap: () {
                    _onImageButtonPressed(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  onWaitingWidget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      height: MediaQuery.of(context).size.width * 0.24,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: CupertinoButton(
        alignment: Alignment.center,
        onPressed: () {
          _showPicker(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/upload.png',
                height: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'upload'.tr,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
