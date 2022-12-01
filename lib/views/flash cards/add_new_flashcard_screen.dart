import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';

class AddNewFlashCardScreen extends ConsumerStatefulWidget {
  const AddNewFlashCardScreen({Key? key}) : super(key: key);

  @override
  _AddNewFlashCardScreenState createState() => _AddNewFlashCardScreenState();
}

class _AddNewFlashCardScreenState extends ConsumerState<AddNewFlashCardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      screenTitle: "Dodaj nową fiszkę",
      body: Padding(
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
      mainColor: theme.mainColor,
    );
  }
}
