import 'package:flutter/material.dart';
import 'package:produce_pos/core/constants/app_images.dart';
import 'package:produce_pos/modules/auth/components/intro_page_body_area.dart';

class IntroLoginPage extends StatelessWidget {
  const IntroLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              fit: BoxFit.cover, // Adjusts the image to cover the entire box
              AppImages.introBackground11,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12.withOpacity(0.1),
                    Colors.black12,
                    Colors.black54,
                    Colors.black54,
                  ],
                ),
              ),
            ),
          ),
          const IntroPageBodyArea(),
        ],
      ),
    );
  }
}
