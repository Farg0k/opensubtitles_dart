import '../entity/user.dart';
import '../entity/user_status.dart';
import '../network/network_requests.dart';
import '../constants/api_constants.dart';

class AuthService {
  final NetworkRequests _networkRequests;
  final Map<String, String> _headers;
  String _apiUrl = ApiConstants.defaultApiUrl;
  String? _authToken;

  AuthService(this._networkRequests, this._headers);

  set apiUrl(String value) => _apiUrl = value;
  set authToken(String value) => _authToken = value;

  Future<UserStatus?> login({
    required String username,
    required String password,
  }) async {
    final url = '$_apiUrl/login';
    final body = {"username": username, "password": password};
    final uri = Uri.parse(url);
    final response = await _networkRequests.postApiRequest(
      uri: uri,
      body: body,
      headers: _headers,
    );
    UserStatus? userStatus =
        response != null ? UserStatus.fromMap(response) : null;
    if (userStatus != null) {
      _apiUrl = 'https://${userStatus.baseUrl}/api/v1';
      _authToken = userStatus.token;
      return userStatus;
    }
    return null;
  }

  Future<bool> logout({String? token, String? baseUrl}) async {
    final url =
        '${baseUrl != null ? 'https://${baseUrl}/logout' : _apiUrl}/logout';
    final authorization = token ?? _authToken;
    if (authorization != null) {
      final uri = Uri.parse(url);
      Map<String, String> headers = Map.from(_headers);
      headers['Authorization'] = 'Bearer $authorization';
      final response = await _networkRequests.deleteApiRequest(
        uri: uri,
        headers: headers,
      );
      return response?["status"] == 200;
    }
    return false;
  }

  Future<User?> getUserInformation({String? token, String? baseUrl}) async {
    final url =
        '${baseUrl != null ? 'https://${baseUrl}/api/v1' : _apiUrl}/infos/user';
    final authorization = token ?? _authToken;
    if (authorization != null) {
      final uri = Uri.parse(url);
      Map<String, String> headers = Map.from(_headers);
      headers['Authorization'] = 'Bearer $authorization';
      final response = await _networkRequests.getApiRequest(
        uri: uri,
        headers: headers,
      );
      if (response?['data'] != null) {
        return User.fromMap(response?['data']);
      }
    }
    return null;
  }
}
