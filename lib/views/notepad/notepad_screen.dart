import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

import '../../main.dart';
import '../../providers/notepad_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/notepad/notepad_widget.dart';
import '../../widgets/rounded_add_button_widget.dart';
import 'notepad_details_screen.dart';

class NotepadScreen extends ConsumerStatefulWidget {
  const NotepadScreen({Key? key}) : super(key: key);

  @override
  _NotepadScreenState createState() => _NotepadScreenState();
}

class _NotepadScreenState extends ConsumerState<NotepadScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    ref.refresh(getAllNotesProvider);
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final notes = ref.watch(getAllNotesProvider);
    return BaseScreenWidget(
      mainColor: theme.mainColor,
      screenTitle: "notepad.title".tr(),
      body: Stack(
        children: [
          notes.when(
              data: (notes) {
                if (notes != null) {
                  return MasonryGridView.builder(
                    padding: const EdgeInsets.only(
                      bottom: 24.0,
                      top: 12.0,
                      left: 24.0,
                      right: 24.0,
                    ),
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: notes.length,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          NotepadWidget(
                            note: notes[index],
                            theme: theme,
                          ),
                          index == notes.length - 1
                              ? const SizedBox(
                                  height: 80,
                                )
                              : Container(),
                        ],
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
              error: (err, s) => Center(
                    child: Container(
                      child: Text("Wystąpił bład"),
                    ),
                  ),
              loading: () {
                return Container();
              }),
          Positioned(
            bottom: 24.0 + MediaQuery.of(context).padding.bottom,
            right: 24.0,
            child: SizedBox(
              width: 60,
              height: 60,
              child: RoundedAddButtonWidget(
                theme: theme,
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(
                        milliseconds: 350,
                      ),
                      child: NotepadDetailsScreen(theme: theme),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
