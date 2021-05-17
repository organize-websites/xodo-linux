import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'homescreen.dart';
import 'politica.dart';

class SobreOApp extends StatefulWidget {

  @override
  _SobreOAppState createState() => _SobreOAppState();
}

class _SobreOAppState extends State<SobreOApp> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      home: Scaffold(   
        key: _scaffoldKey, 
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: FloatingActionButton(backgroundColor: Colors.white, onPressed: () => _scaffoldKey.currentState.openDrawer(), child: Icon(Icons.menu, color: Color.fromRGBO(0, 103, 174, 1.0),),),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset('imagens/logo.png'),
            ),
            Center(
              child:
              Text('Xodó Rações | v1.0.0')
            ),
          ],
        ),
        drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: TextButton(
                  child: Image.asset('imagens/logo.png'),
                  onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('HOME'),
              onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('LIGUE PRA GENTE'),
              onTap: _launchURL4,
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.whatsapp),
              title: Text('WHATSAPP'),
              onTap: _launchURL,
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.facebook),
              title: Text('FACEBOOK'),
              onTap: _launchURL2,
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.facebook),
              title: Text('FACEBOOK TV'),
              onTap: _launchURL6,
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.facebook),
              title: Text('FACEBOOK DIOCESE'),
              onTap: _launchURL7,
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.instagram),
              title: Text('INSTAGRAM'),
              onTap: _launchURL3,
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.globe),
              title: Text('SITE'),
              onTap: _launchURL5,
            ),
            ListTile(
              leading: Icon(Icons.copyright),
              title: Text('SOBRE O APP'),
              onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SobreOApp()));
                      },
            ),
            ListTile(
              leading: Icon(Icons.public),
              title: Text('POLÍTICA DE PRIVACIDADE'),
              onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PoliticaDePrivacidade()));
                      },
            ),
          ],
        ),
      ),
      bottomNavigationBar: 
        ConvexAppBar(
          backgroundColor: Colors.white,
          activeColor: Color.fromRGBO(0, 103, 174, 1.0),
          color: Color.fromRGBO(0, 103, 174, 1.0),
          style: TabStyle.fixedCircle,
          curveSize: 100,
          top: -45,
          items: [
            TabItem(icon: IconButton(padding: EdgeInsets.only(bottom: 150), iconSize: 30, icon: Icon(Icons.home), color: Color.fromRGBO(0, 103, 174, 1.0), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},)),
            TabItem(icon: IconButton(iconSize: 40,icon: Icon(Icons.shopping_cart), color: Colors.white, onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},)),
            TabItem(icon: IconButton(padding: EdgeInsets.only(bottom: 150), iconSize: 30,icon: Icon(Icons.exit_to_app), color: Color.fromRGBO(0, 103, 174, 1.0), onPressed: (){exit(0);},)),
          ]
        )
      ),
    );
  }
}



_launchURL() async {
  const url = 'http://wa.me/554836265177&text=';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL2() async {
  const url = 'fb://page/183031758450675/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL3() async {
  const url = 'instagram://user?username=radiotuba';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL4() async {
  const url = 'tel:+554836264633';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL5() async {
  const url = 'http://www.radiotuba.com.br/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL6() async {
  const url = 'fb://page/1750122901888972/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL7() async {
  const url = 'fb://page/319935404782164/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}