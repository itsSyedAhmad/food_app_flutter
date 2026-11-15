import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/auth_bloc.dart';
import 'package:food_app/components/app_button.dart';
import 'package:food_app/components/app_layout.dart';
import 'package:food_app/components/app_text_field.dart';
import 'package:food_app/screens/login_screen.dart';
import 'package:food_app/theme/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, this.isFromRoot = false});

  final bool isFromRoot;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  final _fullNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  final _dateOfBirthFocusNode = FocusNode();

  final _fullNameFieldKey = GlobalKey();
  final _passwordFieldKey = GlobalKey();
  final _emailFieldKey = GlobalKey();
  final _mobileFieldKey = GlobalKey();
  final _dateOfBirthFieldKey = GlobalKey();

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

      final fields = [
        (_fullNameFocusNode, _fullNameFieldKey),
        (_passwordFocusNode, _passwordFieldKey),
        (_emailFocusNode, _emailFieldKey),
        (_mobileFocusNode, _mobileFieldKey),
        (_dateOfBirthFocusNode, _dateOfBirthFieldKey),
      ];
      final focusedField = fields.where((field) => field.$1.hasFocus);
      if (focusedField.isEmpty) return;

      final fieldContext = focusedField.first.$2.currentContext;
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
    _fullNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _dateOfBirthController.dispose();
    _fullNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _mobileFocusNode.dispose();
    _dateOfBirthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isFromRoot);
    return Container(
      color: AppColors.whiteBase,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom + 10,
          ),
          child: AppLayout(
            header: Column(
              children: [
                const SizedBox(height: 44),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: Center(
                          child: Icon(Icons.arrow_back_ios, color: Colors.red),
                        ),
                      ),
                    ),
                    const Text(
                      'New Account',
                      style: TextStyle(
                        color: AppColors.whiteBase,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 24, height: 24),
                  ],
                ),
              ],
            ),
            content: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    key: _fullNameFieldKey,
                    label: 'Full Name',
                    hintText: 'Enter your full name',
                    controller: _fullNameController,
                    textInputAction: TextInputAction.next,
                    focusNode: _fullNameFocusNode,
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    key: _passwordFieldKey,
                    label: 'Password',
                    hintText: 'Create a password',
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    focusNode: _passwordFocusNode,
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    key: _emailFieldKey,
                    label: 'Email',
                    hintText: 'example@example.com',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    focusNode: _emailFocusNode,
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    key: _mobileFieldKey,
                    label: 'Mobile Number',
                    hintText: 'Enter your mobile number',
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    focusNode: _mobileFocusNode,
                  ),
                  const SizedBox(height: 18),
                  AppTextField(
                    key: _dateOfBirthFieldKey,
                    label: 'Date of Birth',
                    hintText: 'DD/MM/YYYY',
                    controller: _dateOfBirthController,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.done,
                    focusNode: _dateOfBirthFocusNode,
                  ),
                  const SizedBox(height: 32),
                  Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      backgroundColor: AppColors.orangeBase,
                      label: 'Sign Up',
                      labelColor: AppColors.whiteBase,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        context.read<AuthBloc>().add(
                          SignUpEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                            fullName: _fullNameController.text,
                            mobileNumber: _mobileController.text,
                            dateOfBirth: _dateOfBirthController.text,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(color: AppColors.black2, fontSize: 13),
                        children: [
                          TextSpan(text: 'By continuing, you agree to '),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              color: AppColors.orangeBase,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.orangeBase,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 16),

                  GestureDetector(
                    onTap: () {
                      if (widget.isFromRoot) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      } else {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LoginScreen(isFromRoot: true),
                          ),
                        );
                      }
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(
                            color: AppColors.black2,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Log in",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
