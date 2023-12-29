import 'package:suitmedia_test/features/users_list/business/entities/users_entity.dart';

import 'user_model.dart';

class UsersModel extends UsersEntity {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<UserModel> data;
  SupportModel support;

  UsersModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  }) : super(
          page: page,
          perPage: perPage,
          total: total,
          totalPages: totalPages,
          data: data,
          support: support,
        );

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<UserModel>.from(
            json["data"].map((x) => UserModel.fromJson(x))),
        support: SupportModel.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "support": support.toJson(),
      };
}
