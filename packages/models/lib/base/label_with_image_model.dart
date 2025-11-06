import 'package:freezed_annotation/freezed_annotation.dart';

part 'label_with_image_model.freezed.dart';
part 'label_with_image_model.g.dart';

@freezed
abstract class LabelWithImage with _$LabelWithImage {
  const LabelWithImage._();
  const factory LabelWithImage({
    required String id,
    required String label,
    required String image,
  }) = _LabelWithImage;

  // Add an empty constructor
  factory LabelWithImage.empty() => const LabelWithImage(
        id: '',
        label: '',
        image: '',
      );
  bool get isEmpty => this == LabelWithImage.empty();
  bool get isNotEmpty => !isEmpty;

  factory LabelWithImage.fromJson(Map<String, dynamic> json) =>
      _$LabelWithImageFromJson(json);
}
