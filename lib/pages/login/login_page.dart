import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../api_response.dart';
import '../carro/home_page.dart';
import 'login_api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();
  final _tPassword = TextEditingController();
  final _focusSenha = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _showProgress = false;
  @override
  void initState() {
    super.initState();
    Future<Usuario> future = Usuario.get();

    future.then((Usuario usuario) {
      if (usuario != null) {
        setState(() {
          _tLogin.text = usuario.login;
        }); //Iniciar desloago mas com o login preenchido

        // push(context, HomePage(), replace: true); //Iniciar logado
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  _body(context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            AppText(
              "Login",
              "Digite o Login",
              controller: _tLogin,
              validator: _validateLogin,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(height: 20),
            AppText(
              "Senha",
              "Digite a Senha",
              controller: _tPassword,
              obscureText: true,
              validator: _validatePassword,
              inputType: TextInputType.number,
              focus: _focusSenha,
            ),
            SizedBox(height: 20),
            AppButton(
              "Login",
              onPressed: _onClickLogin,
              showProgress: _showProgress,
            )
          ],
        ),
      ),
    );
  }

  String _validatePassword(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    return null;
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  _onClickLogin() async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }
    String login = _tLogin.text;
    String password = _tPassword.text;

    setState(() {
      _showProgress = true;
    });
    ApiResponse loginResponse = await LoginApi.login(login, password);

    if (loginResponse.ok) {
      Usuario user = loginResponse.result;
      push(context, HomePage(), replace: true);
    } else {
      alert(context, loginResponse.msg);
    }
    setState(() {
      _showProgress = false;
    });
  }
}
