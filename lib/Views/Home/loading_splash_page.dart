import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:status_saver_bloc/Utilities/image_urls.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
     
     context.go('/home');
    });
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        color: Colors.black,
        child: const Center(
            child: Center(
          child: SizedBox(
            height: 30,
            width: 30,
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 30,
            )
          ),
        )),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
          ImageUrls.logo,
          height: 100,
          width: 100,
        ),
            )),
      ),
    );
  }
}
