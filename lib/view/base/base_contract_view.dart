import 'package:flutter_mvp/model/network_status.dart';

abstract class BaseContractView {

  void onError(Exception e);

  void onNetwork(NetworkStatus network);
}
