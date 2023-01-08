import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/notepad_models/notepad_model.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';
import 'package:pomodoro_flutter/widgets/custom_button_widget.dart';

class NotepadDetailsScreen extends StatefulWidget {
  const NotepadDetailsScreen({
    Key? key,
    required this.theme,
    this.note,
  }) : super(key: key);

  final AppThemeModel theme;
  final NotepadModel? note;
  @override
  State<NotepadDetailsScreen> createState() => _NotepadDetailsScreenState();
}

class _NotepadDetailsScreenState extends State<NotepadDetailsScreen> {
  final noteTitleController = TextEditingController();
  final noteDescriptionController = TextEditingController();
  final _controller = QuillController.basic();
  @override
  void initState() {
    if (widget.note != null) {
      if (widget.note!.title != null) {
        noteTitleController.text = widget.note!.title!;
      }
      noteDescriptionController.text = widget.note!.description!;
    }
    super.initState();
  }

  @override
  void dispose() {
    noteTitleController.dispose();
    noteDescriptionController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenWidget(
        resizeToAvoidBottomInsets: false,
        mainColor: widget.theme.mainColor,
        screenTitle:
            widget.note != null ? "notepad.edit".tr() : "notepad.create".tr(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 4.0),
                  ],
                ),
                child: QuillToolbar.basic(
                  iconTheme: QuillIconTheme(
                      iconSelectedFillColor: widget.theme.mainColor,
                      borderRadius: 10.0,),
                  controller: _controller,
                  showUndo: false,
                  showLink: false,
                  showAlignmentButtons: false,
                  showCenterAlignment: false,
                  showCodeBlock: false,
                  showDirection: false,
                  showDividers: false,
                  showHeaderStyle: false,
                  showJustifyAlignment: false,
                  showQuote: false,
                  showRedo: false,
                  showSearchButton: false,
                  showRightAlignment: false,
                  showStrikeThrough: false,
                  showInlineCode: false,
                  showIndent: false,
                  showLeftAlignment: false,
                  showSmallButton: false,
                  showFontFamily: false,
                  showFontSize: false,
                  showClearFormat: false,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: QuillEditor.basic(
                    controller: _controller,
                    readOnly: false, // true for view only mode
                  ),
                ),
              ),
              /* Text(
                "title".tr(),
                style: AppStyles.descriptionStyle,
              ),*/
              /*  const SizedBox(
                height: 4.0,
              ),
              TextFieldWidget(
                controller: noteTitleController,
                color: widget.theme.mainColor,
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFieldWidget(
                controller: noteTitleController,
                color: widget.theme.mainColor,
                maxLines: 20,
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 48.0),
                child: Center(
                  child: CustomButtonWidget(
                      buttonText: "pomodoro.createPomodoroSetBtn".tr(),
                      onTap: () {
                        print(_controller.document.toDelta().toJson());
                      },
                      theme: widget.theme),
                ),
              ),
            ],
          ),
        ));
  }
}
