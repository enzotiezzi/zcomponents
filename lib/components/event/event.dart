abstract class Event {
  final String name;

  Event(this.name);

  Future<void> run();
}