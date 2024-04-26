class MessageModel {
  String role;
  List<RoleModel> parts;

  MessageModel({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toJson() {
    return {"role": role, "parts": parts.map((e) => e.toJson()).toList()};
  }
}

class RoleModel {
  String text;
  RoleModel({required this.text});
  Map<String, dynamic> toJson() {
    return {"text": text};
  }
}
