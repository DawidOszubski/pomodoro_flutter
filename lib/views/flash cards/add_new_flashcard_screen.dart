import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pomodoro_flutter/widgets/flash%20cards/big_input_widget.dart';

import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';

class AddNewFlashCardScreen extends ConsumerStatefulWidget {
  const AddNewFlashCardScreen({Key? key}) : super(key: key);

  @override
  _AddNewFlashCardScreenState createState() => _AddNewFlashCardScreenState();
}

class _AddNewFlashCardScreenState extends ConsumerState<AddNewFlashCardScreen> {
  final picker = ImagePicker();
  late Future<XFile?> pickedFile = Future.value(null);

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      screenTitle: "Dodaj nową fiszkę",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pytanie",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 8.0,
            ),
            BigInputWidget(
              controller: TextEditingController(),
              color: theme.mainColor,
            ),
            InkWell(
                onTap: () async {
                  try {
                    pickedFile = (await picker
                            .pickImage(source: ImageSource.gallery)
                            .whenComplete(() => {setState(() {})}))
                        as Future<XFile?>;
                  } catch (e) {
                    print(e);
                  }
                },
                child: Icon(Icons.ac_unit)),
          ],
        ),
      ),
      mainColor: theme.mainColor,
    );
  }
}
