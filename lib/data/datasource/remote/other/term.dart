import 'package:admin/core/class/crud.dart';
import 'package:admin/linkapi.dart';

class TermData {
  Crud crud;
  TermData(this.crud);

  Future getTerm() async {
    var response = await crud.postData(AppLink.term, {});
    return response.fold((l) => l, (r) => r);
  }

  Future editTerm(
    String id,
    String term,
  ) async {
    var response = await crud.postData(
      AppLink.editTerm,
      {
        "id": id,
        "term": term,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
