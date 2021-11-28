class GoldItemData {
  String? loanId = '';
  String? itemId = '';
  String? goldItem = '';
  String? quantity = '';
  String? packetNo = '';
  String? grossWeight = '';
  String? riskClass = '';
  int? netWeight;
  int? deductionQuantity;
  int? deductionWeight;
  Map<String, dynamic>? deductionMap;

  GoldItemData(
    this.loanId,
    this.itemId,
    this.goldItem,
    this.quantity,
    this.packetNo,
    this.grossWeight,
    this.riskClass,
    this.netWeight,
    this.deductionQuantity,
    this.deductionWeight,
    this.deductionMap,
  );
}
