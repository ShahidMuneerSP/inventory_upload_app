class InventoryModel {
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
  List<InventoryFile>? inventoryFile;

  InventoryModel(
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
      this.inventoryFile});

  InventoryModel.fromJson(Map<String, dynamic> json) {
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
    if (json['inventory_file'] != null) {
      inventoryFile = <InventoryFile>[];
      json['inventory_file'].forEach((v) {
        inventoryFile!.add(InventoryFile.fromJson(v));
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
    if (inventoryFile != null) {
      data['inventory_file'] = inventoryFile!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InventoryFile {
  String? id;
  String? inventoryId;
  String? file;
  String? createdAt;
  String? updatedAt;

  InventoryFile(
      {this.id, this.inventoryId, this.file, this.createdAt, this.updatedAt});

  InventoryFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inventoryId = json['inventory_id'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['inventory_id'] = inventoryId;
    data['file'] = file;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
