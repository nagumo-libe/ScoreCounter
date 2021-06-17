import 'package:flutter_application_1/HaiInfo.dart';
import 'package:flutter_application_1/Agarikei.dart';
import 'package:flutter_application_1/KumiInfo.dart';

import 'package:flutter/material.dart';

enum drawable{
  p1, p2, p3, p4, p5, p5r, p6, p7, p8, p9,
  s1, s2, s3, s4, s5, s5r, s6, s7, s8, s9,
  m1, m2, m3, m4, m5, m5r, m6, m7, m8, m9,
  east, south, west, north, white, green, red
}

enum FieldWind{
  btnFieldEast,
  btnFieldSouth,
  btnFieldWest,
  btnFieldNorth
}
// ignore: non_constant_identifier_names
FieldWind ModeFieldWind = FieldWind.btnFieldEast;
enum ThisWind{
  btnThisEast,
  btnThisSouth,
  btnThisWest,
  btnThisNorth
}
// ignore: non_constant_identifier_names
ThisWind ModeThisWind = ThisWind.btnThisEast;
enum Reach{
  btnReachOff,
  btnReachOn,
  btnReachDouble
}
// ignore: non_constant_identifier_names
Reach ModeReach = Reach.btnReachOff;
enum Hola{
  btnTumo,
  btnLon,
  btnTyankan,
  btnTumoSanma
}
// ignore: non_constant_identifier_names
Hola ModeHola = Hola.btnTumo;
// ignore: non_constant_identifier_names
bool ModeFirst = false;
// ignore: non_constant_identifier_names
bool ModeHaitei = false;
// ignore: non_constant_identifier_names
bool ModeRinsyan = false;
// ignore: non_constant_identifier_names
bool ModeIppatu = false;
List<HaiInfo> aryHai = [];
// ignore: non_constant_identifier_names
int NorthDora = 0;
List<Agarikei> aryPattern = [];

// テストデータ生成
// ignore: non_constant_identifier_names
void MakeTestData(){
  aryHai.clear();
  aryHai.add(new HaiInfo(drawable.s1, HaiInfo.MATI , 0));
  aryHai.add(new HaiInfo(drawable.s1, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.p9, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.p9, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.p2, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.p2, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.m4, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.m4, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.p6, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.p6, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.p8, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.p8, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.s8, HaiInfo.TEHAI, 0));
  aryHai.add(new HaiInfo(drawable.s8, HaiInfo.TEHAI, 0));
}

// ignore: non_constant_identifier_names
void Repai(List<HaiInfo> ary){
  ary.sort((a, b) {
    if(a.RedDora) {
      return 1;
    }
    return -1;
  });
  ary.sort((a, b) => a.Type - b.Type);
  ary.sort((a, b) => a.Number - b.Number);
  ary.sort((a, b) => a.Kind - b.Kind);
  ary.sort((a, b) => a.FuroIndex - b.FuroIndex);
}

// ignore: non_constant_identifier_names
String AnalaysisHai(List<HaiInfo> ary, bool ModeChk, bool TatuChk){
  for(int i = 0; i < ary.length; i++){
    ary.elementAt(i).ResetStatus();
  }
  for(int i = 0; i < ary.length; i++){
    if(ary.elementAt(i).Type == HaiInfo.DORA) continue;
    // ignore: non_constant_identifier_names
    bool Left2, Left1, Right1, Right2;
    Left2 = Left1 = Right1 = Right2 = false;
    for(int j = 0; j < ary.length; j++){
      if(i == j || ary.elementAt(i).FuroIndex != ary.elementAt(j).FuroIndex) continue;
      if(ary.elementAt(i).Equal(ary.elementAt(j))){
        if(ary.elementAt(i).Kantu){
          if (ModeChk) return "同種の牌が５枚存在します";
        } else if(ary.elementAt(i).Koutu && ary.elementAt(i).Type != HaiInfo.MATI && ary.elementAt(j).Type != HaiInfo.MATI){
          ary.elementAt(i).Kantu = true;	// 槓子
        } else if(ary.elementAt(i).Toitu){
          ary.elementAt(i).Koutu = true;	// 刻子
        } else {
          ary.elementAt(i).Toitu = true;	// 対子
        }
      } else if(ary.elementAt(i).Kind == ary.elementAt(j).Kind && ary.elementAt(i).Kind != HaiInfo.ZIHAI){
        switch(ary.elementAt(j).Number - ary.elementAt(i).Number){
          case -2: Left2  = true; break;
          case -1: Left1  = true; break;
          case 1:  Right1 = true; break;
          case 2:  Right2 = true; break;
        }
      }
    }
    if(Left2 && Left1 || Left1 && Right1 || Right1 && Right2){
      ary.elementAt(i).Syuntu = true;			// 順子
    }
    if(ModeChk){
      if(ary.elementAt(i).Type == HaiInfo.FURO){
        if(!ary.elementAt(i).Syuntu && !ary.elementAt(i).Koutu){
          return "未完成面子が存在します";
        }
      } else {
        if(!ary.elementAt(i).Toitu && !ary.elementAt(i).Syuntu && TatuChk){
          return "未完成面子が存在します";
        }
      }
    }
  }
  return "";
}

//ダイアログの表示(OKボタンだけ表示)
void showDialogOk(BuildContext context,String title,String msg) async {
  // ignore: unused_local_variable
  var result = await showDialog<int>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(msg),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 1),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// 待ち牌と同じ牌が存在するかの判定
// ignore: non_constant_identifier_names
bool ExistMatiHai(List<HaiInfo> ary){
  for (HaiInfo hai in ary) {
    if(hai.Type == HaiInfo.MATI){
      HaiInfo mati = hai;
      for (HaiInfo hai2 in ary) {
        if(hai2.Type == HaiInfo.TEHAI || hai2.Type == HaiInfo.FURO || hai2.Type == HaiInfo.DORA){
          if(hai2.Equal(mati)) return true;
        }
      }
      break;
    }
  }
  return false;
}

class SpaceBox extends SizedBox {
  SpaceBox({double width = 8, double height = 8})
      : super(width: width, height: height);
  SpaceBox.width([double value = 8]) : super(width: value);
  SpaceBox.height([double value = 8]) : super(height: value);
}

// ignore: non_constant_identifier_names
Agarikei AnalaysisAgari(List<HaiInfo> aryCopy){
//Agarikei AnalaysisAgari(List<HaiInfo> aryCopy, HaiInfo Matihai){
  // 全雀頭パターン取得
	List<Agarikei> aryJyantou = [];
  for(int i = 0; i < aryCopy.length; i++){
    aryCopy.elementAt(i).Flag = false;
  }
  for(int i = 0; i < aryCopy.length; i++){
    if(aryCopy.elementAt(i).Flag || !aryCopy.elementAt(i).Toitu) continue;
    for(int j = i + 1; j < aryCopy.length; j++){
      if(aryCopy.elementAt(i).Flag) continue;
      if(aryCopy.elementAt(i).Equal(aryCopy.elementAt(j))){
        // 同一パターン判定
        int k;
        for(k = 0; k < aryJyantou.length; k++){
          if(aryCopy.elementAt(i).EqualType(aryJyantou.elementAt(k).Jyantou.Kumi.elementAt(0))) break;
        }
        if(k >= aryJyantou.length){
          Agarikei agari = new Agarikei();
          agari.initNormal(aryCopy, i, j);
          aryJyantou.add(agari);
          // どちらかが待ち牌であれば待ち牌のみ判定済みとする
          if(aryCopy.elementAt(i).Type == HaiInfo.MATI){
            aryCopy.elementAt(i).Flag = true;
          } else if(aryCopy.elementAt(j).Type == HaiInfo.MATI){
            aryCopy.elementAt(j).Flag = true;
          } else {
            aryCopy.elementAt(i).Flag = aryCopy.elementAt(j).Flag = true;
          }
        }
        break;
      }
    }
  }
  // 雀頭パターン毎に面子判定
  aryPattern = [];
  for(int i = 0; i < aryJyantou.length; i++){
    SearchMentu(aryJyantou.elementAt(i));
  }
  // 副露牌取得
  List<HaiInfo> aryTemp = []..addAll(aryHai);
  // ignore: non_constant_identifier_names
  List<KumiInfo> FuroList = [];
  for(int i = 1; i <= 4; i++){
    // ignore: non_constant_identifier_names
    KumiInfo Furo = new KumiInfo();
    for(int j = 0; j < aryTemp.length; j++){
          if(aryTemp.elementAt(j).FuroIndex == i) Furo.Kumi.add(aryTemp.elementAt(j));
    }
    if(Furo.Kumi.length > 0){
      if(Furo.Kumi.elementAt(0).Kantu){
        Furo.Kind = KumiInfo.KANTU;
        } else if(Furo.Kumi.elementAt(0).Koutu){
          Furo.Kind = KumiInfo.KOUTU;
        } else if(Furo.Kumi.elementAt(0).Syuntu){
          Furo.Kind = KumiInfo.SYUNTU;
        }
      FuroList.add(Furo);
    }
  }
  if(FuroList.length > 0){
      // 全パターンに副露牌追加
      for(int i = 0; i < aryPattern.length; i++){
        aryPattern.elementAt(i).AddMentu(FuroList);
      }
  }
  // ドラ表示牌を除外
  for(int i = aryTemp.length - 1; i >= 0; i--){
    if(aryTemp.elementAt(i).Type == HaiInfo.DORA) aryTemp.removeAt(i);
  }
  // 待ち判定モードであれば待ち牌を追加
  //if(Matihai != null){
  //  aryTemp.add(Matihai);
  //}
  // 特殊形パターン追加
  if(aryPattern.length == 0){
    AnalaysisHai(aryTemp, false, false);
    Agarikei agari = new Agarikei();
    agari.initSpecial(aryTemp);
    aryPattern.add(agari);
  } else {
    for(int i = 0; i < aryPattern.length; i++){
      aryPattern.elementAt(i).Special = []..addAll(aryTemp);
      // 面前判定
      aryPattern.elementAt(i).SetMenzen();
    }
  }
  // パターン毎に役判定
  bool yakuman = false;
  for(int i = 0; i < aryPattern.length; i++){
    Agarikei agarikei = aryPattern.elementAt(i);
    if(agarikei.Chonbo) continue;	// 錯和であれば次へ
    if(!agarikei.Kokusi){
        agarikei.ChkAnkou(4);			// 四暗刻
        agarikei.ChkKantu(4);			// 四槓子
        agarikei.ChkSangen(9);			// 大三元
        agarikei.ChkSusi();				// 大四喜、小四喜
        agarikei.ChkTuiso();			// 字一色
        agarikei.ChkRyuiso();			// 緑一色
        agarikei.ChkTinroto();			// 清老頭
        agarikei.ChkTyuren();			// 九蓮宝燈
        agarikei.ChkTenhou();			// 天和、地和、人和
    }
    // 役満が存在した場合はそうでないパターンを除外
    if(agarikei.Yakuman > 0){
      agarikei.Score = (8000 * agarikei.Yakuman).toDouble();
      yakuman = true;
    }
    if(yakuman) continue;
    agarikei.ChkTanyao();			// 断么九
    agarikei.ChkJyuntyan();		// 純全帯么九、混全帯么九、混老頭、対々和
    agarikei.ChkTinitu();			// 清一色、混一色
    if(!agarikei.Titoitu){			// 七対子と複合しない役
        if(agarikei.Menzen){		// 面前条件
          agarikei.ChkRyanpeko();	// 二盃口、一盃口
          agarikei.ChkPinfu();	  // 平和
        }
        agarikei.ChkSansyoku();		// 三色同順、三色同刻
        agarikei.ChkIttu();			  // 一気通貫
        agarikei.ChkAnkou(3);		  // 三暗刻
        agarikei.ChkKantu(3);		  // 三槓子
        agarikei.ChkSangen(8);		// 小三元
        agarikei.ChkYakuhai();		// 役牌
        agarikei.ChkRinsyan();		// 嶺上開花
        agarikei.ChkTyankan();		// 槍槓
    }
    if(agarikei.Menzen){			// 面前条件
      agarikei.ChkReach();		// 立直、ダブル立直、一発
      agarikei.ChkMenzenTumo();	// 門前清自摸和
    }
    agarikei.ChkHaitei();			// 海底摸月、河底撈魚
    // 役なしであれば錯和
    if(agarikei.Han <= 0){
      agarikei.Chonbo = true;
    } else {
      agarikei.ChkDora();			// ドラ、赤ドラ、北ドラ
        agarikei.SetFu();			// ５翻未満であれば符計算
    }
    agarikei.SetScore();			// 点数算出
    //agarikei.OutLogMentu();
  }
  // 最高点パターンを採用
  aryPattern.sort((a, b) => b.Fu - a.Fu);
  aryPattern.sort((a, b) => b.Han - a.Han);
  aryPattern.sort((a, b) => (b.Score - a.Score).toInt());
  Agarikei agarikei = aryPattern.elementAt(0);
  if(agarikei.Chonbo){
    agarikei.Yaku.add("錯和");
    agarikei.Score = -2000;
  }
  return agarikei;
}

int sortKumiInfo(KumiInfo obj0, KumiInfo obj1) {
  int ret;
  ret = obj0.Kumi.length - obj1.Kumi.length; if(ret != 0) return ret;
  for(int i = 0; i < obj0.Kumi.length; i++){
      ret = obj0.Kumi.elementAt(i).Kind   - obj1.Kumi.elementAt(i).Kind;   if(ret != 0) return ret;
      ret = obj0.Kumi.elementAt(i).Number - obj1.Kumi.elementAt(i).Number; if(ret != 0) return ret;
  }
  return 0;
}

// ignore: non_constant_identifier_names
void SearchMentu(Agarikei aryWork){
  if(aryWork.UnKnown.length == 0){
    // 面子毎にソート
    aryWork.Mentu.sort(sortKumiInfo);
    // 確定済み和了パターン判定
    int j;
    for(j = 0; j < aryPattern.length; j++){
      if(aryPattern.elementAt(j).Equal(aryWork)) break;
    }
    if(j >= aryPattern.length){
      //aryWork.OutLogMentu();
      // 和了パターン確定
        aryPattern.add(aryWork);
    }
  } else {
    AnalaysisHai(aryWork.UnKnown, false, false);
    for(int j = 0; j < aryWork.UnKnown.length; j++){
      HaiInfo hai = aryWork.UnKnown.elementAt(j);
      if(hai.Syuntu){
        aryWork.ChkSyuntu(hai);
        if(hai.Sleft){
          Agarikei arySub = new Agarikei();
          arySub.copy(aryWork);
          arySub.AddSyuntu(hai, 0);
          SearchMentu(arySub);
        }
        if(hai.Scenter){
          Agarikei arySub = new Agarikei();
          arySub.copy(aryWork);
          arySub.AddSyuntu(hai, 1);
          SearchMentu(arySub);
        }
        if(hai.Sright){
          Agarikei arySub = new Agarikei();
          arySub.copy(aryWork);
          arySub.AddSyuntu(hai, 2);
          SearchMentu(arySub);
        }
      }
      if(hai.Kantu && hai.FuroIndex != 0){
        Agarikei arySub = new Agarikei();
        arySub.copy(aryWork);
        arySub.AddKantu(hai);
        SearchMentu(arySub);
      }
      if(hai.Koutu){
        Agarikei arySub = new Agarikei();
        arySub.copy(aryWork);
        arySub.AddKoutu(hai);
        SearchMentu(arySub);
      }
    }
  }
}
