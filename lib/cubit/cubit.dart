import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/app_states.dart';
import 'package:news_app/cubit/news_states.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import '../modules/business/business_screen.dart';
import '../modules/science/science_screen.dart';
import '../modules/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', queries: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'b52095abe4854ffca559010f54286740',
    }).then((value) {
      business = value.data['articles'] ?? [] as List;
      print('Title >>  ${business[0]['title']}');
      print('List >>  ${value.data['totalResults']}');
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('error ${error.toString()}');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSportsData() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', queries: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'b52095abe4854ffca559010f54286740',
      }).then((value) {
        sports = value.data['articles'] ?? [] as List;
        print('Title >>  ${sports[0]['title']}');
        print('List >>  ${value.data['totalResults']}');
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print('error ${error.toString()}');
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScienceData() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', queries: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'b52095abe4854ffca559010f54286740',
      }).then((value) {
        science = value.data['articles'] ?? [] as List;
        print('Title >>  ${science[0]['title']}');
        print('List >>  ${value.data['totalResults']}');
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print('error ${error.toString()}');
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearchData(String query) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', queries: {
      'q': '$query',
      'apiKey': 'b52095abe4854ffca559010f54286740',
    }).then((value) {
      search = value.data['articles'] ?? [] as List;
      print('Title >>  ${search[0]['title']}');
      print('List >>  ${value.data['totalResults']}');
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print('error ${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}

