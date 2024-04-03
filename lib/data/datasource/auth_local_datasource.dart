import 'package:clinic_ari/data/datasource/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    // save auth data to local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponseModel.toJson());
  }

  Future<void> removeAuthData() async {
    // remove auth data from local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('aut_data');
  }

  Future<AuthResponseModel?> getAuthData() async{
    // get auth data from local storage
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if (authData != null) {
      return AuthResponseModel.fromJson(authData);
    } else {
      return null;
    }
  }

  Future<bool> isUserLoggedIn() async {
    // check if user logged in
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_data');
  }
}