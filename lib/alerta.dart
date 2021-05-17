import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

clearUsr() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}

alert(BuildContext context, String msg){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title:
        Center(
          child: 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Oops...", style: TextStyle(color: Colors.red[700], fontSize:25), textAlign: TextAlign.center,),
              ),
            ],
          )
        ),
        content: Text(msg, textAlign: TextAlign.center,),
        actions: <Widget>[
          TextButton(onPressed: () {Navigator.pop(context);}, child: Text('Tentar Novamente'))
        ]
      );
    }
  );
}

alert2(BuildContext context, String msg){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title:
        Center(
          child: 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Oops...", style: TextStyle(color: Colors.blue[900], fontSize:25), textAlign: TextAlign.center,),
              ),
            ],
          )
        ),
        content: Text(msg, textAlign: TextAlign.center,),
        actions: <Widget>[
          TextButton(onPressed: () {Navigator.pop(context);}, child: Text('Tentar Novamente'))
        ]
      );
    }
  );
}

alert3(BuildContext context, String msg){
  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title:
        Center(
          child: 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Bloqueado...", style: TextStyle(color: Colors.red[900], fontSize:25), textAlign: TextAlign.center,),
              ),
            ],
          )
        ),
        content: Text(msg, textAlign: TextAlign.center,),
        actions: <Widget>[
          TextButton(onPressed: () {Navigator.pop(context);}, child: Text('Tentar Novamente'))
        ]
      );
    }
  );
}