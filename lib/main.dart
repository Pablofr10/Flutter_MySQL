import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mysql/pages/powerPage.dart';
import 'package:flutter_mysql/pages/vendedoresPage.dart';
import 'package:http/http.dart' as http;

void main() => runApp(LoginApp());

String nome;

class LoginApp extends StatelessWidget {
  const LoginApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter + Mysql',
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/powerPage': (context) => new PowerPage(),
        '/vendedoresPage': (context) => new VendedoresPage(),
        '/loginPage': (context) => new LoginPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUser = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  String msg = '';

  Future<List> Login() async {
    final response =
        await http.post('http://192.168.15.23/flutter/login.php', body: {
      'username': controllerUser.text,
      'password': controllerPass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = 'Usuário e senha errados';
      });
    } else {
      if (datauser[0]['nivel'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/powerPage');
      } else if (datauser[0]['nivel'] == 'vendas') {
        Navigator.pushReplacementNamed(context, '/vendedoresPage');
      }
      setState(() {
        nome = datauser[0]['nome'];
      });
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/images/digital.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 77.0),
                child: new CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: new Image(
                    width: 135,
                    height: 135,
                    image: new AssetImage('assets/images/avatar7.png'),
                  ),
                ),
                width: 170.0,
                height: 170.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 93),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5),
                          ]),
                      child: TextFormField(
                        controller: controllerUser,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: 'Usuário',
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 50,
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(
                          top: 4, right: 16, left: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        controller: controllerPass,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.vpn_key, color: Colors.black),
                          hintText: 'Senha',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 6,
                          right: 32,
                        ),
                        child: Text('Recuperar a senha',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                    ),
                    Spacer(),
                    new RaisedButton(
                      child: new Text('Entrar'),
                      color: Colors.orangeAccent,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () {
                        Login();
                        Navigator.pop(context);
                      },
                    ),
                    Text(msg,
                      style: TextStyle(color: Colors.red, fontSize: 25.0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
