import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class MyImageProvider extends ChangeNotifier {
  PickedFile img1;
  PickedFile img2;
  PickedFile img3;
  bool loading = true;

  Future saveImgState(PickedFile imageFile, int a) async {
    if (a == 1) {
      img1 = imageFile;
    } else if (a == 2) {
      img2 = imageFile;
    } else if (a == 3) {
      img3 = imageFile;
    }
    this.loading = false;
    this.notifyListeners();
  }
}
