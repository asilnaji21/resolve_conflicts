


import '../../../app/constants_manager.dart';
import '../../models/user_model.dart';
import '../../models/verify_reset_password_code_model.dart';
import '../../network/remote/api_result_handler.dart';
import 'package:dartz/dartz.dart';

import '../../network/remote/dio_helper.dart';

class AuthRepository {
  DioHelper dioHelper = DioHelper();

  Future<Either<ApiSuccess, ApiFailure>> login(
      {required String email, required String password}) async {
    ApiResults response = await dioHelper.postData(
        endPoint: Endpoints.login,
        data: {"username": email, "password": password});

    if (response is ApiSuccess) {
      return left(
          ApiSuccess(UserModel.fromJson(response.data), response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message['detail'].toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> register(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    ApiResults response =
        await dioHelper.postData(endPoint: Endpoints.register, data: {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password
    });

    if (response is ApiSuccess) {
      return left(ApiSuccess(response.data["detail"], response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        right(ApiFailure(response.message['detail'][0].toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> verifyCode(
      {required String code}) async {
    ApiResults response = await dioHelper
        .postData(endPoint: Endpoints.verifyCode, data: {"code": code});
    if (response is ApiSuccess) {
      return left(
          ApiSuccess(response.data["detail"].toString(), response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message['code'][0].toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> sendCodeToResetPassword(
      {required String email}) async {
    ApiResults response = await dioHelper.postData(
        endPoint: Endpoints.sendCodeToResetPassword, data: {"email": email});
    if (response is ApiSuccess) {
      return left(
          ApiSuccess(response.data["detail"].toString(), response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(
            ApiFailure(response.message['email']['detail'].toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> verifyResetPasswordCode(
      {required String code}) async {
    ApiResults response = await dioHelper.postData(
        endPoint: Endpoints.verifyResetPasswordCode, data: {"code": code});
    if (response is ApiSuccess) {
      return left(ApiSuccess(
          ResetPasswordCodeModel.fromJson(response.data), response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message['detail'][0].toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> resetNewPassword(
      {required String token, required String newPassword}) async {
    ApiResults response = await dioHelper.postData(
        endPoint: Endpoints.resetNewPassword,
        data: {
          "token": token,
          "new_password1": newPassword,
          "new_password2": newPassword
        });

    if (response is ApiSuccess) {
      return left(
          ApiSuccess(response.data['detail'].toString(), response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message.toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> resendCode(
      {required String email}) async {
    ApiResults response =
        await dioHelper.postData(endPoint: Endpoints.resendCode, data: {
      "email": email,
    });

    if (response is ApiSuccess) {
      return left(
          ApiSuccess(response.data['detail'].toString(), response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message["detail"][0].toString()));
      }
      return right(response as ApiFailure);
    }
  }

  Future<Either<ApiSuccess, ApiFailure>> logout(
      {required String refresh}) async {
    ApiResults response =
        await dioHelper.postData(endPoint: Endpoints.logout, data: {
      "refresh": refresh,
    });

    if (response is ApiSuccess) {
      return left(ApiSuccess('نم تسجيل الخروج بنجاح', response.statusCode));
    } else {
      if (response is ApiFailure && response.statusCode == 400) {
        return right(ApiFailure(response.message.toString()));
      }
      return right(response as ApiFailure);
    }
  }
}
