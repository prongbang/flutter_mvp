import 'package:flutter/material.dart';
import 'package:flutter_mvp/api/api.dart';
import 'package:flutter_mvp/interactor/user_interactor.dart';
import 'package:flutter_mvp/model/network_status.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/presenter/user_presenter.dart';
import 'package:flutter_mvp/view/user/user_contract.dart';

class UserWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: UserStateWidget(),
    );
  }
}

class UserStateWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserListState();
  }
}

class UserListState extends State<UserStateWidget> with WidgetsBindingObserver implements UserContractView {
  UserPresenter _presenter;

  List<User> _users;
  bool _isLoading;

  UserListState() {
    _presenter = UserPresenter(UserInteractor(ApiService()));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isLoading = true;
    _presenter.bind(this);
    _presenter.loadUser(10);
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isLoading) {
      widget = Center(
          child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: CircularProgressIndicator()));
    } else {
      widget = ListView(children: <Widget>[Column(children: _buildUserList())]);
    }

    return widget;
  }

  List<_UserListItem> _buildUserList() {
    return _users.map((contact) => _UserListItem(contact)).toList();
  }

  @override
  void onError(Exception e) {
    // TODO: implement onError
  }

  @override
  void onNetwork(NetworkStatus network) {
    if (NetworkStatus.STRONG == network) {
    } else if (NetworkStatus.WEAK == network) {
    } else {}
  }

  @override
  void onSuccess(List<User> response) {
    print(response);

    setState(() {
      _users = response;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    print("-> dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _presenter.unbind();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print("-> inactive");
        break;
      case AppLifecycleState.paused:
        print("-> paused");
        break;
      case AppLifecycleState.resumed:
        print("-> resumed");
        break;
      case AppLifecycleState.suspending:
        print("-> suspending");
        break;
    }
  }
}

class _UserListItem extends ListTile {
  _UserListItem(User user)
      : super(
            title: Text(user.fullName),
            subtitle: Text(user.email),
            leading: CircleAvatar(child: Text(user.fullName[0])));
}
