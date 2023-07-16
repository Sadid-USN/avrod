import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/chat/widgets/Input_decoration.dart';
import 'package:avrod/chat/widgets/login_button.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:avrod/widgets/avrod_bunner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static String routName = '/registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                  title: 'Сабт',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  title: 'Ҳисоби корбари худро инҷо эҷод кунед!',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(
                  height: 50,
                ),
                const AvrodBunner(
                  height: 160,
                  width: 160,
                  borderRadius: 16,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Исми худро холи нагузоред';
                    }
                  },
                  onChanged: (val) {
                    controller.onChangedFullName(val);
                  },
                  decoration: inputDecoration.copyWith(
                    prefixIcon:
                        const Icon(Icons.person_outline, color: navItemsColor),
                    hintText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                        ? null
                        : "Лутфан email-и дурустро ворид кунед!";
                  },
                  onChanged: (val) {
                    controller.onChangedRegisterEmail(val);
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
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Рамз бояд на камтар аз 6 аломат бошад";
                    } else {
                      return null;
                    }
                  },
                  decoration: inputDecoration.copyWith(
                    prefixIcon:IconButton(
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
                    controller.onChangedRegisterPassword(val);
                  },
            
                ),
                const SizedBox(
                  height: 16,
                ),
                LoginButton(
                  onPressed: () {
                    controller.register();
                  },
                  buttonTitle: 'Сабт',
                ),
                const SizedBox(
                  height: 16,
                ),
                Text.rich(
                  TextSpan(
                    text: 'Ба сафҳаи вуруд ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'бозгаштан',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.goToLogin();
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
}
