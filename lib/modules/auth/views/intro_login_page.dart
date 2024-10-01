import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/core/utils/validators.dart';
import 'package:produce_pos/modules/auth/components/login_button.dart';

import '../../../core/constants/constants.dart';

class IntroLoginPage extends StatefulWidget {
  const IntroLoginPage({super.key});

  @override
  State<IntroLoginPage> createState() => _IntroLoginPageState();
}

class _IntroLoginPageState extends State<IntroLoginPage> {
  final _key = GlobalKey<FormState>();

  bool isPasswordShown = false;

  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  onLogin() {
    final bool isFormOkay = _key.currentState?.validate() ?? false;
    if (isFormOkay) {
      Navigator.pushNamed(context, AppRoutes.entryPoint);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints:const BoxConstraints(minHeight: 400, minWidth: 300),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4, // Responsive width
            height:
                MediaQuery.of(context).size.height * 0.6, // Responsive width

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDefaults.padding * 2),
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    FlutterLogo(size: 80),
                    SizedBox(height: 20),

                    // Username Field
                    TextFormField(
                      validator: Validators.requiredWithFieldName('Phone').call,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'اسم المستخدم',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Password Field
                    TextFormField(
                      validator: Validators.password.call,
                      // onFieldSubmitted: (v) => onLogin(),

                      textInputAction: TextInputAction.done,
                      obscureText: !isPasswordShown,
                      decoration: InputDecoration(
                        labelText: 'كلمة السر',
                        suffixIcon: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: onPassShowClicked,
                            icon: SvgPicture.asset(
                              AppIcons.eye,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Login Button
                    SizedBox(height: 35, child: LoginButton(onPressed: () {}))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
