import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final double width;
  // final Widget? title;
  final ValueChanged<T> onChanged;

  const MyRadioListTile(
      {required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.leading,
      required this.width,
      // this.title,
      });

  @override
  Widget build(BuildContext context) {
    // final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 30,
        // padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            // SizedBox(width: 12),
            // if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final bool isSelected = value == groupValue;
    return Container(
      width: this.width,
      // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : null,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.blue! : Colors.grey[600]!,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          leading,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
