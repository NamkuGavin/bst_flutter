import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  // final Widget? title;
  final ValueChanged<T> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    // this.title,
  });

  @override
  Widget build(BuildContext context) {
    // final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        child: Row(
          children: [
            _customRadioButton,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final bool isSelected = value == groupValue;
    return Builder(
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.28,
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF99CB57) : null,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Color(0xFF99CB57) : Colors.grey[600]!,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              leading,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        );
      }
    );
  }
}
