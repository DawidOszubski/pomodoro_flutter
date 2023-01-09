import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/notepad_models/notepad_model.dart';

import '../../constants/app_styles.dart';
import '../../services/notepad_service.dart';
import '../../widgets/pop_up_widget.dart';

class DeleteNoteScreen extends ConsumerStatefulWidget {
  const DeleteNoteScreen({
    Key? key,
    required this.note,
    required this.theme,
    this.isDoublePop,
  }) : super(key: key);

  final NotepadModel note;
  final AppThemeModel theme;
  final bool? isDoublePop;
  @override
  _DeleteNoteScreenState createState() => _DeleteNoteScreenState();
}

class _DeleteNoteScreenState extends ConsumerState<DeleteNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return PopUpWidget(
        title: "notepad.deleteTitle".tr(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(
                height: 12.0,
              ),
              Text(
                "notepad.deleteDescription".tr(),
                textAlign: TextAlign.center,
                style: AppStyles.textStyle,
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      ref
                          .read(notepadServiceProvider)
                          .deleteNote(widget.note)
                          .then((value) { Navigator.of(context).pop();
                      if(widget.isDoublePop != null){ Navigator.of(context).pop();}
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "yes".tr(),
                        style: AppStyles.yesNoButtonOptionsStyle
                            .copyWith(color: widget.theme.mainColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "no".tr(),
                        style: AppStyles.yesNoButtonOptionsStyle
                            .copyWith(color: widget.theme.mainColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
        mainColor: widget.theme.mainColor);
  }
}
