import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/network/local/cache_helper.dart';

import '../modules/business/business_screen.dart';
import '../modules/science/science_screen.dart';
import '../modules/sports/sports_screen.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int current_index = 0;

  void changeBottomNavBar(int index) {
    current_index = index;
    emit(AppBottomNavState());
  }
  List<Widget> screens = [BusinessScreen(), SportsScreen(), ScienceScreen()];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_rounded), label: "Business"),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_esports_rounded), label: "Sports"),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_rounded), label: "Science"),
  ];

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppModeState());
    }else {
      isDark = !isDark;
      CacheHelper.setBoolean(key: "isDark", value: isDark)
          .then((value) => emit(ChangeAppModeState()));
    }

  }
}
