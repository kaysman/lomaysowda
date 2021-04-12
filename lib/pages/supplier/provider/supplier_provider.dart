import 'package:flutter/widgets.dart';
import 'package:lomaysowda/models/supplier.dart';
import 'package:lomaysowda/services/supplier_service.dart';

class SupplierProvider with ChangeNotifier {
  final int supplierId;
  bool loading = true;
  SupplierModel supplier;

  SupplierProvider({this.supplierId}) {
    getData();
  }

  Future<void> getData() async {
    SupplierModel detail = await SupplierAPI.getSupplierData(supplierId);
    supplier = detail;
    loading = false;
    notifyListeners();
  }
}
