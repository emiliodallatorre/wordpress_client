import 'package:dio/src/cancel_token.dart';

import '../../authorization.dart';
import '../../enums.dart';
import '../../responses/post_response.dart';
import '../../utilities/callback.dart';
import '../../utilities/helpers.dart';
import '../../utilities/pair.dart';
import '../request.dart';
import '../request_builder_base.dart';

class PostRetriveBuilder implements IRequestBuilder<PostRetriveBuilder, Post> {
  @override
  Authorization authorization;

  @override
  CancelToken cancelToken;

  @override
  String endpoint;

  @override
  List<Pair<String, String>> headers;

  @override
  List<Pair<String, String>> queryParameters;

  @override
  bool Function(Post) responseValidationDelegate;

  @override
  Callback callback;

  int _postId = -1;
  String _context = '';
  String _password;

  PostRetriveBuilder withPostId(int postId) {
    _postId = postId;
    endpoint += '/$_postId';
    return this;
  }

  PostRetriveBuilder withScope(FilterScope scope) {
    switch (scope) {
      case FilterScope.VIEW:
        _context = 'view';
        break;
      case FilterScope.EMBED:
        _context = 'embed';
        break;
      case FilterScope.EDIT:
        _context = 'edit';
        break;
    }

    return this;
  }

  PostRetriveBuilder withPassword(String password) {
    _password = password;
    return this;
  }

  @override
  Request<Post> build() {
    return Request<Post>(
      endpoint,
      callback: callback,
      httpMethod: HttpMethod.GET,
      validationDelegate: responseValidationDelegate,
      cancelToken: cancelToken,
      authorization: authorization,
      headers: headers,
      queryParams: _parseQueryParameters(),
    );
  }

  Map<String, String> _parseQueryParameters() {
    return {
      if (_postId >= 0) 'id': _postId.toString(),
      if (!isNullOrEmpty(_context)) 'context': _context,
      if (!isNullOrEmpty(_password)) 'password': _password,
      if (queryParameters != null && queryParameters.isNotEmpty)
        for (var pair in queryParameters)
          if (!isNullOrEmpty(pair.key) && !isNullOrEmpty(pair.value)) pair.key: pair.value
    };
  }

  @override
  PostRetriveBuilder initializeWithDefaultValues() {
    _postId = 0;
    return this;
  }

  @override
  PostRetriveBuilder withAuthorization(Authorization auth) {
    authorization = auth;
    return this;
  }

  @override
  PostRetriveBuilder withCancellationToken(CancelToken token) {
    cancelToken = token;
    return this;
  }

  @override
  PostRetriveBuilder withEndpoint(String newEndpoint) {
    endpoint = newEndpoint;
    return this;
  }

  @override
  PostRetriveBuilder withHeaders(Iterable<Pair<String, String>> customHeaders) {
    headers ??= [];
    headers.addAll(customHeaders);
    return this;
  }

  @override
  PostRetriveBuilder withQueryParameters(Iterable<Pair<String, String>> extraQueryParameters) {
    queryParameters ??= [];
    queryParameters.addAll(extraQueryParameters);
    return this;
  }

  @override
  PostRetriveBuilder withResponseValidationOverride(bool Function(Post) responseDelegate) {
    responseValidationDelegate = responseDelegate;
    return this;
  }

  @override
  PostRetriveBuilder withCallback(Callback requestCallback) {
    callback = requestCallback;
    return this;
  }
}