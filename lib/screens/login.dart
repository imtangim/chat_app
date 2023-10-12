import 'package:chat_messenger/services/auth/auth_service.dart';
import 'package:chat_messenger/widgets/custom_button.dart';
import 'package:chat_messenger/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function() ontap;
  const LoginPage({super.key, required this.ontap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();

  Future<void> signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signinWithEmailAndPassword(
          emailControler.text, passwordControler.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // Gap(50),
                  //logo
                  Icon(
                    Icons.message,
                    size: 80,
                    color: Colors.grey[800],
                  ),
                  const Gap(35),
                  //welcome back message

                  const Text(
                    "Welcome back, you've been missed ",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Gap(35),
                  //email textfield
                  CustomTextfield(
                    controller: emailControler,
                    hintext: "Enter your email",
                    obscureText: false,
                  ),
                  const Gap(20),
                  //password textfield
                  CustomTextfield(
                    controller: passwordControler,
                    hintext: "Enter your password",
                    obscureText: true,
                  ),
                  const Gap(35),

                  //sign in button
                  CustomButton(
                    function: signIn,
                    buttonText: "Sign In",
                  ),
                  const Gap(20),
                  //not a member?
                  GestureDetector(
                    onTap: widget.ontap,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not a member? "),
                        Text(
                          "Register Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
