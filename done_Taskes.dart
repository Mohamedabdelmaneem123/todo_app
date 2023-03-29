import 'package:application/shared/Bloc/Appstates.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Bloc/Cubit.dart';
import '../../shared/componets/compontes.dart';

class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cuebit, appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = Cuebit.get(context).doneTasks;

        return tasksBuilder(tasks);
      },
    );
  }
}
