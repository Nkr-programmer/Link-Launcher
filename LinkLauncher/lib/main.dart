import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UrlLauncher',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _launced;
  String phoneNumber;
  String _launchurl='https://console.firebase.google.com/';
 Future<void> launchinBrowser(String url) async{
   if(await canLaunch(url))
   {await 
   launch(url,forceSafariVC: false,
   forceWebView: false,
   headers: <String,String>{'header_key':'header_value'},);}
   else{
     throw'could not resolve $url';
   }
 }
 Future<void> launchinApp(String url) async{
   if(await canLaunch(url))
   {await 
   launch(url,forceSafariVC: true,
   forceWebView: true,
   headers: <String,String>{'header_key':'header_value'},);}
   else{
     throw'could not resolve $url';
   }
 }
 Future<void> launchuniversal(String url)async{
if(await canLaunch(url)){
  final bool nativeApp =await launch(url,forceSafariVC: false,universalLinksOnly: true );
  if(!nativeApp){
    launch(url,forceSafariVC: true,);
  }
}

}
  Future<void> phoneCall(String url)async{
if(await canLaunch(url))
await launch(url);
   else{
     throw'could not resolve $url';
   }
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Link Launcher"),
      ),
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            RaisedButton(child:  const Text('Google'),
            onPressed: (){
              setState(() {
                _launced=launchinBrowser(_launchurl);
              });
              
            },
            ),
         RaisedButton(child:  const Text('Google in app'),
            onPressed: (){
              setState(() {
                _launced=launchinApp(_launchurl);

              });
            Timer(const Duration(seconds:55),(){closeWebView();});  
            },
            ),   RaisedButton(child:  const Text('launch in app'),
            onPressed: (){
              setState(() {
         _launced=   launchuniversal('https://youtube.com');
              });
            },
            ),
            SizedBox(height: 20.0,),
FutureBuilder(
           future: _launced,
builder: (BuildContext context,AsyncSnapshot<void> snapshot){
  if(snapshot.hasError)
  {
    return Text('Error:${snapshot.error}');
  }
  else{return Text('launched'  );}
}
         ),

        
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: (){
              setState(() {
         _launced=   phoneCall('tel:919818573493');
              });
            },  
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
