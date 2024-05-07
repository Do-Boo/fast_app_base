import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback onTop;

  const BigButton(this.text, {super.key, required this.onTop});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Html(
        data: text,
        style: {
          "*": Style(
            color: Vx.gray800,
            fontSize: FontSize(16),
            fontWeight: FontWeight.w600,
          ),
        },
      ),
    );
  }
}
