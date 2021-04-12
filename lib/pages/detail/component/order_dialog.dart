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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  String savedName;
  String nameError;

  TextEditingController _phoneController = TextEditingController();
  String savedPhone;
  String phoneError;

  TextEditingController _messageController = TextEditingController();
  String savedMessage;
  String messageError;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1.0,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 14,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'productd_order_title'.tr,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 14),
                MyTextFormField(
                  controller: _nameController,
                  validator: validateName,
                  hintText: 'productd_order_name'.tr,
                  onChanged: (v) {
                    if (nameError != null) {
                      setState(() => nameError = null);
                    }
                  },
                  onSaved: (v) => savedName = v,
                ),
                SizedBox(height: 14),
                MyTextFormField(
                  controller: _phoneController,
                  validator: validateName,
                  hintText: 'productd_order_phone'.tr,
                  onChanged: (v) {
                    if (phoneError != null) {
                      setState(() => phoneError = null);
                    }
                  },
                  onSaved: (v) => savedPhone = v,
                ),
                SizedBox(height: 14),
                MyTextFormField(
                  controller: _messageController,
                  validator: validateName,
                  hintText: 'productd_order_message'.tr,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onChanged: (v) {
                    if (messageError != null) {
                      setState(() => messageError = null);
                    }
                  },
                  onSaved: (v) => savedMessage = v,
                ),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyCustomButton(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      text: 'productd_order_cancel'.tr,
                    ),
                    SizedBox(width: 16),
                    MyCustomButton(
                      onTap: _sendData,
                      text: 'productd_order'.tr,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sendData() async {
    final form = _formKey.currentState;
    // final scaffold = Scaffold.of(context);
    if (form.validate()) {
      form.save();
      await widget.state.orderProduct(
        savedName,
        savedPhone,
        savedPhone,
      );
      Navigator.of(context).pop();
    }
  }
}
