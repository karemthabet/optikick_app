part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> reactions;
  final List<NotificationModel> assessments;
  final List<NotificationModel> trainingPrograms;

  NotificationsSuccess({
    required this.reactions,
    required this.assessments,
    required this.trainingPrograms,
  });
}

class NotificationsFailure extends NotificationsState {
  final String error;

  NotificationsFailure({required this.error});
}

class NotificationsRefresh extends NotificationsState {
  NotificationsRefresh();
}
