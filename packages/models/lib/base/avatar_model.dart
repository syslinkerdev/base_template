// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'avatar_model.freezed.dart';
part 'avatar_model.g.dart';

@freezed
abstract class Avatar with _$Avatar {
  const factory Avatar({
    required String id,
    required String image,
  }) = _Avatar;

  // Add an empty constructor
  factory Avatar.empty() => const Avatar(
        id: '',
        image: '',
      );

  static const String avatarsDocId = 'avatars';
  static const String avatarsFieldName = 'in';

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);
}
