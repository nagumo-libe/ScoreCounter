import 'CommonInfo.dart' as ci;
import 'package:flutter_application_1/CommonInfo.dart';
import 'package:flutter_application_1/HaiInfo.dart';
import 'package:flutter_application_1/Agarikei.dart';

import 'package:flutter/material.dart';

class ScoreResult extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScoreResult();
  }
}

class _ScoreResult extends State<ScoreResult> {
  var imvTehai = ['images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg'];
  var imvFuro = ['images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg'];
  var imvDora = ['images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg', 'images/dummy.jpg'];
  var txtYaku = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
  var imvMati = 'images/dummy.jpg', txtHanFu = '', txtScore = '', txtChip = '';
	String strYaku = '';
	String strHanFu = '';
	String strScore = '';
	String strChip = '';

  @override
  void initState(){
    super.initState();
    
    List<HaiInfo> aryCopy = []..addAll(ci.aryHai);
    // 牌画像表示
    // ignore: non_constant_identifier_names
		int CtTehai, CtFuro, CtDora;
		CtTehai = CtFuro = CtDora = 0;
    for(int i = 0; i < aryCopy.length; i++){
      if(aryCopy.elementAt(i).Type == HaiInfo.TEHAI){
				imvTehai[CtTehai] = aryCopy.elementAt(i).FileName; CtTehai++;
      } else if(aryCopy.elementAt(i).Type == HaiInfo.FURO){
				imvFuro[CtFuro] = aryCopy.elementAt(i).FileName; CtFuro++;
      } else if(aryCopy.elementAt(i).Type == HaiInfo.MATI){
				imvMati = aryCopy.elementAt(i).FileName;
      } else if(aryCopy.elementAt(i).Type == HaiInfo.DORA){
				imvDora[CtDora] = aryCopy.elementAt(i).FileName; CtDora++;
			}
    }
    // 手牌、待ち牌以外を除外
    for(int i = aryCopy.length - 1; i >= 0; i--){
      if(aryCopy.elementAt(i).Type != HaiInfo.TEHAI && aryCopy.elementAt(i).Type != HaiInfo.MATI) aryCopy.removeAt(i);
    }
    // 和了形判定
    // ignore: unused_local_variable
    Agarikei agarikei = ci.AnalaysisAgari(aryCopy);
    // 結果表示
    strYaku = "";
    for(int i = 0; i < agarikei.Yaku.length && i < txtYaku.length; i++){
      txtYaku[i] = agarikei.Yaku.elementAt(i);		// 役
      if(strYaku != "") strYaku += ",";
      strYaku += agarikei.Yaku.elementAt(i);
    }
    strHanFu = "";
    if(agarikei.Yakuman <= 0){
      strHanFu = agarikei.Han.toString() + "翻";	// 翻
    }
    if(agarikei.Fu > 0){
      strHanFu += agarikei.Fu.toString() + "符";	// 符
    }
    txtHanFu = strHanFu;
    strScore = agarikei.GetScoreStr();
    txtScore = strScore;							// 点数
    strChip = agarikei.GetChipStr();
    txtChip = strChip;								// チップ
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                flex: 20,
                child: Text(
                  '手牌',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(0)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(1)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(2)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(3)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(4)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(5)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(6)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(7)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(8)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(9)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(10)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(11)),
              ),
              Expanded(
                flex: 5,
                child: Image.asset(imvTehai.elementAt(12)),
              ),
              Expanded(
                flex: 15,
                child: Text(''),
              ),
            ],),
            Row(children: <Widget>[
              Expanded(
                flex: 20,
                child: Text(
                  '副露牌',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro1"
                child: Image.asset(imvFuro.elementAt(0)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro2"
                child: Image.asset(imvFuro.elementAt(1)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro3"
                child: Image.asset(imvFuro.elementAt(2)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro4"
                child: Image.asset(imvFuro.elementAt(3)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro5"
                child: Image.asset(imvFuro.elementAt(4)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro6"
                child: Image.asset(imvFuro.elementAt(5)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro7"
                child: Image.asset(imvFuro.elementAt(6)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro8"
                child: Image.asset(imvFuro.elementAt(7)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro9"
                child: Image.asset(imvFuro.elementAt(8)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro10"
                child: Image.asset(imvFuro.elementAt(9)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro11"
                child: Image.asset(imvFuro.elementAt(10)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro12"
                child: Image.asset(imvFuro.elementAt(11)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro13"
                child: Image.asset(imvFuro.elementAt(12)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro14"
                child: Image.asset(imvFuro.elementAt(13)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro15"
                child: Image.asset(imvFuro.elementAt(14)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvFuro16"
                child: Image.asset(imvFuro.elementAt(15)),
              ),
            ],),
            Row(children: <Widget>[
              Expanded(
                flex: 20,
                child: Text(
                  '待ち牌',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvMati"
                child: Image.asset(imvMati),
              ),
              Expanded(
                flex: 75,
                child: Text(''),
              ),
            ],),
            Row(children: <Widget>[
              Expanded(
                flex: 20,
                child: Text(
                  'ドラ表示牌',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora1"
                child: Image.asset(imvDora.elementAt(0)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora2"
                child: Image.asset(imvDora.elementAt(1)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora3"
                child: Image.asset(imvDora.elementAt(2)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora4"
                child: Image.asset(imvDora.elementAt(3)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora5"
                child: Image.asset(imvDora.elementAt(4)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora6"
                child: Image.asset(imvDora.elementAt(5)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora7"
                child: Image.asset(imvDora.elementAt(6)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora8"
                child: Image.asset(imvDora.elementAt(7)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora9"
                child: Image.asset(imvDora.elementAt(8)),
              ),
              Expanded(
                flex: 5,
                //android:id="@+id/imvDora10"
                child: Image.asset(imvDora.elementAt(9)),
              ),
              Expanded(
                flex: 30,
                child: Text(''),
              ),
            ],),
            Row(children: <Widget>[
              Expanded(
                //android:id="@+id/txtYaku1"
                child: Text(
                  txtYaku.elementAt(0),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku2"
                child: Text(
                  txtYaku.elementAt(1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku3"
                child: Text(
                  txtYaku.elementAt(2),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku4"
                child: Text(
                  txtYaku.elementAt(3),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku5"
                child: Text(
                  txtYaku.elementAt(4),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ],),
            Row(children: <Widget>[
              Expanded(
                //android:id="@+id/txtYaku6"
                child: Text(
                  txtYaku.elementAt(5),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku7"
                child: Text(
                  txtYaku.elementAt(6),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku8"
                child: Text(
                  txtYaku.elementAt(7),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku9"
                child: Text(
                  txtYaku.elementAt(8),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku10"
                child: Text(
                  txtYaku.elementAt(9),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ],),
            Row(children: <Widget>[
              Expanded(
                //android:id="@+id/txtYaku11"
                child: Text(
                  txtYaku.elementAt(10),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku12"
                child: Text(
                  txtYaku.elementAt(11),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku13"
                child: Text(
                  txtYaku.elementAt(12),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku14"
                child: Text(
                  txtYaku.elementAt(13),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                //android:id="@+id/txtYaku15"
                child: Text(
                  txtYaku.elementAt(14),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ],),
            Row(children: <Widget>[
              Expanded(
                flex: 1,
                //android:id="@+id/txtHanFu"
                child: Text(
                  txtHanFu,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                //android:id="@+id/txtScore"
                child: Text(
                  txtScore,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                //android:id="@+id/txtChip"
                child: Text(
                  txtChip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ],),
            Row(children: <Widget>[
              Expanded(
                flex: 20,
                //android:id="@+id/txtTitle"
                child: Text(
                  'タイトル',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                flex: 50,
                //<EditText 
                //android:id="@+id/edtTitle" />
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
              SpaceBox.width(),
              Expanded(
                flex: 15,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {},
                  child: Text('保存'),
                ),
              ),
              SpaceBox.width(),
              Expanded(
                flex: 15,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('戻る'),
                ),
              ),
            ],),
          ],
        ),
      ),
    );
  }
}
