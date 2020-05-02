import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:quiz/providers/bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc implements Bloc {
  final FacebookLogin fbLogin = FacebookLogin();

  final BehaviorSubject<String> _facebookResult = new BehaviorSubject<String>();
  final BehaviorSubject<String> _userName = new BehaviorSubject<String>();

  Stream<String> get facebookToken => _facebookResult.stream;
  Stream<String> get userName => _userName.stream;

  Future<Null> initiateFBLogin() async {
    var facebookLogin = FacebookLogin();
    var result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.error:
        _facebookResult.addError('Facebook auth error');
        print('Facebook auth error');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _facebookResult.addError('FB: cancelled by user');
        print('FB: cancelled by user');
        break;
      case FacebookLoginStatus.loggedIn:
        print('FB: logged in');
        _facebookResult.sink.add(result.accessToken.token);
        break;
    }
  }

  signOutFacebook() async {
    await fbLogin.logOut().then(_facebookResult.sink.add);
  }

  @override
  dispose(){
    _facebookResult.close();
    _userName.close();
  }
}