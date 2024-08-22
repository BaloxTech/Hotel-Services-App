import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/style.dart';
import 'package:hotel_services_app/view/screens/auth/login.dart';

class VerifyEmailDialog extends StatelessWidget {
  final bool fromSignUp;
  const VerifyEmailDialog({this.fromSignUp = true, super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser!.sendEmailVerification();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.green, size: 100),
            const SizedBox(height: 20),
            Text(
                fromSignUp ? 'Sign Up successfully' : "Email sent successfully",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            Text(
                'Please check your email ${FirebaseAuth.instance.currentUser!.email} to verify your account.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: fontWeightNormal)),
            const SizedBox(height: 20),
            CustomButton(
              text: 'OK',
              onPressed: () => fromSignUp
                  ? launchScreen(const LoginScreen(), replace: true)
                  : Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
