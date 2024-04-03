// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:clinic_ari/data/datasource/auth_remote_datasource.dart';
import 'package:clinic_ari/data/datasource/models/response/auth_response_model.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource _authRemoteDatasource;
  LoginBloc(
    this._authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Login>((event, emit) async{
      emit(const _loading());
      final result = await _authRemoteDatasource.login(event.email, event.password);
      result.fold(
        (l) => (_error(l)),
         (r) => (_success(r))
         );
    });
  }
}
