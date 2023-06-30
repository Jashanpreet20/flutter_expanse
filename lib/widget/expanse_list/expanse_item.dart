
import 'package:earn/model/expanse.dart';
import 'package:flutter/material.dart';


class ExpasneItem extends StatelessWidget{
  const ExpasneItem(this.expanse,{super.key});

  final Expanse expanse;
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(expanse.title,
            style: Theme.of(context).textTheme.titleLarge,),
        const SizedBox(height: 4,),
        Row(children: [
          Text('\$${expanse.amount.toStringAsFixed(2)}'),
          const Spacer(),
          Row(children: [
             Icon(CategoryIcons[expanse.category]),
            Text(expanse.formatdate)
          ],)
        ],)
      ],),
    ),);
  }
}