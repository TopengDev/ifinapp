import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/ui/ui.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: primaryColor.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset(
                    AssetPath.icSuccess,
                    width: 140,
                  ),
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'Level Selesai',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Center(
                  child: Text(
                    'Selamat! kamu menyelesaikan level ini dengan baik, kamu bisa melanjutkan level berikutnya',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteName.landingScreen,
                      (route) => false,
                    );
                  },
                  text: 'Selesai',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
