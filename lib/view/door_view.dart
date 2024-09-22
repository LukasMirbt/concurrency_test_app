import 'package:concurrency_test_app/bloc/door_bloc.dart';
import 'package:concurrency_test_app/bloc/door_event.dart';
import 'package:concurrency_test_app/bloc/door_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoorView extends StatelessWidget {
  const DoorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LockFirstButton(),
              SizedBox(height: 16),
              _UnlockFirstButton(),
              SizedBox(height: 16),
              _LockSecondButton(),
              SizedBox(height: 16),
              _UnlockSecondButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LockFirstButton extends StatelessWidget {
  const _LockFirstButton();

  @override
  Widget build(BuildContext context) {
    final isLockInProgress = context.select(
      (DoorBloc bloc) => bloc.state.doors['first'] == LockStatus.lockInProgress,
    );

    return FilledButton.icon(
      onPressed: isLockInProgress
          ? null
          : () {
              context.read<DoorBloc>().add(
                    const DoorLockPressed('first'),
                  );
            },
      icon: isLockInProgress ? const _Spinner() : const Icon(Icons.lock),
      label: const Text('Lock first door'),
    );
  }
}

class _UnlockFirstButton extends StatelessWidget {
  const _UnlockFirstButton();

  @override
  Widget build(BuildContext context) {
    final isUnlockInProgress = context.select(
      (DoorBloc bloc) =>
          bloc.state.doors['first'] == LockStatus.unlockInProgress,
    );

    return FilledButton.icon(
      onPressed: isUnlockInProgress
          ? null
          : () {
              context.read<DoorBloc>().add(
                    const DoorUnlockPressed('first'),
                  );
            },
      icon: isUnlockInProgress ? const _Spinner() : const Icon(Icons.lock_open),
      label: const Text('Unlock first door'),
    );
  }
}

class _LockSecondButton extends StatelessWidget {
  const _LockSecondButton();

  @override
  Widget build(BuildContext context) {
    final isLockInProgress = context.select(
      (DoorBloc bloc) =>
          bloc.state.doors['second'] == LockStatus.lockInProgress,
    );

    return FilledButton.icon(
      onPressed: isLockInProgress
          ? null
          : () {
              context.read<DoorBloc>().add(
                    const DoorLockPressed('second'),
                  );
            },
      icon: isLockInProgress ? const _Spinner() : const Icon(Icons.lock),
      label: const Text('Lock second door'),
    );
  }
}

class _UnlockSecondButton extends StatelessWidget {
  const _UnlockSecondButton();

  @override
  Widget build(BuildContext context) {
    final isUnlockInProgress = context.select(
      (DoorBloc bloc) =>
          bloc.state.doors['second'] == LockStatus.unlockInProgress,
    );

    return FilledButton.icon(
      onPressed: isUnlockInProgress
          ? null
          : () {
              context.read<DoorBloc>().add(
                    const DoorUnlockPressed('second'),
                  );
            },
      icon: isUnlockInProgress ? const _Spinner() : const Icon(Icons.lock_open),
      label: const Text('Unlock second door'),
    );
  }
}

class _Spinner extends StatelessWidget {
  const _Spinner();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 18,
      height: 18,
      child: CircularProgressIndicator(),
    );
  }
}
