class ApiUrl {
  static const String BASE_URL = 'http://192.168.3.196:7040/';
  //获取token
  static const String LOGIN = 'api-auth/oauth/mobile/token';
  static const String ALL_FROM = 'api-bp-online/bp_online';
  static const String SAVE_FORM = 'api-bp-online/bp_online';
  //获取机器人列表
  static const String ROBOT_LIST = 'api-robot/robots/list';
  //获取主机器人信息
  static const String MAIN_ROBOT_MESSAGE = 'api-robot/robots/primary';
  //获取我的应用机器人
  static const String MINE_ROBOT = 'api-robot/robots/application_robots';
  //获取我的特约机器人
  static const String MINE_SPECIAL_ROBOT = 'api-robot/robots/contract_robots';
  //获取用户信息
  static const String MINE_MESSAGE = 'api-user/users/detail';
}
