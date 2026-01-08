import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class LoginData {
  Crud crud;
  LoginData(this.crud);

  Future postData(
    String email,
    String adminPassword,
  ) async {
    var response = await crud.postData(
      AppLink.login,
      {
        'admin_email': email.toString(),
        'admin_password': adminPassword.toString(),
      },
    );

    return response.fold((l) => l, (r) => r);
  }
}
