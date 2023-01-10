import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/constants/app_themes.dart';

import '../../widgets/planner/planner_item_widget.dart';

class ToDoListScreen extends ConsumerStatefulWidget {
  const ToDoListScreen({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final AppThemeModel theme;
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends ConsumerState<ToDoListScreen> {
  final List<String> items = ['Dzisiaj', 'Ten tydzień'];
  String? selectedValue = 'Dzisiaj';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: items
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
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  iconSize: 24,
                  iconEnabledColor: widget.theme.mainColor,
                  iconDisabledColor: Colors.grey,
                  buttonHeight: 50,
                  buttonWidth: 160,
                  buttonPadding: const EdgeInsets.only(left: 12, right: 12),
                  buttonDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  buttonElevation: 2,
                  itemHeight: 40,
                  itemPadding: const EdgeInsets.only(left: 14, right: 14),
                  dropdownMaxHeight: 200,
                  dropdownWidth: 160,
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
              Expanded(
                child: Center(
                  child: Text(
                    "Oznacz wszystkie",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: widget.theme.mainColor),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: PlannerItemWidget(theme: widget.theme),
        )
      ],
    );
  }
}
