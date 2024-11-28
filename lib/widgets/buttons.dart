import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

enum AnswerButtonType { right, wrong }

class AnswerButton extends StatefulWidget {
  final AnswerButtonType? buttonType;
  final void Function() onPressed;

  const AnswerButton({super.key, this.buttonType, required this.onPressed});

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
        shape: BoxShape.circle,
        color: (widget.buttonType == AnswerButtonType.right)
            ? Colors.green
            : Colors.red,
      ),
      child: Center(
          child: IconButton(
        iconSize: 50,
        icon: (widget.buttonType == AnswerButtonType.right)
            ? const Icon(Icons.check)
            : const Icon(Icons.close),
        color: Colors.white,
        onPressed: widget.onPressed,
      )),
    );
  }
}
