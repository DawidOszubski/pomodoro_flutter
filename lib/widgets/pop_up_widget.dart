import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/app_styles.dart';

class PopUpWidget extends StatelessWidget {
  const PopUpWidget({
    Key? key,
    required this.body,
    required this.mainColor,
    required this.title,
  }) : super(key: key);

  final Widget body;
  final Color mainColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: Offset(4, 3))
                      ],
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 8.0,
                                right: 8.0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: mainColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50.0,
                                vertical: 21.0,
                              ),
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: AppStyles.popUpTitleStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      body,
                    ],
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
