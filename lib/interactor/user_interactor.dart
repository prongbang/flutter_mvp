import 'dart:async';

import 'package:flutter_mvp/api/api.dart';
import 'package:flutter_mvp/view/user/user_contract.dart';
import 'package:http/http.dart';

class UserInteractor implements UserContractInteractor {

  ApiService _api;

  UserInteractor(this._api);

  @override
  Future<Response> loadUser(int size) {
    return _api.loadUser(size);
  }
}
