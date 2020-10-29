import 'dart:convert';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;
import '../api_response.dart';

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}",
    };

    var response =
        await http.get("httpsxx://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo", headers: headers);

    List mapResponse = json.decode(response.body);
    List<Carro> carros = mapResponse.map<Carro>((e) => Carro.fromJson(e)).toList();
    return carros;
  }
}
