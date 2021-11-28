import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:salesapp/pages/add_gold_loan_page.dart';
import 'package:salesapp/utils/app_string.dart';
import 'package:salesapp/widget/design.dart';
import 'package:salesapp/widget/listtile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppString.assets,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: _homeBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Modular.to.navigate("${AppString.addGoldLoanPage}/0"),
        elevation: 5.0,
        icon: const Icon(Icons.add),
        label: Text(AppString.goldLoan),
      ),
    ));
  }

  _homeBody() {
    return Stack(
      children: [
        const DesignWidget(),
        saveDataList.isEmpty
            ? Container()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: saveDataList.length,
                itemBuilder: (context, index) {
                  return ListTileWidget(
                    saveDataList[index].goldItem!,
                    index,
                    saveDataList[index].quantity!,
                    saveDataList[index].packetNo!,
                    saveDataList[index].grossWeight!,
                    saveDataList[index].riskClass!,
                    saveDataList[index].netWeight!,
                    saveDataList[index].deductionQuantity!.toString(),
                    saveDataList[index].deductionWeight!.toString(),
                    saveDataList[index],
                    onTap,
                  );
                },
              ),
      ],
    );
  }

  Function? onTap(int index) {
    saveDataList.removeAt(index);
    Modular.to.pop();
    setState(() {});
  }
}
