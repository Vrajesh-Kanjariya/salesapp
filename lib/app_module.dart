import 'package:flutter_modular/flutter_modular.dart';
import 'package:salesapp/pages/add_gold_loan_page.dart';
import 'package:salesapp/pages/home_page.dart';
import 'package:salesapp/utils/app_string.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomePage()),
        ChildRoute("${AppString.addGoldLoanPage}/:id",
            child: (_, args) => AddGoldLoanPage(
                id: args.params['id'], deductionEditData: args.data),
            transition: TransitionType.fadeIn),
      ];
}
