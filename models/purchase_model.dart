class PurchaseModel {
  String? id;
  String? companyId;
  String? userId;
  String? invoiceNo;
  String? title;
  String? description;
  String? file;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<PurchaseFile>? purchaseFile;

  PurchaseModel(
      {this.id,
      this.companyId,
      this.userId,
      this.invoiceNo,
      this.title,
      this.description,
      this.file,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.purchaseFile});

  PurchaseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    userId = json['user_id'];
    invoiceNo = json['invoice_no'];
    title = json['title'];
    description = json['description'];
    file = json['file'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['purchase_file'] != null) {
      purchaseFile = <PurchaseFile>[];
      json['purchase_file'].forEach((v) {
        purchaseFile!.add(PurchaseFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['user_id'] = userId;
    data['invoice_no'] = invoiceNo;
    data['title'] = title;
    data['description'] = description;
    data['file'] = file;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (purchaseFile != null) {
      data['purchase_file'] = purchaseFile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchaseFile {
  String? id;
  String? purchaseId;
  String? file;
  String? createdAt;
  String? updatedAt;

  PurchaseFile(
      {this.id, this.purchaseId, this.file, this.createdAt, this.updatedAt});

  PurchaseFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseId = json['purchase_id'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['purchase_id'] = purchaseId;
    data['file'] = file;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
