import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/fab/w_floating_daangn_button.dart';
import 'package:fast_app_base/screen/main/fab/w_floating_daangn_reverpod.dart';
import 'package:fast_app_base/screen/main/tab/home/w_product_post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widget/w_line.dart';
import '../../../../entity/dummies.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  String title = '플러터동';
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener((){
      final floatingState = ref.read(floatingButtonStateProvider);

      if(scrollController.position.pixels > 100 && !floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(true);
      } else if (scrollController.position.pixels < 100 && floatingState.isSmall) {
        ref.read(floatingButtonStateProvider.notifier).changeButtonSize(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          AppBar(
            title: PopupMenuButton<String>(
              onSelected: (value) {
                setState(() {
                  title = value;
                });
              },
              onCanceled: () {
                print('onCanceled');
              },
              onOpened: () {
                print('onOpened');
              },
              itemBuilder: (BuildContext context) => ["다트동", "앱동"]
                  .map((e) => PopupMenuItem(
                value: e,
                child: Text(e),
              ))
                  .toList(),
              child: Text(title),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: FloatingDaangnButton.height),
              controller: scrollController,
              itemBuilder: (context, index) => ProductPostItem(postList[index]),
              itemCount: postList.length,
              separatorBuilder: (context, index) => const Line().pSymmetric(h: 15),
            ),
          ),
        ],
      ),
    );
  }

}
