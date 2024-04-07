// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:momentum/momentum.dart';

import '../models/user_model.dart';
import '../services/network/user_network.dart';
import '../values/route_value.dart';
import 'loading_controller.dart';

class UserController extends MomentumController<UserModel> {
  @override
  UserModel init() {
    return UserModel(this, user: User());
  }

  void login(BuildContext context, String email, String password) async {
    Momentum.controller<LoadingController>(context).loading();

    var token = await UserNetwork.login(email, password);

    Momentum.controller<LoadingController>(context).noLoading();

    if (token != null) {
      Navigator.pushNamed(
        context,
        RouteValue.routeNameToHome,
      );
      Momentum.controller<UserController>(context)
          .getUserWithToken(token.accessToken);
    } else {
      debugPrint('Error : đăng nhập thất bại');
    }
  }

  void getUserWithToken(String? accessToken) async {
    var user = await UserNetwork.getUserWithSession(accessToken);
    model.update(user: user);
    debugPrint(model.user!.email);
  }
}
