import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Custom log output that handles different platforms
class _ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      // In debug mode, use debugPrint for better formatting
      if (kDebugMode) {
        debugPrint(line);
      }
    }
  }
}

/// Custom log printer with improved formatting
class _CustomPrinter extends PrettyPrinter {
  _CustomPrinter()
      : super(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
        );

  @override
  List<String> log(LogEvent event) {
    final String emoji = _getEmoji(event.level);
    final String levelStr = _getLevelString(event.level);
    final String timestamp = DateTime.now().toIso8601String().substring(11, 19);
    final String message = event.message.toString();
    
    final List<String> output = [];
    
    // Format header
    output.add('$emoji $timestamp [$levelStr] $message');
    
    // Add error details if present
    if (event.error != null) {
      output.add('  ⮡ Error: ${event.error}');
    }
    
    // Add stack trace for errors
    if (event.stackTrace != null && event.level == Level.error) {
      final String stackTrace = event.stackTrace.toString();
      final List<String> lines = stackTrace.split('\n');
      
      // Only show first few lines of stack trace in production
      final int maxLines = kReleaseMode ? 3 : 10;
      for (int i = 0; i < lines.length && i < maxLines; i++) {
        output.add('  ⮡ ${lines[i]}');
      }
      
      if (lines.length > maxLines) {
        output.add('  ⮡ ... (${lines.length - maxLines} more lines)');
      }
    }
    
    return output;
  }
  
  String _getEmoji(Level level) {
    switch (level) {
      case Level.trace:
        return '🔍';
      case Level.debug:
        return '🐛';
      case Level.info:
        return 'ℹ️';
      case Level.warning:
        return '⚠️';
      case Level.error:
        return '❌';
      case Level.fatal:
        return '💀';
      default:
        return '📝';
    }
  }
  
  String _getLevelString(Level level) {
    switch (level) {
      case Level.trace:
        return 'TRACE';
      case Level.debug:
        return 'DEBUG';
      case Level.info:
        return 'INFO';
      case Level.warning:
        return 'WARN';
      case Level.error:
        return 'ERROR';
      case Level.fatal:
        return 'FATAL';
      default:
        return 'LOG';
    }
  }
}

/// Production log filter that respects log levels
class _ProductionFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // In release mode, only log warnings and above
    if (kReleaseMode) {
      return event.level.index >= Level.warning.index;
    }
    
    // In debug mode, log everything
    return true;
  }
}

/// Global logger instance
final Logger _logger = Logger(
  filter: _ProductionFilter(),
  printer: _CustomPrinter(),
  output: _ConsoleOutput(),
);

/// Static logging utility class
/// Provides convenient static methods for logging at different levels
class Log {
  Log._();
  
  /// Log trace message (most verbose)
  static void t(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.t(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log debug message
  static void d(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log info message
  static void i(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log warning message
  static void w(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log error message
  static void e(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log fatal error message
  static void f(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }
  
  /// Log network request
  static void network({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
    int? statusCode,
    dynamic response,
    Duration? duration,
    dynamic error,
  }) {
    final StringBuffer buffer = StringBuffer();
    
    buffer.write('$method $url');
    
    if (statusCode != null) {
      buffer.write(' [$statusCode]');
    }
    
    if (duration != null) {
      buffer.write(' (${duration.inMilliseconds}ms)');
    }
    
    if (error != null) {
      _logger.e(buffer.toString(), error: error);
    } else if (statusCode != null && statusCode >= 400) {
      _logger.w(buffer.toString());
      if (response != null && kDebugMode) {
        _logger.w('Response: $response');
      }
    } else {
      _logger.d(buffer.toString());
      
      if (kDebugMode) {
        if (headers != null) {
          _logger.t('Headers: $headers');
        }
        if (body != null) {
          _logger.t('Body: $body');
        }
        if (response != null) {
          _logger.t('Response: $response');
        }
      }
    }
  }
  
  /// Log performance metric
  static void performance({
    required String operation,
    required Duration duration,
    Map<String, dynamic>? metadata,
  }) {
    final StringBuffer buffer = StringBuffer();
    buffer.write('Performance: $operation took ${duration.inMilliseconds}ms');
    
    if (metadata != null && metadata.isNotEmpty) {
      buffer.write(' | ');
      buffer.write(metadata.entries.map((e) => '${e.key}: ${e.value}').join(', '));
    }
    
    if (duration.inMilliseconds > 1000) {
      _logger.w(buffer.toString());
    } else {
      _logger.d(buffer.toString());
    }
  }
  
  /// Log analytics event
  static void analytics({
    required String event,
    Map<String, dynamic>? parameters,
  }) {
    final StringBuffer buffer = StringBuffer();
    buffer.write('Analytics: $event');
    
    if (parameters != null && parameters.isNotEmpty) {
      buffer.write(' | ');
      buffer.write(parameters.entries.map((e) => '${e.key}: ${e.value}').join(', '));
    }
    
    _logger.d(buffer.toString());
  }
  
  /// Create a custom logger with specific configuration
  static Logger custom({
    Level? level,
    LogFilter? filter,
    LogPrinter? printer,
    LogOutput? output,
  }) {
    return Logger(
      level: level,
      filter: filter ?? _ProductionFilter(),
      printer: printer ?? _CustomPrinter(),
      output: output ?? _ConsoleOutput(),
    );
  }
}

/// Extension methods for convenience logging
extension LoggerExtension on Object {
  /// Log this object as debug message
  void logDebug() => Log.d(toString());
  
  /// Log this object as info message
  void logInfo() => Log.i(toString());
  
  /// Log this object as warning message
  void logWarning() => Log.w(toString());
  
  /// Log this object as error message
  void logError([dynamic error, StackTrace? stackTrace]) =>
      Log.e(toString(), error: error, stackTrace: stackTrace);
}

/// Stopwatch utility for measuring execution time
class LogStopwatch {
  final String operation;
  final Stopwatch _stopwatch;
  final Map<String, dynamic> metadata;
  
  LogStopwatch(this.operation, {Map<String, dynamic>? metadata})
      : _stopwatch = Stopwatch()..start(),
        metadata = metadata ?? {};
  
  /// Add metadata to the measurement
  void addMetadata(String key, dynamic value) {
    metadata[key] = value;
  }
  
  /// Stop the stopwatch and log the result
  Duration stop() {
    _stopwatch.stop();
    
    Log.performance(
      operation: operation,
      duration: _stopwatch.elapsed,
      metadata: metadata.isNotEmpty ? metadata : null,
    );
    
    return _stopwatch.elapsed;
  }
  
  /// Get elapsed time without stopping
  Duration get elapsed => _stopwatch.elapsed;
  
  /// Check if stopwatch is running
  bool get isRunning => _stopwatch.isRunning;
}