import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  test('Should call HttClient with correct URL', () async {
    /// Triple A (AAA): Arrange - Act - Assert
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    // SUT = system under test
    final sut = RemoteAuthentication(httpClient: httpClient, url: url);
    await sut.auth();

    verify(httpClient.request(url: url));
  });
}

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({
    required this.httpClient,
    required this.url,
  });

  Future<void> auth() async {
    await httpClient.request(url: url);
  }
}

abstract class HttpClient {
  Future<void> request({required url}) async {}
}

class HttpClientSpy extends Mock implements HttpClient {}
