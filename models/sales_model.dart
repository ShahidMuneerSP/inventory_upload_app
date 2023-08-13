class SalesModel {
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
  List<SaleFile>? saleFile;

  SalesModel(
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
      this.saleFile});

  SalesModel.fromJson(Map<String, dynamic> json) {
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
    if (json['sale_file'] != null) {
      saleFile = <SaleFile>[];
      json['sale_file'].forEach((v) {
        saleFile!.add(SaleFile.fromJson(v));
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
    if (saleFile != null) {
      data['sale_file'] = saleFile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleFile {
  String? id;
  String? saleId;
  String? file;
  String? createdAt;
  String? updatedAt;

  SaleFile({this.id, this.saleId, this.file, this.createdAt, this.updatedAt});

  SaleFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleId = json['sale_id'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sale_id'] = saleId;
    data['file'] = file;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
