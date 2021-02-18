import 'package:flutter/material.dart';

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;
  final String countryCode;

  Language({
    this.id,
    @required this.name,
    @required this.flag,
    @required this.languageCode,
    this.countryCode,
  });

  static List<Language> languageList() {
    return <Language>[
      Language(
        id: 1,
        name: 'English',
        languageCode: 'en',
        flag: '🇺🇸',
      ),
      Language(
          id: 2,
          name: 'Pусский',
          languageCode: 'ru',
          flag: '🇷🇺',
          countryCode: 'RU'),
      Language(
          id: 3,
          name: 'Türkmen',
          languageCode: 'tk',
          flag: '🇹🇲',
          countryCode: 'TM'),
    ];
  }
}
