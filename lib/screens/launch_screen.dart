import 'package:flutter/material.dart';
import 'package:food_app/components/app_button.dart';
import 'package:food_app/screens/login_screen.dart';
import 'package:food_app/screens/sign_up_screen.dart';
import 'package:food_app/theme/app_colors.dart';

class LaunchScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.orangeBase,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,

          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                AppColors.yellowBase,
                BlendMode.srcIn,
              ),
              child: SizedBox(
                width: 202,
                height: 257,
                //color: Colors.green,

                child: Image.asset("assets/images/app_splash.png"),
              ),
            ),

            //
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.",

              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteBase,
              ),
              textAlign: TextAlign.center,
            ),

            //
            SizedBox(height: 43),

            AppButton(
              backgroundColor: AppColors.yellowBase,
              label: 'Log In',
              labelColor: AppColors.orangeBase,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(isFromRoot: true),
                  ),
                );
              },
            ),

            SizedBox(height: 10),

            AppButton(
              backgroundColor: AppColors.yellow2,
              label: 'Sign Up',
              labelColor: AppColors.orangeBase,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(isFromRoot: true),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
