import 'package:bloc/bloc.dart';
import 'package:first_flutter/shared/cubit/states.dart';
import 'package:first_flutter/shared/network/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles =
  [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
void changeIndex(index)
{
  currentIndex = index;
  emit(AppChangeBottomNavBarState());
}

  Database? database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];
  void createDatabase()  {
     openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT, date TEXT,time TEXT ,status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('error is : ${error.toString()}');
          });
          print('created database success');
          emit(AppCreateDataBaseState());
        }, onOpen: (database)
         {
           getFromDatabase(database);

          print('opened database success');
        }).then((value) {
          database=value;
          emit(AppCreateDataBaseState());
     });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
     database?.transaction((txn)
    async {
      int id1 = await txn.rawInsert(
          'INSERT INTO tasks (title, date, time, status) VALUES ("$title", "$date", "$time", "new")');
      print('inserted1: $id1');

    }).then((value) {
      emit(AppInsertDataBaseState());
      getFromDatabase(database);
      print('heeeerrrr $newTasks');
    });
  }
   void getFromDatabase(database) {
    doneTasks=[];
    archiveTasks=[];
    newTasks=[];
    emit(AppDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value)
    {
      value.forEach((element)
      {
        if(element['status']=='new') newTasks.add(element);
        if(element['status']=='done') doneTasks.add(element);
        if(element['status']=='archive') archiveTasks.add(element);
      });
      emit(AppGetDataBaseState());
    });
  }
  void updateDatabase({
  required String status,
  required int id,
}){
    database?.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]
    ).then((value) {
      getFromDatabase(database);
          emit(AppUpdateDataBaseState());
    });
  }

  void deleteDatabase({
    required int id,
  }){
    database?.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id]
    ).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDataBaseState());
    });
  }
  bool isBottomSheetShown=false;
  IconData iconsheet=Icons.edit;
  void changeBottomSheetState({
    required bool isShow,
    required IconData icon
})
  {
    isBottomSheetShown=isShow;
    iconsheet=icon;
    emit(AppChangeBottomSheetState());
  }
  bool isDark = false;
  void changeMode({bool? fromCash}){
    if(fromCash!=null)
      {
        isDark = fromCash;
        emit(AppChangeModeState());
      }
    else{
      isDark=!isDark;
      CashHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
    
  }
}