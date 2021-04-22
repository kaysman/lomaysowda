import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetLocale;
import 'package:lomaysowda/config/extensions.dart';
import 'package:lomaysowda/config/validators.dart';
import 'package:lomaysowda/pages/category/provider/category_provider.dart';
import 'package:lomaysowda/pages/login/login_page.dart';
import 'package:lomaysowda/pages/my_brands.dart/provider/getbrands_provider.dart';
import 'package:lomaysowda/pages/add_product/components/upload_image.dart';
import 'package:lomaysowda/pages/view_my_products/products_page.dart';
import 'package:lomaysowda/pages/add_product/provider/addproduct_provider.dart';
import 'package:lomaysowda/pages/add_product/provider/image_provider.dart';
import 'package:lomaysowda/pages/profile/provider/user_provider.dart';
import 'package:lomaysowda/widgets/my_appbar.dart';
import 'package:lomaysowda/widgets/my_loading.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ProductAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, state, child) {
        return state.getUser ? ProductAddPageContainer() : LoginPage();
      },
    );
  }
}

class ProductAddPageContainer extends StatefulWidget {
  @override
  _ProductAddPageContainerState createState() =>
      _ProductAddPageContainerState();
}

class _ProductAddPageContainerState extends State<ProductAddPageContainer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //
  TextEditingController _nameController = TextEditingController();
  String savedName;
  String nameError;

  TextEditingController _priceController = TextEditingController();
  String savedPrice;
  String priceError;

  TextEditingController _quantityController = TextEditingController();
  String savedQuantity;
  String quantityError;

  TextEditingController _keywordController = TextEditingController();
  String savedKeyword;
  String keywordError;

  TextEditingController _descripController = TextEditingController();
  String savedDesc;
  String descError;

  String _selectedCategory, _selectedBrand, _selectedUnit;
  List<File> _images = [];

  @override
  Widget build(BuildContext context) {
    /// states
    final state = Provider.of<AddProductProvider>(context);
    final cat_state = Provider.of<CategoryProvider>(context);
    final brand_state = Provider.of<GetBrandsProvider>(context);
    final imagestate = Provider.of<MyImageProvider>(context);
    final langCode = GetLocale.Get.locale.languageCode;

    /// dropdown lists
    final brands = brand_state.userBrands.map((e) => e.name).toList();
    final categories =
        cat_state.categories.map((e) => e.getName(langCode)).toList();
    final units = cat_state.units.map((e) => e.getName(langCode)).toList();

    /// login function
    var onSubmit = () async {
      hideKeyboard();
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();

        AddProductProvider _state =
            Provider.of<AddProductProvider>(context, listen: false);

        Map<String, dynamic> data = {
          'name_tm': _nameController.text,
          'cat_id': categories.indexOf(_selectedCategory) + 1,
          'brand_id': brands.indexOf(_selectedBrand) + 1,
          'unit_id': units.indexOf(_selectedUnit) + 1,
        };

        if (imagestate.img1 != null) {
          print("Image 1: ${imagestate.img1.path}");
          _images.add(File(imagestate.img1.path));
        }
        if (imagestate.img2 != null) {
          print("Image 2: ${imagestate.img2.path}");
          _images.add(File(imagestate.img2.path));
        }
        if (imagestate.img3 != null) {
          print("Image 3: ${imagestate.img3.path}");
          _images.add(File(imagestate.img3.path));
        }

        Map<String, List<MultipartFile>> fileMap = {"images": []};
        for (File file in _images) {
          String filename = basename(file.path);
          fileMap['images'].add(
            MultipartFile(
              file.openRead(),
              await file.length(),
              filename: filename,
            ),
          );
        }
        if (fileMap['images'].isNotEmpty) {
          data.addAll(fileMap);
        } else {
          showSnackbar(context, "Surat yukle");
          return;
        }

        var formData = FormData.fromMap(data);

        var res = await _state.addUserProduct(formData);
        showSnackbar(context, res.toString());
        if (_state.isAdded) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MyProductsPage()));
        } else {
          print('haryt goshulmady, product_add_page');
        }
      } else {
        print('form validation failed');
      }
    };

    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: Text('add_new_product'.tr),
        leadingType: AppBarBackType.None,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 38),
            child: Form(
              key: _formKey,
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: UploadSection(number: 1)),
                          const SizedBox(width: 8),
                          Expanded(child: UploadSection(number: 2)),
                          const SizedBox(width: 8),
                          Expanded(child: UploadSection(number: 3)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'add_name'.tr,
                          errorText: nameError,
                        ),
                        validator: validateName,
                        onChanged: (v) {
                          if (nameError != null) {
                            setState(() => nameError = null);
                          }
                        },
                        onSaved: (v) => savedName = v,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _priceController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'add_price'.tr,
                                errorText: priceError,
                              ),
                              onChanged: (v) {
                                if (priceError != null) {
                                  setState(() => priceError = null);
                                }
                              },
                              onSaved: (v) => savedPrice = v,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'add_min'.tr,
                                errorText: quantityError,
                              ),
                              onChanged: (v) {
                                if (quantityError != null) {
                                  setState(() => quantityError = null);
                                }
                              },
                              onSaved: (v) => savedQuantity = v,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _keywordController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'add_keywords'.tr,
                          errorText: keywordError,
                        ),
                        onChanged: (v) {
                          if (keywordError != null) {
                            setState(() => keywordError = null);
                          }
                        },
                        onSaved: (v) => savedKeyword = v,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: _selectedCategory,
                          onChanged: (v) {
                            setState(() {
                              _selectedCategory = v;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'add_category'.tr,
                          ),
                          items: List.generate(
                            categories.length,
                            (i) {
                              final category = categories[i];
                              return DropdownMenuItem(
                                child: Text(category),
                                value: category,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedBrand,
                        onChanged: (v) {
                          setState(() {
                            _selectedBrand = v;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'add_brand'.tr,
                        ),
                        items: List.generate(
                          brands.length,
                          (i) {
                            final brand = brands[i];
                            return DropdownMenuItem(
                              child: Text(brand),
                              value: brand,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedUnit,
                        onChanged: (v) {
                          setState(() {
                            _selectedUnit = v;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'add_unit'.tr,
                        ),
                        items: List.generate(
                          units.length,
                          (i) {
                            final unit = units[i];
                            return DropdownMenuItem(
                              child: Text(unit),
                              value: unit,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _descripController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'add_desc'.tr,
                          errorText: descError,
                        ),
                        onChanged: (v) {
                          if (descError != null) {
                            setState(() => descError = null);
                          }
                        },
                        onSaved: (v) => savedDesc = v,
                      ),
                      const SizedBox(height: 8),
                      Consumer<AddProductProvider>(
                        builder: (_, state, child) {
                          return ElevatedButton(
                            onPressed: onSubmit,
                            child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 100),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (state.loading) MyLoadingWidget(),
                                    Text(
                                      'add_product_add'.tr,
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
  void dispose() {
    // controllers
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _keywordController.dispose();
    _descripController.dispose();
    super.dispose();
  }
}
