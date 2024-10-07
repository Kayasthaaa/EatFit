import 'dart:convert';
import 'package:eat_fit/src/instructor/constant/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:eat_fit/src/instructor/feature/screens/redeem_code/models/redeem_code_models.dart';

class RedeemCodeApi {
  Future<RedeemCodeModels?> redeemCode(String inviteCode) async {
    var redeemCodeResponse = await http.post(
      Uri.parse(ApiUrl.kApiBaseUrl + ApiUrl.kPostRedeemCode),
      body: {
        "invite_code": inviteCode,
      },
    );
    if (redeemCodeResponse.statusCode == 200) {
      RedeemCodeModels redeemCodeModels = RedeemCodeModels.fromJson(
        json.decode(redeemCodeResponse.body),
      );

      return redeemCodeModels;
    }
    return null;
  }
}
