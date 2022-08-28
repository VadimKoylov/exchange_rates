// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$isLoadingAtom =
      Atom(name: '_HomeStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isSuccessAtom =
      Atom(name: '_HomeStore.isSuccess', context: context);

  @override
  bool get isSuccess {
    _$isSuccessAtom.reportRead();
    return super.isSuccess;
  }

  @override
  set isSuccess(bool value) {
    _$isSuccessAtom.reportWrite(value, super.isSuccess, () {
      super.isSuccess = value;
    });
  }

  late final _$convertAtom = Atom(name: '_HomeStore.convert', context: context);

  @override
  ConvertModel? get convert {
    _$convertAtom.reportRead();
    return super.convert;
  }

  @override
  set convert(ConvertModel? value) {
    _$convertAtom.reportWrite(value, super.convert, () {
      super.convert = value;
    });
  }

  late final _$currencyAtom =
      Atom(name: '_HomeStore.currency', context: context);

  @override
  String get currency {
    _$currencyAtom.reportRead();
    return super.currency;
  }

  @override
  set currency(String value) {
    _$currencyAtom.reportWrite(value, super.currency, () {
      super.currency = value;
    });
  }

  late final _$amountAtom = Atom(name: '_HomeStore.amount', context: context);

  @override
  String get amount {
    _$amountAtom.reportRead();
    return super.amount;
  }

  @override
  set amount(String value) {
    _$amountAtom.reportWrite(value, super.amount, () {
      super.amount = value;
    });
  }

  late final _$percentAtom = Atom(name: '_HomeStore.percent', context: context);

  @override
  String get percent {
    _$percentAtom.reportRead();
    return super.percent;
  }

  @override
  set percent(String value) {
    _$percentAtom.reportWrite(value, super.percent, () {
      super.percent = value;
    });
  }

  late final _$updatingTimeAtom =
      Atom(name: '_HomeStore.updatingTime', context: context);

  @override
  DateTime? get updatingTime {
    _$updatingTimeAtom.reportRead();
    return super.updatingTime;
  }

  @override
  set updatingTime(DateTime? value) {
    _$updatingTimeAtom.reportWrite(value, super.updatingTime, () {
      super.updatingTime = value;
    });
  }

  late final _$getRationAsyncAction =
      AsyncAction('_HomeStore.getRation', context: context);

  @override
  Future<void> getRation() {
    return _$getRationAsyncAction.run(() => super.getRation());
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void setCurrency(String value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setCurrency');
    try {
      return super.setCurrency(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmount(String value) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.setAmount');
    try {
      return super.setAmount(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDifference(String oldCurrency, String newCurrency) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setDifference');
    try {
      return super.setDifference(oldCurrency, newCurrency);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isSuccess: ${isSuccess},
convert: ${convert},
currency: ${currency},
amount: ${amount},
percent: ${percent},
updatingTime: ${updatingTime}
    ''';
  }
}
