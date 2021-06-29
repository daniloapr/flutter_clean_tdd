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

// class HttpClientSpy extends Mock implements HttpClient {
//   // @override
//   // Future<void> request({required String url, required String method}) async {
//   //   await Future.delayed(Duration(milliseconds: 1));
//   // }
// }

@GenerateMocks([HttpClient])
void main() {
  /// Triple A (AAA): Arrange - Act - Assert
  ///
  // late HttpClientSpy httpClient;
  // late String url;
  // // SUT = system under test
  // late RemoteAuthentication sut;

  setUp(() {
    // httpClient = HttpClientSpy();
    // url = faker.internet.httpUrl();
    // sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });
  test('Should call HttpClient with correct values', () async {
    final httpClient = MockHttpClient();

    final url = faker.internet.httpUrl();
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    await sut.auth();

    verify(httpClient.request(url: url, method: 'post'));
  });
}
