import 'package:flutter_mvp/api/api.dart';
import 'package:flutter_mvp/interactor/user_interactor.dart';
import 'package:flutter_mvp/presenter/user_presenter.dart';

class Injector {

  static UserPresenter provideUserPresenter() {
    return UserPresenter(provideUserInteractor());
  }

  static ApiService provideApiService() {
    return ApiService();
  }

  static UserInteractor provideUserInteractor() {
    return UserInteractor(provideApiService());
  }

}