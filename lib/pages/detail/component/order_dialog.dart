import 'package:flutter/material.dart';
import 'package:lomaysowda/config/validators.dart';
import 'package:lomaysowda/pages/detail/provider/product_provider.dart';
import 'package:lomaysowda/widgets/my_custom_button.dart';
import 'package:lomaysowda/widgets/my_textformfield.dart';
import 'package:get/get.dart';

class CustomOrderDialog extends StatefulWidget {
  final ProductDetailProvider state;
  const CustomOrderDialog({
    Key key,
    this.state,
  }) : super(key: key);

  @override
  _CustomOrderDialogState createState() => _CustomOrderDialogState();
}

class _CustomOrderDialogState extends State<CustomOrderDialog> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 1.0,
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 10.0),
      titlePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20.0),
      title: Text(
        'productd_order_title'.tr,
        style: Theme.of(context).textTheme.headline6,
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListView(
          children: [
            Form(
              key: _key,
              child: Column(
                children: [
                  MyTextFormField(
                    controller: _nameController,
                    validator: validateName,
                    hintText: 'productd_order_name'.tr,
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    controller: _phoneController,
                    validator: validateName,
                    hintText: 'productd_order_phone'.tr,
                  ),
                  SizedBox(height: 20),
                  MyTextFormField(
                    controller: _messageController,
                    validator: validateName,
                    hintText: 'productd_order_message'.tr,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        MyCustomButton(
          onTap: () {
            Navigator.of(context).pop();
          },
          text: 'productd_order_cancel'.tr,
        ),
        MyCustomButton(
          onTap: _sendData,
          text: 'productd_order'.tr,
        ),
      ],
    );
  }

  _sendData() async {
    final form = _key.currentState;
    // final scaffold = Scaffold.of(context);
    if (form.validate()) {
      form.save();
      await widget.state.orderProduct(
        _nameController.text,
        _phoneController.text,
        _messageController.text,
      );
      Navigator.of(context).pop();
    }
  }
}
