import 'package:calculator_domain_final/data/data.dart';
import 'package:calculator_domain_final/domain/domain.dart';
import 'package:calculator_domain_final/presentation/presentation.dart';
import 'package:calculator_domain_final/ui/widget/widget.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final ICalculatorLocalDataSource _calculatorLocalDataSource = CalculatorLocalDataSource();
  late final CalculatorDataSource _calculatorDataSource = CalculatorDataSource(_calculatorLocalDataSource);
  late final ICalculatorRepository _calculatorRepository = CalculatorRepository(_calculatorDataSource);
  late final FetchCalculatorUseCase _fetchCalculatorUseCase = FetchCalculatorUseCase(_calculatorRepository);
  late final SaveCalculatorUseCase _saveCalculatorUseCase = SaveCalculatorUseCase(_calculatorRepository);
  late final CalculatorViewModel _viewModel = CalculatorViewModel(
    _fetchCalculatorUseCase,
    _saveCalculatorUseCase,
    CalculatorEntity(),
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _viewModel.load();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculator'),
      ),
      body: ValueListenableBuilder<CalculatorEntity>(
        valueListenable: _viewModel,
        builder: (context, calculator, child) => Column(
          children: [
            CalculatorBoard(
              number: calculator.result,
            ),
            Row(
              children: [
                Expanded(
                  child: CalculatorButton.complex(
                    text: 'AC',
                    onTap: (buttonText) => _perform(
                      buttonText,
                      save: true,
                    ),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.complex(
                    text: '+/-',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.complex(
                    text: '<',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.operator(
                    text: '/',
                    operator: calculator.operator,
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CalculatorButton.simple(
                    text: '7',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.simple(
                    text: '8',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.simple(
                    text: '9',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.operator(
                    text: 'x',
                    operator: calculator.operator,
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CalculatorButton.simple(
                    text: '4',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.simple(
                    text: '5',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.simple(
                    text: '6',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.operator(
                    text: '-',
                    operator: calculator.operator,
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CalculatorButton.simple(
                    text: '1',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.simple(
                    text: '2',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.simple(
                    text: '3',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.operator(
                    text: '+',
                    operator: calculator.operator,
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CalculatorButton.simple(
                    text: '0',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.simple(
                    text: '.',
                    onTap: (buttonText) => _perform(buttonText),
                  ),
                ),
                Expanded(
                  child: CalculatorButton.operator(
                    text: '=',
                    onTap: (buttonText) => _perform(
                      buttonText,
                      save: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _perform(
    String buttonText, {
    bool save = false,
  }) async {
    _viewModel.calculate(buttonText);

    if (save) {
      await _viewModel.save();
    }
  }
}
