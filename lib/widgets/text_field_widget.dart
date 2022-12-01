import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    Key? key,
    this.textFieldTitle,
    this.hint,
    required this.controller,
    required this.color,
    this.autofocus,
    this.validator,
  }) : super(key: key);

  final String? textFieldTitle;
  final String? hint;
  final TextEditingController controller;
  final Color color;
  final bool? autofocus;
  final String? Function(String?)? validator;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.textFieldTitle != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.textFieldTitle!,
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                ],
              )
            : Container(),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: 1,
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
        ),
      ],
    );
  }
}
