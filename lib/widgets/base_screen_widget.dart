import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class BaseScreenWidget extends StatefulWidget {
  const BaseScreenWidget({
    Key? key,
    required this.mainColor,
    required this.screenTitle,
    required this.body,
    this.onTap,
  }) : super(key: key);

  final Color mainColor;
  final String screenTitle;
  final Widget body;
  final void Function()? onTap;

  @override
  State<BaseScreenWidget> createState() => _BaseScreenWidgetState();
}

class _BaseScreenWidgetState extends State<BaseScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: widget.mainColor,
            child: SafeArea(
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 18.0,
                            horizontal: 20.0,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.backgroundColor,
                            size: 24.0,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.onTap != null,
                        child: InkWell(
                          onTap: widget.onTap,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 18.0,
                              horizontal: 20.0,
                            ),
                            child: Icon(
                              Icons.help_outlined,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.screenTitle,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(
                top: 60.0,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: widget.body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
