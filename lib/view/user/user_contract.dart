import 'dart:async';

import 'package:flutter_mvp/interactor/base_interactor.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/presenter/base_presenter.dart';
import 'package:flutter_mvp/view/base/base_contract_view.dart';
import 'package:http/http.dart';

abstract class UserContractInteractor extends BaseInteractor {
  Future<Response> loadUser(int size);
}

abstract class UserContractPresenter extends BasePresenter<UserContractView> {
  void loadUser(int size);
}

abstract class UserContractView extends BaseContractView {
  void onSuccess(List<User> response);
}
