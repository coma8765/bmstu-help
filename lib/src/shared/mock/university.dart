import 'package:bmstu_help/src/domain/domain.dart';
import 'package:bmstu_help/src/shared/mock/consts.dart';
import 'package:bmstu_help/src/shared/mock/faker.dart';

class SubjectFactory extends ModelFactory<Subject> {
  @override
  Subject generateFake() {
    return Subject(
      id: createFakeUUID(),
      title: faker.animal.name(),
    );
  }

  @override
  List<Subject> generateFakeList({required int length}) {
    return List.generate(length, (int index) => generateFake());
  }
}

class ContentFactory extends ModelFactory<Content> {
  @override
  Content generateFake({String? subjectId}) {
    return Content(
      id: createFakeUUID(),
      subjectId: subjectId ?? createFakeUUID(),
      title: faker.lorem.word(),
      fileName: createFakeFileName(),
      fileUrl: faker.image.image(random: true),
      description: faker.lorem.sentence(),
    );
  }

  String createFakeFileName() {
    final extension = FakerConsts.extensions[faker.randomGenerator
        .numbers(
          FakerConsts.extensions.length,
          1,
        )
        .first];

    return '${faker.lorem.word()}$extension';
  }

  @override
  List<Content> generateFakeList({required int length, String? subjectId}) {
    return List.generate(
      length,
      (int index) => generateFake(subjectId: subjectId),
    );
  }
}
