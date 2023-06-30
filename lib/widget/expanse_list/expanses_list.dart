import 'package:earn/model/expanse.dart';
import 'package:earn/widget/expanse_list/expanse_item.dart';
import 'package:flutter/material.dart';

class ExpanseList extends StatelessWidget {
  const ExpanseList({super.key, required this.expanse,required this.onRemoveExpanse});
  final List<Expanse> expanse;
  final void Function(Expanse expansse) onRemoveExpanse;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expanse.length,
        itemBuilder: (ctx, index) => Dismissible(key: ValueKey(expanse[index]),
        background: Container(color: Colors.redAccent,),
        onDismissed: (direction){
          onRemoveExpanse(expanse[index]);
        },
         child: ExpasneItem(expanse[index]))
        );
  }
}
