import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salesapp/data/model/gold_item_data.dart';
import 'package:salesapp/utils/app_colors.dart';
import 'package:salesapp/utils/app_string.dart';

class ListTileWidget extends StatelessWidget {
  final int? id;
  final String? name;
  final String? quantity;
  final String? pocketNo;
  final String? grossWeight;
  final String? riskClass;
  final int? netWeight;
  final String? deductionQuantity;
  final String? deductionWeight;
  final GoldItemData? deductionData;
  final Function? onTap;

  const ListTileWidget(
      this.name,
      this.id,
      this.quantity,
      this.pocketNo,
      this.grossWeight,
      this.riskClass,
      this.netWeight,
      this.deductionQuantity,
      this.deductionWeight,
      this.deductionData,
      this.onTap,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 5,
      shadowColor: Colors.grey,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.only(left: 7.5),
        child: ListTile(
          subtitle: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No : ${id! + 1}",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            "Name : $name",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            "Risk Class : $riskClass",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            "Pocket No : $pocketNo",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Net Weight : $netWeight",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            "Deduction Weight : $deductionWeight",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            "Gross Weight : $grossWeight",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 3),
                    ElevatedButton(
                      onPressed: () {
                        Modular.to.navigate("${AppString.addGoldLoanPage}/$id",
                            arguments: deductionData);
                      },
                      child: const Icon(Icons.edit),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          // barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              elevation: 5.0,
                              title: Text(
                                AppString.delete,
                                style: const TextStyle(color: Colors.black),
                              ),
                              content: Text(
                                AppString.areYouSureDelete,
                                style: const TextStyle(color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    onTap!.call(id);
                                  },
                                  child: const Text('Yes'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Modular.to.pop();
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Icon(Icons.delete),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                )
              ],
            ),
          ),
          // horizontalTitleGap: 20.0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
        ),
      ),
    );
  }
}
