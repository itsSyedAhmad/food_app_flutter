import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/auth_bloc.dart';
import 'package:food_app/components/app_button.dart';
import 'package:food_app/components/app_text_field.dart';
import 'package:food_app/components/app_layout.dart';
import 'package:food_app/screens/sign_up_screen.dart';
import 'package:food_app/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.isFromRoot = false});

  final bool isFromRoot;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailFieldKey = GlobalKey();
  final _passwordFieldKey = GlobalKey();
  double _lastKeyboardInset = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;
    if (keyboardInset == _lastKeyboardInset) return;

    _lastKeyboardInset = keyboardInset;
    if (keyboardInset <= 0) return;

    Future<void>.delayed(const Duration(milliseconds: 250), () {
      if (!mounted) return;

      final fieldKey = _passwordFocusNode.hasFocus
          ? _passwordFieldKey
          : _emailFocusNode.hasFocus
          ? _emailFieldKey
          : null;
      final fieldContext = fieldKey?.currentContext;
      if (fieldContext == null) return;

      Scrollable.ensureVisible(
        fieldContext,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
      );
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteBase,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom + 10,
          ),
          child: AppLayout(
            header: Column(
              children: [
                // Container(height: 44, color: Colors.green),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        // color: Colors.green,
                        child: Center(
                          child: Icon(Icons.arrow_back_ios, color: Colors.red),
                        ),
                      ),
                    ),
                    Text(
                      "Log In",
                      style: TextStyle(
                        color: AppColors.whiteBase,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 24, height: 24),
                  ],
                ),
              ],
            ),
            content: SingleChildScrollView(
              //   padding: EdgeInsets.only(
              //     bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
              //   ),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 34),
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: AppColors.font,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 19),
                  Text(
                    "Sign in to discover delicious meals, track your orders, and enjoy quick delivery. ",
                    style: TextStyle(
                      color: AppColors.black2,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 46),
                  AppTextField(
                    key: _emailFieldKey,
                    label: 'Email or Mobile Number',
                    hintText: 'example@example.com',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocusNode,
                  ),

                  SizedBox(height: 22),
                  AppTextField(
                    key: _passwordFieldKey,
                    label: 'Password',
                    hintText: 'Password',
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    focusNode: _passwordFocusNode,
                  ),

                  //   SizedBox(height: MediaQuery.viewInsetsOf(context).bottom),
                  SizedBox(height: 43),

                  Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      backgroundColor: AppColors.orangeBase,
                      label: 'Log In',
                      labelColor: AppColors.whiteBase,

                      onTap: () {
                        context.read<AuthBloc>().add(
                          SignInEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      if (widget.isFromRoot) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SignUpScreen(isFromRoot: true),
                          ),
                        );
                      }
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: const TextStyle(
                            color: AppColors.black2,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: const TextStyle(
                                color: AppColors.orangeBase,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
