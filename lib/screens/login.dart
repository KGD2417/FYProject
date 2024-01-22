import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pinput/pinput.dart';
import 'package:vidyaniketan_app/screens/home.dart';

import '../utils/spacing_styles.dart';
import 'chg_pass.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isObscure = true;


  sendSMS() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException ex) {},
        codeSent: (String verificationId, int? resendToken) {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        const Text("Enter the OTP "),
                        const SizedBox(
                          height: 10,
                        ),
                        Pinput(
                          controller: otpController,
                          length: 6,
                          showCursor: true,
                          defaultPinTheme: PinTheme(
                              width: 50,
                              height: 60,
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily:
                                  GoogleFonts
                                      .poppins()
                                      .fontFamily,
                                  fontWeight:
                                  FontWeight.w600),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(
                                    10),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 2),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(

                              // OTP CHECKING
                              onPressed: () async {
                                try {
                                  PhoneAuthCredential credential = await PhoneAuthProvider
                                      .credential(
                                      verificationId: verificationId,
                                      smsCode: otpController.text.toString());
                                  FirebaseAuth.instance.signInWithCredential(
                                      credential).then((value) {
                                    User? user = FirebaseAuth.instance
                                        .currentUser;
                                    var count = FirebaseFirestore.instance
                                        .collection('users').doc(
                                        user!.phoneNumber).get().then((
                                        DocumentSnapshot documentSnapshots) {
                                          Navigator.pop(context);
                                      if (documentSnapshots.get('passCheck')==0){
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (
                                                context) => const ChangePassScreen()));
                                      }
                                      else{
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (
                                                context) => const HomeScreen()));
                                      }
                                    });
                                  });
                                }
                                catch (ex) {
                                  log(ex.toString());
                                }
                              },
                              child: Text(
                                "Verify",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: GoogleFonts
                                        .poppins()
                                        .fontFamily),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: "+91${phoneController.text}");
  }

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
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                  const SizedBox(
                    height: 35,
                  )
                ],
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.user),
                              labelText: "Username",
                              hintText: "Enter Username"),
                          keyboardType: TextInputType.name,

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phoneController,
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
                          controller: passController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.password_check),
                              labelText: "Password",
                              hintText: "Enter Password",
                              suffixIcon: IconButton(icon: Icon(
                                  _isObscure ? Iconsax.eye_slash : Iconsax.eye),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },)),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _isObscure,
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

                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () async {
                                  String number = "+91${phoneController.text}";
                                  var kk = FirebaseFirestore.instance
                                      .collection('users').doc(number)
                                      .get()
                                      .then((
                                      DocumentSnapshot documentSnapshot) {
                                    if (documentSnapshot.exists) {
                                      if (documentSnapshot.get('username') ==
                                          userController.text.toString() &&
                                          documentSnapshot.get('pass') ==
                                              passController.text.toString()) {
                                        sendSMS();
                                      }
                                      else {
                                        showDialog(context: context,
                                            builder: (context) =>
                                            const AlertDialog(
                                              title: Text("Error"),
                                              content: Text(
                                                  "Invalid Credentials"),
                                            ));
                                      }
                                    }
                                    else {
                                      showDialog(context: context,
                                          builder: (context) =>
                                          const AlertDialog(
                                            title: Text("Error"),
                                            content: Text(
                                                "User Doesn't Exist."),
                                          ));
                                    }
                                  });
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: GoogleFonts
                                          .poppins()
                                          .fontFamily),
                                ))),


                        //Temp Button
                        // ElevatedButton(onPressed: (){
                        //   String number = "+91${phoneController.text}";
                        //   var kk = FirebaseFirestore.instance.collection('users').doc(number).get().then((DocumentSnapshot documentSnapshot){
                        //     if(documentSnapshot.exists){
                        //       if(documentSnapshot.get('username')== userController.text.toString() && documentSnapshot.get('pass')==passController.text.toString()){
                        //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ChangePassScreen()));
                        //       }
                        //       else{
                        //         showDialog(context: context, builder: (context)=>const AlertDialog(
                        //           title: Text("Error"),
                        //           content: Text("Invalid Credentials"),
                        //         ));
                        //       }
                        //     }
                        //     else{
                        //       showDialog(context: context, builder: (context)=>const AlertDialog(
                        //         title: Text("Error"),
                        //         content: Text("User Doesn't Exist."),
                        //       ));
                        //     }
                        //   });
                        //
                        //
                        // }, child: Text("Change Pass"))
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
