class PharmacyAppApis{

  static final String baseUrl = "https://pharmacy13.herokuapp.com/";


  static String signUpApi = baseUrl + 'api/user/';
  static String loginApi = baseUrl + 'api/token/login';
  static String storeListApi = baseUrl + 'api/pharmacy/?q=';
  static String drugsApi = baseUrl + 'api/drug/?q=';
  static String orderProcessingApi = baseUrl + "api/customer/";
}