import 'package:portal_ckc/api/controller/call_api.dart';
import 'package:portal_ckc/bloc/data/bloc_data.dart';
import 'package:portal_ckc/bloc/data/bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocImplement extends Bloc<BlocEvent, Data> {
  BlocImplement() : super(LoadingData()) {
    on<FetchData>(_onFetchData);
    on<RefreshData>(_onRefreshData);
  }

  Future<void> _onFetchData(FetchData event, Emitter<Data> emit) async {
    try {
      final comment = await CallApi.postServices.getComments();
      emit(LoadedData(comment));
    } catch (e) {
      emit(ErroData(e.toString()));
    }
  }

  Future<void> _onRefreshData(RefreshData event, Emitter<Data> emit) async {
    try {
      final comment = await CallApi.postServices.getComments();
      emit(LoadedData(comment));
    } catch (e) {
      emit(ErroData(e.toString()));
    }
  }
}
