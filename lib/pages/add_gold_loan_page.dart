import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salesapp/data/model/deduction_data.dart';
import 'package:salesapp/data/model/gold_child_item.dart';
import 'package:salesapp/data/model/gold_item.dart';
import 'package:salesapp/data/model/gold_item_data.dart';
import 'package:salesapp/data/model/gold_loan_deduction_form.dart';
import 'package:salesapp/utils/app_string.dart';
import 'package:salesapp/utils/common_validation.dart';
import 'package:salesapp/utils/utils.dart';
import 'package:salesapp/widget/common_snack_bar.dart';
import 'package:salesapp/widget/common_text_form_field.dart';
import 'package:salesapp/widget/design.dart';

List<GoldItemData> saveDataList = [];

class AddGoldLoanPage extends StatefulWidget {
  final GoldItemData? deductionEditData;
  final String? id;

  const AddGoldLoanPage({Key? key, this.deductionEditData, this.id})
      : super(key: key);

  @override
  _AddGoldLoanPageState createState() => _AddGoldLoanPageState();
}

class _AddGoldLoanPageState extends State<AddGoldLoanPage> {
  GlobalKey<FormState> saveFormKey = GlobalKey<FormState>();
  final TextEditingController _quantity = TextEditingController();
  final TextEditingController _packetNo = TextEditingController();
  final TextEditingController _grossWeight = TextEditingController();
  final TextEditingController _riskClass = TextEditingController();
  int? index;

  Map<String, dynamic> goldSelectedItem = {};
  List<GoldItem> goldItemList = [];
  List<GoldChildItem> goldChildItemList = [];
  List<GoldLoanDeductionForm> listChildDeductionForm = [];
  Map<String, dynamic> deductionMap = {};
  List<DeductionData> deductionList = [];

  int totalDeductionQ = 0;
  int totalDeductionW = 0;
  int netWeight = 0;
  int? goldItemId = 0;
  bool isShowAdd = false;
  bool showMore = false;

  bool isItemError = false;

  @override
  void initState() {
    index = int.parse(widget.id!);
    if (widget.deductionEditData != null) {
      print("index ==> $index");
      deductionMap = widget.deductionEditData!.deductionMap!;
      print(deductionMap);
    }
    fillDropDownGoldItem();
    loadEditData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _back(),
      child: SafeArea(
        child: Scaffold(
          appBar: _appBar(),
          body: _body(),
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() => AppBar(
        title: Text(AppString.goldLoan),
        leading: IconButton(
          onPressed: () => _back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      );

  Widget _body() => Stack(
        children: [
          const DesignWidget(),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Form(
                  key: saveFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      goldLoanFormFieldItem(),
                      if (isShowAdd) addButton(),
                      // const SizedBox(height: 8),
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: listChildDeductionForm.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(
                                right: 16, top: 8, left: 16),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white38,
                            ),
                            child: goldLoanChildItem(index),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      deductionField(AppString.deductionQuantity,
                          totalDeductionQ.toString()),
                      const SizedBox(height: 8),
                      deductionField(AppString.deductionWeight,
                          totalDeductionW.toString()),
                      const SizedBox(height: 8),
                      deductionField(AppString.netWeight, netWeight.toString()),
                      const SizedBox(height: 8),
                      riskClass(),
                      const SizedBox(height: 8),
                      saveButton(),
                      const SizedBox(height: 8),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );

  goldLoanFormFieldItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          DropdownButtonFormField<Map<String, dynamic>>(
            value: goldSelectedItem,
            decoration: InputDecoration(
                labelText: 'Item',
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isItemError ? Colors.black : Colors.red))),
            onChanged: (value) {
              goldSelectedItem = value!;
              if (value['id'] != '0') {
                isShowAdd = true;
              } else {
                isShowAdd = false;
              }
              setState(() {});
            },
            items:
                goldItemList.map<DropdownMenuItem<Map<String, dynamic>>>((e) {
              return DropdownMenuItem<Map<String, dynamic>>(
                child: Text(e.itemMap['name']),
                value: e.itemMap,
              );
            }).toList(),
            icon: const Icon(Icons.expand_more),
            iconSize: 24,
            elevation: 16,
            isExpanded: true,
          ),
          const SizedBox(height: 8),
          Visibility(
            visible: isItemError,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Gold item required',
                style: TextStyle(fontSize: 12, color: Colors.red),
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CommonTextFormField(
            controller: _quantity,
            labelText: AppString.quantity,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(5),
            ],
            validator: (value) =>
                CommonValidation.commonValidation(value!, AppString.quantity),
          ),
          const SizedBox(height: 8),
          CommonTextFormField(
            controller: _packetNo,
            labelText: AppString.packetNo,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(5),
            ],
            validator: (value) =>
                CommonValidation.commonValidation(value!, AppString.packetNo),
          ),
          const SizedBox(height: 8),
          CommonTextFormField(
            controller: _grossWeight,
            labelText: AppString.grossWeight,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(8),
            ],
            validator: (value) => CommonValidation.commonValidation(
                value!, AppString.grossWeight),
            onChanged: (value) => setState(() {
              if (value.isEmpty) {
                netWeight = 0;
              } else {
                netWeight = int.parse(value);
              }
            }),
          )
        ],
      ),
    );
  }

  addButton() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () {
          _addEmptyView();
        },
        child: Text(AppString.add),
      ),
    );
  }

  deductionField(label, value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white38,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            ':',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  riskClass() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: CommonTextFormField(
        controller: _riskClass,
        labelText: AppString.riskClass,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
        ],
        validator: (value) =>
            CommonValidation.commonValidation(value!, AppString.riskClass),
      ),
    );
  }

  saveButton() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () {
          if (goldItemList[0].itemMap == goldSelectedItem) {
            setState(() {
              isItemError = true;
            });
          } else {
            setState(() {
              isItemError = false;
            });
          }

          if (saveFormKey.currentState!.validate() && !isItemError) {
            var data = GoldItemData(
              '100',
              goldSelectedItem['id'],
              goldSelectedItem['name'],
              _quantity.text,
              _packetNo.text,
              _grossWeight.text,
              _riskClass.text,
              netWeight,
              totalDeductionQ,
              totalDeductionW,
              deductionMap,
            );

            print("Deduction map ==> $deductionMap");

            if (goldItemId != 0) {
              saveDataList.removeAt(index!);
              saveDataList.insert(index!, data);
            } else {
              saveDataList.add(data);
            }
            Modular.to.navigate('/');
          }
          setState(() {});
        },
        child: Text(goldItemId != 0 ? AppString.update : AppString.save),
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12)),
      ),
    );
  }

  fillDropDownGoldItem() {
    Map<String, dynamic> selectedDeductionType = {};

    goldItemList.add(GoldItem({"id": "0", "name": "Please select item"}));
    goldItemList.add(GoldItem({"id": "1", "name": "Bangles"}));
    goldItemList.add(GoldItem({"id": "2", "name": "Bangles Rings"}));
    goldItemList.add(GoldItem({"id": "3", "name": "Bracelet"}));
    goldItemList.add(GoldItem({"id": "4", "name": "Chain"}));
    goldItemList.add(GoldItem({"id": "5", "name": "Gold Bars"}));
    goldItemList.add(GoldItem({"id": "6", "name": "Gold Coins"}));
    goldItemList.add(GoldItem({"id": "7", "name": "Gold Earrings"}));
    goldItemList.add(GoldItem({"id": "8", "name": "Gold Jewellery"}));
    goldItemList.add(GoldItem({"id": "9", "name": "Rings"}));

    goldChildItemList.add(
        GoldChildItem({"id": "0", "name": "Please select deduction item"}));
    goldChildItemList.add(GoldChildItem({"id": "1", "name": "Stone"}));
    goldChildItemList.add(GoldChildItem({"id": "2", "name": "Pearl"}));
    goldChildItemList.add(GoldChildItem({"id": "3", "name": "Colours"}));
    goldChildItemList.add(GoldChildItem({"id": "4", "name": "Coin"}));

    if (widget.deductionEditData != null) {
      goldItemId = int.parse(widget.deductionEditData!.itemId!);

      for (int i = 0; i < goldItemList.length; i++) {
        if (goldItemList[i].itemMap['id'] == widget.deductionEditData!.itemId) {
          goldSelectedItem = goldItemList[i].itemMap;
        }
      }

      if (widget.deductionEditData!.deductionMap!.isNotEmpty) {
        setState(() {
          showMore = true;
        });

        List<GoldLoanDeductionForm> data =
            widget.deductionEditData!.deductionMap!['deductionList'];

        if (data.isNotEmpty) {
          for (int j = 0; j < data.length; j++) {
            for (int k = 0; k < goldChildItemList.length; k++) {
              if (data[j].deductionId == goldChildItemList[k].childItem['id']) {
                selectedDeductionType = goldChildItemList[k].childItem;
              }
            }

            GoldLoanDeductionForm goldLoanDeductionForm = GoldLoanDeductionForm(
              deductionId: data[j].deductionId,
              deductionItemName: selectedDeductionType,
              deductionQuantity: data[j].deductionQuantity.toString(),
              deductionWeight: data[j].deductionWeight.toString(),
              isAdded: false,
            );

            listChildDeductionForm.add(goldLoanDeductionForm);
          }
        } else {}
      }
      setState(() {
        isShowAdd = true;
      });
    } else if (widget.deductionEditData == null && goldItemList.isNotEmpty) {
      goldSelectedItem = goldItemList[0].itemMap;
    }
  }

  _back() {
    Modular.to.navigate('/');
  }

  _addEmptyView() {
    if (goldChildItemList.isNotEmpty) {
      GoldLoanDeductionForm goldLoanDeductionForm = GoldLoanDeductionForm(
        deductionItemName: goldChildItemList[0].childItem,
        deductionQuantity: "",
        deductionWeight: "",
        isAdded: true,
      );
      listChildDeductionForm.add(goldLoanDeductionForm);
      setState(() {});
    } else {
      displayMessage(context, 'Gold deduction item empty');
    }
  }

  goldLoanChildItem(int index) {
    GoldLoanDeductionForm item = listChildDeductionForm[index];
    final goldLoanFormKey = GlobalKey<FormState>();
    final TextEditingController deductionQuantity =
        TextEditingController(text: item.deductionQuantity);
    final TextEditingController deductionWeight =
        TextEditingController(text: item.deductionWeight);
    return Form(
      key: goldLoanFormKey,
      child: Column(
        children: [
          DropdownButtonFormField<Map<String, dynamic>>(
            value: item.deductionItemName,
            decoration: const InputDecoration(
              labelText: 'Deduction Description',
              border: OutlineInputBorder(),
            ),
            onChanged: (Map<String, dynamic>? newValue) {
              listChildDeductionForm[index].deductionItemName = newValue!;
              if (newValue['id'] != '0') {
                showMore = true;
              } else {
                showMore = false;
              }
              setState(() {});
            },
            items: goldChildItemList
                .map<DropdownMenuItem<Map<String, dynamic>>>((item) {
              return DropdownMenuItem<Map<String, dynamic>>(
                value: item.childItem,
                child: Text(item.childItem["name"]),
              );
            }).toList(),
            icon: const Icon(Icons.expand_more),
            iconSize: 24,
            elevation: 16,
            isExpanded: true,
          ),
          const SizedBox(height: 8),
          if (showMore)
            CommonTextFormField(
              controller: deductionQuantity,
              labelText: AppString.deductionQuantity,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
              ],
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return '${AppString.deductionQuantity} is required';
                }
                return null;
              },
            ),
          const SizedBox(height: 8),
          if (showMore)
            CommonTextFormField(
              controller: deductionWeight,
              labelText: AppString.deductionWeight,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(8),
              ],
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return '${AppString.deductionWeight} is required';
                }
                return null;
              },
            ),
          const SizedBox(height: 8),
          if (showMore)
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      bool validation =
                          goldLoanFormKey.currentState!.validate();

                      if (validation) {
                        GoldLoanDeductionForm goldLoanDeductionForm =
                            GoldLoanDeductionForm(
                          loanId: '100',
                          goldLoanId: goldSelectedItem['id'],
                          deductionId: listChildDeductionForm[index]
                              .deductionItemName!['id'],
                          deductionItemName:
                              listChildDeductionForm[index].deductionItemName!,
                          deductionName: listChildDeductionForm[index]
                              .deductionItemName!['name'],
                          deductionQuantity: deductionQuantity.text.trim(),
                          deductionWeight: deductionWeight.text.trim(),
                          isAdded: false,
                        );

                        listChildDeductionForm[index] = goldLoanDeductionForm;

                        deductionMap = {
                          'goldItemId': goldSelectedItem['id'],
                          'deductionList': listChildDeductionForm,
                        };

                        setState(() {

                        });

                        displayMessage(context, "Item Saved.");
                        countDeductionValue();
                      }
                    },
                    child: item.isAdded!
                        ? const Icon(Icons.add)
                        : const Icon(Icons.done),
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  item.isAdded!
                      ? Container()
                      : ElevatedButton(
                          child: const Icon(Icons.close),
                          onPressed: () {
                            listChildDeductionForm.removeAt(index);

                            deductionMap = {
                              'goldItemId': goldSelectedItem['id'],
                              'deductionList': listChildDeductionForm,
                            };

                            displayMessage(context, "Item Removed.");
                            countDeductionValue();
                          },
                          style: ButtonStyle(
                            shadowColor: MaterialStateProperty.all(
                              Colors.transparent,
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.red,
                            ),
                          ),
                        ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  countDeductionValue() {
    totalDeductionQ = 0;
    totalDeductionW = 0;
    netWeight = 0;
    for (var element in listChildDeductionForm) {
      if (!element.isAdded!) {
        if (isNumeric(element.deductionQuantity!.toString().trim())) {
          totalDeductionQ += int.parse(element.deductionQuantity!);
        }
        if (isNumeric(element.deductionWeight!.toString().trim())) {
          totalDeductionW += int.parse(element.deductionWeight!);
        }
      }
    }
    String? grossWeight = _grossWeight.text.toString().trim();
    if (grossWeight.isNotEmpty) {
      if (isNumeric(grossWeight)) {
        netWeight = int.parse(grossWeight) - totalDeductionW;
      }
    }
    setState(() {});
  }

  void loadEditData() {
    if (widget.deductionEditData != null) {
      _quantity.text = widget.deductionEditData!.quantity.toString();
      _packetNo.text = widget.deductionEditData!.packetNo.toString();
      _grossWeight.text = widget.deductionEditData!.grossWeight.toString();
      _riskClass.text = widget.deductionEditData!.riskClass.toString();
      netWeight = widget.deductionEditData!.netWeight!;
      totalDeductionQ = widget.deductionEditData!.deductionQuantity!;
      totalDeductionW = widget.deductionEditData!.deductionWeight!;
    }
  }
}
