import 'package:flutter/material.dart';
import 'package:money_manager_flutter/db/category/category_db.dart';
import 'package:money_manager_flutter/screens/catogory/expense_category_list.dart';
import 'package:money_manager_flutter/screens/catogory/income_category_list.dart';

class ScreenCatogory extends StatefulWidget {
  const ScreenCatogory({super.key});

  @override
  State<ScreenCatogory> createState() => _ScreenCatogoryState();
}

class _ScreenCatogoryState extends State<ScreenCatogory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CatogoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'INCOME'),
              Tab(text: 'EXPENSE'),
            ]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              IncomeCatogoryList(),
              ExpenseCatogoryList(),
            ],
          ),
        ),
      ],
    );
  }
}
