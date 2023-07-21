import 'package:ifinapp/common/common.dart';
import 'package:ifinapp/ui/ui.dart';
import 'package:flutter/material.dart';

class FailScreen extends StatelessWidget {
  const FailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: Colors.red.withOpacity(0.8),
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Icon(
                    Icons.error_outline,
                    size: 140,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'Gagal',
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
                    'Maaf! kamu telah gagal dalam menyelesaikan level ini, kamu bisa mencoba kembali',
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
                  text: 'Coba Lagi',
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
