abstract class RandomEvent {}

class RandomLoadedStarted extends RandomEvent {}

class RandomTypeSelected extends RandomEvent {
  final int? typeId;

  RandomTypeSelected({this.typeId});
}

class RandomFetchFood extends RandomEvent {
  final int? typeId;

  RandomFetchFood({this.typeId});
}
