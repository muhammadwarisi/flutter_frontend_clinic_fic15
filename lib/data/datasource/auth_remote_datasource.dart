import 'package:clinic_ari/core/constants/variables.dart';
import 'package:clinic_ari/data/datasource/auth_local_datasource.dart';
import 'package:clinic_ari/data/datasource/models/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(String email, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url, 
      body:{
        'email':email,
        'password':password
        },
      );

      if (response.statusCode==200) {
        await AuthLocalDatasource()
          .saveAuthData(AuthResponseModel.fromJson(response.body));
        return Right(AuthResponseModel.fromJson(response.body));
      } else {
        return const Left('gagal login');
      }
  }

  Future<Either<String, String>> logout() async {
      final authDataModel = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(
      url, 
      headers: {
        'authorization': 'bearer ${authDataModel?.token}',
      }
      );

      if (response.statusCode==200) {
        return const Right('Logout Berhasil');
      } else {
        return const Left('gagal logout');
      }
  }
}