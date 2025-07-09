import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/routes/routes.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/features/message/presentation/view/message_view.dart';
import 'package:optikick/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:optikick/features/notifications/presentation/view/widgets/notification_tile.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NotificationsCubit>(context).loadNotifications();
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationsRefresh) {
          BlocProvider.of<NotificationsCubit>(context).loadNotifications();
        }
      },
      builder: (context, state) {
        if (state is NotificationsLoading) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 4, 21, 10),
                  Color(0xff5D6E68),
                ],
                stops: [0.0, 0.9],
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 97, 103, 87),
              ),
            ),
          );
        }

        if (state is NotificationsFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        if (state is NotificationsSuccess) {
          final tiles = <Widget>[];

          // Reactions
          for (var n in state.reactions) {
            tiles.add(
              NotificationTile(
                leadingIcon: Icons.account_circle,
                title: n.title,
                subtitle: n.body,
                handle: '${n.senderName} ${n.senderUsername}',
                isNotRead: n.readAt == null,
                onTap: () {
                  BlocProvider.of<NotificationsCubit>(context)
                      .notificationMarkAsRead(notificationID: n.id);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MessageView(),
                    ),
                  );
                },
              ),
            );
          }
          for (var n in state.assessments) {
            tiles.add(
              NotificationTile(
                leadingIcon: Symbols.stethoscope,
                title: n.title,
                subtitle: n.body,
                handle: '${n.senderName} ${n.senderUsername}',
                isNotRead: n.readAt == null,
                onTap: () {
                  if (CacheHelper.getData(key: ApiKey.role) ==
                      ApiKey.coachRole) {
                    BlocProvider.of<NotificationsCubit>(context)
                        .notificationMarkAsRead(notificationID: n.id);
                  } else {
                    BlocProvider.of<NotificationsCubit>(context)
                        .notificationMarkAsRead(notificationID: n.id);

                    if (CacheHelper.getData(key: ApiKey.role) ==
                        ApiKey.playerRole) {
                      Navigator.pushNamed(
                          context, RoutesName.submitNewAssesmentRequest);
                    } // as PLayerView;
                    else {
                      Navigator.pushNamed(
                          context,
                          RoutesName
                              .viewAllAssessmentRequests); // as a DoctorView
                    }
                  }
                },
              ),
            );
          }

          // Training programs
          for (var n in state.trainingPrograms) {
            tiles.add(
              NotificationTile(
                leadingIcon: Icons.assignment_outlined,
                title: n.title,
                subtitle: n.body,
                handle: '${n.senderName} ${n.senderUsername}',
                isNotRead: n.readAt == null,
                onTap: () {
                  BlocProvider.of<NotificationsCubit>(context)
                      .notificationMarkAsRead(notificationID: n.id);

                  CacheHelper.getData(key: ApiKey.isPlayer)
                      ? Navigator.pushNamed(context, RoutesName.playerView)
                      : Navigator.pushNamed(
                          context, RoutesName.trainingProgram);
                },
              ),
            );
          }

          return Container(
            height: 1.sh,
            width: 1.sw,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff102418),
                  Color.fromARGB(255, 40, 59, 52),
                  Color(0xff566761),
                ],
                stops: [0.0, 0.5, 0.9],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                itemCount: tiles.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                  thickness: 1,
                  indent: 16.w,
                  endIndent: 16.w,
                ),
                itemBuilder: (context, index) {
                  return tiles[index];
                },
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
