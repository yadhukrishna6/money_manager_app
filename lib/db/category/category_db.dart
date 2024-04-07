import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_flutter/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CatogoryDbFunctions {
  Future<List<Categorymodel>> getCategories();
  Future<void> insertCategory(Categorymodel value);
  Future<void> deleteCategory(String categoryID);
}

class CatogoryDB implements CatogoryDbFunctions {
  CatogoryDB._internal();
  static CatogoryDB instance = CatogoryDB._internal();
  factory CatogoryDB() {
    return instance;
  }
  ValueNotifier<List<Categorymodel>> incomeCategoryListListener =
      ValueNotifier([]);
  ValueNotifier<List<Categorymodel>> expenseCategoryListListener =
      ValueNotifier([]);
  @override
  Future<void> insertCategory(Categorymodel value) async {
    final _categoryDB = await Hive.openBox<Categorymodel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<Categorymodel>> getCategories() async {
    final _categoryDB = await Hive.openBox<Categorymodel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    await Future.forEach(
      _allCategories,
      (Categorymodel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListener.value.add(category);
        } else {
          expenseCategoryListListener.value.add(category);
        }
      },
    );
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<Categorymodel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(categoryID);
    refreshUI();
  }
}
