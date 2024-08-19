import 'package:fast_app_base/entity/post/vo_simple_product_post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../entity/dummies.dart';

final postProvider = StateProvider<List<SimpleProductPost>>((ref)=>postList);