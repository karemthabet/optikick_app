import 'package:bloc/bloc.dart';
import 'package:optikick/core/error/api_exceptions.dart';
import 'package:optikick/features/reaction_time/data/repos/player_metric_repo.dart';

import '../../data/repos/player_metric_repo_impl.dart';
import 'metric_cubit_state.dart';

class MetricCubit extends Cubit<MetricCubitState> {
  MetricCubit() : super(MetricCubitInitial());
  final PlayerMetricRepo _playerMetricRepo = PlayerMetricRepoImpl();
  Future<void> getPlayerMetric({
    required String mericType,
    String? period,
  }) async {
    emit(MetricCubitLoading());
    try {
      final playerMetric = await _playerMetricRepo.getPlayerMetric(
        mericType: mericType,
        period: period,
      );
      emit(MetricCubitLoaded(graphDataModel: playerMetric));
    } on ApiException catch (e) {
      emit(MetricCubitError(errorMessage: e.errModel.message.toString()));
    } catch (e) {
      emit(MetricCubitError(errorMessage: e.toString()));
    }
  }
}
