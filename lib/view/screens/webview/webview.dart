import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hotel_services_app/common/tabbutton.dart';

class LoadWebView extends StatefulWidget {
  final String url;
  const LoadWebView({required this.url, Key? key}) : super(key: key);

  @override
  LoadWebViewState createState() => LoadWebViewState();
}

class LoadWebViewState extends State<LoadWebView> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  CookieManager cookieManager = CookieManager.instance();
  bool isLoading = false;
  String url = '';

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
        useOnDownloadStart: true,
        javaScriptEnabled: true,
        cacheEnabled: true,
        supportZoom: false,
        verticalScrollBarEnabled: false,
        horizontalScrollBarEnabled: false,
        transparentBackground: true,
      ),
      android: AndroidInAppWebViewOptions(
          useHybridComposition: true,
          thirdPartyCookiesEnabled: true,
          allowFileAccess: true,
          useShouldInterceptRequest: true),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (await webViewController!.canGoBack()) {
            webViewController!.goBack();
          } else {
            Navigator.pop(context);
          }
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: CustomBackButton(
              onTap: () async {
                if (await webViewController!.canGoBack()) {
                  webViewController!.goBack();
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    webViewController!.reload();
                  }),
              IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
          body: Column(
            children: [
              Visibility(
                  visible: isLoading,
                  child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor))),
              webview(),
            ],
          ),
        ));
  }

  webview() {
    return Expanded(
        child: InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(url: WebUri(widget.url)),
      //  Uri.parse(widget.url)),
      initialOptions: options,
      onWebViewCreated: (controller) async {
        webViewController = controller;
      },
      onLoadStart: (controller, url) {
        setState(() {
          isLoading = true;
          this.url = url.toString();
        });
      },
      onLoadStop: (con, url) async {
        setState(() {
          isLoading = false;
        });
      },
      onEnterFullscreen: (controller) {
        enterFullScreen();
      },
      onExitFullscreen: (controller) {
        exitFullScreen(context);
      },
      shouldInterceptFetchRequest: (controller, fetchRequest) {
        return removeAdsInWebview(controller, fetchRequest);
      },
    ));
  }

  Future<FetchRequest> removeAdsInWebview(
      InAppWebViewController controller, FetchRequest fetchRequest) async {
    return fetchRequest;
  }
}

enterFullScreen() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

exitFullScreen(BuildContext context) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
