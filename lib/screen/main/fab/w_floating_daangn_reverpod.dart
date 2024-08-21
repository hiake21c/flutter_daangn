import 'package:fast_app_base/screen/main/fab/w_floating_daangn_button.state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final floatingButtonStateProvider =
    StateNotifierProvider<FloatingButtonStateNotifier, FloatingButtonState>(
        (ref) => FloatingButtonStateNotifier(
            FloatingButtonState(false, false, false),
        ));

class FloatingButtonStateNotifier extends StateNotifier<FloatingButtonState> {
  FloatingButtonStateNotifier(super.state);

  bool needToMakeButtonBigger = false;

  void changeButtonSize(bool isSmall) {
    if(state.isExpanded) {
      return;
    }
    state = state.copyWith(isSmall: isSmall);
  }

  void toggleMenu() {
    final isExpanded = state.isExpanded;
    final isSmall = state.isSmall;

    state = state.copyWith(isExpanded: !state.isExpanded, isSmall: needToMakeButtonBigger ? false : true);

    if (needToMakeButtonBigger) {
      needToMakeButtonBigger = false;
    }

    if (!isSmall && !isExpanded) {
      needToMakeButtonBigger = true;
    }
  }

  void hideButton() {
    state = state.copyWith(isHided: true);
  }

  void showButton() {
    state = state.copyWith(isHided: false);
  }

}