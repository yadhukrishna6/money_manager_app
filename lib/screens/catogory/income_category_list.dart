import 'package:flutter/material.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';

class IncomeCatogoryList extends StatelessWidget {
  const IncomeCatogoryList({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CatogoryDB().incomeCategoryListListener,
        builder: (BuildContext ctx, List<Categorymodel> newlist, Widget? _) {
          return ListView.separated(
            itemBuilder: (cxt, index) {
              final catogory = newlist[index];

              return Card(
                child: ListTile(
                  title: Text(catogory.name),
                  trailing: IconButton(
                    onPressed: () {
                      CatogoryDB.instance.deleteCategory(catogory.id);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            },
            separatorBuilder: (cxt, index) {
              return const SizedBox(height: 10);
            },
            itemCount: newlist.length,
          );
        });
  }
}
