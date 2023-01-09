import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/notepad_models/notepad_model.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';
import 'package:pomodoro_flutter/widgets/custom_button_widget.dart';
import 'package:pomodoro_flutter/widgets/text_field_widget.dart';

import '../../services/notepad_service.dart';
import 'delete_note_screen.dart';

class NotepadDetailsScreen extends ConsumerStatefulWidget {
  const NotepadDetailsScreen({
    Key? key,
    required this.theme,
    this.note,
  }) : super(key: key);

  final AppThemeModel theme;
  final NotepadModel? note;
  @override
  _NotepadDetailsScreenState createState() => _NotepadDetailsScreenState();
}

class _NotepadDetailsScreenState extends ConsumerState<NotepadDetailsScreen> {
  final noteTitleController = TextEditingController();
  final noteDescriptionController = TextEditingController();
  final _controller = QuillController.basic();
  @override
  void initState() {
    if (widget.note != null) {
      if (widget.note!.title != null) {
        noteTitleController.text = widget.note!.title!;
      }
      _controller.document =
          Document.fromJson(jsonDecode(widget.note!.description!));
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
        onTap: widget.note != null
            ? () {
                FocusScope.of(context).unfocus();
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: const Duration(
                      milliseconds: 100,
                    ),
                    child: DeleteNoteScreen(
                      theme: widget.theme,
                      note: widget.note!,
                      isDoublePop: true,
                    ),
                  ),
                );
              }
            : null,
        actionIcon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        resizeToAvoidBottomInsets: true,
        mainColor: widget.theme.mainColor,
        screenTitle:
            widget.note != null ? "notepad.edit".tr() : "notepad.create".tr(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                  controller: noteTitleController,
                  color: widget.theme.mainColor,
                  hint: "title".tr()),
              const SizedBox(
                height: 24,
              ),
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
                    borderRadius: 10.0,
                  ),
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
              Visibility(
                visible:
                    true, // MediaQuery.of(context).viewInsets.bottom == 0.0,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 12.0,
                    bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Center(
                    child: CustomButtonWidget(
                        buttonText: widget.note != null
                            ? "save".tr()
                            : "pomodoro.createPomodoroSetBtn".tr(),
                        onTap: () {
                          if (_controller.document.toPlainText().length > 1) {
                            if (widget.note != null) {
                              final note = NotepadModel(
                                  id: widget.note!.id,
                                  title: noteTitleController.text,
                                  description: jsonEncode(
                                      _controller.document.toDelta().toJson()),
                                  date: widget.note!.date);

                              ref
                                  .watch(notepadServiceProvider)
                                  .updateNote(notepadModel: note)
                                  .then((value) => Navigator.pop(context));
                            } else {
                              final note = NotepadModel(
                                  title: noteTitleController.text,
                                  description: jsonEncode(
                                      _controller.document.toDelta().toJson()),
                                  date: DateFormat('dd/MM/yyyy')
                                      .format(DateTime.now()));

                              ref
                                  .read(notepadServiceProvider)
                                  .createNote(note)
                                  .then((value) => Navigator.pop(context));
                            }
                          }
                        },
                        theme: widget.theme),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
