import 'package:flutter/material.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:xodoracoes/homescreen.dart';

import 'alerta.dart';

void main() {
  runApp(
  MaterialApp(  
  title: 'Xodó Rações',
  home: Login(),
      )
    );
}

String baseUrl = "https://xodoracoes.com.br/";
String consumerKey = "ck_06559837de784fb0fac9fe62cc965a28f4aa553b";
String consumerSecret = "cs_a5e7624a47cfdf395e4332c99293288a02839826";

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{ 
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    isDebug: true,
  );
  final username = TextEditingController();
  final password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: 
        Container(
          color: Color.fromRGBO(233, 102, 72, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(child: _body(context),),
          ),
        ),
      ),
    );
    
  }


  _body(BuildContext context) {
  return Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 40, left: 25, right: 25),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset('imagens/logo.png', width: 100,),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Faça o Login', style: TextStyle(color: Colors.white, fontSize: 25), textAlign: TextAlign.center,),
          ),
          textFormFieldLogin(),
          textFormFieldSenha(),
          containerButton(context),
        ],
      ),
    )
  );
}

textFormFieldLogin() {
  return Padding(
    padding: const EdgeInsets.only(top: 55),
    child: TextFormField(
      controller: username,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration( 
        labelText: "Login",
        labelStyle: TextStyle(color: Colors.white),
        hintText: "Informe o login"
      )
    ),
  );
}

textFormFieldSenha() {
  return TextFormField( 
    controller: password,
    obscureText: true,
    keyboardType: TextInputType.text,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration( 
      labelText: "Senha",
      labelStyle: TextStyle(color: Colors.white),
      hintText: "Informe a senha"
    )
  );
}

containerButton(BuildContext context) {
  return Container(
    height: 35.0,
    width: 90.0,
    margin: EdgeInsets.only(top: 10.0, right: 55, left: 55),
    child: 
    TextButton(
      child: 
          Text("Acessar  ", style: TextStyle(color: Colors.white, fontSize: 17.0)),
      onPressed: () {_onClickLogin(context);},
    ),
  );
}

  _onClickLogin(BuildContext context) async {
    final login = username.text;
    final senha = password.text;
    print("Login: $login , Senha: $senha" );      

    if( login.isEmpty || senha.isEmpty ){
      alert2(context, "Preencha os Dados");
     }
     else {
       final token = wooCommerce.authenticateViaJWT(username: login, password: senha);
       final customer = wooCommerce.loginCustomer(username: login, password: senha);
       bool isLoggedIn = await wooCommerce.isCustomerLoggedIn();
       if(token != null) {
         navegaHomeSimp(context);
       }
       else{
         alert(context, 'Tente Novamente');
       }
      /*final token = wooCommerce.authenticateViaJWT(username: username, password: password);
      final customer = wooCommerce.loginCustomer(username: username, password: password);
       if( token != null ) { 
            navegaHomeSimp(context);
       }
       else {
        alert(context, 'Tente Novamente');
       } */   
     }
  }

  navegaHomeSimp(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()),);
  }
}