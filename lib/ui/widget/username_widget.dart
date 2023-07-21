import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsernameWidget extends StatelessWidget {
  const UsernameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, BaseState<UserModel>>(
      builder: (context, state) {
        final UserModel user = state.data!;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetPath.icProfile,
              height: 22,
              width: 22,
            ),
            const SizedBox(width: 4),
            Text(user.username ?? '-'),
          ],
        );
      },
    );
  }
}
