import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vidyaniketan_app/screens/home.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Change Password",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/chng_pass.png",
                  fit: BoxFit.cover,
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "As this password is assigned to you, We recommend you to change your password",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
                Form(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.lock),
                            labelText: "Password",
                            hintText: "Enter Passsword",
                            suffixIcon: IconButton(
                              icon: Icon(
                                  _isObscure ? Iconsax.eye_slash : Iconsax.eye),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: confirmPassController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isObscure2,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Iconsax.lock),
                            labelText: "Confirm Password",
                            hintText: "Confirm Passsword",
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure2
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye),
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              },
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                changePass();
                              },
                              child: Text(
                                "Change",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                              )))
                    ],
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  changePass() {
    User? user = FirebaseAuth.instance.currentUser;
    print(user!.phoneNumber);
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');
    usersRef.doc(user.phoneNumber).update(
        {'pass': passController.text.toString(), 'passCheck': 1}).then((value) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Changed"),
                content: Text("Password Changed"),
              ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}
