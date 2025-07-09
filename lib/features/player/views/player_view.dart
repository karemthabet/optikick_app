import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:optikick/core/api/api_consumer.dart';
import 'package:optikick/core/keys/end_ponits.dart';
import 'package:optikick/core/models/player_training_program_model.dart';
import 'package:optikick/core/services/cache_helper.dart';
import 'package:optikick/core/utils/colors.dart';
import 'package:optikick/features/player/widgets/player_item.dart';

class PlayerView extends StatefulWidget {
  final ApiConsumer api;
  final int? playerId;
  final String? playerName;

  const PlayerView({
    super.key,
    required this.api,
    this.playerId,
    this.playerName,
  });

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late Future<TrainingProgram?> trainingProgramFuture;

  @override
  void initState() {
    super.initState();
    trainingProgramFuture = fetchTrainingProgram(widget.api);
  }

  Future<TrainingProgram?> fetchTrainingProgram(ApiConsumer api) async {
    try {
      if (CacheHelper.getData(key: ApiKey.isPlayer)) {
        final response = await api.get(EndPoint.playerTrainingProgram);
        final programJson = response['data']['program'];
        return TrainingProgram.fromJson(programJson);
      } else {
        final endpoint = CacheHelper.getData(key: ApiKey.isDoctor)
            ? 'doctor/players/${widget.playerId}/program'
            : 'coach/players/${widget.playerId}/program';
        final response = await api.get(endpoint);
        final programJson = response['data']['program'];
        return programJson != null
            ? TrainingProgram.fromJson(programJson)
            : null;
      }
    } catch (e) {
      throw Exception('Failed to load training program: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPlayer = CacheHelper.getData(key: ApiKey.isPlayer);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff102418),
            Color.fromARGB(255, 40, 59, 52),
            Color(0xff566761),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorsManager.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorsManager.realWhiteColor,
              size: 20.sp,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            isPlayer
                ? 'Training Program'
                : widget.playerName ?? 'Player Program',
            style: TextStyle(
              fontSize: 18.sp,
              color: ColorsManager.realWhiteColor,
            ),
          ),
          actions: [
            if (CacheHelper.getData(key: ApiKey.isDoctor))
              IconButton(
                icon: Icon(
                  Symbols.edit_square_rounded,
                  color: ColorsManager.realWhiteColor,
                  size: 22.sp,
                  opticalSize: 6.sp,
                ),
                onPressed: () {},
              ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<TrainingProgram?>(
          future: trainingProgramFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 97, 103, 87)));
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red, fontSize: 16.sp),
                ),
              );
            }

            final program = snapshot.data;

            if (program == null) {
              return Center(
                child: Text(
                  'No training program assigned yet.',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ColorsManager.realWhiteColor,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  PlayerItem(title: 'Focus: ${program.focusArea}'),
                  SizedBox(height: 22.h),
                  ...program.exercises.map((e) {
                    final parts = e.split(":");
                    final title = parts.first.trim();
                    final details = parts.length > 1
                        ? parts.sublist(1).join(":").trim()
                        : null;

                    return Column(
                      children: [
                        PlayerItem(title: title, toDo: details),
                        SizedBox(height: 22.h),
                      ],
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
