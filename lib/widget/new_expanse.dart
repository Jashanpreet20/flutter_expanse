import 'package:flutter/material.dart';
import 'package:earn/model/expanse.dart';

class NewExpanse extends StatefulWidget {
  const NewExpanse({super.key, required this.onAddexpanse});
  final void Function(Expanse expanse) onAddexpanse;
  @override
  State<StatefulWidget> createState() {
    return _NewExpanse();
  }
}

class _NewExpanse extends State<NewExpanse> {
  final titlecontroller = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selecteddatetime;
  Category _selectedcategoryitem = Category.leisure;

  void presentDatePicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);
    final datepicker = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);

    setState(() {
      _selecteddatetime = datepicker;
    });
  }

  void _sumbitExpanseData() {
    final titleValidation = titlecontroller.text.trim().isEmpty;
    final enteredAmount = double.tryParse(amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (titleValidation || amountIsValid || _selecteddatetime == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('please enter valid input'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('okay'))
          ],
        ),
      );
      return;
    }

    widget.onAddexpanse(Expanse(
        title: titlecontroller.text,
        amount: enteredAmount,
        date: _selecteddatetime!,
        category: _selectedcategoryitem));

        Navigator.pop(context);
  }

  @override
  void dispose() {
    titlecontroller.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16,48,16,16),
        child: Column(
          children: [
            TextField(
              maxLength: 50,
              controller: titlecontroller,
              decoration: const InputDecoration(label: Text('title')), 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    maxLength: 50,
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixText: '\$', label: Text('amount')),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(_selecteddatetime == null
                    ? 'no select date'
                    : format.format(_selecteddatetime!)),
                IconButton(
                    onPressed: presentDatePicker,
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                    value: _selectedcategoryitem,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase())))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedcategoryitem = value;
                      });
                    }),
                    const Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel')),
                ElevatedButton(
                    onPressed: _sumbitExpanseData,
                    child: const Text('save Expanse'))
              ],
            )
          ],
        ));
  }
}
