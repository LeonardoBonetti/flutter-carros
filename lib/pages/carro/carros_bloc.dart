import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/simple_bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  fetch(String tipoCarro) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipoCarro);
      add(carros);
    } catch (e) {
      addError(e);
    }
  }
}
