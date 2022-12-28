import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/news_states.dart';
import '../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusinessData(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var list =  NewsCubit.get(context).business;
          return ConditionalBuilder(
            condition: list.length > 0,
            builder: (context) =>
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildArticleItem(list[index], context),
                  itemCount: list.length,
                  separatorBuilder: (BuildContext context, int index) => listDivider(),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {

        },
      ),
    );
  }
}
