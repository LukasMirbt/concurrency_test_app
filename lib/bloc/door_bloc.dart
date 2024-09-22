import 'dart:async';

import 'package:concurrency_test_app/bloc/door_event.dart';
import 'package:concurrency_test_app/bloc/door_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<E> droppablePerId<E extends DoorEvent>() {
  return (events, mapper) {
    final processingIds = <dynamic>{};

    return events.flatMap((event) {
      final id = event.id;

      if (processingIds.contains(id)) {
        // Drop the event.
        return Stream<E>.empty();
      } else {
        processingIds.add(id);

        void remove() {
          processingIds.remove(id);
        }

        return mapper(event)
            .doOnDone(remove)
            .doOnError((_, __) => remove())
            .doOnCancel(remove);
      }
    });
  };
}

class DoorBloc extends Bloc<DoorEvent, DoorState> {
  DoorBloc()
      : super(
          const DoorState(
            doors: {
              'first': LockStatus.unknown,
              'second': LockStatus.unknown,
            },
          ),
        ) {
    on<DoorEvent>(
      (event, emit) => switch (event) {
        DoorLockPressed() => _onLockPressed(event, emit),
        DoorUnlockPressed() => _onUnlockPressed(event, emit),
      },
      transformer: droppablePerId(),
    );
  }

  Future<void> _onLockPressed(
    DoorLockPressed event,
    Emitter<DoorState> emit,
  ) async {
    emit(
      state.copyWith(
        doors: {
          ...state.doors,
          event.id: LockStatus.lockInProgress,
        },
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    emit(
      state.copyWith(
        doors: {
          ...state.doors,
          event.id: LockStatus.locked,
        },
      ),
    );
  }

  Future<void> _onUnlockPressed(
    DoorUnlockPressed event,
    Emitter<DoorState> emit,
  ) async {
    emit(
      state.copyWith(
        doors: {
          ...state.doors,
          event.id: LockStatus.unlockInProgress,
        },
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    emit(
      state.copyWith(
        doors: {
          ...state.doors,
          event.id: LockStatus.unlocked,
        },
      ),
    );
  }
}
