import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

abstract class ModelFactory<T> {
  Faker get faker => Faker();

  String createFakeUUID() {
    return const Uuid().v4();
  }

  T generateFake();

  List<T> generateFakeList({required int length});
}
