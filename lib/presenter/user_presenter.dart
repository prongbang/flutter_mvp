import 'dart:async';
import 'dart:convert';

import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/utils/fetch_data_exception.dart';
import 'package:flutter_mvp/view/user/user_contract.dart';
import 'package:flutter_mvp/interactor/user_interactor.dart';
import 'package:http/http.dart';

class UserPresenter implements UserContractPresenter {
  UserContractView _view;
  UserInteractor _userInteractor;
  final JsonDecoder _decoder = new JsonDecoder();

  UserPresenter(this._userInteractor);

  @override
  void loadUser(int size) {
    _userInteractor.loadUser(size).then((Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw FetchDataException(
            "Error while getting contacts [StatusCode:$statusCode, Error:${response
                .reasonPhrase}]");
      }

      final userContainer = _decoder.convert(jsonBody);
      final List userItems = userContainer['results'];

      return userItems
          .map((contactRaw) => new User.fromMap(contactRaw))
          .toList();
    }).then((List<User> response) {
      if (_view != null) _view.onSuccess(response);
    }).catchError((onError) {
      if (_view != null) _view.onError(onError);
    });
  }

  @override
  void bind(UserContractView view) {
    _view = view;
  }

  @override
  void unbind() {
    _view = null;
  }
}
