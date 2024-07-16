import 'package:flutter/material.dart';

class PositionAppBar extends StatelessWidget {
  const PositionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Positioned(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      onTap: ()=> Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
