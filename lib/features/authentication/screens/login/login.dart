import 'package:vidyaniketan/common/styles/spacing_styles.dart';
import 'package:vidyaniketan/features/authentication/screens/login/otp_login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ESpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Iconsax.global,
                    size: 30,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Let's Get Started!",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 35,
                  )
                ],
              ),
              Form(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.user),
                          labelText: "Username",
                          hintText: "Enter Username"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.call),
                          labelText: "Phone Number",
                          hintText: "Enter Phone Number"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.password_check),
                          labelText: "Password",
                          hintText: "Enter Password",
                          suffixIcon: Icon(Iconsax.eye_slash)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: true, onChanged: (value) {}),
                            const Text("Remember Me"),
                          ],
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Forgot Password?"))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OTPScreen()));
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            )))
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
