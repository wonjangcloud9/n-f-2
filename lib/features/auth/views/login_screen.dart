import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resultnomad/constants/gaps.dart';
import 'package:resultnomad/constants/sizes.dart';
import 'package:resultnomad/features/auth/repos/auth_repo.dart';
import 'package:resultnomad/features/auth/views/widgets/form_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _password = "";
  String _email = "";

  bool activeLogin = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });

    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
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

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length >= 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() {
    if (_password.isEmpty || !_isPasswordValid()) {
      return;
    }
    if (_email.isEmpty || _isEmailValid() != null) {
      return;
    }

    if (activeLogin) {
      ref.read(authRepo).signIn(_email, _password);
    } else {
      ref.read(authRepo).signUp(_email, _password);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Sizes.size96,
        title: const Text("로그인"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                labelText: "이메일",
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
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                errorText: _password.isEmpty ? "비밀번호를 입력해주세요." : null,
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
                labelText: "비밀번호",
                alignLabelWithHint: true,
                suffix: _password.isNotEmpty && _isPasswordValid()
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
                  disabled: _password.isEmpty ||
                      !_isPasswordValid() ||
                      _isEmailValid() != null ||
                      _email.isEmpty,
                  signUp: !activeLogin,
                ),
              ),
            ),
            Gaps.v16,
            GestureDetector(
              onTap: () {
                activeLogin = !activeLogin;
                setState(() {});
              },
              child: Text(
                activeLogin ? "회원가입" : "로그인",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
