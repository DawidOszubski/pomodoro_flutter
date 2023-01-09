import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/notepad_models/notepad_model.dart';

import '../../views/notepad/delete_note_screen.dart';
import '../../views/notepad/notepad_details_screen.dart';

class NotepadWidget extends ConsumerStatefulWidget {
  const NotepadWidget({
    Key? key,
    required this.note,
    required this.theme,
  }) : super(key: key);

  final NotepadModel note;
  final AppThemeModel theme;
  @override
  _NotepadWidgetState createState() => _NotepadWidgetState();
}

class _NotepadWidgetState extends ConsumerState<NotepadWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(
              milliseconds: 100,
            ),
            child: DeleteNoteScreen(
              theme: widget.theme,
              note: widget.note,
            ),
          ),
        );
      },
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(
              milliseconds: 350,
            ),
            child: NotepadDetailsScreen(theme: widget.theme, note: widget.note),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow.shade50,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(2.0, 2.0),
              blurRadius: 4.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        constraints: const BoxConstraints(minHeight: 100, maxHeight: 240),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurStyle: BlurStyle.inner,
                          spreadRadius: .5,
                          offset: const Offset(-.5, -.5),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurStyle: BlurStyle.inner,
                          spreadRadius: .5,
                          offset: const Offset(-.5, -.5),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurStyle: BlurStyle.inner,
                          spreadRadius: .5,
                          offset: const Offset(-.5, -.5),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 24.0,
                right: 24.0,
                bottom: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.note.title != null && widget.note.title!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "${widget.note.title}",
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 16.0,
                              letterSpacing: .5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(),
                  Text(
                    "${quill.Document.fromJson(jsonDecode(widget.note.description!)).toPlainText()}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 12.0,
                      letterSpacing: .5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "${widget.note.date}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
