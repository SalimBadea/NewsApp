import 'dart:html';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/app_cubit.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/news_states.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                DefaultTextField(
                  controller: searchController,
                  labelText: 'Search',
                  validate: 'search query',
                  textInputType: TextInputType.text,
                  onChange: (value) {
                    NewsCubit.get(context).getSearchData(value);
                  },
                  prefix: Icons.search,
                ),
                Expanded(child: articleBuilder(list, context, isSearch: true))
              ],
            ),
          );
        });
  }
}
