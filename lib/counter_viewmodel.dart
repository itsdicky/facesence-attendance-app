import 'package:flutter/foundation.dart';

class CounterViewModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  WebApi _webApi = serviceLocator<WebApi>(); //  <-- service

  Future loadData() async { //                   <-- load initial data
    print(_webApi);
    _counter = await _webApi.fetchValue();
    notifyListeners();
  }

  void increment() {
    _counter++;
    notifyListeners();
  }
}

// Fake service locator. Use GetIt in a real app.
// Or inject the service in the view model constructor.
WebApi serviceLocator<T>() {
  return WebApi();
}

// Fake web api
class WebApi {
  Future<int> fetchValue() => Future.delayed(Duration(seconds: 2), () => 11);
}