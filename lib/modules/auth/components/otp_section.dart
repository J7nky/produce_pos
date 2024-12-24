import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';
import 'package:produce_pos/core/utils/validators.dart';

class OtpSection extends StatelessWidget {
  const OtpSection({
    super.key,
    required this.phoneNumber,
    required this.formKey,
    required this.codeController,
  });

  final String phoneNumber;
  final GlobalKey<FormState> formKey;
  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Phone Number Verification',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        RichText(
          text: TextSpan(
              text: "Enter the code sent to ",
              children: [
                TextSpan(
                    text: "+961 $phoneNumber",
                    style: Theme.of(context).textTheme.titleSmall),
              ],
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: AppDefaults.padding * 2,
              right: AppDefaults.padding * 2,
              top: AppDefaults.padding),
          child: Form(
            key: formKey,
            child: PinCodeTextField(
              key: const ValueKey('otp_field'),
              validator: Validators.requiredWithFieldName("*Otp code").call,
              appContext: context,
              pastedTextStyle: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              animationType: AnimationType.fade,

              pinTheme: PinTheme(
                  selectedColor: Colors.white,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 70.spMax,
                  fieldWidth: MediaQuery.of(context).size.width / 7.5,
                  activeFillColor: Colors.white,
                  errorBorderColor: Colors.red,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.green),
              cursorColor: Colors.black,

              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: codeController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
              onCompleted: (v) {},
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                // hasError = false;
              },
              beforeTextPaste: (text) {
                if (!text!.contains(RegExp(r'[0-9]'))) {
                  return true;
                }
                return false;
              },
            ),
          ),
        ),
        SizedBox(
          height: 30.spMax,
        ),
      ],
    );
  }
}
