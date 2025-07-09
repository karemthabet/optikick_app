import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:optikick/core/api/api_consumer.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/models/notification_model.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final ApiConsumer api;

  List<NotificationModel> reactions = [];
  List<NotificationModel> assessments = [];
  List<NotificationModel> trainingPrograms = [];

  NotificationsCubit({required this.api}) : super(NotificationsInitial());

  Future<void> loadNotifications() async {
    emit(NotificationsLoading());

    // Clear old lists
    reactions = [];
    assessments = [];
    trainingPrograms = [];

    try {
      final response = await api.get(EndPoint.notification);

      if (response == null || response is! List) {
        emit(NotificationsFailure(error: 'Invalid response format from API'));
        return;
      }

      final List<dynamic> data = response;

      final notifications =
          data.map((json) => NotificationModel.fromJson(json)).toList();

      for (var n in notifications) {
        switch (n.type) {
          case 'reaction':
            reactions.add(n);
            break;
          case 'assessment':
            assessments.add(n);
            break;
          case 'training_program':
            trainingPrograms.add(n);
            break;
        }
      }

      emit(NotificationsSuccess(
        reactions: reactions,
        assessments: assessments,
        trainingPrograms: trainingPrograms,
      ));
    } catch (e) {
      emit(NotificationsFailure(error: e.toString()));
    }
  }

  void notificationMarkAsRead({required int notificationID}) async {
    try {
      // Call the API to mark as read
      await api.post(EndPoint.notfiMarkAsRead(notificationID));

      // OPTIONAL: Update local list
      _markLocalNotificationAsRead(notificationID);

      // OPTIONAL: Re-emit success state so UI updates
      emit(NotificationsRefresh());
    } catch (e) {
      emit(NotificationsFailure(
          error: 'Failed to mark notification as read: ${e.toString()}'));
    }
  }

  void _markLocalNotificationAsRead(int id) {
    for (var list in [reactions, assessments, trainingPrograms]) {
      for (var n in list) {
        if (n.id == id) {
          n.readAt !=
              DateTime.now()
                  .toIso8601String(); // Or any value to indicate "read"
        }
      }
    }
  }
}
