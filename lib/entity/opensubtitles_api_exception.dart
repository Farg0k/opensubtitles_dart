class OpensubtitlesApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  OpensubtitlesApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() =>
      'OpensubtitlesApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}
