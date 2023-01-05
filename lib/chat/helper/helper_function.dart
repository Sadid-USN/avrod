import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
// Keys
  static String userLoggedInKey = 'LOGGEDINKEY';
  static String userNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';

//saving data
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sharedF = await SharedPreferences.getInstance();
    return await sharedF.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSf(String userName) async {
    SharedPreferences sharedF = await SharedPreferences.getInstance();
    return await sharedF.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSf(String userEmail) async {
    SharedPreferences sharedF = await SharedPreferences.getInstance();
    return await sharedF.setString(userEmailKey, userEmail);
  }
// getting data

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getBool(userLoggedInKey);
  }

  static Future<String?> getUserEmailFromSF() async {
    SharedPreferences sharedF = await SharedPreferences.getInstance();
    return sharedF.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSF() async {
    SharedPreferences sharedF = await SharedPreferences.getInstance();
    return sharedF.getString(userNameKey);
  }
}
