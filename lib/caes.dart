import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:woocommerce/woocommerce.dart';
import 'dart:io';

import 'homescreen.dart';

String baseUrl = "https://xodoracoes.com.br/";
String consumerKey = "ck_06559837de784fb0fac9fe62cc965a28f4aa553b";
String consumerSecret = "cs_a5e7624a47cfdf395e4332c99293288a02839826";

class Caes extends StatefulWidget {

  @override
  _CaesState createState() => _CaesState();
}

class _CaesState extends State<Caes> {

  List<WooProduct> products = [];
  List<WooProduct> featuredProducts = [];
  WooCommerce wooCommerce = WooCommerce(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
    isDebug: true,
  );

  getProducts() async{
    products = await wooCommerce.getProducts(category: '50', perPage: 100);
    setState(() {
    });
    print(products.toString());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() { 
    super.initState();    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    getProducts();
  } 

  @override
  Widget build(BuildContext context) {    
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return MaterialApp(      
      home: Scaffold(   
        key: _scaffoldKey, 
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: FloatingActionButton(backgroundColor: Colors.white, onPressed: () => _scaffoldKey.currentState.openDrawer(), child: Icon(Icons.menu, color: Color.fromRGBO(233, 102, 72, 1.0), size: 30,),),
        ),
        body: 
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('imagens/bg.png'), fit: BoxFit.cover)),
          child:
          CustomScrollView(
          slivers: 
          <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 30),
                      child: Text('Cães', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                    ),
                  ]
                )
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (itemWidth / 495),
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 1,
                ),

                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final product = products[index];
                        final id = products[index].id;                        
                    return                    
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10)),),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(color: Color.fromRGBO(233, 102, 72, 1.0), borderRadius: BorderRadius.all(Radius.circular(10)),),                          
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 200,
                                    width: 200,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: NetworkImage(product.images[0].src,),
                                          fit: BoxFit.cover),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    //child: Image.network(product.images[0].src, fit: BoxFit.cover,),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(product.name?? 'Loading...', style: TextStyle(color: Colors.white, fontSize: 17), textAlign: TextAlign.center,),
                                  ),
                                  Text('R\$ '+product.price?? '', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: Colors.purple,
                                        child: 
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextButton(onPressed: (){wooCommerce.addToMyCart(itemId: '$id', quantity: '1');}, child: Text('Comprar', style: TextStyle(color: Colors.white, fontSize: 20), textAlign: TextAlign.center,),),
                                        )
                                      ),
                                    ),
                                  )
                                ],
                                ),
                              ),
                            ),
                          ),
                        );
                  },
                  childCount: products.length,
                ),
              )
            ],
          ),
        ),
        drawer: 
        ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
          child: Drawer(
          child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate( 
                [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DrawerHeader(
                      child: Center(
                        child: TextButton(
                          child: Image.asset('imagens/logo.png'),
                          onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                              },
                            ),
                          ),
                        ),
                  ),
                    ]
                  ),
                ),
                SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          color: Color.fromRGBO(233, 102, 72, 1.0), 
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              child: Container(
                                color: Colors.white, 
                                child: Center(
                                  child: Container(
                                    child: FaIcon(FontAwesomeIcons.facebook, size: 40, color: Color.fromRGBO(233, 102, 72, 1.0),)
                                  )
                                )
                              )
                            ),
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          color: Color.fromRGBO(233, 102, 72, 1.0), 
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              child: Container(
                                color: Colors.white, 
                                child: Center(
                                  child: Container(
                                    child: FaIcon(FontAwesomeIcons.instagram, size: 40, color: Color.fromRGBO(233, 102, 72, 1.0),)
                                  )
                                )
                              )
                            ),
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          color: Color.fromRGBO(233, 102, 72, 1.0), 
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              child: Container(
                                color: Colors.white, 
                                child: Center(
                                  child: Container(
                                    child: FaIcon(FontAwesomeIcons.youtube, size: 40, color: Color.fromRGBO(233, 102, 72, 1.0),)
                                  )
                                )
                              )
                            ),
                          )
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          color: Color.fromRGBO(233, 102, 72, 1.0),
                          child: Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.shoppingBag, size: 25, color: Colors.white,),
                                  ),
                                  Text('Faça Seu Pedido', style: TextStyle(color: Colors.white, fontSize: 15),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.angleRight, size: 25, color: Colors.white,),
                                  ),
                                ],
                              )
                            )
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          color: Color.fromRGBO(233, 102, 72, 1.0),
                          child: Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.user, size: 25, color: Colors.white,),
                                  ),
                                  Text('Minha Conta / Acessar', style: TextStyle(color: Colors.white, fontSize: 15),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.angleRight, size: 25, color: Colors.white,),
                                  ),
                                ],
                              )
                            )
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          color: Color.fromRGBO(233, 102, 72, 1.0),
                          child: Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.shoppingCart, size: 25, color: Colors.white,),
                                  ),
                                  Text('Veja Seu Carrinho', style: TextStyle(color: Colors.white, fontSize: 15),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.angleRight, size: 25, color: Colors.white,),
                                  ),
                                ],
                              )
                            )
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: Container(
                          color: Color.fromRGBO(233, 102, 72, 1.0),
                          child: Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.taxi, size: 25, color: Colors.white,),
                                  ),
                                  Text('Peça o Taxi Dog', style: TextStyle(color: Colors.white, fontSize: 15),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FaIcon(FontAwesomeIcons.angleRight, size: 25, color: Colors.white,),
                                  ),
                                ],
                              )
                            )
                          )
                        )
                      ),
                    ),
                  ]
                )
              ),
              SliverSafeArea(
                minimum: EdgeInsets.only(top: 90),
                bottom: false,
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                  [
                    Center(
                        child: Column(
                          children: [
                            Text('Xodó Rações | 1.0.0', style: TextStyle(color: Colors.grey),),
                            Text('Criado por', style: TextStyle(color: Colors.grey),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('imagens/logo-organize.png', width: 110,),
                            ),
                          ],
                        ),
                      ),
                  ]
                ),
                ),               
              )
              ],
            ),
          ),
        ),
        bottomNavigationBar: 
        ConvexAppBar(
          backgroundColor: Colors.white,
          activeColor: Color.fromRGBO(233, 102, 72, 1.0),
          color: Color.fromRGBO(233, 102, 72, 1.0),
          style: TabStyle.fixedCircle,
          curveSize: 100,
          top: -45,
          items: [
            TabItem(icon: IconButton(padding: EdgeInsets.only(bottom: 150), iconSize: 30, icon: Icon(Icons.home), color: Color.fromRGBO(233, 102, 72, 1.0), onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},)),
            TabItem(icon: IconButton(iconSize: 40,icon: Icon(Icons.shopping_cart), color: Colors.white, onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},)),
            TabItem(icon: IconButton(padding: EdgeInsets.only(bottom: 150), iconSize: 30,icon: Icon(Icons.exit_to_app), color: Color.fromRGBO(233, 102, 72, 1.0), onPressed: (){exit(0);},)),
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