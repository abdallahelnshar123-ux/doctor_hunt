import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repo/user_repo.dart';
import 'choose_role_event.dart';
import 'choose_role_state.dart';

@injectable
class ChooseRoleBloc extends Bloc<ChooseRoleEvent, ChooseRoleState> {
  final UserRepo _userRepo;

  ChooseRoleBloc(this._userRepo) : super(ChooseRoleInitial()) {
    on<UpdateUserRoleRequested>(_onUpdateUserRoleRequested);
  }

  Future<void> _onUpdateUserRoleRequested(
    UpdateUserRoleRequested event,
    Emitter<ChooseRoleState> emit,
  ) async {
    emit(UpdateUserRoleLoading());

    final result = await _userRepo.updateDatabaseUser(user: event.user);

    result.fold(
      (failure) => emit(UpdateUserRoleError(failure.message)),
      (_) => emit(UpdateUserRoleSuccess()),
    );
  }
}
