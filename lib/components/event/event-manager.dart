import 'package:z_components/components/event/event.dart';

class EventManager {
  final List<Event> events;

  EventManager({this.events});

  void runEvent(String eventName) {
    if (events != null) {
      var event = events.firstWhere((element) => element.name == eventName);

      if (event != null) event.run();
    }
  }
}
