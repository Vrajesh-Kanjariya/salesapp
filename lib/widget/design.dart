import 'package:flutter/material.dart';
import 'package:salesapp/utils/app_colors.dart';

class DesignWidget extends StatelessWidget {
  const DesignWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            top: 50,
            bottom: -100,
            left: -200,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.blue[900]!.withOpacity(0.2),
                    blurRadius: 50,
                    spreadRadius: 2,
                    offset: const Offset(20, 0)),
                const BoxShadow(
                    color: Colors.white12,
                    blurRadius: 0,
                    spreadRadius: -2,
                    offset: Offset(0, 0)),
              ], shape: BoxShape.circle, color: Colors.white30),
            ),
          ),
          Positioned.fill(
            top: -100,
            bottom: 50,
            left: -300,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.blue[900]!.withOpacity(0.2),
                    blurRadius: 50,
                    spreadRadius: 2,
                    offset: const Offset(20, 0)),
                const BoxShadow(
                    color: Colors.white12,
                    blurRadius: 0,
                    spreadRadius: -2,
                    offset: Offset(0, 0)),
              ], shape: BoxShape.circle, color: Colors.white30),
            ),
          ),
        ],
      ),
    );
  }
}
