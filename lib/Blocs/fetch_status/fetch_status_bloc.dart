import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:status_saver_bloc/Utilities/global_constants.dart';

import '../../Services/Providers/status_provider.dart';

part 'fetch_status_event.dart';
part 'fetch_status_state.dart';

class FetchStatusBloc extends Bloc<FetchStatusEvent, FetchStatusState> {
  FetchStatusBloc() : super(FetchStatusInitial()) {
    on<FetchStatusImages>((event, emit) async {
      try {
        emit(FetchStatusLoading());
        final response =
            await StatusProviders().fetchStatus(ext: '.jpg', path: STATUS_PATH);
        emit(FetchStatusSuccess(statuses: response));
      } catch (e) {
        emit(FetchStatusFailure(message: e.toString()));
      }
    });

    on<FetchStatusVideos>((event, emit) async {
      try {
        emit(FetchStatusLoading());
        final response =
            await StatusProviders().fetchStatus(ext: '.mp4', path: STATUS_PATH);

        emit(FetchStatusSuccess(statuses: response));
      } catch (e) {
        emit(FetchStatusFailure(message: e.toString()));
      }
    });

    on<FetchSavedImages>((event, emit) async {
      try {
        emit(FetchStatusLoading());
        final response =
            await StatusProviders().fetchStatus(ext: '.jpg', path: SAVED_PATH);
        emit(FetchStatusSuccess(statuses: response));
      } catch (e) {
        emit(FetchStatusFailure(message: e.toString()));
      }
    });
  }
}
