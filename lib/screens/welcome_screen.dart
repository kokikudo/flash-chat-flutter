import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  //ルートネーム。文字列だとタイプミスする可能性があるので変数にしておく
  //取得するためだけの値なので、staticでクラスそのものに付与するオブジェクトにする
  //constで変更不可にする
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    // AnimationControllerの定義
    // AnimationControllerにはTickerProviderが必須であり、StateにSingleTickerProviderStateMixinまたはTickerProviderStateMixinを付与する必要がある
    animationController = AnimationController(
      duration: Duration(seconds: 1), //　変化する時間
      vsync: this, // TickerProviderをこのWidgetに設定する
      //upperBound: 100.0, // 変化の上限
    );

    //アニメーションの種類
    //CurvedAnimationは変化に強弱をつけられる
    //1が上限なので、upperBoundを指定してるとエラーになる
    //animation = CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    //Tweenという種類があり、開始と終了を決めることでその間をアニメーションで変化できる
    animation = ColorTween(begin: Colors.grey, end: Colors.white)
        .animate(animationController);

    //アニメーションが変化する順番
    animationController.forward();
    //逆
    //animationController.reverse(from: 1.0);

    //アニメーションのステータスが変化したときに呼バレるコールバックを指定
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('Animation Finished!');
      }
    });

    //アニメーションが変化するたびに実行されるコールバックを指定
    animationController.addListener(() {
      // animationController.valueで変化過程をdoubleで取得
      // buildしたWidgetのなかで利用する場合はsetStateでbuildを更新する
      setState(() {});
    });
  }

  @override
  void dispose() {
    // コントローラーを削除するのを忘れない
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0, // 上限が1のため100をかけることで大きく表示される
                  ),
                ),
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Flach Chat',
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                      speed: Duration(milliseconds: 300),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                title: 'Log In'),
            RoundedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                title: 'Register'),
          ],
        ),
      ),
    );
  }
}
