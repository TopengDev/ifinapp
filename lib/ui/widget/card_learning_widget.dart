import 'package:ifinapp/common/common.dart';
import 'package:flutter/material.dart';

class CardLearningWidget extends StatelessWidget {
  final String title;
  final String description;

  const CardLearningWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        // set min height
        minHeight: MediaQuery.of(context).size.width - 48,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 64,
              right: 8,
              child: Image.asset(
                AssetPath.illustrationProfile,
                height: 160,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
