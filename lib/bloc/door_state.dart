import 'package:equatable/equatable.dart';

enum LockStatus {
  unknown,
  lockInProgress,
  locked,
  unlockInProgress,
  unlocked;
}

class DoorState extends Equatable {
  const DoorState({
    required this.doors,
  });

  final Map<String, LockStatus> doors;

  DoorState copyWith({
    Map<String, LockStatus>? doors,
  }) {
    return DoorState(
      doors: doors ?? this.doors,
    );
  }

  @override
  List<Object> get props => [doors];
}
