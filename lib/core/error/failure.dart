import 'package:flutter/foundation.dart';

/// Base class for all failures in the application
/// Uses sealed class pattern for exhaustive pattern matching
@immutable
abstract class Failure {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;
  
  const Failure({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });
  
  /// User-friendly error message
  String get userMessage => message;
  
  /// Technical error details for debugging
  String get debugMessage {
    final StringBuffer buffer = StringBuffer();
    buffer.writeln('Failure: ${runtimeType}');
    buffer.writeln('Message: $message');
    
    if (code != null) {
      buffer.writeln('Code: $code');
    }
    
    if (originalError != null) {
      buffer.writeln('Original Error: $originalError');
    }
    
    if (stackTrace != null && kDebugMode) {
      buffer.writeln('Stack Trace:');
      buffer.write(stackTrace.toString());
    }
    
    return buffer.toString();
  }
  
  @override
  String toString() => debugMessage;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;
  
  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}

/// Network-related failures
class NetworkFailure extends Failure {
  final int? statusCode;
  final Map<String, dynamic>? response;
  
  const NetworkFailure({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.statusCode,
    this.response,
  });
  
  factory NetworkFailure.fromStatusCode(int statusCode, {dynamic response}) {
    String message;
    String code;
    
    switch (statusCode) {
      case 400:
        message = '잘못된 요청입니다';
        code = 'BAD_REQUEST';
        break;
      case 401:
        message = '인증이 필요합니다';
        code = 'UNAUTHORIZED';
        break;
      case 403:
        message = '접근 권한이 없습니다';
        code = 'FORBIDDEN';
        break;
      case 404:
        message = '요청한 정보를 찾을 수 없습니다';
        code = 'NOT_FOUND';
        break;
      case 408:
        message = '요청 시간이 초과되었습니다';
        code = 'REQUEST_TIMEOUT';
        break;
      case 429:
        message = '너무 많은 요청을 보냈습니다. 잠시 후 다시 시도해주세요';
        code = 'TOO_MANY_REQUESTS';
        break;
      case 500:
        message = '서버 오류가 발생했습니다';
        code = 'INTERNAL_SERVER_ERROR';
        break;
      case 502:
        message = '게이트웨이 오류가 발생했습니다';
        code = 'BAD_GATEWAY';
        break;
      case 503:
        message = '서비스를 일시적으로 사용할 수 없습니다';
        code = 'SERVICE_UNAVAILABLE';
        break;
      case 504:
        message = '게이트웨이 시간이 초과되었습니다';
        code = 'GATEWAY_TIMEOUT';
        break;
      default:
        message = '네트워크 오류가 발생했습니다 (코드: $statusCode)';
        code = 'NETWORK_ERROR_$statusCode';
    }
    
    return NetworkFailure(
      message: message,
      code: code,
      statusCode: statusCode,
      response: response is Map<String, dynamic> ? response : null,
    );
  }
  
  @override
  String get userMessage {
    // Provide more user-friendly messages
    if (statusCode == null) {
      return '네트워크 연결을 확인해주세요';
    }
    return super.userMessage;
  }
}

/// Connection-related failures
class ConnectionFailure extends NetworkFailure {
  const ConnectionFailure({
    super.message = '인터넷 연결을 확인해주세요',
    super.code = 'NO_CONNECTION',
    super.originalError,
    super.stackTrace,
  });
}

/// Timeout failures
class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure({
    super.message = '요청 시간이 초과되었습니다',
    super.code = 'TIMEOUT',
    super.originalError,
    super.stackTrace,
  });
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = '서버 오류가 발생했습니다',
    super.code = 'SERVER_ERROR',
    super.originalError,
    super.stackTrace,
  });
}

/// Authentication failures
class AuthFailure extends Failure {
  final AuthFailureType type;
  
  const AuthFailure({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.type = AuthFailureType.unknown,
  });
  
  factory AuthFailure.invalidCredentials() => const AuthFailure(
        message: '이메일 또는 비밀번호가 올바르지 않습니다',
        code: 'INVALID_CREDENTIALS',
        type: AuthFailureType.invalidCredentials,
      );
  
  factory AuthFailure.userNotFound() => const AuthFailure(
        message: '사용자를 찾을 수 없습니다',
        code: 'USER_NOT_FOUND',
        type: AuthFailureType.userNotFound,
      );
  
  factory AuthFailure.emailAlreadyInUse() => const AuthFailure(
        message: '이미 사용 중인 이메일입니다',
        code: 'EMAIL_ALREADY_IN_USE',
        type: AuthFailureType.emailAlreadyInUse,
      );
  
  factory AuthFailure.weakPassword() => const AuthFailure(
        message: '비밀번호가 너무 약합니다',
        code: 'WEAK_PASSWORD',
        type: AuthFailureType.weakPassword,
      );
  
  factory AuthFailure.sessionExpired() => const AuthFailure(
        message: '세션이 만료되었습니다. 다시 로그인해주세요',
        code: 'SESSION_EXPIRED',
        type: AuthFailureType.sessionExpired,
      );
  
  factory AuthFailure.unauthorized() => const AuthFailure(
        message: '인증이 필요합니다',
        code: 'UNAUTHORIZED',
        type: AuthFailureType.unauthorized,
      );
}

enum AuthFailureType {
  invalidCredentials,
  userNotFound,
  emailAlreadyInUse,
  weakPassword,
  sessionExpired,
  unauthorized,
  unknown,
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = '캐시 오류가 발생했습니다',
    super.code = 'CACHE_ERROR',
    super.originalError,
    super.stackTrace,
  });
  
  factory CacheFailure.notFound() => const CacheFailure(
        message: '캐시된 데이터를 찾을 수 없습니다',
        code: 'CACHE_NOT_FOUND',
      );
  
  factory CacheFailure.expired() => const CacheFailure(
        message: '캐시가 만료되었습니다',
        code: 'CACHE_EXPIRED',
      );
}

/// Validation failures
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;
  
  const ValidationFailure({
    super.message = '입력 값이 올바르지 않습니다',
    super.code = 'VALIDATION_ERROR',
    super.originalError,
    super.stackTrace,
    this.fieldErrors,
  });
  
  factory ValidationFailure.field({
    required String field,
    required String message,
  }) =>
      ValidationFailure(
        message: message,
        fieldErrors: {
          field: [message]
        },
      );
  
  factory ValidationFailure.multiple(Map<String, List<String>> errors) {
    final String message = errors.values
        .expand((messages) => messages)
        .take(3)
        .join(', ');
    
    return ValidationFailure(
      message: message,
      fieldErrors: errors,
    );
  }
  
  @override
  String get userMessage {
    if (fieldErrors != null && fieldErrors!.isNotEmpty) {
      return fieldErrors!.values.expand((messages) => messages).join('\n');
    }
    return super.userMessage;
  }
}

/// Permission failures
class PermissionFailure extends Failure {
  final PermissionType type;
  
  const PermissionFailure({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.type = PermissionType.unknown,
  });
  
  factory PermissionFailure.location() => const PermissionFailure(
        message: '위치 권한이 필요합니다',
        code: 'LOCATION_PERMISSION_DENIED',
        type: PermissionType.location,
      );
  
  factory PermissionFailure.camera() => const PermissionFailure(
        message: '카메라 권한이 필요합니다',
        code: 'CAMERA_PERMISSION_DENIED',
        type: PermissionType.camera,
      );
  
  factory PermissionFailure.storage() => const PermissionFailure(
        message: '저장소 권한이 필요합니다',
        code: 'STORAGE_PERMISSION_DENIED',
        type: PermissionType.storage,
      );
  
  factory PermissionFailure.notification() => const PermissionFailure(
        message: '알림 권한이 필요합니다',
        code: 'NOTIFICATION_PERMISSION_DENIED',
        type: PermissionType.notification,
      );
}

enum PermissionType {
  location,
  camera,
  storage,
  notification,
  unknown,
}

/// Parse failures
class ParseFailure extends Failure {
  const ParseFailure({
    super.message = '데이터 파싱 오류가 발생했습니다',
    super.code = 'PARSE_ERROR',
    super.originalError,
    super.stackTrace,
  });
  
  factory ParseFailure.json() => const ParseFailure(
        message: 'JSON 파싱 오류가 발생했습니다',
        code: 'JSON_PARSE_ERROR',
      );
}

/// Feature not available failures
class FeatureNotAvailableFailure extends Failure {
  const FeatureNotAvailableFailure({
    super.message = '이 기능은 현재 사용할 수 없습니다',
    super.code = 'FEATURE_NOT_AVAILABLE',
    super.originalError,
    super.stackTrace,
  });
}

/// Unknown failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = '알 수 없는 오류가 발생했습니다',
    super.code = 'UNKNOWN_ERROR',
    super.originalError,
    super.stackTrace,
  });
}

/// Extension to convert exceptions to failures
extension ExceptionToFailure on Exception {
  Failure toFailure() {
    // You can add more specific exception handling here
    return UnknownFailure(
      originalError: this,
      stackTrace: StackTrace.current,
    );
  }
}

/// Result type for handling success and failure cases
class Result<T> {
  final T? data;
  final Failure? failure;
  
  const Result._({this.data, this.failure});
  
  factory Result.success(T data) => Result._(data: data);
  factory Result.failure(Failure failure) => Result._(failure: failure);
  
  bool get isSuccess => data != null;
  bool get isFailure => failure != null;
  
  /// Execute function based on result
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    if (isSuccess) {
      return onSuccess(data as T);
    } else {
      return onFailure(failure!);
    }
  }
  
  /// Map success value
  Result<R> map<R>(R Function(T data) mapper) {
    if (isSuccess) {
      return Result.success(mapper(data as T));
    } else {
      return Result.failure(failure!);
    }
  }
  
  /// FlatMap for chaining operations
  Result<R> flatMap<R>(Result<R> Function(T data) mapper) {
    if (isSuccess) {
      return mapper(data as T);
    } else {
      return Result.failure(failure!);
    }
  }
  
  /// Get data or throw
  T getOrThrow() {
    if (isSuccess) {
      return data as T;
    } else {
      throw failure!;
    }
  }
  
  /// Get data or default
  T getOrElse(T defaultValue) {
    return data ?? defaultValue;
  }
}