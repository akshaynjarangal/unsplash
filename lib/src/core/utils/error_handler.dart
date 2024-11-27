import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';

abstract class Failure {
  int? get statusCode;
  String get message;
}

// Define specific failure enums extending the base failure class
class ServerFailure extends Failure {
  final int errorCode;
  final String msg;
  ServerFailure({required this.errorCode, required this.msg});
  @override
  String get message => msg;

  @override
  int? get statusCode => errorCode;
}

class CacheFailure extends Failure {
  final int errorCode;
  CacheFailure({required this.errorCode});
  @override
  String get message => 'Cache Failure';

  @override
  int? get statusCode => errorCode;
}

class NetworkFailure extends Failure {
  @override
  String get message => 'No Internet Connection';

  @override
  int? get statusCode => null;
}

class TimeoutFailure extends Failure {
  @override
  String get message => 'Request Timed Out';

  @override
  int? get statusCode => null;
}

class UnknownFailure extends Failure {
  @override
  String get message => 'Unknown Failure';

  @override
  int? get statusCode => null;
}

class OtpFailure extends Failure {
  final int errorCode;
  OtpFailure({required this.errorCode});
  @override
  String get message => 'Invalid OTP';

  @override
  int? get statusCode => errorCode;
}

class EmailFailure extends Failure {
  final int errorCode;
  EmailFailure({required this.errorCode});
  @override
  String get message => 'Invalid Email';

  @override
  int? get statusCode => errorCode;
}

class ExceptionFailure extends Failure {
  @override
  String get message => 'Exception Failure';

  @override
  int? get statusCode => null;
}

class NotFoundFailure extends Failure {
  final int errorCode;
  final String? msg;
  NotFoundFailure({this.msg, required this.errorCode});
  @override
  String get message => msg ?? 'Not Found Failure';

  @override
  int? get statusCode => errorCode;
}

class ServerErrorFailure extends Failure {
  final int errorCode;
  ServerErrorFailure({required this.errorCode});
  @override
  String get message => 'Server Error Failure';

  @override
  int? get statusCode => errorCode;
}

class BadRequestFailure extends Failure {
  final int errorCode;
  final String? msg;
  BadRequestFailure({this.msg, required this.errorCode});
  @override
  String get message => msg ?? 'Bad Request';

  @override
  int? get statusCode => errorCode;
}

class StatusCodeFailure extends Failure {
  final int errorCode;
  final String msg;
  StatusCodeFailure({required this.errorCode, required this.msg});
  @override
  String get message => msg;

  @override
  int? get statusCode => errorCode;
}

class UnAuthorizedFailure extends Failure {
  final int errorCode;
  final String msg;
  UnAuthorizedFailure({required this.msg, required this.errorCode});
  @override
  String get message => msg;

  @override
  int? get statusCode => errorCode;
}

class FormatException extends Failure {
  @override
  String get message => 'Format exception';

  @override
  int? get statusCode => null;
}

class ConflictFailure extends Failure {
  final int errorCode;
  final String msg;
  ConflictFailure({required this.msg, required this.errorCode});
  @override
  String get message => msg;

  @override
  int? get statusCode => errorCode;
}

class HandleForwarding extends Failure {
  final String token;

  HandleForwarding({required this.token});
  @override
  String get message => token;

  @override
  int? get statusCode => 301;
}

class NoContentFailure extends Failure {
  @override
  String get message => 'No Content!';

  @override
  int? get statusCode => 204;
}

class NotAcceptableFailure extends Failure {
  final int errorCode;
  final String msg;
  NotAcceptableFailure({required this.msg, required this.errorCode});
  @override
  String get message => msg;

  @override
  int? get statusCode => errorCode;
}

Failure handleStatusCode(int statusCode, String? message) {
  log('Status Code: $statusCode', name: 'ErrorHandler');
  switch (statusCode) {
    case 204:
      return NoContentFailure();
    case 301:
      return HandleForwarding(
        token: message ?? 'Forwarding',
      );
    case 401:
      return UnAuthorizedFailure(
        errorCode: 401,
        msg: message ?? 'UnAuthorized Access',
      );
    case 400:
      return BadRequestFailure(
        errorCode: 400,
        msg: message ?? 'Bad Request',
      );
    case 404:
      return NotFoundFailure(
        errorCode: 404,
        msg: 'Not Found',
      );
    case 406:
      return NotAcceptableFailure(
        errorCode: 406,
        msg: message ?? 'Not Acceptable',
      );
    case 409:
      return ConflictFailure(
        errorCode: 409,
        msg: message ?? 'Conflict Occurred',
      );
    case 500:
      return ServerErrorFailure(errorCode: 500);
    default:
      return StatusCodeFailure(
        errorCode: statusCode,
        msg: message ?? 'An error occurred',
      );
  }
}

Failure handleException(Object e) {
  if (e is ClientException && e is SocketException) {
    return NetworkFailure();
  }
  if (e is TimeoutException) {
    return TimeoutFailure();
  } else {
    return UnknownFailure();
  }
}