import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';

import '../constants/app_colors.dart';

class BaseScreenWidget extends ConsumerStatefulWidget {
  const BaseScreenWidget({
    Key? key,
    required this.mainColor,
    required this.screenTitle,
    required this.body,
    this.onTap,
    this.resizeToAvoidBottomInsets,
    this.actionIcon,
    this.backIcon,
  }) : super(key: key);

  final Color mainColor;
  final String screenTitle;
  final Widget body;
  final void Function()? onTap;
  final bool? resizeToAvoidBottomInsets;
  final Icon? actionIcon;
  final void Function()? backIcon;

  @override
  _BaseScreenWidgetState createState() => _BaseScreenWidgetState();
}

class _BaseScreenWidgetState extends ConsumerState<BaseScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInsets,
      body: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(gradient: theme.gradient),
              child: SafeArea(
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: widget.backIcon ??
                              () {
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 18.0,
                                horizontal: 20.0,
                              ),
                              child: widget.actionIcon ??
                                  const Icon(
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.screenTitle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 60.0 + MediaQuery.of(context).padding.top,
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
                padding: EdgeInsets.only(
                  top: 24.0,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: widget.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
