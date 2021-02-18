import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lomaysowdamuckup/model/slider.dart';
import 'package:http/http.dart' as http;

class SliderProvider extends ChangeNotifier {
  Duration _cacheValidDuration;
  DateTime _lastFetchTime;
  List<SliderImage> _sliderImages;

  SliderProvider() {
    _cacheValidDuration = Duration(minutes: 30);
    _lastFetchTime = DateTime.fromMillisecondsSinceEpoch(0);
    _sliderImages = [];
  }

  Future<void> refreshSlider(bool notifyListeners) async {
    final response = await http.get('http://lomaysowda.com.tm/api/sliders');
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      _sliderImages = SliderImage.listFromJson(jsonData['data']);
      _lastFetchTime = DateTime.now();
      if (notifyListeners) this.notifyListeners();
    } else {
      print('Sliders/ error occured');
    }
  }

  Future<List<SliderImage>> fetchSliderImages(
      {bool forceRefresh = false}) async {
    bool shouldRefresh = (_sliderImages == null) ||
        (_sliderImages.isEmpty) ||
        (_lastFetchTime == null) ||
        (_lastFetchTime
            .isBefore(DateTime.now().subtract(_cacheValidDuration))) ||
        forceRefresh;
    if (shouldRefresh) await refreshSlider(false);
    return _sliderImages;
  }
}
