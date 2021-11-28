class GoldLoanDeductionForm {
  String? loanId;
  String? goldLoanId;
  String? deductionId;
  String? deductionName;
  Map<String, dynamic>? deductionItemName;
  String? deductionQuantity;
  String? deductionWeight;
  bool? isAdded;

  GoldLoanDeductionForm({
    this.loanId,
    this.goldLoanId,
    this.deductionId,
    this.deductionName,
    this.deductionItemName,
    this.deductionQuantity,
    this.deductionWeight,
    this.isAdded,
  });
}
