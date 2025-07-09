import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:optikick/core/api/api_consumer.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/models/admin_dash_model.dart';
import 'package:optikick/core/models/player_dash_model.dart';
import 'package:optikick/core/services/cache_helper.dart';

part 'dash_board_state.dart';

class DashBoardCubit extends Cubit<DashBoardState> {
  DashBoardCubit({required this.api}) : super(DashBoardInitial());
  ApiConsumer api;

  DashboardPlayerMetrics? playerMetrics;
  AdminStatusOverview? adminOverview;

  getPlayerDashboard() async {
    emit(DashLoading());
    try {
      final response = await api.get(EndPoint.playerDash);
      playerMetrics = DashboardPlayerMetrics.fromJson(response);
      emit(DashSuccesss(dashBoardData: playerMetrics!));
    } catch (e) {
      emit(DashFailure(errMessage: e.toString()));
    }
  }

  getAdminDashboard() async {
    emit(DashLoading());
    try {
      final response = await api.get(CacheHelper.getData(key: ApiKey.isDoctor)
          ? EndPoint.doctorDash
          : EndPoint.coachDash);
      adminOverview = AdminStatusOverview.fromJson(response);
      emit(DashSuccesss(dashBoardData: adminOverview!));
    } catch (e) {
      emit(DashFailure(errMessage: e.toString()));
    }
  }
} //? cubit
