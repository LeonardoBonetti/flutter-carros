import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:mobx/mobx.dart';

part 'carros_model.g.dart'; // flutter packages pub run  build_runner build -> to generate model

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {
  @observable
  List<Carro> carros;

  @observable
  var error;

  @action
  fetch(String tipoCarro) async {
    error = null;

    try {
      carros = await CarrosApi.getCarros(tipoCarro);
    } catch (e) {
      print("erro");
      error = e;
      print('errooooo -> ${error}');
    }
  }
}
