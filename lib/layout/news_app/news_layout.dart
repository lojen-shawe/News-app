import 'package:first_flutter/layout/news_app/cubit/states.dart';
import 'package:first_flutter/modules/news_app/search/search_screen.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:first_flutter/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class NewsLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<NewsCubit,NewsStates>(
     listener: (context,state){},
      builder: (context,state){
        NewsCubit cubit = NewsCubit.get(context);
       return Scaffold(
         appBar: AppBar(
           title: Text(
             'News App',
           ),
           actions: [
             IconButton(
                 onPressed: (){
                   navigateTo(context,SearchScreen());
                 },
                 icon: Icon(Icons.search),
             ),
             IconButton(
                 onPressed: (){
                   AppCubit.get(context).changeMode();
                 },
                 icon: Icon(Icons.brightness_4_outlined),
             ),
           ],
         ),
         bottomNavigationBar: BottomNavigationBar(
           items: cubit.bottomItems,
           currentIndex: cubit.currentIndex,
           onTap:(index)=> cubit.changeNavBarBottom(index),
         ),
         body: cubit.screens[cubit.currentIndex],
       );
      },
    );
  }
}
