import 'package:application/shared/componets/compontes.dart';
import 'package:application/shared/componets/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Bloc/Appstates.dart';
import '../../shared/Bloc/Cubit.dart';

class NewtaskesScreen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cuebit, appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = Cuebit.get(context).newTasks;

        return tasksBuilder(tasks);
      },
    );


  }
}
