import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search_provider.dart';

class SearchBarWidget extends ConsumerStatefulWidget {
  const SearchBarWidget({
    Key? key,
    this.hint,
    required this.controller,
    required this.color,
    this.autofocus,
  }) : super(key: key);

  final String? hint;
  final TextEditingController controller;
  final Color color;
  final bool? autofocus;

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        ref.read(isSearchProvider.state).state = true;
      },
      autofocus: widget.autofocus != null ? widget.autofocus! : false,
      maxLines: 1,
      controller: widget.controller,
      cursorColor: widget.color,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          left: 12.0,
          right: 24.0,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: FocusScope.of(context).hasFocus ? widget.color : Colors.grey,
        ),
        hintText: widget.hint ?? "",
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.color,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
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
