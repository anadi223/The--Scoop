import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBlog extends StatefulWidget {

  final String url;

  const WebBlog(this.url);

  @override
  _WebBlogState createState() => _WebBlogState();
}

class _WebBlogState extends State<WebBlog> {
  Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("WebView",style: TextStyle(fontFamily: "VarelaRound",fontWeight: FontWeight.w600,color: Colors.white),),),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}


