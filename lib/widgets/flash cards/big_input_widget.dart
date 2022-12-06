import 'package:flutter/material.dart';

class BigInputWidget extends StatefulWidget {
  const BigInputWidget({
    Key? key,
    this.hint,
    required this.controller,
    required this.color,
    this.autofocus,
    this.validator,
  }) : super(key: key);

  final String? hint;
  final TextEditingController controller;
  final Color color;
  final bool? autofocus;
  final String? Function(String?)? validator;

  @override
  State<BigInputWidget> createState() => _BigInputWidgetState();
}

class _BigInputWidgetState extends State<BigInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: 6,
      validator: widget.validator,
      autofocus: widget.autofocus != null ? widget.autofocus! : false,
      controller: widget.controller,
      cursorColor: widget.color,
      decoration: InputDecoration(
        hintText: widget.hint ?? "",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.color,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.color,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
