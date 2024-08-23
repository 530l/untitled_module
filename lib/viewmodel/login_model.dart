import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dio/api_client.dart';
part 'login_model.g.dart';

class LoginInfo {
  final String userName;
  final String loginTime;

  LoginInfo({
    required this.userName,
    required this.loginTime,
  });

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(
      userName: json['userName'],
      loginTime: json['loginTime'],
    );
  }
}

class LoginPageState {
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final LoginInfo? loginInfo;

  LoginPageState({this.loginInfo, required this.userNameController, required this.passwordController});

  LoginPageState.initial()
      : userNameController = TextEditingController(),
        passwordController = TextEditingController(),
        loginInfo = null;

  LoginPageState copyWith({
    TextEditingController? userNameController,
    TextEditingController? passwordController,
    LoginInfo? loginInfo,
  }) {
    return LoginPageState(
      userNameController: userNameController ?? this.userNameController,
      passwordController: passwordController ?? this.passwordController,
      loginInfo: loginInfo ?? this.loginInfo,
    );
  }
}

@riverpod
class LoginPageVM extends _$LoginPageVM {
  @override
  LoginPageState build() => LoginPageState.initial();

  Future<void> login() async {
    final userName = state.userNameController.text;
    final password = state.passwordController.text;
    if (userName.isEmpty || password.isEmpty) {
      showSnackBar("请输入帐号或密码");
    } else {
      var response = await Dio().post(
        "https://mock.apifox.com/m1/4081539-3719383-default/flutter_article/testLogin",
        data: {'username': userName, 'password': password},
      );
      var data = response.data['data'];
      if (response.data['errorCode'] == 200) {
        var loginInfo = LoginInfo.fromJson(data);
        state = state.copyWith(loginInfo: loginInfo);
        showSnackBar("登录成功");
        pop(result: loginInfo);
      } else {
        showSnackBar("登录失败");
      }
    }
  }
}



/// login_page.dart → 登录页
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  @override
  Widget build(BuildContext context) {
    var loginState = ref.watch(loginPageVMProvider);
    var loginVM = ref.watch(loginPageVMProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('登录页', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: loginState.userNameController,
              decoration: const InputDecoration(
                labelText: '用户名',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: loginState.passwordController,
              decoration: const InputDecoration(
                labelText: '密码',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            MaterialButton(
              onPressed: () {
                loginVM.login();
              },
              color: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: const Text('登录', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}



final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void showSnackBar(String message) {
  if (navigatorKey.currentContext != null) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(content: Text(message)));
  }
}

void pop<T>({T? result}) {
  if (navigatorKey.currentContext != null) {
    if(result != null) {
      Navigator.pop(navigatorKey.currentContext!, result);
    } else {
      Navigator.pop(navigatorKey.currentContext!);
    }
  }
}


void main() {
  ApiClient.init("https://mock.apifox.com/m1/4081539-3719383-default/flutter_article/");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage(), navigatorKey: navigatorKey);
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Center(child: Consumer(builder: (context, ref, child) {
          LoginInfo? loginInfo = ref.watch(loginPageVMProvider.select((value) => value.loginInfo));
          return loginInfo == null
              ? ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text('去登录'),
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('用户名：${loginInfo.userName}'),
              Text('登录时间：${loginInfo.loginTime}'),
            ],
          );
        })));
  }
}
