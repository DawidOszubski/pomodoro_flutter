import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro_flutter/constants/app_colors.dart';
import 'package:pomodoro_flutter/constants/app_styles.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';

class LessonDetailsScreen extends ConsumerStatefulWidget {
  const LessonDetailsScreen({
    Key? key,
    required this.lessonDate,
    required this.lessonName,
    required this.lessonTopic,
  }) : super(key: key);

  final String lessonName;
  final String lessonTopic;
  final DateTime lessonDate;

  @override
  _LessonDetailsScreenState createState() => _LessonDetailsScreenState();
}

class _LessonDetailsScreenState extends ConsumerState<LessonDetailsScreen> {
  late List detailsList = [];

  @override
  void initState() {
    detailsList = [
      SingleItemDetails(
        title: "Przedmiot",
        body: widget.lessonName,
      ),
      SingleItemDetails(
        title: "Temat",
        body: widget.lessonTopic,
      ),
      SingleItemDetails(
        title: "Najbliższe zajęcia",
        body: DateFormat('dd/MM/yyyy').format(widget.lessonDate),
      ),
      SingleItemDetails(
        title: "Prowadzący",
        body: "prof dr jakiś ziomek",
      ),
      SingleItemDetails(
        title: "Sala",
        body: "sala 231\nul. Jakaś tam 12",
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(appThemeProvider);
    //  final primaryColor = themeData["primaryColor"];
    //final backgroundColor = themeData["backgroundColor"];
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: themeData.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.mainColor,
        centerTitle: true,
        title: Text("Szczegóły zajecia"),
      ),
      backgroundColor: themeData.backgroundColor,
      body: ListView.builder(
          itemCount: detailsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailsList[index],
                index != detailsList.length - 1
                    ? Divider(
                        color: themeData.mainColor,
                        height: 0,
                        thickness: 1,
                        endIndent: 24.0,
                        indent: 24.0,
                      )
                    : Container(),
              ],
            );
          }),
    );
  }
}

class SingleItemDetails extends StatelessWidget {
  const SingleItemDetails({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        editWidget(context, title);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.detailsTitleStyle,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              body,
              style: AppStyles.detailsBodyStyle,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> editWidget(
  BuildContext context,
  String title,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AlertDialog(
          backgroundColor: AppColors.darkBrown,
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          content: TextField(
              cursorColor: AppColors.darkBrown,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: AppColors.mainColorLighter)),
                fillColor: Colors.white,
                filled: true,
              )),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: const Text('Anuluj'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: const Text('Zapisz'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
