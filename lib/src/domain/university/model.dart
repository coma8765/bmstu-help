import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
class Subject with _$Subject {
  const factory Subject({
    required String id,
    required String title,
  }) = _Subject;
}

@freezed
class Content with _$Content {
  const factory Content({
    required String id,
    required String subjectId,
    required String title,
    required String fileName,
    required String fileUrl,
    required String? description,
  }) = _Content;
}
