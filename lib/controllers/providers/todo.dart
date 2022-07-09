/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:flutter/material.dart';
import 'package:supabase_example/controllers/services/supabase_handler.dart';
import 'package:supabase_example/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  // initialize data
  String? _title;
  String? _dsc;
  List<TodoModel?> _listTodos = [];
  TodoModel? _selectedTodo;
  int? _loading = 0;

  // TODO: add supabase handler
  SupaBaseHandler supabaseHandler = SupaBaseHandler();

  // setters
  setTitle(String val) {
    _title = val;
    notifyListeners();
  }

  setDsc(String val) {
    _dsc = val;
    notifyListeners();
  }

  selectTodo(TodoModel val) {
    _selectedTodo = val;
    notifyListeners();
  }

  getTodosList() async {
    _loading = 1;
    Future.delayed(const Duration(seconds: 0), () async {
      // TODO: get all todos
      await supabaseHandler.readData().then((data) {
        _listTodos = [];
        for (var e in data) {
          _listTodos.add(TodoModel.fromJson(e));
        }
        return;
      });
      _loading = 0;
      notifyListeners();
      return;
    });
  }

  addToList(TodoModel todo) {
    supabaseHandler.addData(todo);
    getTodosList();
    notifyListeners();
  }

  removeFromList(int id) {
    supabaseHandler.deleteData(id);
    getTodosList();
    notifyListeners();
  }

  updateList(TodoModel todo) {
    supabaseHandler.updateData(todo);
    getTodosList();
    notifyListeners();
  }

  // getters
  int? get loading => _loading;
  String? get title => _title;
  String? get dsc => _dsc;
  List<TodoModel?> get listTodos => _listTodos;
  TodoModel? get selectedTodo => _selectedTodo;
}
