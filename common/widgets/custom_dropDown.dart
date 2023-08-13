import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_theme.dart';

// ignore: must_be_immutable
class CustomDropDownMenu extends StatefulWidget {
   CustomDropDownMenu({super.key, 
    required this.controller,
    required this.valueController,
    required this.hintText,
    required this.maxHeight,
    required this.maxWidth,
    required this.items,
    required this.values,
    required this.labelText,
    this.validatorText = "",
  });

  TextEditingController controller;
  TextEditingController valueController;
  String hintText;
  double maxHeight;
  double maxWidth;
  List values;
  List<String> items;
  String validatorText;
  String labelText;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  //create items

  var fieldValue = '';

  final GlobalKey _popupMenuKey = GlobalKey();

  List<PopupMenuItem> items = [];

  //set items to dropdown list
  setitems() {
    items.clear();
    // if (widget._items.isNotEmpty || widget._values.isNotEmpty) {
    for (int i = 0; i < items.length; i++) {
      items.add(
        PopupMenuItem(
          value: widget.values[i],
          child: Container(
            // width: MediaQuery.of(context).size.width,
            child: Text(
              widget.items[i].toString(),
            ),
          ),
        ),
      );
    }
  }

  bool focused = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (widget.controller.text == widget.hintText) {
          // log('focused');
          setState(() {
            focused = true;
            widget.controller.text = '';
          });
        }
      } else {
        if (widget.controller.text.trim() == '') {
          widget.controller.text = widget.hintText;
        } else {
          if (widget.controller.text.isNotEmpty) {
            setState(() {
              focused = true;
            });
          } else {
            setState(() {
              focused = false;
            });
          }
        }
        // log('unfocused');
      }
    });

    if (widget.controller.text.isNotEmpty) {
      setState(() {
        focused = true;
      });
    } else {
      setState(() {
        focused = false;
      });
    }

    if (widget.controller.text.trim() == '') {
      Future.delayed(
        const Duration(microseconds: 100),
        () {
          widget.controller.text = widget.hintText;
          setState(() {
            focused = true;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget._items.toString());
    items.clear();
    for (int i = 0; i < widget.items.length; i++) {
      items.add(
        PopupMenuItem(
          value: widget.values[i],
          child: Container(
            // width: MediaQuery.of(context).size.width,
            child: Text(
              widget.items[i].toString(),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
    // setitems();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 40.r,
            color: Colors.black.withOpacity(0.25),
            spreadRadius: -15,
            offset: Offset(0, 7.h),
          )
        ],
      ),
      child: PopupMenuButton(
        constraints: BoxConstraints(
          // maxHeight:,
          minWidth: widget.maxWidth,
          maxHeight: widget.maxHeight,
        ),
        key: _popupMenuKey,
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        onSelected: (value) {
          for (int i = 0; i < widget.items.length; i++) {
            if (widget.values[i] == value) {
              widget.controller.text = widget.items[i];
              widget.valueController.text = value.toString();
            }
          }
        },
        child: TextFormField(
          onTap: () {
            dynamic state = _popupMenuKey.currentState;
            state.showButtonMenu();
          },
          focusNode: focusNode,
          enabled: true,
          readOnly: true,
          controller: widget.controller,
          cursorColor: AppTheme.primaryColor,
          validator: (value) {
            if (widget.validatorText != "") {
              if (value == null ||
                  value.isEmpty ||
                  value.trim() == widget.hintText) {
                return widget.validatorText;
              }
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.r),
              borderSide: const BorderSide(
                color: AppTheme.appGrayLite,
                width: 1,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            labelText: widget.labelText,
            labelStyle: focused
                ? TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 13.5.sp,
                    // fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  )
                : TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 10.sp,
                    color: Colors.black54,
                  ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12.sp,
              color: Colors.black45,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.r),
              borderSide: const BorderSide(
                color: AppTheme.appGrayLite,
                width: 1,
              ),
            ),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black26,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.r),
              borderSide: const BorderSide(
                color: AppTheme.primaryColor,
                width: 1.5,
              ),
            ),
            prefixIcon: Container(
              width: 18.w,
            ),
            prefixIconConstraints: BoxConstraints(
              maxWidth: 55.w,
            ),
          ),
          style: focused
              ? TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                )
              : TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black26,
                ),
        ),
        itemBuilder: (context) {
          return items;
        },
      ),
    );
  }
}
