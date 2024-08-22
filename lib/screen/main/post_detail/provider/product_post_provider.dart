


import 'package:fast_app_base/common/dart/extension/num_duration_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/network/daangn_api.dart';

final productPostProvider = AutoDisposeFutureProviderFamily(<ProductPost, int>(ref, id) async {
  ref.cacheFor(3.minutes);
  return await DaangnApi.getPost(id);
});