import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/simple_bloc.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

class LoginBloc {
  final buttonBloc = SimpleBloc<bool>(); //Caso de composição

  Future<ApiResponse<Usuario>> login(login, password) async {
    buttonBloc.add(true);
    ApiResponse loginResponse = await LoginApi.login(login, password);
    buttonBloc.add(false);
    return loginResponse;
  }

  void dispose() {
    buttonBloc.dispose();
  }
}
