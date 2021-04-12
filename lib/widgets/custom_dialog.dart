import 'package:flutter/material.dart';

///Customize Dialog
class CustomDialog extends StatefulWidget {
  //------------------Dialog without pictures------------------------
  final String title; //Popup title
  final TextStyle titleStyle; // Heading style
  final Widget content; // Pop-up content
  final String confirmContent; // Button text
  final String cancelContent; // Cancel button text
  final Color confirmTextColor; // OK button text color
  final bool
      isCancel; // Whether there is a cancel button, the default is false true: yes false: no
  final Color confirmColor; // OK button color
  final Color cancelColor; // Cancel button color
  final Color cancelTextColor; // Cancel button text color
  final bool outsideDismiss;

  ///  Click outside of the
  /// pop-up window to close the pop-up window, the default is true true: can be
  /// closed false: can not be closed
  final Function confirmCallback; // Click the OK button to call back
  final Function dismissCallback; // Callback when the pop-up window is closed

  //------------------Dialog with pictures------------------------
  final String image; //dialog add picture
  final String imageHintText; //Text reminder below the picture

  const CustomDialog({
    Key key,
    this.title,
    this.content,
    this.confirmContent,
    this.confirmTextColor,
    this.isCancel = true,
    this.confirmColor,
    this.cancelColor,
    this.outsideDismiss = false,
    this.confirmCallback,
    this.dismissCallback,
    this.image,
    this.imageHintText,
    this.titleStyle,
    this.cancelContent,
    this.cancelTextColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomDialogState();
  }
}

class _CustomDialogState extends State<CustomDialog> {
  _confirmDialog() {
    /// Judge based on the returned index
    Navigator.of(context).pop(1);
    Future.delayed(Duration(milliseconds: 250), () {
      if (widget.confirmCallback != null) {
        widget.confirmCallback();
      }
    });
  }

  _dismissDialog() {
    /// Judge based on the returned index
    Navigator.of(context).pop(0);
    Future.delayed(Duration(milliseconds: 250), () {
      if (widget.dismissCallback != null) {
        widget.dismissCallback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    Column _columnText = Column(
      children: <Widget>[
        SizedBox(height: widget.title == null ? 0 : 15.0),
        // Head title
        Container(
          height: 30,
          child: Text(
            widget.title == null ? '' : widget.title,
            style: widget.titleStyle,
          ),
        ),
        // Intermediate content
        Container(
          height: 80,
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          child: Center(
            child: widget.content,
          ),
        ),
        SizedBox(height: 0.5, child: Container(color: Color(0xDBDBDBDB))),
        // Bottom button
        Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: widget.isCancel
                    ? Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: widget.cancelColor == null
                                ? Color(0xFFFFFFFF)
                                : widget.cancelColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16.0))),
                        child: InkWell(
                          child: Center(
                            child: Text(
                                widget.cancelContent == null
                                    ? 'cancel'
                                    : widget.cancelContent,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                  color: widget.cancelColor == null
                                      ? (widget.cancelTextColor == null
                                          ? Colors.black87
                                          : widget.cancelTextColor)
                                      : Color(0xFFFFFFFF),
                                )),
                          ),
                          onTap: _dismissDialog,
                          splashColor: widget.cancelColor == null
                              ? Color(0xFFFFFFFF)
                              : widget.cancelColor,
                          highlightColor: widget.cancelColor == null
                              ? Color(0xFFFFFFFF)
                              : widget.cancelColor,
                        ),
                      )
                    : Text(''),
                flex: widget.isCancel ? 1 : 0,
              ),
              SizedBox(
                  width: widget.isCancel ? 1.0 : 0,
                  child: Container(color: Color(0xDBDBDBDB))),
              Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: widget.confirmColor == null
                          ? Color(0xFFFFFFFF)
                          : widget.confirmColor,
                      borderRadius: widget.isCancel
                          ? BorderRadius.only(
                              bottomRight: Radius.circular(16.0))
                          : BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0)),
                    ),
                    child: InkWell(
                      onTap: _confirmDialog,
                      child: Center(
                        child: Text(
                            widget.confirmContent == null
                                ? 'Determine'
                                : widget.confirmContent,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: widget.confirmColor == null
                                  ? (widget.confirmTextColor == null
                                      ? Colors.black87
                                      : widget.confirmTextColor)
                                  : Color(0xFFFFFFFF),
                            )),
                      ),
                      splashColor: widget.confirmColor == null
                          ? Color(0xFFFFFFFF)
                          : widget.confirmColor,
                      highlightColor: widget.confirmColor == null
                          ? Color(0xFFFFFFFF)
                          : widget.confirmColor,
                    ),
                  ),
                  flex: 1),
            ],
          ),
        )
      ],
    );

    /// Route interception
    return WillPopScope(
        child: GestureDetector(
          onTap: () => {widget.outsideDismiss ? _dismissDialog() : null},
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                width: widget.image == null ? width - 100.0 : width - 150.0,
                height: 168.0,
                alignment: Alignment.center,
                child: _columnText,
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(16.0)),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return widget.outsideDismiss;
        });
  }
}
