import 'package:design_pattern/core/theming/colors.dart';
import 'package:design_pattern/core/widgets/app_text_btn.dart';
import 'package:design_pattern/core/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  Future<void> _sendPasswordResetEmail(BuildContext context) async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent successfully')),
      );
      Navigator.pop(context); // Navigate back to the previous screen
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address.';
      } else {
        errorMessage = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Forget Password",
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  color: MyColors.mainBrown),
            ),
            Text(
              "Enter your email for the verification process. You will recieve Email",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            AppTextField(
                controller: emailController,
                hintText: "enter your email",
                prefixIcon: Icons.email_outlined),
            SizedBox(
              height: 60,
            ),
            AppTextBtn(buttonText: "Send Email", onPressed: () =>_sendPasswordResetEmail(context))
          ],
        ),
      ),
    );
  }
}
