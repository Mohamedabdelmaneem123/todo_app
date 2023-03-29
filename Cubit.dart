

import 'dart:ffi';

import 'package:application/shared/Bloc/Appstates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../moduals/archive_Taskes2/Acrichve_taskes.dart';
import '../../moduals/archive_taskes/Archive_Taskes.dart';
import '../../moduals/done_taskes/done_Taskes.dart';
import '../componets/constant.dart';

class Cuebit extends Cubit<appstates>{
  Cuebit(): super(initialstate());

  static Cuebit get(context) => BlocProvider.of(context);
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Map> tasks =[];

  int current_index =0;


  List<Widget> screens =
  [
    NewtaskesScreen(),
    Done(),
    ArchivedTasksScreen(),

  ];
  List<String> names =
  [
    "New task",
    "done task",
    "archive task"

  ];
  void changeIndex(int index){
    current_index = index;
    emit(appchange());
  }
  bool isbottomshow =false;
  IconData fabicon = Icons.edit;
  void changeBottomSheetState({
  required bool isshow,
  required IconData icon

}){

    fabicon = icon;
    isbottomshow = isshow;
    emit(AchangebottomSheetState());
  }

  Future<String> getName() async  {
    return "maimed abdomen";
  }
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database database, int version) {
        database
            .execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (Database database) {
        getdatabaseFromdatabase(database);
        print('opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }
  insertdatabase({
    required String title,
    required String date,
    required String time,

  }) async {
    database.transaction((txn)
    {
      txn.rawInsert( 'INSERT INTO Tasks(title, date, time,status) VALUES("$title", "$date","$time","new")').then((value){
        print(' insert successfully table');
        emit(AppInsertDatabaseState());
        getdatabaseFromdatabase(database);

      }).catchError((error){
        print('when insert occurs error ${error.toString()}');
      });
      return null;
    });

  }
  void getdatabaseFromdatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppCreateDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      emit(getDate());
      print(tasks);
    });

  }
  void updateData({required String status, required int id}) async {
    database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?', ['$status', id]).then((value) {
      getdatabaseFromdatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData({required int id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getdatabaseFromdatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

}