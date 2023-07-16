import 'package:avrod/booksScreen/library_screen.dart';
import 'package:avrod/chat/helper/helper_function.dart';
import 'package:avrod/chat/services/auth_servisec.dart';
import 'package:avrod/chat/services/database_service.dart';
import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/chat/widgets/Input_decoration.dart';
import 'package:avrod/chat/widgets/login_button.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:avrod/widgets/avrod_bunner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static String routName = '/loginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  HomePageController controller = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  title: controller.currrentIndexTab == 1 ? "Китобхона" : 'Чат',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  maxLines: 3,
                  title: controller.currrentIndexTab == 1
                      ? 'Барои дохил шудан ба китобхона, шумо бояд ба ҳисоби корбари худ ворид шавед!'
                      : 'Барои дохил шудан ба чат, шумо бояд ба ҳисоби корбари худ ворид шавед!',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 40,
                ),
                const AvrodBunner(
                  height: 200,
                  width: 200,
                  borderRadius: 100,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  initialValue: controller.emailLogin,
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                        ? null
                        : "Лутфан email-и дурустро ворид кунед!";
                  },
                  onChanged: (val) {
                    controller.onChangedLoginEmail(val);
                  },
                  decoration: inputDecoration.copyWith(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: navItemsColor,
                    ),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  obscureText: controller.passwordVisible,
                  initialValue: controller.passwordLogin,
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Рамз бояд на камтар аз 6 аломат бошад";
                    } else {
                      return null;
                    }
                  },
                  decoration: inputDecoration.copyWith(
                    prefixIcon: 
                    IconButton(
                      onPressed: () {
                        setState(() {
                          controller.passwordVisible =
                              !controller.passwordVisible;
                        });
                      },
                      icon: controller.passwordVisible
                          ? const Icon(
                              Icons.lock_outline,
                              color: navItemsColor,
                            )
                          : const Icon(
                              Icons.lock_open,
                              color: navItemsColor,
                            ),
                    ),
                    hintText: 'Password',
                  ),
                  onChanged: (val) {
                    controller.onChangedLoginPassword(val);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                LoginButton(
                  buttonTitle: 'Вуруд',
                  onPressed: () {
                    setState(() {
                      login();
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Айни ҳол ҳисоб надоред? ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'Сабт кардан',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.goToRegisterPage();
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                IconButton(
                  onPressed: () {
                    controller.goToHomePage();
                  },
                  icon: const Icon(
                    Icons.home,
                    color: navItemsColor,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      setState(() {
        controller.isLoading;
      });
    }
    await authService
        .signInWithEmailAndPassword(
            controller.emailLogin, controller.passwordLogin)
        .then((value) async {
      if (value == true) {
        QuerySnapshot snapshot =
            await DtabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(controller.emailLogin)
                .whenComplete(() {
          if (controller.currrentIndexTab == 1) {
            Get.offNamed(LibraryScreen.routName);
          } else {
            setState(() {
              controller.goToChatHomePage();
            });
          }
        });
        // saving the values to our shared preferences
        await HelperFunction.saveUserLoggedInStatus(true);
        await HelperFunction.saveUserEmailSf(controller.emailLogin);
        await HelperFunction.saveUserNameSf(
          snapshot.docs[0]['fullName'],
        );
        // Get.offNamed(ChatHomePage.routName);
        // update();
      } else {
        setState(() {
          controller.errorSnackbar();
          controller.isLoading = false;
        });
      }
    });
  }
}
