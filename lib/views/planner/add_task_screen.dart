import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';
import 'package:pomodoro_flutter/models/planner_models/task_model.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';
import 'package:pomodoro_flutter/widgets/custom_button_widget.dart';
import 'package:pomodoro_flutter/widgets/text_field_widget.dart';

import '../../constants/app_styles.dart';
import '../../services/planner_service.dart';
import 'delete_task_screen.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({
    Key? key,
    required this.theme,
    this.task,
  }) : super(key: key);

  final AppThemeModel theme;
  final TaskModel? task;

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final titleController = TextEditingController();
  final _controller = quill.QuillController.basic();

  @override
  void initState() {
    if (widget.task != null) {
      titleController.text = widget.task!.title!;
      if (widget.task!.description != null) {
        _controller.document =
            quill.Document.fromJson(jsonDecode(widget.task!.description!));
      }
      if (widget.task!.date != null) {
        deadlineDate = DateTime.parse(widget.task!.date!);
      }
      selectedImportant = widget.task!.isImportant;
      selectedUrgent = widget.task!.isUrgent;
    }
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    _controller.dispose();
    super.dispose();
  }

  final titleValidator = MultiValidator([
    RequiredValidator(errorText: 'error.cantBeEmpty'.tr()),
    MaxLengthValidator(255, errorText: "error.titleToLong".tr())
  ]);

  String? selectedUrgent;
  String? selectedImportant;
  String? urgentError;
  String? importantError;
  final List<String> important = [
    "planner.important".tr(),
    "planner.notImportant".tr()
  ];
  final List<String> urgent = [
    "planner.urgent".tr(),
    "planner.notUrgent".tr(),
  ];
  DateTime? deadlineDate;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseScreenWidget(
      onTap: widget.task != null
          ? () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child:
                      DeleteTaskScreen(theme: widget.theme, task: widget.task!),
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
      screenTitle: "planner.createTask".tr(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24.0,
          right: 24.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "title".tr(),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Form(
                          key: _formKey,
                          child: TextFieldWidget(
                            controller: titleController,
                            color: widget.theme.mainColor,
                            validator: titleValidator,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 24.0,
                  ),
                  Flexible(
                    flex: 5,
                    child: Stack(
                      children: [
                        Visibility(
                          visible: deadlineDate == null,
                          maintainAnimation: true,
                          maintainSize: true,
                          maintainState: true,
                          child: InkWell(
                            onTap: () async {
                              await showDatePicker(
                                  context: context,
                                  initialDate:
                                      DateTime.now(), //get today's date
                                  firstDate: DateTime
                                      .now(), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(
                                    DateTime.now().year + 10,
                                  )).then((value) => setState(() {
                                    deadlineDate = value;
                                  }));
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "planner.deadline".tr(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Icon(
                                      Icons.calendar_month_rounded,
                                      color: widget.theme.mainColor,
                                      size: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: deadlineDate != null,
                          maintainAnimation: true,
                          maintainSize: true,
                          maintainState: true,
                          child: InkWell(
                            onTap: () async {
                              await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(
                                    DateTime.now().year + 10,
                                  )).then((value) => setState(() {
                                    deadlineDate = value;
                                  }));
                            },
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("planner.deadline".tr()),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.0),
                                      child: deadlineDate != null
                                          ? Text(
                                              DateFormat('dd.MM.yyyy')
                                                  .format(deadlineDate!),
                                              style: AppStyles.descriptionStyle,
                                            )
                                          : Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.6)),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
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
                      child: quill.QuillToolbar.basic(
                        iconTheme: quill.QuillIconTheme(
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
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 12.0,
                        ),
                        child: quill.QuillEditor.basic(
                          controller: _controller,
                          readOnly: false, // true for view only mode
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              "choose".tr(),
                            ),
                            isExpanded: true,
                            items: urgent
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedUrgent,
                            onChanged: (value) {
                              setState(() {
                                selectedUrgent = value as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 24,
                            iconEnabledColor: widget.theme.mainColor,
                            iconDisabledColor: Colors.grey,
                            buttonHeight: 50,
                            // buttonWidth: 160,
                            buttonPadding:
                                const EdgeInsets.only(left: 12, right: 12),
                            buttonDecoration: BoxDecoration(
                              border: urgentError != null
                                  ? Border.all(color: Colors.red)
                                  : null,
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            buttonElevation: 2,
                            itemHeight: 40,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            dropdownMaxHeight: 200,
                            //dropdownWidth: 160,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            dropdownElevation: 2,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 3,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(0, 0),
                          ),
                        ),
                        Visibility(
                          visible: urgentError != null,
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: Text(
                              "$urgentError",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.red.shade700, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text(
                              "choose".tr(),
                            ),
                            isExpanded: true,
                            items: important
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedImportant,
                            onChanged: (value) {
                              setState(() {
                                selectedImportant = value as String;
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down,
                            ),
                            iconSize: 24,
                            iconEnabledColor: widget.theme.mainColor,
                            iconDisabledColor: Colors.grey,
                            buttonHeight: 50,
                            //buttonWidth: 160,
                            buttonPadding:
                                const EdgeInsets.only(left: 12, right: 12),
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: importantError != null
                                  ? Border.all(color: Colors.red)
                                  : null,
                              color: Colors.white,
                            ),
                            buttonElevation: 2,
                            itemHeight: 40,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            dropdownMaxHeight: 200,
                            //dropdownWidth: 160,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            dropdownElevation: 2,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 3,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(0, 0),
                          ),
                        ),
                        Visibility(
                          visible: importantError != null,
                          maintainSize: true,
                          maintainState: true,
                          maintainAnimation: true,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: Text(
                              "$importantError",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.red.shade700, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: CustomButtonWidget(
                      buttonText: "create".tr(),
                      onTap: () {
                        if (_formKey.currentState?.validate() == true) {
                          if (selectedUrgent == null) {
                            setState(() {
                              urgentError = "choose".tr();
                            });
                            if (selectedImportant == null) {
                              setState(() {
                                importantError = "choose".tr();
                              });
                            } else {
                              setState(() {
                                importantError = null;
                              });
                            }
                          } else {
                            setState(() {
                              urgentError = null;
                            });
                            if (selectedImportant == null) {
                              setState(() {
                                selectedImportant = "choose".tr();
                              });
                            } else {
                              setState(() {
                                importantError = null;
                              });
                              final task = TaskModel(
                                title: titleController.text.trim(),
                                description: jsonEncode(
                                    _controller.document.toDelta().toJson()),
                                date: deadlineDate != null
                                    ? DateFormat('yyyy-MM-DD')
                                        .format(deadlineDate!)
                                    : null,
                                isDone: 0,
                                isImportant: selectedImportant,
                                isUrgent: selectedUrgent,
                              );
                              ref
                                  .read(plannerServiceProvider)
                                  .createTask(task)
                                  .then((value) => Navigator.pop(context));
                            }
                          }
                        } else {
                          if (selectedUrgent == null) {
                            setState(() {
                              urgentError = "choose".tr();
                            });
                            if (selectedImportant == null) {
                              setState(() {
                                importantError = "choose".tr();
                              });
                            } else {
                              setState(() {
                                importantError = null;
                              });
                            }
                          } else {
                            setState(() {
                              urgentError = null;
                            });
                            if (selectedImportant == null) {
                              setState(() {
                                importantError = "choose".tr();
                              });
                            } else {
                              setState(() {
                                importantError = null;
                              });
                            }
                          }
                        }
                      },
                      theme: widget.theme),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
