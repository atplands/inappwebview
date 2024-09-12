import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_cookie_manager/flutter_cookie_manager.dart';

class MyWebsite extends StatefulWidget {
  const MyWebsite({Key? key}) : super(key: key);

  @override
  State<MyWebsite> createState() => _MyWebsiteState();
}

class _MyWebsiteState extends State<MyWebsite> {
  double _progress = 0;
  late InAppWebViewController _webViewController;
  final CookieManager _cookieManager = CookieManager();
  bool _isLoading = false;

  /*
  void _showLoadingIndicator(bool show) {
    setState(() {
      _isLoading = show;
    });
  } 
  */

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirm Exit'),
              content: Text(
                  'Are you sure you want to exit the app? All cookies and cache will be cleared.'),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('Confirm'),
                  onPressed: () async {
                    await _webViewController.clearCache();
                    await _cookieManager.deleteCookies(
                        url: WebUri.uri(
                            Uri.parse("https://itrefaicloud.onrender.com")));
                    Navigator.pop(context);
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
              ],
            );
          },
        );
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.white, // Set status bar color to transparent
          statusBarIconBrightness:
              Brightness.dark, // Set status bar icons to dark
        ),
        child: SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri.uri(
                        Uri.parse("https://itrefaicloud.onrender.com")),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                    _setupJavaScriptHandler(controller);
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;
                    if (uri.scheme == 'whatsapp' ||
                        uri.host == 'wa.me' ||
                        uri.host == 'api.whatsapp.com') {
                      await _launchWhatsApp();
                      return NavigationActionPolicy.CANCEL;
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    await _injectJavaScript(controller);
                  },
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true,
                      mediaPlaybackRequiresUserGesture: false,
                      allowFileAccessFromFileURLs: true,
                      allowUniversalAccessFromFileURLs: true,
                      clearCache: false,
                      useShouldInterceptAjaxRequest: true,
                    ),
                  ),
                  onAjaxReadyStateChange: (controller, ajaxRequest) async {
                    if (ajaxRequest.url.toString().contains("login") &&
                        ajaxRequest.readyState == AjaxRequestReadyState.DONE) {
                      await controller.loadUrl(
                          urlRequest: URLRequest(
                              url: WebUri(
                                  "https://itrefaicloud.onrender.com/")));
                    }
                    return AjaxRequestAction.PROCEED;
                  },
                  onLoadResource: (controller, resource) {
                    print("Resource loaded: ${resource.url}");
                  },
                ),
                _progress < 1.0
                    ? LinearProgressIndicator(value: _progress)
                    : const SizedBox.shrink(),
                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+918341254558',
      text: "Hey! I'm inquiring about the IT information",
    );

    try {
      await launch('$link');
    } catch (e) {
      //print('Error launching WhatsApp: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Couldn't open WhatsApp: $e")),
      );
    }
  }

  void _setupJavaScriptHandler(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
      handlerName: 'handleWhatsAppLink',
      callback: (args) async {
        await _launchWhatsApp();
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'handleFormSubmit',
      callback: (args) async {
        print('Form submitted: ${args[0]}');
        _showLoadingIndicator(true);
        // Process form data here
        await Future.delayed(
            Duration(seconds: 2)); // Simulating processing time
        _showLoadingIndicator(false);
        return {'status': 'success'};
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'handleFileUpload',
      callback: (args) async {
        String fieldName = args[0];
        String base64Data = args[1];
        print('File uploaded for field: $fieldName');
        // Process the file data here
        return {'status': 'success'};
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'onLoginSuccess',
      callback: (args) async {
        await controller.loadUrl(
            urlRequest:
                URLRequest(url: WebUri("https://itrefaicloud.onrender.com/")));
      },
    );
  }

  Future<void> _injectJavaScript(InAppWebViewController controller) async {
    await controller.evaluateJavascript(source: """
      const whatsappLink = document.querySelector('a.whatsapp-link');
      if (whatsappLink) {
        whatsappLink.addEventListener('click', (e) => {
          e.preventDefault();
          console.log('WhatsApp link clicked');
          window.flutter_inappwebview.callHandler('handleWhatsAppLink');
        });
        console.log('WhatsApp link event listener added');
      } else {
        console.log('WhatsApp link not found');
      }

      // Handle file inputs
      const fileInputs = document.querySelectorAll('input[type="file"]');
      fileInputs.forEach(input => {
        input.addEventListener('change', (e) => {
          const file = e.target.files[0];
          const reader = new FileReader();
          reader.onload = function(e) {
            const base64 = e.target.result;
            window.flutter_inappwebview.callHandler('handleFileUpload', input.name, base64);
          };
          reader.readAsDataURL(file);
        });
      });

      // Handle form submissions
      const forms = document.querySelectorAll('form');
      forms.forEach(form => {
        form.addEventListener('submit', (e) => {
          e.preventDefault();
          const formData = new FormData(form);
          const data = Object.fromEntries(formData);
          window.flutter_inappwebview.callHandler('handleFormSubmit', data).then(result => {
            if (result.status === 'success') {
              console.log('Form submitted successfully');
              if (form.id === 'login-form') {
                window.flutter_inappwebview.callHandler('onLoginSuccess');
              }
            }
          });
        });
      });
    """);
  }

  void _showLoadingIndicator(bool show) {
    setState(() {
      _isLoading = show;
    });
  }
}
