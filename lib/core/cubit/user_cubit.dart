import 'dart:async';

import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<BaseState<UserModel>> {
  final UserService userService;

  UserCubit({
    required this.userService,
  }) : super(const InitializedState());

  StreamSubscription<UserModel>? streamSubscription;

  void init({required UserModel user}) {
    emit(LoadedState(data: user));

    streamSubscription = userService.watchUser(userId: user.id!).listen(
      (data) {
        emit(LoadedState(data: data));
      },
    );
  }

  void update() {
    UserModel user = state.data!;
    int level = user.level ?? 1;
    int segment = user.segment ?? 1;

    if (segment < 2) {
      segment++;
    } else {
      segment = 1;
      level++;
    }

    userService.update(
      user: user.copyWith(
        level: level,
        segment: segment,
      ),
    );
  }

  void reInit() {
    streamSubscription?.cancel();
    emit(const InitializedState());
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
