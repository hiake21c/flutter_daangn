import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalLifeFragment extends ConsumerStatefulWidget {
  const LocalLifeFragment({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<LocalLifeFragment> createState() => _LocalLifeFragmentState();
}

class _LocalLifeFragmentState extends ConsumerState<LocalLifeFragment> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 200,
          color: Colors.orange,
        ),
        Container(
          height: 200,
          color: Colors.yellow,
        ),
        Container(
          height: 200,
          color: Colors.blue,
        ),
      ],
    );
  }
}
