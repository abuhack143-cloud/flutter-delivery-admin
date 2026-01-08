import 'package:admin/core/constant/color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropDown extends StatelessWidget {
  final String value;
  final void Function(String?)? onChanged;
  const CustomDropDown({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        hint: Text(
          'not_accepted'.tr,
          style: const TextStyle(color: Colors.grey),
        ),
        items: [
          {'key': '1', 'value': 'not_accepted'.tr},
          {'key': '2', 'value': 'accepted'.tr},
        ]
            .map((item) => DropdownMenuItem<String>(
                  value: item['key'],
                  child: Text(item['value']!),
                ))
            .toList(),
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Appcolor.primary,
              width: 1,
            ),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey.shade900
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
