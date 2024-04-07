import 'package:flutter/material.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';
import 'package:money_manager_flutter/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_manager_flutter/screens/catogory/category_add_popup.dart';
import 'package:money_manager_flutter/screens/catogory/screen_catogory.dart';
import 'package:money_manager_flutter/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager_flutter/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [
    ScreenTransaction(),
    ScreenCatogory(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 225, 225),
      appBar: AppBar(
        title: Text('Money manager'),
        centerTitle: true,
      ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add transaction');
            Navigator.of(context).pushNamed(ScreenaddTransation.routeName);
          } else {
            print('Add category');
            showCategoryAddPopup(context);
            // final _sample = Categorymodel(
            //   id: DateTime.now().microsecondsSinceEpoch.toString(),
            //   name: 'Travel',
            //   type: CategoryType.expense,
            // );
            // CatogoryDB().insertCategory(_sample);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
