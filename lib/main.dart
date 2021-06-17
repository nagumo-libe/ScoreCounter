import 'CommonInfo.dart' as ci;
import 'package:flutter_application_1/CommonInfo.dart';
import 'package:flutter_application_1/HaiInfo.dart';
import 'package:flutter_application_1/ScoreResult.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    SystemChrome.setEnabledSystemUIOverlays([]); // ステータスバーとナビゲーションバーを非表示にする場合
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  late int CtMati;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {  },
                      child: Text('牌入力'),
                    ),
                  ),
                ),
                SpaceBox.width(),
                Expanded(
                  child: Container(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        ci.MakeTestData();
                        // ソート（理牌）
                        ci.Repai(ci.aryHai);
                        // 入力判定
                        if(ChkInput()){
                          if(CtMati == 0){
                          /*
                            // 待ち判定
                            btnIntent.setClassName("jp.mj.scorecounter","jp.mj.scorecounter.MatiResult");
                            startActivity(btnIntent);
                          */
                          } else {
                            //if(edtNorthDora.getText().length() > 0){
                            //  ci.NorthDora = Integer.parseInt(edtNorthDora.getText().toString());
                            //} else {
                              ci.NorthDora = 0;
                            //}
                            // 結果画面表示
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ScoreResult();
                                },
                              ),
                            );
                          }
                        }
                      },
                      child: Text('計算'),
                    ),
                  ),
                ),
                SpaceBox.width(),
                Expanded(
                  child: Container(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {  },
                      child: Text('履歴'),
                    ),
                  ),
                ),
                SpaceBox.width(),
                Expanded(
                  child: Container(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {  },
                      child: Text('設定'),
                    )
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeFieldWind = FieldWind.btnFieldEast;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeFieldWind == FieldWind.btnFieldEast ? Colors.orange : Colors.grey,
                      ),
                      child: Text('東場'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeFieldWind = FieldWind.btnFieldWest;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeFieldWind == FieldWind.btnFieldWest ? Colors.orange : Colors.grey,
                      ),
                      child: Text('南場'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeFieldWind = FieldWind.btnFieldSouth;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeFieldWind == FieldWind.btnFieldSouth ? Colors.orange : Colors.grey,
                      ),
                      child: Text('西場'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeFieldWind = FieldWind.btnFieldNorth;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeFieldWind == FieldWind.btnFieldNorth ? Colors.orange : Colors.grey,
                      ),
                      child: Text('北場'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: Text(
                      '三麻',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeHola = Hola.btnTumoSanma;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeHola == Hola.btnTumoSanma ? Colors.orange : Colors.grey,
                      ),
                      child: Text('ツモ'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: Text(
                      '北ドラ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    //北ドラ枚数入力
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeThisWind = ThisWind.btnThisEast;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeThisWind == ThisWind.btnThisEast ? Colors.orange : Colors.grey,
                      ),
                      child: Text('東家'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeThisWind = ThisWind.btnThisSouth;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeThisWind == ThisWind.btnThisSouth ? Colors.orange : Colors.grey,
                      ),
                      child: Text('南家'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeThisWind = ThisWind.btnThisWest;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeThisWind == ThisWind.btnThisWest ? Colors.orange : Colors.grey,
                      ),
                      child: Text('西家'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeThisWind = ThisWind.btnThisNorth;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeThisWind == ThisWind.btnThisNorth ? Colors.orange : Colors.grey,
                      ),
                      child: Text('北家'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: Text(
                      '立直',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeReach = Reach.btnReachOff;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeReach == Reach.btnReachOff ? Colors.orange : Colors.grey,
                      ),
                      child: Text('なし'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeReach = Reach.btnReachOn;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeReach == Reach.btnReachOn ? Colors.orange : Colors.grey,
                      ),
                      child: Text('あり'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeReach = Reach.btnReachDouble;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeReach == Reach.btnReachDouble ? Colors.orange : Colors.grey,
                      ),
                      child: Text('ダブル'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      '和了',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeHola = Hola.btnTumo;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeHola == Hola.btnTumo ? Colors.orange : Colors.grey,
                      ),
                      child: Text('ツモ'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeHola = Hola.btnLon;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeHola == Hola.btnLon ? Colors.orange : Colors.grey,
                      ),
                      child: Text('ロン'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeHola = Hola.btnTyankan;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeHola == Hola.btnTyankan ? Colors.orange : Colors.grey,
                      ),
                      child: Text('槍槓'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeFirst = !ci.ModeFirst;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeFirst ? Colors.orange : Colors.grey,
                      ),
                      child: Text('一巡目'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeHaitei = !ci.ModeHaitei;
                          if(ci.ModeRinsyan && ci.ModeHaitei) ci.ModeRinsyan = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeHaitei ? Colors.orange : Colors.grey,
                      ),
                      child: Text('海底'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeRinsyan = !ci.ModeRinsyan;
                          if(ci.ModeRinsyan && ci.ModeHaitei) ci.ModeHaitei = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeRinsyan ? Colors.orange : Colors.grey,
                      ),
                      child: Text('嶺上'),
                    ),
                  ),
                ),
                SpaceBox.width(1),
                Expanded(
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ci.ModeIppatu = !ci.ModeIppatu;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: ci.ModeIppatu ? Colors.orange : Colors.grey,
                      ),
                      child: Text('一発'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 入力判定
  // ignore: non_constant_identifier_names
	bool ChkInput() {
    // ignore: non_constant_identifier_names
		bool Kokusi = true;
    // ignore: non_constant_identifier_names
		int CtTehai, CtFuro, CtDora;
		CtTehai = CtFuro = CtDora = 0;
		CtMati = 0;
		for(int i = 0; i < ci.aryHai.length; i++){
			HaiInfo hai = ci.aryHai.elementAt(i);
			if(hai.Type == HaiInfo.TEHAI){
				CtTehai++;
      } else if(hai.Type == HaiInfo.FURO){
				CtFuro++;
      } else if(hai.Type == HaiInfo.MATI){
				CtMati++;
      } else if(hai.Type == HaiInfo.DORA){
				CtDora++;
			}
			// 国士
			if(hai.Type == HaiInfo.TEHAI || hai.Type == HaiInfo.MATI){
				if(!hai.IsYaotyu()) Kokusi = false;
			}
		}
		String ret = ci.AnalaysisHai(ci.aryHai, true, !Kokusi && CtMati > 0);
		if(ret != ""){
			ci.showDialogOk(context, "", ret);
			return false;
		}
		// タイプ毎の数
		if(CtTehai < 1 || 17 < CtTehai) { ci.showDialogOk(context, "", "手牌の数が正しくありません"); return false; }
		if(16 < CtFuro)                 { ci.showDialogOk(context, "", "副露牌の数が正しくありません"); return false; }
		if(10 < CtDora)                 { ci.showDialogOk(context, "", "ドラ表示牌の数が正しくありません"); return false; }
		// 選択項目
		if(ci.ModeReach == Reach.btnReachOff && ci.ModeIppatu)                	   { ci.showDialogOk(context, "", "リーチがかかっていないため一発は無効です"); return false; }
		if(ci.ModeReach == Reach.btnReachOff && CtDora > 5)                		     { ci.showDialogOk(context, "", "リーチがかかっていないためドラ表示牌は５個までです"); return false; }
		if(ci.ModeHola == Hola.btnTyankan && ci.ModeRinsyan)                       { ci.showDialogOk(context, "", "槍槓であがったため嶺上は無効です"); return false; }
		if(ci.ModeHola == Hola.btnTyankan && ci.ExistMatiHai(ci.aryHai))           { ci.showDialogOk(context, "", "槍槓であがったため待ち牌と同じ牌は存在しません"); return false; }
		if(ci.ModeRinsyan && CtTehai + CtFuro < 14)                       		     { ci.showDialogOk(context, "", "嶺上であがった際の牌の数が正しくありません"); return false; }
		if(ci.ModeFirst && 0 < CtFuro)                                    		     { ci.showDialogOk(context, "", "副露牌が存在するため一巡目限定の役満は成立しません"); return false; }
		if(ci.ModeHaitei && ci.ModeReach == Reach.btnReachDouble && ci.ModeIppatu) { ci.showDialogOk(context, "", "海底であがったためダブリー一発は成立しません"); return false; }
		if(ci.ModeReach != Reach.btnReachOff && 0 < CtFuro){
      // ignore: non_constant_identifier_names
			bool Ankan = true;
			for(int i = 0; i < ci.aryHai.length; i++){
				HaiInfo hai = ci.aryHai.elementAt(i);
				if(hai.Type == HaiInfo.FURO && !hai.AnKan){
					Ankan = false;
					break;
				}
			}
			if(!Ankan){
				ci.showDialogOk(context, "", "リーチがかかっているため暗槓を除く副露牌は存在しません");
				return false;
			}
		}
		// 特殊形
		if(CtTehai == 13 && CtFuro == 0){
			int i;
			for(i = 0; i < ci.aryHai.length; i++){
				if(!ci.aryHai.elementAt(i).Toitu) break;
			}
			if( i >= ci.aryHai.length){
        // ignore: non_constant_identifier_names
				int CtSyuntuKouho = 0;
				for(i = 0; i < ci.aryHai.length; i++){
					if(ci.aryHai.elementAt(i).Syuntu){
						CtSyuntuKouho++;
					}
				}
				if(CtSyuntuKouho >= 12){
					return true;
				}
				for(i = 0; i < ci.aryHai.length; i++){
					if(ci.aryHai.elementAt(i).Koutu) break;
				}
				if( i >= ci.aryHai.length){
					return true;
				}
			}
		}
		// 槓子
    // ignore: non_constant_identifier_names
		int CtKantuKouho = 0;
		if(CtTehai + CtFuro > 13){
			for(int i = 0; i < ci.aryHai.length; i++){
				if(ci.aryHai.elementAt(i).Kantu) CtKantuKouho++;
			}
			if(CtKantuKouho % 4 != 0 || CtKantuKouho / 4 < CtTehai + CtFuro - 13){
				ci.showDialogOk(context, "", "槓子の数が足りません");
				return false;
			}
		}
		// 雀頭
    // ignore: non_constant_identifier_names
		int CtToitu = 0;
		for(int i = 0; i < ci.aryHai.length; i++){
			if(ci.aryHai.elementAt(i).Toitu) CtToitu++;
		}
		if(CtToitu == 0 && CtMati != 0){
			ci.showDialogOk(context, "", "雀頭が存在しません");
			return false;
		}
		return true;
	}
}
