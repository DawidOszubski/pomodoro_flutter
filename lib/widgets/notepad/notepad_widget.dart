import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_flutter/models/notepad_models/notepad_model.dart';

class NotepadWidget extends StatefulWidget {
  const NotepadWidget({
    Key? key,
    required this.notepad,
  }) : super(key: key);

  final NotepadModel notepad;
  @override
  State<NotepadWidget> createState() => _NotepadWidgetState();
}

class _NotepadWidgetState extends State<NotepadWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow.shade50,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(3.0, 3.0),
              blurRadius: 6.0,
              spreadRadius: 1.0),
        ],
      ),
      constraints: const BoxConstraints(minHeight: 100, maxHeight: 240),
      child: Column(
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
                Text(
                  "${widget.notepad.title}",
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: .5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "${widget.notepad.description}",
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
                DateFormat('dd/MM/yyyy')
                    .format(DateTime.parse(widget.notepad.date!)),
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
    );
  }
}
