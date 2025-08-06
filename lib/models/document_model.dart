class Document {
  final String? description;
  final String? pdf;

  Document({
    this.description,
    this.pdf,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      description: json['Description'],
      pdf: json['PDF'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Description': description,
      'PDF': pdf,
    };
  }
}
