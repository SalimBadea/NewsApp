import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/news_states.dart';
import '../../shared/components/components.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var list =  NewsCubit.get(context).science;
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
    );
  }
}


