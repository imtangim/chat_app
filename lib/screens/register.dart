import 'package:chat_messenger/services/auth/auth_service.dart';
import 'package:chat_messenger/widgets/custom_button.dart';
import 'package:chat_messenger/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function() ontap;
  const RegisterPage({super.key, required this.ontap});

  @override
  State<RegisterPage> createState() => _LogiRegisterState();
}

class _LogiRegisterState extends State<RegisterPage> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController confirmpasswordControler = TextEditingController();
  TextEditingController nameControler = TextEditingController();

  Future<void> signUp() async {
    if (passwordControler.text != confirmpasswordControler.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Doesn't Matched"),
        ),
      );
      return;
    } else {
      final authService = Provider.of<AuthService>(context, listen: false);
      try {
        await authService.signupWithEmailAndPassword(
            emailControler.text, passwordControler.text, nameControler.text);
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
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
                    "Welcome to our community",
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
                    controller: nameControler,
                    hintext: "Name",
                    obscureText: false,
                  ),
                  const Gap(20),
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
                  const Gap(20),
                  CustomTextfield(
                    controller: confirmpasswordControler,
                    hintext: "Confirm Password",
                    obscureText: true,
                  ),
                  const Gap(35),

                  //sign in button
                  CustomButton(
                    function: signUp,
                    buttonText: "Sign Up",
                  ),
                  const Gap(20),
                  //not a member?
                  GestureDetector(
                    onTap: widget.ontap,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already a member? "),
                        Text(
                          "Login Now",
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
