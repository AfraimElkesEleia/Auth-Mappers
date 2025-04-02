import 'package:auth_mappers/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:auth_mappers/constants/colors.dart';
import 'package:auth_mappers/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeScreen extends StatelessWidget {
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  late String phoneNumber = '';
  HomeScreen({super.key});
  Widget _buildIntroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What is your phone number?',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            'Please enter yout phone number to verify your account.',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ],
    );
  }

  String _generateFlagCountery() {
    String counteryCode = 'eg';
    String flag = counteryCode.toUpperCase().replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
    );
    return flag;
  }

  Widget _buildPhoneNumber() {
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
              autofocus: true,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(border: InputBorder.none),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter yout phone number!';
                } else if (value.length < 11) {
                  return 'Too short for a phone number!';
                }
                phoneNumber = value;
                return null;
              },
              onSaved: (value) {
                phoneNumber = value ?? '';
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberSubmittedBloc() {
    // I dont need bloc builder here i will navigate from screen to another only
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (ctx, state) {
        if (state is Loading) {
          _showProgressIndicator(ctx);
        } else if (state is PhoneNumberSubmitted) {
          Navigator.pop(ctx);
          Navigator.of(ctx).pushNamed(otpScreen, arguments: phoneNumber);
        } else if (state is ErrorOccured) {
          Navigator.pop(ctx);
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  void _showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (context) => alertDialog,
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
    );
  }

  Future<void> _register(BuildContext context) async {
    if (!_phoneKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      _phoneKey.currentState!.save();
      BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber);
    }
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {
          if (_phoneKey.currentState!.validate()) {
            _register(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          'Next',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _phoneKey,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 88, horizontal: 24),
            child: Column(
              children: [
                _buildIntroText(),
                SizedBox(height: 110),
                _buildPhoneNumber(),
                SizedBox(height: 70),
                _buildNextButton(context),
                _buildPhoneNumberSubmittedBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
