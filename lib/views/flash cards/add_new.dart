import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme_provider.dart';

class AddNew extends ConsumerStatefulWidget {
  const AddNew({Key? key}) : super(key: key);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends ConsumerState<AddNew> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height / 3,
                  maxHeight: MediaQuery.of(context).size.height / 2,
                  minWidth: MediaQuery.of(context).size.width,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(
                            2.0,
                            2.0,
                          ),
                          spreadRadius: 0,
                          blurRadius: 4,
                        ),
                        BoxShadow(
                          color: theme.mainColorDarker.withOpacity(0.6),
                          offset: const Offset(
                            3.0,
                            3.0,
                          ),
                          spreadRadius: 0,
                          blurRadius: 8,
                        ),
                      ]),
                  child: Text("text"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
