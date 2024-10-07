abstract class ApiUrl {
  static String kApiBaseUrl = 'http://khaanpin.com.np:8000/api/v1';
  static String kApiVerifyPath = "/user/verify-phonenumber/";
  static String kApiAccessPath = "/user/get-token/";
  static String kApiRefreshTokenPath = "/user/refresh-token/";
  static String kApiGetPlans = "/meals/";
  static String kApiGenerateCode = "/meals/getinvitecode/";
  static String kGetSubscribers = "/subscribers/";
  static String kPostRedeemCode = "/sharedmeals/redeemcode/";
  static String kRegister = "/user/";
  static String kAddMealPlan = '/meals/';
  static String kMealInvitations = '/sharedmeals/';
  static String kGetEarnings = '/user/earningwithdraw/list/earning-details/';
  static String kGetEarningsDetails =
      '/user/earningwithdraw/list/?type=Credited';
  static String kPostPayout = '/user/paymentrequest/list/';
  static String kGetPayout = '/user/earningwithdraw/list/?type=Debited';
  static String kGetNotificationMe = '/notifications/me/';
  static String kFCMToken = '/user/devices/list/';
}
