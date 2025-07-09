part of 'dash_board_cubit.dart';

@immutable
sealed class DashBoardState {}

final class DashBoardInitial extends DashBoardState {}

final class DashLoading extends DashBoardState {}

final class DashSuccesss extends DashBoardState {
  final dynamic dashBoardData;
  DashSuccesss({required this.dashBoardData});
}

final class DashFailure extends DashBoardState {
  final String errMessage;
  DashFailure({required this.errMessage});
}
