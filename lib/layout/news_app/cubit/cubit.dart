import 'package:bloc/bloc.dart';
import 'package:first_flutter/layout/news_app/cubit/states.dart';
import 'package:first_flutter/modules/news_app/business/business_screen.dart';
import 'package:first_flutter/modules/news_app/science/science_screen.dart';
import 'package:first_flutter/modules/news_app/sports/sports_screen.dart';
import 'package:first_flutter/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
 int currentIndex =0;
 List <BottomNavigationBarItem> bottomItems=[
   BottomNavigationBarItem(
     label: 'Business',
       icon: Icon(Icons.business),
   ),
   BottomNavigationBarItem(
     label: 'Science',
       icon: Icon(Icons.science),
   ),
   BottomNavigationBarItem(
     label: 'Sports',
       icon: Icon(Icons.sports),
   ),

 ];
 void changeNavBarBottom(index){
   currentIndex=index;
   if(index == 1) getScience();
   if(index == 2) getSports();
   emit(NewsBottomNavState());
 }
 List<Widget> screens =[
   BusinessScreen(),
   ScienceScreen(),
   SportsScreen(),
 ];
 List <dynamic> business=[];
 void getBusiness(){
   emit(NewsGetBusinessLoadingState());
   if(business.length==0)
   {
   DioHelper.getData(
       url: 'v2/top-headlines',
       query: {
         'country':'us',
         'category':'business',
         'apiKey':'6a8902851ea244019a9a82dcd364bf6c',
       }
   ).then((value) {
     emit(NewsGetBusinessSuccessState());
     business = value.data['articles'];
   }).catchError((error){
     emit(NewsGetBusinessErrorState(error));
     print(error.toString());
   });
   }
   else  emit(NewsGetBusinessSuccessState());
 }

 List <dynamic> science=[];
 void getScience(){
   emit(NewsGetScienceLoadingState());
   if(science.length==0){
     DioHelper.getData(
         url: 'v2/top-headlines',
         query: {
           'country':'us',
           'category':'science',
           'apiKey':'6a8902851ea244019a9a82dcd364bf6c',
         }
     ).then((value) {
       emit(NewsGetScienceSuccessState());
       science = value.data['articles'];
     }).catchError((error){
       emit(NewsGetScienceErrorState(error));
       print(error.toString());
     });
   }
   else emit(NewsGetScienceSuccessState());
 }

 List <dynamic> sports=[];
 void getSports(){
   emit(NewsGetSportsLoadingState());
   if(sports.length==0){
     DioHelper.getData(
         url: 'v2/top-headlines',
         query: {
           'country':'us',
           'category':'sports',
           'apiKey':'6a8902851ea244019a9a82dcd364bf6c',
         }
     ).then((value) {
       emit(NewsGetSportsSuccessState());
       sports = value.data['articles'];
     }).catchError((error){
       emit(NewsGetSportsErrorState(error));
       print(error.toString());
     });
   }
   else emit(NewsGetSportsSuccessState());

 }
  List <dynamic> search=[];
  void getSearch(String value){

    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          'apiKey':'6a8902851ea244019a9a82dcd364bf6c',
        }
    ).then((value) {
      emit(NewsGetSearchSuccessState());
      search = value.data['articles'];
    }).catchError((error){
      emit(NewsGetSearchErrorState(error));
      print(error.toString());
    });

  }

}