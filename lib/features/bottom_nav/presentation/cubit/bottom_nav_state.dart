part of 'bottom_nav_cubit.dart';

@immutable
abstract class BottomNavState {}

class BottomNavInitial extends BottomNavState {}

class ChangeIndex extends BottomNavState {}

class UpdateState extends BottomNavState {}

class GetUserInfoLoading extends BottomNavState {}

class GetUserInfoSuccess extends BottomNavState {}

class GetUserInfoFailure extends BottomNavState {
  final String errorMessage;
  GetUserInfoFailure({required this.errorMessage});
}
