import 'package:freezed_annotation/freezed_annotation.dart';

part 'vo_user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String nickname,
    required String profileUrl,
    required double temperature,
  }) = _User;
}