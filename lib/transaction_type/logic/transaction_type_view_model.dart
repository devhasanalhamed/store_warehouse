import 'package:flutter/foundation.dart';
import 'package:store_warehouse/core/database/dao/transaction_type_dao.dart';
import 'package:store_warehouse/transaction_type/data/transaction_type_model.dart';

class TransactionTypeViewModel extends ChangeNotifier {
  final TransactionTypeDAO transactionTypeDAO = TransactionTypeDAO();
  List<TransactionTypeModel> transactionTypeList = [];

  Future<void> getTransactionType() async {
    final result = await transactionTypeDAO.fetch();
    transactionTypeList = result;
    notifyListeners();
  }

  TransactionTypeModel getTransactionById(int id) =>
      transactionTypeList.firstWhere((element) => element.id == id);



}
