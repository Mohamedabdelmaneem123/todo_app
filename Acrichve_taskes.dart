import 'package:application/shared/Bloc/Cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Bloc/Appstates.dart';
import '../../shared/componets/compontes.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cuebit, appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = Cuebit.get(context).archivedTasks;

        return tasksBuilder(tasks);
      },
    );
  }
}
