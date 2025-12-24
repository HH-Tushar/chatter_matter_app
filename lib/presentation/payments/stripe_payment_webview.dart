import 'package:chatter_matter_app/application/user/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';



class StripePaymentWebView extends StatefulWidget {
  final String url;
  final void Function()? onSuccess;

  const StripePaymentWebView({super.key, required this.url, this.onSuccess});

  @override
  State<StripePaymentWebView> createState() => _StripePaymentWebViewState();
}

class _StripePaymentWebViewState extends State<StripePaymentWebView> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool hasShownError = false; // Prevent duplicate error messages
  bool? isSuccess;

  // Use the actual URL from your backend/Stripe success redirect
  // final String successUrlPattern = 'http://localhost:300/cancel';

  // Professional SnackBar helper methods
  void _showSuccessSnackBar() {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Successful!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Your subscription has been activated',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showCancelledSnackBar() {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.info_outline, color: Colors.white, size: 20),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Cancelled',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'You can try again anytime',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // void _showErrorSnackBar(String message) {
  //   // Reset error flag when showing error
  //   hasShownError = true;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Row(
  //         children: [
  //           Icon(Icons.error_outline, color: Colors.white, size: 20),
  //           SizedBox(width: 12),
  //           Expanded(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Payment Error',
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 16,
  //                     fontFamily: 'Outfit',
  //                     fontWeight: FontWeight.w600,
  //                   ),
  //                 ),
  //                 Text(
  //                   message,
  //                   style: TextStyle(
  //                     color: Colors.white.withOpacity(0.9),
  //                     fontSize: 14,
  //                     fontFamily: 'Outfit',
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //       backgroundColor: Colors.red,
  //       duration: const Duration(seconds: 4),
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //       action: SnackBarAction(
  //         label: 'Retry',
  //         textColor: Colors.white,
  //         onPressed: () {
  //           hasShownError = false; // Reset flag when retrying
  //           _controller.reload();
  //         },
  //       ),
  //     ),
  //   );
  // }



  void _showConnectionErrorSnackBar(String message) {
    if (!context.mounted) return;
    if (!hasShownError) {
      hasShownError = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.white, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Connection Error',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Unable to connect to payment gateway. Please check your internet connection.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          action: SnackBarAction(
            label: 'Retry',
            textColor: Colors.white,
            onPressed: () {
              hasShownError = false;
              _controller.reload();
            },
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Set a timeout for initial loading
    Future.delayed(Duration(seconds: 30), () {
      if (isLoading && mounted) {
        setState(() {
          isLoading = false;
        });
        if (!hasShownError) {
          _showConnectionErrorSnackBar('Page load timeout');
        }
      }
    });

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar if needed
          },
          onPageStarted: (String url) async {
          

            print('WebView page started loading: $url'); // Debugging
            if (mounted) {
              setState(() {
                isLoading = true;
                hasShownError = false; // Reset error flag on new page load
              });
            }
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');

            if (!mounted) return;

            try {
              // SUCCESS
              if (url.contains('/success')) {
                await Provider.of<UserBloc>(
                  context,
                  listen: false,
                ).fetchProfile();
                print("in secess");
                isSuccess = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showSuccessSnackBar();
                  widget.onSuccess?.call();
                  Navigator.of(context).pop(true);
                });
                return;
              }

              // CANCEL
              if (url.contains('/cancel')) {
                isSuccess = false;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showCancelledSnackBar();
                  Navigator.of(context).pop(false);
                });
                return;
              }
            } catch (e) {
              print("unable to redirect");
            }

            setState(() {
              isLoading = false;
            });
          },

          onWebResourceError: (WebResourceError error) {
            print('WebView error: ${error.description}'); // Debugging

            // Ignore minor resource loading errors and Stripe's internal redirects
            if (error.description.contains('favicon') ||
                error.description.contains('analytics') ||
                error.description.contains('tracking') ||
                error.description.contains('stripe.com/analytics')) {
              return;
            }

            // Only show error for significant connection issues
            if (!hasShownError &&
                (error.description.contains('net::ERR_CONNECTION_REFUSED') ||
                    error.description.contains('net::ERR_TIMED_OUT') ||
                    error.description.contains('net::ERR_NETWORK') ||
                    error.description.contains('ERR_CONNECTION'))) {
              if (isSuccess == null) {
                _showConnectionErrorSnackBar(error.description);
              }
            }
          },
          // onNavigationRequest: (NavigationRequest request) {
          //   print('WebView navigation request: ${request.url}'); // Debugging
          //   if (request.url.contains('/success')) {
          //     print('Payment Successful: Navigating to settings screen');
          //     _showSuccessSnackBar();
          //     if (widget.onSuccess != null) widget.onSuccess!();
          //     // Navigate to settings screen and remove all previous routes
          //     Navigator.of(
          //       context,
          //     ).pop(true); // Return true to indicate success
          //     return NavigationDecision.prevent;
          //   }
          //   // Check for cancel patterns
          //   if (request.url.contains('cancel') ||
          //       request.url.contains('payment_cancel') ||
          //       request.url.contains('checkout/cancel')) {
          //     print('Payment Cancelled');
          //     _showCancelledSnackBar();
          //     Navigator.of(
          //       context,
          //     ).pop(false); // Return false to indicate cancellation
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF263133),
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.payment, color: const Color(0xFF8BF0E6), size: 24),
            SizedBox(width: 12),
            Text(
              'Secure Payment',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2D393A),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white, size: 24),
          onPressed: () {
            // Don't show cancellation message if user just closes without starting payment
            if (!isLoading) {
              _showCancelledSnackBar();
            }
            Navigator.of(context).pop(false);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white, size: 24),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              Container(
                color: const Color(0xFF263133),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8BF0E6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(0xFF8BF0E6),
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Loading Payment Gateway...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please wait while we connect securely',
                        style: TextStyle(
                          color: const Color(0xFFA0A0A6),
                          fontSize: 14,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
