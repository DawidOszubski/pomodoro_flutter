import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';

class HomePageListItemWidget extends ConsumerStatefulWidget {
  const HomePageListItemWidget({
    Key? key,
    required this.imageAsset,
    required this.nextScreen,
  }) : super(key: key);

  final String imageAsset;
  final Widget nextScreen;
  @override
  _HomePageListItemWidgetState createState() => _HomePageListItemWidgetState();
}

class _HomePageListItemWidgetState extends ConsumerState<HomePageListItemWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  )..addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: widget.nextScreen));
          _controller.reverse();
        }
      },
    );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(appThemeProvider);
    final DecorationTween decorationTween = DecorationTween(
      begin: BoxDecoration(
        gradient: themeData.gradientButton,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: themeData.mainColorLighter.withOpacity(0.6),
            offset: const Offset(-1.0, -1.0),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: themeData.mainColorDarker,
            offset: const Offset(4.0, 6.0),
            blurRadius: 3.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: themeData.mainColorDarker.withOpacity(0.9),
            offset: const Offset(3.0, 6.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      end: BoxDecoration(
        gradient: themeData.gradientButton,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    );
    return InkWell(
      onTap: () {
        _controller.forward();
      },
      child: DecoratedBoxTransition(
        decoration: decorationTween.animate(_controller),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(
            widget.imageAsset,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
