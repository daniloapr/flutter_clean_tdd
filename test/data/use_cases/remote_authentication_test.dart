import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'remote_authentication_test.mocks.dart';
import 'package:mockito/mockito.dart';

/// https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future<void> auth() async {
    await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request({
    required String url,
    required String method,
  });
}

@GenerateMocks([HttpClient])
void main() {
  /// Triple A (AAA): Arrange - Act - Assert
  ///
  late HttpClient httpClient;
  late String url;
  // SUT = system under test
  late RemoteAuthentication sut;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });
  test('Should call HttpClient with correct values', () async {
    await sut.auth();

    verify(httpClient.request(url: url, method: 'post'));
  });
}
