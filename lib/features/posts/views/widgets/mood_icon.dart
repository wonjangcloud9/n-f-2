import 'package:flutter/material.dart';

class MoodIcon extends StatefulWidget {
  final VoidCallback onTap;
  final String icon;
  final bool selected;

  const MoodIcon({
    super.key,
    required this.onTap,
    required this.icon,
    required this.selected,
  });

  @override
  State<MoodIcon> createState() => _MoodIconState();
}

class _MoodIconState extends State<MoodIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: widget.selected ? 1 : 0.5,
        child: Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                widget.selected ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Text(
            widget.icon,
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
