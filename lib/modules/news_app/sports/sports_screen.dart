import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter/layout/news_app/cubit/cubit.dart';
import 'package:first_flutter/layout/news_app/cubit/states.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list =NewsCubit.get(context).sports;
        return ConditionalBuilder(
          condition: state is! NewsGetSportsLoadingState,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index) => buildArticleItem(list[index],context),
            separatorBuilder: (context,index) => myDivider(),
            itemCount: list.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
