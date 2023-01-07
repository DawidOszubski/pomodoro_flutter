import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/widgets/custom_button_widget.dart';

import '../../../widgets/base_screen_widget.dart';
import '../../../widgets/text_field_widget.dart';

class AddTestScreen extends ConsumerStatefulWidget {
  const AddTestScreen({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final AppThemeModel theme;
  @override
  _AddTestScreenState createState() => _AddTestScreenState();
}

class _AddTestScreenState extends ConsumerState<AddTestScreen> {
  final testTitleController = TextEditingController();
  final testDescriptionController = TextEditingController();
  final testSubjectController = TextEditingController();
  final testDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreenWidget(
      resizeToAvoidBottomInsets: true,
      screenTitle: "addTest".tr(),
      mainColor: widget.theme.mainColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("testTitle".tr()),
              TextFieldWidget(
                controller: testTitleController,
                color: widget.theme.mainColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36.0),
                child: Divider(
                  color: widget.theme.mainColor,
                  height: 1.0,
                  thickness: 1.0,
                ),
              ),
              Text("testDescription".tr()),
              TextFieldWidget(
                maxLines: 5,
                controller: testDescriptionController,
                color: widget.theme.mainColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36.0),
                child: Divider(
                  color: widget.theme.mainColor,
                  height: 1.0,
                  thickness: 1.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Przedmiot"),
                        TextFieldWidget(
                          controller: testSubjectController,
                          color: widget.theme.mainColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 48.0,
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Data"),
                        TextFieldWidget(
                          controller: testDateController,
                          color: widget.theme.mainColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: CustomButtonWidget(
                      buttonText: "addTestBtn".tr(),
                      theme: widget.theme,
                      onTap: () {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
