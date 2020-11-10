import 'package:z_components/components/event/event.dart';

import 'i-event-manager.dart';

class EventManager implements IEventManager{
  final List<Event> events;

  EventManager({this.events});

  @override
  void runEvent(String eventName, {Map<String, dynamic> payload}) {
    if (events != null) {
      var event = events.firstWhere((element) => element.name == eventName);

      if (event != null) event.run(payload: payload);
    }
  }
}
