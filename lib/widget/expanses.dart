import 'package:earn/widget/chart/chart.dart';
import 'package:earn/model/expanse.dart';
import 'package:earn/widget/expanse_list/expanses_list.dart';
import 'package:earn/widget/new_expanse.dart';
import 'package:flutter/material.dart';

class Expanses extends StatefulWidget {
  const Expanses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Expanses();
  }
}

class _Expanses extends State<Expanses> {
  final List<Expanse> _registeredExpanse = [
    Expanse(
        title: 'flutter course',
        amount: 20.31,
        date: DateTime.now(),
        category: Category.work),
    Expanse(
        title: 'movie',
        amount: 15.25,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void openBottomOverlay() {
    showModalBottomSheet<void>(
        backgroundColor: Color.fromARGB(255, 45, 141, 123),
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpanse(
              onAddexpanse: addExpanse,
            ));
  }

  void addExpanse(Expanse expanse) {
    setState(() {
      _registeredExpanse.add(expanse);
    });
  }

  void removeExpanse(Expanse expanse) {
    final expanseIndex = _registeredExpanse.indexOf(expanse);
    setState(() {
      _registeredExpanse.remove(expanse);
    });
    ScaffoldMessenger.of(context)
        .clearSnackBars(); //immediately remove snackbars;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('delete expanse'),
        action: SnackBarAction(
            label: 'undo',
            onPressed: () {
              setState(() {
                _registeredExpanse.insert(expanseIndex, expanse);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('no expanse found add some expanse!'),
    );
    if (_registeredExpanse.isNotEmpty) {
      mainContent = ExpanseList(
        expanse: _registeredExpanse,
        onRemoveExpanse: removeExpanse,
      );
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Expanse Tracker app',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: openBottomOverlay,
              iconSize: 30,
              padding: const EdgeInsets.only(left: 0,top: 0,right: 20,bottom: 0),
              icon: const Icon(
                Icons.add,
              
                color: Color.fromARGB(255, 45, 141, 123),
                ),
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.black],
                end: Alignment.topLeft,
                begin: Alignment.topRight),
          ),
          child: Column(
            children: [
              Chart(expenses: _registeredExpanse),
              Expanded(child: mainContent)
            ],
          ),
        ));
  }
}
