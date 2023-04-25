import 'package:betna/style/custom_text.dart';
import 'package:betna/style/style.dart';
import 'package:flutter/material.dart';
import 'package:betna/generated/l10n.dart';

class NoteExchangeRate extends StatefulWidget {
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final double textSize;
  const NoteExchangeRate({super.key, required this.edgeInsetsGeometry, required this.textSize});

  @override
  State<StatefulWidget> createState() => _NoteExchangeRate();
}

class _NoteExchangeRate extends State<NoteExchangeRate> {
  double h = 70;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: widget.edgeInsetsGeometry,

      color: Colors.white70,
    height: h,
    duration: const Duration(milliseconds: 750),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: () {
          setState(() {
            h = 0;
          });
        },style: ButtonStyles.style, child: CustomText(text:S.of(context).kClose,color: Colors.white,size: 10,),),
        const SizedBox(width: 6,),
        Expanded(child: CustomText(text: S.of(context).kNoteExchangeRate,size: widget.textSize,textAlign: TextAlign.justify,height: 1.2,),)
      ],
    ),
    );
  }
}
