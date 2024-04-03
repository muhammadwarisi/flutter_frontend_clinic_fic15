part of 'logout_bloc.dart';

@freezed
class LogoutState with _$LogoutState {
  const factory LogoutState.initial() = _Initial;
  const factory LogoutState.loading() = _loading;
  const factory LogoutState.success() = _success;
  const factory LogoutState.error(String message) = _error;
}
