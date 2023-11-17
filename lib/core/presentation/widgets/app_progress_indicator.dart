import 'package:chat_client_app/core/presentation/app_colors.dart';
import 'package:chat_client_app/core/presentation/app_ui.dart';
import 'package:flutter/material.dart';

abstract class _ProgressIndicator extends StatelessWidget {
  final double progressSize;
  final Color progressColor;
  final double progressWidth;

  const _ProgressIndicator(
      {Key? key,
      required this.progressSize,
      required this.progressColor,
      required this.progressWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: progressSize,
      width: progressSize,
      child: CircularProgressIndicator(
        color: progressColor,
        strokeWidth: progressWidth,
      ),
    );
  }
}

class AppProgressIndicator extends _ProgressIndicator {
  final Color? color;
  const AppProgressIndicator({super.key, this.color})
      : super(
          progressSize: AppUI.progressIndicatorSize,
          progressColor:color ?? AppColors.appColor,
          progressWidth: 3.0,
        );
}

class ButtonProgressIndicator extends _ProgressIndicator {
  const ButtonProgressIndicator({super.key})
      : super(
          progressSize: AppUI.progressIndicatorSizeSmall,
          progressColor: Colors.white,
          progressWidth: 2.0,
        );
}

class TextFieldProgressIndicator extends _ProgressIndicator {
  const TextFieldProgressIndicator({super.key})
      : super(
          progressSize: AppUI.progressIndicatorSizeSmall,
          progressColor: AppColors.appColor,
          progressWidth: 2.0,
        );
}
