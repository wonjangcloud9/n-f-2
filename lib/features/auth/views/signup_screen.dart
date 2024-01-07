import 'package:flutter/material.dart';
import 'package:resultnomad/constants/gaps.dart';
import 'package:resultnomad/constants/sizes.dart';
import 'package:resultnomad/features/auth/views/widgets/form_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _username = "";
  String _email = "";

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
    _usernameController.text = "wonjang";
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
    _emailController.text = "wonjang@naver.com";
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) {
      return null;
    }
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!regExp.hasMatch(_email)) {
      return "유효하지 않은 이메일입니다.";
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() {
    if (_username.isEmpty) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Sizes.size96,
        title: const Text("😃 기분일기 😂"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                errorText: _username.isEmpty ? "이름을 입력해주세요." : null,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                labelText: "Name",
                alignLabelWithHint: true,
                suffix: _username.isNotEmpty
                    ? GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.check_circle,
                          size: Sizes.size24,
                          color: Colors.green,
                        ),
                      )
                    : null,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              onEditingComplete: () {},
              autocorrect: false,
              decoration: InputDecoration(
                errorText: _isEmailValid(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                alignLabelWithHint: true,
                labelText: "Email",
                suffix: _email.isNotEmpty && _isEmailValid() == null
                    ? GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.check_circle,
                          size: Sizes.size24,
                          color: Colors.green,
                        ),
                      )
                    : null,
              ),
            ),
            Gaps.v16,
            GestureDetector(
              onTap: _onNextTap,
              child: Container(
                alignment: Alignment.centerRight,
                child: FormButton(
                  big: true,
                  disabled: _username.isEmpty ||
                      _isEmailValid() != null ||
                      _email.isEmpty,
                  signUp: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
