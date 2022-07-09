/* Developed by: Eng Mouaz M. Al-Shahmeh */
import 'package:supabase/supabase.dart';
import 'package:supabase_example/controllers/services/supabase_settings.dart';
import 'package:supabase_example/models/todo.dart';

class SupaBaseHandler {
  // define supabase client
  final client = SupabaseClient(
      SupabaseSettings.supabaseUrl, SupabaseSettings.supabaseKey);

  // get the data from supabase
  readData() async {
    PostgrestResponse response = await client
        .from('todotable')
        .select()
        .order('id',
            ascending: false) // TODO: if you want order data as sql data
        .execute();
    final dataList = response.data;
    return dataList;
  }

  // add data to supabase
  addData(TodoModel todo) {
    client
        .from('todotable')
        .insert({'title': todo.title, 'dsc': todo.dsc}).execute();
    // TODO: no need to id which generated automatically as auto increment
  }

  // update data to supabase
  updateData(TodoModel todo) {
    client
        .from('todotable')
        .update({'title': todo.title, 'dsc': todo.dsc})
        .eq('id', todo.id)
        // TODO: you need to id for comparing records
        .execute();
  }

  // delete data from supabase
  deleteData(int id) {
    // TODO: you need to id for comparing records
    client.from('todotable').delete().eq('id', id).execute();
  }
}
