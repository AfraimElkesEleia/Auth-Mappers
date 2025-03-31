import 'package:auth_mappers/constants/colors.dart';
import 'package:flutter/material.dart';

class PhoneNumberField extends StatelessWidget {
  final GlobalKey<FormState> _phoneKey = GlobalKey();
  late String phoneNumber;
  PhoneNumberField({super.key});
  String _generateFlagCountery() {
    String counteryCode = 'eg';
    String flag = counteryCode.toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: MyColors.lightGrey),
            ),
            child: Text(
              '${_generateFlagCountery()}+20',
              style: TextStyle(fontSize: 18, letterSpacing: 2),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: MyColors.lightGrey),
            ),
            child: TextFormField(
              key: _phoneKey,
              autofocus: true,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(border: InputBorder.none),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter yout phone number!';
                } else if (value.length < 11) {
                  return 'Too short for a phone number!';
                }
                return null;
              },
              onSaved: (value) {
                phoneNumber = value!;
              },
            ),
          ),
        ),
      ],
    );
  }
}
