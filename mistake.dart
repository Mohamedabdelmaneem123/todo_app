
import 'package:application/shared/Bloc/Appstates.dart';
import 'package:application/shared/Bloc/Cubit.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../../moduals/archive_Taskes2/Acrichve_taskes.dart';
import '../../moduals/archive_taskes/Archive_Taskes.dart';
import '../../moduals/done_taskes/done_Taskes.dart';
import '../../shared/componets/constant.dart';

class mistake extends StatelessWidget {
  var scaffoldkay = GlobalKey<ScaffoldState>();
  var formkay = GlobalKey<FormState>();

  var textcontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => Cuebit()..createDatabase(),
        child: BlocConsumer<Cuebit, appstates>(
        listener: (BuildContext context, appstates state) {
      if (state is AppInsertDatabaseState) {

        Navigator.pop(context);
      }
    },
    builder: (BuildContext context, state) {
    Cuebit cubit = Cuebit.get(context);
    return Scaffold(
    key: scaffoldkay,
    appBar: AppBar(
    backgroundColor: Colors.black,
    title: Text(
    cubit.names[cubit.current_index],
    style: const TextStyle(
    color: Colors.yellow,
    fontWeight: FontWeight.bold,
    fontSize: 40.0,
    ),
    ),
    ),
    body: ConditionalBuilder(
    condition: state is! AppCreateDatabaseLoadingState,
    builder: (context) => cubit.screens[cubit.current_index],
    fallback: (context) => Center(
    child: CircularProgressIndicator(),
    ),
    ),
    floatingActionButton: FloatingActionButton(
    backgroundColor: Colors.black,
    onPressed: () {
    if (cubit.isbottomshow) {
    if (formkay.currentState?.validate() == true) {
    cubit.insertdatabase(
    title: textcontroller.text,
    time: timecontroller.text,
    date: datecontroller.text,
    );
    }
    } else {
    scaffoldkay.currentState!.showBottomSheet(
    (context) => Container(
    color: Colors.white,
    child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Form(
    key: formkay,
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    TextFormField(
    controller: textcontroller,
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.title),
    labelText: "title task",
    ),
    validator: (String? value) {
    if (value?.isEmpty ?? true) {
    return "must be not empty";
    }
    return null;
    },
    ),
    const SizedBox(
    height: 15,
    ),
    TextFormField(
    controller: timecontroller,
    keyboardType: TextInputType.datetime,
    onTap: () {
    showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    ).then((value) {
    if (value != null) {
    timecontroller.text =
    value.format(context).toString();
    }
    });
    },
    decoration: const InputDecoration(
    border: OutlineInputBorder(),
    prefixIcon:
    Icon(Icons.watch_later_outlined),
    labelText: "task time",
    ),
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return "must be not empty";
        }
        return null;
      },
    ),
      const SizedBox(
        height: 15,
      ),
      TextFormField(
        controller: datecontroller,
        keyboardType: TextInputType.datetime,
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.parse("2025-01-01"),
          ).then((value) {
            if (value != null) {
              datecontroller.text =
                  DateFormat.yMMMd().format(value);
            }
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.calendar_today),
          labelText: "task date",
        ),
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "must be not empty";
          }
          return null;
        },
      ),
    ],
    ),
    ),
    ),
    ),
      elevation: 20.0,
    ).closed.then((value) {

      cubit.changeBottomSheetState(
        isshow:false, icon: Icons.edit );

    });
    cubit.changeBottomSheetState(
        isshow: true, icon: Icons.add);

    }
    },
      child: Icon(
        cubit.fabicon,
        color: Colors.yellow,
      ),
    ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: cubit.current_index,
        onTap: (index) {
          cubit.changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: Colors.yellow,
            ),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline_outlined,
              color: Colors.yellow,
            ),
            label: "Done",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
              color: Colors.yellow,
            ),
            label: "Archive",
          ),
        ],
      ),
    );
    },
        ),
    );
  }
}




