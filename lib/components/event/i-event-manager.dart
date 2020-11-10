abstract class IEventManager {
  void runEvent(String eventName, {Map<String, dynamic> payload});
}