import 'package:auth_mappers/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  //final String phoneNumber;
  const OtpScreen({super.key});
  Widget _buildIntroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify your phone number',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 25),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 6 digits code numbers sent to ',
              style: TextStyle(color: Colors.black, height: 1.4, fontSize: 18),
              children: <TextSpan>[
                TextSpan(
                  text: ' phoneNumber',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return Container(
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        pastedTextStyle: TextStyle(
          color: Colors.green.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        backgroundColor: Colors.white,
        obscureText: false,
        //obscuringCharacter: '*',
        //obscuringWidget: const FlutterLogo(size: 24),
        blinkWhenObscuring: true,
        animationType: AnimationType.scale,
        validator: (v) {
          if (v!.length < 3) {
            return "I'm from validator";
          } else {
            return null;
          }
        },
        cursorColor: Colors.black,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: MyColors.lightBlue,
          activeColor: MyColors.lightBlue,
          inactiveColor: MyColors.lightGrey,
          inactiveFillColor: Colors.white,
          selectedColor: MyColors.blue,
          selectedFillColor: Colors.white,
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        //errorAnimationController: errorController,
        // controller: textEditingController,
        keyboardType: TextInputType.number,
        boxShadows: const [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10,
          ),
        ],
        onCompleted: (code) {
          // otpCode = code;
          debugPrint("Completed");
        },
        // onTap: () {
        //   print("Pressed");
        // },
        // onChanged: (value) {
        //   debugPrint(value);
        //   setState(() {
        //     currentText = value;
        //   });
        // },
        // beforeTextPaste: (text) {
        //   debugPrint("Allowing to paste $text");
        //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
        //   return true;
        // },
      ),
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(
          'Verify',
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
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 88),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntroText(),
              SizedBox(height: 88),
              _buildPinCodeFields(context),
              SizedBox(height: 60),
              _buildVerifyButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
