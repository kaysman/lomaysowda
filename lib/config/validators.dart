// username validator
String validateName(String value) {
  String msg;
  if (value.isEmpty) {
    msg = 'Bos goymaly dal';
  } else if (value.length < 3) {
    msg = '3 sifrdan az bolmaly dal';
  }
  return msg;
}

// password validator
String validatePassword(String value) {
  String msg;
  if (value.isEmpty) {
    msg = 'Bos goymaly dal';
  } else if (value.length < 6) {
    msg = '6 sifrdan az bolmaly dal';
  }
  return msg;
}
