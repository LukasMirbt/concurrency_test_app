import 'package:equatable/equatable.dart';

sealed class DoorEvent extends Equatable {
  const DoorEvent(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

class DoorLockPressed extends DoorEvent {
  const DoorLockPressed(super.id);
}

final class DoorUnlockPressed extends DoorEvent {
  const DoorUnlockPressed(super.id);
}
