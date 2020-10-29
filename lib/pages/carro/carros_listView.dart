import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_model.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CarrosListView extends StatefulWidget {
  String tipoCarro;
  CarrosListView(this.tipoCarro);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin<CarrosListView> {
  List<Carro> carros;
  String get tipoCarro => widget.tipoCarro;
  final _model = CarrosModel();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetch();
  }

  void _fetch() {
    _model.fetch(tipoCarro);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(
      builder: (_) {
        List<Carro> carros = _model.carros;

        if (_model.error != null) {
          return TextError("Não foi possível buscar os dados", onPressed: _fetch);
        }
        if (carros == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];
          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      c.urlFoto ??
                          "https://s3-sa-east-1.amazonaws.com/videos.livetouchdev.com.br/classicos/Chevrolet_Corvette.png",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome ?? "",
                    style: TextStyle(fontSize: 25),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    "Descrição...",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarTheme.of(context),
                    child: ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Text('Detalhes'),
                          onPressed: () => _onClickCarro(c),
                        ),
                        FlatButton(
                          child: Text('Share'),
                          onPressed: () {
                            print('pressed');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }
}
