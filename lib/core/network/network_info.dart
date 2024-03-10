import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo{
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo{
  final InternetConnectionChecker checker;

  NetworkInfoImpl({required this.checker});

  @override
  Future<bool> isConnected() {
    return  checker.hasConnection;
  }

}