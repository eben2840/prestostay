import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'Navpage.dart';


class AnotherPage extends StatefulWidget {
  AnotherPage({Key? key}) : super(key: key);

  @override
  _AnotherPageState createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {

  late WebViewController controller;
  double progress = 0.0; 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return true;
        } 
      },
      
      child: Scaffold(
        
        appBar: AppBar(
  leading: IconButton(
    onPressed: () async {
      if (await controller.canGoBack()) {
        controller.goBack();
      }
    },
    icon: Icon(Icons.arrow_back),
  ),
  backgroundColor: Color.fromARGB(255, 18, 6, 151),
  title: Text("Find A Hostel"),
  actions: [], 
),

        
        body: Container(
          color: Colors.white,
          // padding: EdgeInsets.only(top: 10.0),
          child: WebView(
            initialUrl: "https://stay.prestoghana.com/find",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
               controller = webViewController;
            },

            
            onPageFinished: (url) {
               controller.evaluateJavascript(
                "document.getElementsByTagName('nav')[0].style.display='none';");
             controller.evaluateJavascript(
                "document.getElementsByTagName('hr')[0].style.display='none';");
             
            },
            onProgress: (progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
          ),
        ),
      ),
      );  
  }
}