import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_rates/api/api.dart';
import 'package:exchange_rates/model/convert_model.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore();

  final List<String> couples = [
    "USDRUB",
    "USDEUR",
    "EURRUB",
    "EURUSD",
    "RUBUSD",
    "RUBEUR",
  ];

  @observable
  bool isLoading = false;

  @observable
  bool isSuccess = true;

  @observable
  ConvertModel? convert;

  @observable
  String currency = "USDRUB";

  String from = "USD";

  String to = "RUB";

  @observable
  String amount = "";

  @observable
  String percent = "";

  @observable
  DateTime? updatingTime;

  int growing = 0;

  @action
  void setCurrency(String value) => currency = value;

  @action
  void setAmount(String value) => amount = value;

  @action
  void setDifference(String oldCurrency, String newCurrency) {
    growing = newCurrency.compareTo(oldCurrency);
    final amountPercent = getPercent(growing, oldCurrency, newCurrency);
    percent = getDifference(growing, amountPercent, from);
  }

  @action
  Future<void> getRation() async {
    try {
      isLoading = true;
      getCurrencyCode();
      final yesterday = DateFormat("yyyy-MM-dd")
          .format(DateTime.now().subtract(const Duration(days: 1)));
      final today = DateFormat("yyyy-MM-dd").format(DateTime.now());
      convert = await Api()
          .getRatio(startDate: yesterday, endDate: today, from: from, to: to);
      final newCurrency = jsonDecode(const JsonEncoder.withIndent('  ')
          .convert(convert!.quotes[yesterday]));
      final oldCurrency = jsonDecode(
          const JsonEncoder.withIndent('  ').convert(convert!.quotes[today]));
      final currencyKey = from + to;
      setDifference(oldCurrency[currencyKey].toString(),
          newCurrency[from + to].toString());
      setAmount((newCurrency[currencyKey] as double).toStringAsFixed(3));
      isLoading = false;
      isSuccess = true;
    } catch (e, trace) {
      log("ERROR: ${e.toString()}");
      log("ERROR: ${trace.toString()}");
      isSuccess = false;
    }
  }

  String getDifference(int compare, String _amount, String _currency) {
    switch (compare) {
      case -1:
        return "change".tr(args: [_currency.tr(), "fell", _amount]);
      case 0:
        return "same".tr(args: [_currency.tr()]);
      case 1:
        return "change".tr(args: [_currency.tr(), "grow", _amount]);
      default:
        return "";
    }
  }

  void getCurrencyCode() {
    switch (currency) {
      case "USDRUB":
        from = "USD";
        to = "RUB";
        break;
      case "USDEUR":
        from = "USD";
        to = "EUR";
        break;
      case "EURRUB":
        from = "EUR";
        to = "RUB";
        break;
      case "EURUSD":
        from = "EUR";
        to = "USD";
        break;
      case "RUBUSD":
        from = "RUB";
        to = "USD";
        break;
      case "RUBEUR":
        from = "RUB";
        to = "EUR";
        break;
    }
  }

  String getPercent(int value, String oldCurrency, String newCurrency) {
    switch (value) {
      case -1:
        return (100 -
                (double.parse(newCurrency) * 100 ~/ double.parse(oldCurrency)))
            .toString();
      case 1:
        return (100 -
                (double.parse(oldCurrency) * 100 ~/ double.parse(newCurrency)))
            .toString();
    }
    return "0";
  }

  List<String> getCurrency(String value) =>
      [value.substring(0, 3), value.substring(3, 6)];
}

HomeStore homeStore = HomeStore();

HomeStore get getHomeStore => homeStore;
