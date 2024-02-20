import 'package:calculator_domain_starter/data/data.dart';
import 'package:flutter/foundation.dart';

class CalculatorViewModel extends ValueNotifier<CalculatorEntity> {
  final FetchCalculatorUseCase _fetchCalculatorUseCase;
  final SaveCalculatorUseCase _saveCalculatorUseCase;

  CalculatorViewModel(
    this._fetchCalculatorUseCase,
    this._saveCalculatorUseCase,
    super.calculator,
  );

  Future<void> load() async {
    value = await _fetchCalculatorUseCase.execute();
  }

  Future<void> save() async {
    await _saveCalculatorUseCase.execute(value);
  }

  void calculate(String buttonText) {
    value.calculate(buttonText);
    notifyListeners();
  }
}

class FetchCalculatorUseCase {
  Future<CalculatorEntity> execute() {
    return CalculatorRepository(CalculatorDataSource(CalculatorLocalDataSource())).fetch();
  }
}

class SaveCalculatorUseCase {
  Future<void> execute(CalculatorEntity entity) {
    return CalculatorRepository(CalculatorDataSource(CalculatorLocalDataSource())).save(entity);
  }
}
