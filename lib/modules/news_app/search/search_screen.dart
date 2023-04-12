import 'package:conditional_builder/conditional_builder.dart';
import 'package:first_flutter/layout/news_app/cubit/cubit.dart';
import 'package:first_flutter/layout/news_app/cubit/states.dart';
import 'package:first_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        bool isSearch = true;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                    controller: searchController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "can't be empty";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search',
                      prefix: Icon(Icons.search),
                    ),
                  onChanged: (value){
                      NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: state is! NewsGetSearchLoadingState,
                  builder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildArticleItem(list[index], context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount: list.length,
                  ),
                  fallback: (context) =>(isSearch==true)? Container():Center(child: CircularProgressIndicator(),),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
