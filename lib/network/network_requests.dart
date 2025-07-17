import 'dart:convert' as convert;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../entity/opensubtitles_api_exception.dart';

/// Makes an API request with the specified parameters.
///
/// [uri] - The URI to send the request to
/// [headers] - The headers to include in the request
/// [body] - Optional request body
/// [delete] - Whether this is a DELETE request
///
/// Returns the parsed JSON response or null if the request fails.
/// Throws [OpensubtitlesApiException] if the request fails.
class NetworkRequests {
  NetworkRequests();
  Future<Uint8List> fetchPartialContent({
    required String url,
    required int start,
    required int end,
  }) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Range': 'bytes=$start-$end'},
    );

    if (response.statusCode == 206 || response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw OpensubtitlesApiException(
        "Server does not support Range requests or returned an error",
      );
    }
  }

  Future<int?> getFileSize({required String url}) async {
    final response = await http.head(Uri.parse(url));
    final contentLength = response.headers['content-length'];
    return contentLength != null ? int.tryParse(contentLength) : null;
  }

  Future<Map<String, dynamic>?> getApiRequest({
    required Uri uri,
    required Map<String, String> headers,
  }) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        throw OpensubtitlesApiException(
          'API request failed',
          statusCode: response.statusCode,
          data: response.body,
        );
      }
    } catch (e) {
      if (e is OpensubtitlesApiException) rethrow;
      throw OpensubtitlesApiException('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> postApiRequest({
    required Uri uri,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: convert.jsonEncode(body),
      );
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        throw OpensubtitlesApiException(
          'API request failed',
          statusCode: response.statusCode,
          data: response.body,
        );
      }
    } catch (e) {
      if (e is OpensubtitlesApiException) rethrow;
      throw OpensubtitlesApiException('Network error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> deleteApiRequest({
    required Uri uri,
    required Map<String, String> headers,
  }) async {
    try {
      final response = await http.delete(uri, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        return jsonResponse;
      } else {
        throw OpensubtitlesApiException(
          'API request failed',
          statusCode: response.statusCode,
          data: response.body,
        );
      }
    } catch (e) {
      if (e is OpensubtitlesApiException) rethrow;
      throw OpensubtitlesApiException('Network error: ${e.toString()}');
    }
  }

  /// Makes a raw POST request to the API.
  ///
  /// [uri] - The URI to send the request to
  /// [headers] - The headers to include in the request
  /// [body] - Optional request body
  ///
  /// Returns the raw response body as a string or null if the request fails.
  Future<String?> postRawApiRequest({
    required Uri uri,
    required Map<String, String> headers,
    Map<String, dynamic>? body,
  }) async {
    final response = await http.post(
      uri,
      headers: headers,
      body: convert.jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }
}
