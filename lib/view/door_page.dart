import 'package:concurrency_test_app/bloc/door_bloc.dart';
import 'package:concurrency_test_app/view/door_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoorPage extends StatelessWidget {
  const DoorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DoorBloc(),
      child: const DoorView(),
    );
  }
}
