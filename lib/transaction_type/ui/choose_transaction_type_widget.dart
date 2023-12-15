import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_warehouse/core/utils/app_design.dart';
import 'package:store_warehouse/transaction_type/logic/transaction_type_view_model.dart';

class ChooseTransactionTypeWidget extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  const ChooseTransactionTypeWidget({Key? key, this.onChanged})
      : super(key: key);

  @override
  ChooseTransactionTypeWidgetState createState() =>
      ChooseTransactionTypeWidgetState();
}

class ChooseTransactionTypeWidgetState
    extends State<ChooseTransactionTypeWidget> {
  int currentType = 2;
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionTypeViewModel>(
      builder: (_, state, __) => Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(AppDesign.circularRadius),
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    currentType = state.transactionTypeList[0].id;
                    widget.onChanged!.call('$currentType');
                  });
                },
                child: Container(
                  child: Center(
                    child: Text(
                      state.transactionTypeList.first.name,
                      style: TextStyle(
                        color: state.transactionTypeList[0].id == currentType
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: state.transactionTypeList[0].id == currentType
                          ? Colors.purple
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppDesign.circularRadius),
                        bottomRight: Radius.circular(AppDesign.circularRadius),
                      )),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    currentType = state.transactionTypeList[1].id;
                    widget.onChanged!.call('$currentType');
                  });
                },
                child: Container(
                  child: Center(
                    child: Text(
                      state.transactionTypeList.last.name,
                      style: TextStyle(
                        color: state.transactionTypeList[1].id == currentType
                            ? Colors.white
                            : Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: state.transactionTypeList[1].id == currentType
                          ? Colors.purple
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppDesign.circularRadius),
                        bottomLeft: Radius.circular(AppDesign.circularRadius),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
