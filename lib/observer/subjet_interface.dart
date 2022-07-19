import 'observer_interface.dart';

abstract class ISubject {
  void attach(IObserver observer);
  void detatch(IObserver observer);
  void notify();
}
