import 'dart:io';
import 'dart:typed_data';

import '../entity/download_url_info.dart';
import '../entity/guessit_info.dart';
import '../entity/opensubtitles_api_exception.dart';
import '../network/network_requests.dart';
import '../constants/api_constants.dart';

class FilesService {
  final NetworkRequests _networkRequests;
  final Map<String, String> _headers;
  String _apiUrl = ApiConstants.defaultApiUrl;
  String? _authToken;

  FilesService(this._networkRequests, this._headers);

  set apiUrl(String value) => _apiUrl = value;
  set authToken(String value) => _authToken = value;

  Future<DownloadUrlInfo?> getDownloadUrl({
    required int fileId,
    String? subFormat,
    String? fileName,
    double? inFps,
    double? outFps,
    double? timeShift,
    String? token,
    String? baseUrl,
  }) async {
    final url =
        '${baseUrl != null ? 'https://${baseUrl}/api/v1' : _apiUrl}/download';
    final body = {
      'file_id': fileId,
      if (subFormat != null) 'sub_format': subFormat,
      if (fileName != null) 'file_name': fileName,
      if (inFps != null) 'in_fps': inFps,
      if (outFps != null) 'out_fps': outFps,
      if (timeShift != null) 'timeshift': timeShift,
    };
    final uri = Uri.parse(url);
    final authorization = token ?? _authToken;
    if (authorization != null) {
      Map<String, String> headers = Map.from(_headers);
      headers['Authorization'] = 'Bearer $authorization';
      final response = await _networkRequests.postApiRequest(
        uri: uri,
        body: body,
        headers: headers,
      );
      if (response == null) return null;
      return DownloadUrlInfo.fromMap(response);
    }
    return null;
  }

  Future<String?> forceDownload({
    required int fileId,
    String? subFormat,
    String? fileName,
    double? inFps,
    double? outFps,
    double? timeShift,
    String? token,
    String? baseUrl,
  }) async {
    final url =
        '${baseUrl != null ? 'https://${baseUrl}/api/v1' : _apiUrl}/download';
    final body = {
      'file_id': fileId,
      if (subFormat != null) 'sub_format': subFormat,
      if (fileName != null) 'file_name': fileName,
      if (inFps != null) 'in_fps': inFps,
      if (outFps != null) 'out_fps': outFps,
      if (timeShift != null) 'timeshift': timeShift,
      'force_download': true,
    };
    final uri = Uri.parse(url);
    final authorization = token;
    if (authorization != null) {
      Map<String, String> headers = Map.from(_headers);
      headers['Authorization'] = 'Bearer $authorization';
      headers['Content-Type'] = "application/force-download";
      headers['Accept'] = "application/force-download";
      final response = await _networkRequests.postRawApiRequest(
        uri: uri,
        body: body,
        headers: headers,
      );
      return response;
    }
    return null;
  }

  Future<String> getOpenSubtitlesHash({
    required String pathOrUrl,
    int? fileSize,
  }) async {
    const int chunkSize = 64 * 1024; // 64 KB
    Uint8List firstChunk;
    Uint8List lastChunk;
    int totalFileSize;

    if (pathOrUrl.startsWith("http")) {
      totalFileSize =
          fileSize ?? (await _networkRequests.getFileSize(url: pathOrUrl)) ?? 0;
      if (totalFileSize == 0) {
        throw OpensubtitlesApiException("Failed to get file size!");
      }

      firstChunk = await _networkRequests.fetchPartialContent(
        url: pathOrUrl,
        start: 0,
        end: chunkSize - 1,
      );
      lastChunk = await _networkRequests.fetchPartialContent(
        url: pathOrUrl,
        start: totalFileSize - chunkSize,
        end: totalFileSize - 1,
      );
    } else {
      final file = File(pathOrUrl);
      if (!(await file.exists())) {
        throw OpensubtitlesApiException("File not found: $pathOrUrl");
      }
      totalFileSize = await file.length();

      if (totalFileSize < chunkSize * 2) {
        throw OpensubtitlesApiException(
          "File is too small for OpenSubtitles Hash",
        );
      }

      final raf = await file.open();
      firstChunk = await raf.read(chunkSize);
      await raf.setPosition(totalFileSize - chunkSize);
      lastChunk = await raf.read(chunkSize);
      await raf.close();
    }

    int hash = totalFileSize;
    ByteData firstData = ByteData.sublistView(firstChunk);
    ByteData lastData = ByteData.sublistView(lastChunk);

    for (int i = 0; i < chunkSize; i += 8) {
      hash += firstData.getUint64(i, Endian.little);
      hash += lastData.getUint64(i, Endian.little);
    }

    String hashHex = hash.toUnsigned(64).toRadixString(16);
    return hashHex.padLeft(16, '0');
  }

  Future<GuessitInfo?> guessit({required String filename}) async {
    final url = '$_apiUrl/utilities/guessit';
    final queryParams = <String, String>{'filename': filename};
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    final response = await _networkRequests.getApiRequest(
      uri: uri,
      headers: _headers,
    );
    if (response == null) return null;
    return GuessitInfo.fromMap(response);
  }
}
