import 'package:flutter/material.dart';

class PopUpWidget extends StatelessWidget {
  const PopUpWidget({
    Key? key,
    required this.body,
    required this.mainColor,
  }) : super(key: key);

  final Widget body;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
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
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: mainColor,
                          size: 30,
                        ),
                      ),
                      body,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
