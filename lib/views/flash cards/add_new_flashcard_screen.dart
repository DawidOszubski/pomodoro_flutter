import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/widgets/flash%20cards/big_input_widget.dart';

import '../../constants/app_styles.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/base_screen_widget.dart';

class AddNewFlashCardScreen extends ConsumerStatefulWidget {
  const AddNewFlashCardScreen({Key? key}) : super(key: key);

  @override
  _AddNewFlashCardScreenState createState() => _AddNewFlashCardScreenState();
}

class _AddNewFlashCardScreenState extends ConsumerState<AddNewFlashCardScreen> {
  final picker = ImagePicker();

  File? image;
  var loadImage = false;
  var isTrue = true;
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BaseScreenWidget(
        screenTitle: "Dodaj nową fiszkę",
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Pytanie",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: BigInputWidget(
                  controller: TextEditingController(),
                  color: theme.mainColor,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                      onTap: () async {
                        try {
                          await pickImage();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Dodaj obraz",
                          style: AppStyles.secondaryButtonStyle
                              .copyWith(color: theme.mainColor),
                        ),
                      )),
                ),
              ),
              image != null
                  ? Image.file(
                      image!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : Container(),
              SizedBox(
                height: 24.0 * 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Odpowiedź",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: answerNotChosen(),
              ),
            ],
          ),
        ),
        mainColor: theme.mainColor,
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) {
        return;
      } else {
        final imageTmp = File(image.path);
        setState(() {
          this.image = imageTmp;
        });
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Widget answerText({required AppThemeModel theme}) {
    return BigInputWidget(
      controller: TextEditingController(),
      color: theme.mainColor,
    );
  }

  Widget answerTF({required AppThemeModel theme}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                if (!isTrue) {
                  setState(() {
                    isTrue = true;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.mainColor, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isTrue ? theme.mainColor : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text("PRAWDA"),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (isTrue) {
                  setState(() {
                    isTrue = false;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.mainColor, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isTrue ? theme.mainColor : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text("FAŁSZ"),
          ],
        ),
      ],
    );
  }

  Widget answerMultiple() {
    return Container();
  }

  Widget answerNotChosen() {
    return Container(
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(child: Text("PRAWDA / FAŁSZ")),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey, width: 1),
                  right: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: Center(child: Text("Zamknięte")),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(child: Text("Otwarte")),
            ),
          ),
        ],
      ),
    );
  }
}
