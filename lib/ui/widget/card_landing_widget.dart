import 'package:ifinapp/common/common.dart';
import 'package:flutter/material.dart';

class CardLandingWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Function() onTap;

  const CardLandingWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 30,
              right: 22,
              bottom: 20,
              child: Image.asset(
                image,
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 48) * 0.6,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
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
