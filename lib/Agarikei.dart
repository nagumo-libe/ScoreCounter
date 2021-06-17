import 'CommonInfo.dart' as ci;
import 'package:flutter_application_1/CommonInfo.dart';
import 'package:flutter_application_1/HaiInfo.dart';
import 'package:flutter_application_1/KumiInfo.dart';

import 'dart:math' as Math;

class Agarikei {
  // ignore: non_constant_identifier_names
	late List<HaiInfo> UnKnown;	// 未確定
  // ignore: non_constant_identifier_names
	late KumiInfo Jyantou;			// 雀頭
  // ignore: non_constant_identifier_names
	late List<KumiInfo> Mentu;	// 面子
  // ignore: non_constant_identifier_names
	late List<HaiInfo> Special;	// 特殊形　OR　通常形の判定前情報
  // ignore: non_constant_identifier_names
	late List<String> Yaku;		// 役名称
  // ignore: non_constant_identifier_names
	late bool Menzen;				// 面前
  // ignore: non_constant_identifier_names
	late bool Chonbo;				// 錯和
  // ignore: non_constant_identifier_names
	late bool Kokusi;				// 国士
  // ignore: non_constant_identifier_names
	late bool Titoitu;				// 七対子
  // ignore: non_constant_identifier_names
	late int Han;						// 翻
  // ignore: non_constant_identifier_names
	late int Fu;						// 符
  // ignore: non_constant_identifier_names
	late int Yakuman;					// 役満数
  // ignore: non_constant_identifier_names
	late double Score;				// 子のツモ和了で子１人が払う点数
  // ignore: non_constant_identifier_names
	late int Chip;					// チップ枚数
  // ignore: non_constant_identifier_names
	//late HaiInfo Matihai;				// 待ち牌（待ち牌判定用）
  // ignore: non_constant_identifier_names
	late bool Tumo;				// 自摸
	
	// 通常形
	void initNormal(List<HaiInfo> aryHai, int idx1, int idx2){
		UnKnown = []..addAll(aryHai);
		Jyantou = new KumiInfo();
		Jyantou.AddToitu(UnKnown.elementAt(idx1), UnKnown.elementAt(idx2));
		UnKnown.removeAt(idx2);
		UnKnown.removeAt(idx1);
		Mentu   = [];
		Special = [];
		Yaku    = [];
		Menzen = Chonbo = Kokusi = Titoitu = false;
		Han = Fu = Yakuman = Chip = 0;
		Score = 0.0;
		//Matihai = null;
		SetTumo();
	}
	
	//　特殊形（七対子、国士）
	void initSpecial(List<HaiInfo> aryHai){
		UnKnown = []..addAll(aryHai);
		Mentu   = [];
		Han = Fu = Yakuman = Chip = 0;
		Score = 0.0;
		Jyantou = new KumiInfo();
		Special = []..addAll(aryHai);
		Yaku    = [];
		Kokusi  = Titoitu = false;
		//Matihai = null;
		SetMenzen();
    // 面前でなければ錯和
		Chonbo = !Menzen;
		if(Chonbo) return;
		// 雀頭が無ければ錯和
		Chonbo = true;
    for(int i = 0; i < aryHai.length; i++){
      if(!aryHai.elementAt(i).Toitu) continue;
      for(int j = i + 1; j < aryHai.length; j++){
          if(aryHai.elementAt(i).Equal(aryHai.elementAt(j))){
            Jyantou.AddToitu(aryHai.elementAt(i), aryHai.elementAt(j));
            UnKnown.remove(aryHai.elementAt(j));
            UnKnown.remove(aryHai.elementAt(i));
            Chonbo = false;
            break;
          }
      }
      if(!Chonbo) break;
    }
    ChkKokusi();		// 国士無双
    if(!Kokusi){
      ChkTitoitu();	// 七対子
      // どちらでもなければ錯和
      if(!Titoitu) Chonbo = true;
    }
    SetTumo();
	}
	
	// コピー
	void copy(Agarikei agari){
		UnKnown  = []..addAll(agari.UnKnown);
		Jyantou  = agari.Jyantou;
		Mentu    = []..addAll(agari.Mentu);
		Special  = []..addAll(agari.Special);
		Yaku     = []..addAll(agari.Yaku);
		Menzen   = agari.Menzen;
		Chonbo   = agari.Chonbo;
		Kokusi   = agari.Kokusi;
		Titoitu  = agari.Titoitu;
		Han      = agari.Han;
		Fu       = agari.Fu;
		Score    = agari.Score;
		Chip     = agari.Chip;
		//Matihai  = agari.Matihai;
		Tumo     = agari.Tumo;
	}
	
  // ignore: non_constant_identifier_names
	void SetTumo(){
		Tumo = (ci.ModeHola == Hola.btnTumo || ci.ModeHola == Hola.btnTumoSanma);
	}
	
  // ignore: non_constant_identifier_names
	void SetMenzen(){
		Menzen = false;
		for(int i = 0; i < Special.length; i++){
			if(Special.elementAt(i).FuroIndex != 0 && !Special.elementAt(i).AnKan) return;
		}
		Menzen = true;
	}
	
  // ignore: non_constant_identifier_names
	void AddKantu(HaiInfo hai){
		Mentu.add(new KumiInfo());
		KumiInfo kantu = Mentu.elementAt(Mentu.length - 1);
		kantu.Kind = KumiInfo.KANTU;
		for(int i = UnKnown.length - 1, num = 0; i >= 0 && num < 4; i--){
			if(hai.Equal(UnKnown.elementAt(i))){
				kantu.Kumi.add(UnKnown.elementAt(i));
				UnKnown.removeAt(i);
				num++;
			}
		}		
	}
	
  // ignore: non_constant_identifier_names
	void AddKoutu(HaiInfo hai){
		Mentu.add(new KumiInfo());
		KumiInfo koutu = Mentu.elementAt(Mentu.length - 1);
		koutu.Kind = KumiInfo.KOUTU;
		for(int i = UnKnown.length - 1, num = 0; i >= 0 && num < 3; i--){
			if(hai.Equal(UnKnown.elementAt(i))){
				koutu.Kumi.add(UnKnown.elementAt(i));
				UnKnown.removeAt(i);
				num++;
			}
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkSyuntu(HaiInfo syuntu){
    // ignore: non_constant_identifier_names
		bool Left2, Left1, Right1, Right2;
		Left2 = Left1 = Right1 = Right2 = false;
		for(int i = 0; i < UnKnown.length; i++){
			if(UnKnown.elementAt(i).Syuntu && (UnKnown.elementAt(i).Kind == syuntu.Kind)){
				switch(UnKnown.elementAt(i).Number - syuntu.Number){
					case -2: Left2  = true; break;
					case -1: Left1  = true; break;
					case  1: Right1 = true; break;
					case  2: Right2 = true; break;
				}
			}
		}
		syuntu.Sleft   = Right1 && Right2;
		syuntu.Scenter = Left1 && Right1;
		syuntu.Sright  = Left2 && Left1;
	}

	// mode　0:左　1:中　2:右
  // ignore: non_constant_identifier_names
	void AddSyuntu(HaiInfo hai, int mode){
    // ignore: non_constant_identifier_names
		bool Left2, Left1, Right1, Right2, Self;
		Left2 = Left1 = Right1 = Right2 = false;
		Self = true;
		switch(mode){
			case 0: Right1 = true; Right2 = true; break;
			case 1: Left1  = true; Right1 = true; break;
			case 2: Left2  = true; Left1  = true; break;
		}
		Mentu.add(new KumiInfo());
		KumiInfo syuntu = Mentu.elementAt(Mentu.length - 1);
		syuntu.Kind = KumiInfo.SYUNTU;
		for(int i = 0; i < UnKnown.length; i++){
			if(UnKnown.elementAt(i).Syuntu && (UnKnown.elementAt(i).Kind == hai.Kind)){
				switch(UnKnown.elementAt(i).Number - hai.Number){
					case -2: if(Left2) { syuntu.Kumi.add(UnKnown.elementAt(i)); UnKnown.removeAt(i); i--; Left2 =  false; } break;
					case -1: if(Left1) { syuntu.Kumi.add(UnKnown.elementAt(i)); UnKnown.removeAt(i); i--; Left1  = false; } break;
					case  0: if(Self)  { syuntu.Kumi.add(UnKnown.elementAt(i)); UnKnown.removeAt(i); i--; Self   = false; } break;
					case  1: if(Right1){ syuntu.Kumi.add(UnKnown.elementAt(i)); UnKnown.removeAt(i); i--; Right1 = false; } break;
					case  2: if(Right2){ syuntu.Kumi.add(UnKnown.elementAt(i)); UnKnown.removeAt(i); i--; Right2 = false; } break;
				}
			}
		}
	}
	
  // ignore: non_constant_identifier_names
	void AddMentu(List<KumiInfo> mentu){
		for(int i = 0; i < mentu.length; i++){
			Mentu.add(mentu.elementAt(i));
		}
	}

  // ignore: non_constant_identifier_names
	bool Equal(Agarikei agari){
		if(Jyantou.Kumi.length != agari.Jyantou.Kumi.length) return false;
		for(int i = 0; i < Jyantou.Kumi.length; i++){
			if(!Jyantou.Kumi.elementAt(i).Equal(agari.Jyantou.Kumi.elementAt(i))) return false;
		}
		if(Mentu.length != agari.Mentu.length) return false;
		for(int i = 0; i < Mentu.length; i++){
			List<HaiInfo> kumi = Mentu.elementAt(i).Kumi;
			if(kumi.length != agari.Mentu.elementAt(i).Kumi.length) return false;
			for(int j = 0; j < kumi.length; j++){
				if(!kumi.elementAt(j).Equal(agari.Mentu.elementAt(i).Kumi.elementAt(j))) return false;
				if(kumi.elementAt(j).Type != agari.Mentu.elementAt(i).Kumi.elementAt(j).Type) return false;
			}
		}
		return true;
	}
	
  // ignore: non_constant_identifier_names
	bool EqualResult(Agarikei agari){
    // ignore: unnecessary_null_comparison
		if(agari == null) return false;
		if(Score != agari.Score) return false;
		if(Chip != agari.Chip) return false;
		if(Han != agari.Han) return false;
		if(Yaku.length != agari.Yaku.length) return false;
		for(int i = 0; i < Yaku.length; i++){
			if(Yaku.elementAt(i) != agari.Yaku.elementAt(i)) return false;
		}
		return true;
	}
  /*
	void OutLogMentu(){
		String msg = "";
		for(int i = 0; i < Mentu.length; i++){
			List<HaiInfo> kumi = Mentu.elementAt(i).Kumi;
			for(int j = 0; j < kumi.length; j++){
				msg += kumi.elementAt(j).GetHaiName() + " ";
			}
		}
		Log.i("面子", msg);
		msg = "";
		for(int i = 0; i < Yaku.length; i++){
			msg += Yaku.elementAt(i) + " ";
		}
		if(msg == "") msg = "役なし";
		Log.i("役", msg);
		Log.i("翻", Integer.toString(Han));
		Log.i("符", Integer.toString(Fu));
		Log.i("点数", Double.toString(Score));
	}
	*/  
  // ignore: non_constant_identifier_names
	void SetFu(){
    	if(Han < 5){
    		if(Titoitu){
    			Fu = 25;
    		} else {
    			// 基本符
    			Fu = 20;
    			// 面前加符
    			if((ci.ModeHola == Hola.btnLon || ci.ModeHola == Hola.btnTyankan) && Menzen) Fu += 10;
    			// ツモ符
    			if(Tumo) Fu += 2;
    			// 雀頭
    			if(Jyantou.Kumi.elementAt(0).Kind == HaiInfo.ZIHAI){
    				if(Jyantou.Kumi.elementAt(0).Number == HaiInfo.HAKU ||
               Jyantou.Kumi.elementAt(0).Number == HaiInfo.HATU ||
               Jyantou.Kumi.elementAt(0).Number == HaiInfo.TYUN
            ){
    				  Fu += 2;
            } else {
              if(Jyantou.Kumi.elementAt(0).IsFieldWind()) Fu += 2;
              if(Jyantou.Kumi.elementAt(0).IsThisWind())  Fu += 2;
    				}
    			}
    			// 面子
    			for(int i = 0; i < Mentu.length; i++){
    				if(Mentu.elementAt(i).Kind == KumiInfo.KOUTU){ // 刻子
              if(Mentu.elementAt(i).Kumi.elementAt(0).IsYaotyu()){
                  if(Mentu.elementAt(i).IsAnkou()){ Fu += 8; } else { Fu += 4; }
              } else {
                  if(Mentu.elementAt(i).IsAnkou()){ Fu += 4; } else { Fu += 2; }
              }
            } else if(Mentu.elementAt(i).Kind == KumiInfo.KANTU){ // 槓子
              if(Mentu.elementAt(i).Kumi.elementAt(0).IsYaotyu()){
                if(Mentu.elementAt(i).Kumi.elementAt(0).AnKan){ Fu += 32; } else { Fu += 16; }
              } else {
                if(Mentu.elementAt(i).Kumi.elementAt(0).AnKan){ Fu += 16; } else { Fu += 8; }
              }
            }
    			}
    			// 待ち
    			for(int i = 0; i < Jyantou.Kumi.length; i++){
    				if(Jyantou.Kumi.elementAt(i).Type == HaiInfo.MATI){
    					Fu += 2; break;	// 単騎
    				}
    			}
    			for(int i = 0; i < Mentu.length; i++){
    				if(Mentu.elementAt(i).Kind != KumiInfo.SYUNTU) continue;
    				List<HaiInfo> kumi = Mentu.elementAt(i).Kumi;
    				for(int j = 0; j < kumi.length; j++){
	    				if(kumi.elementAt(j).Type == HaiInfo.MATI){
    						switch(j){
    							case 1:
    								Fu += 2; break;							// 嵌張
    							case 0:
    								if(kumi.elementAt(j).Number == 7) Fu += 2; 	// 辺張
    								break;
    							case 2:
    								if(kumi.elementAt(j).Number == 3) Fu += 2; 	// 辺張
    								break;
    						}
	    					break;
	    				}
    				}
    			}
    			// 切り上げ
    			Fu = Kiriage(Fu.toDouble(), 10);
    			if(Han == 1 && Fu == 20){
        			// １翻２０符は３０符
    				Fu = 30;
    			} else {
    				// ピンヅモのみ２０符
            // ignore: non_constant_identifier_names
    				bool Pinfu;
    				Pinfu = false;
    				for(int i = 0; i < Yaku.length; i++){
    					if(Yaku.elementAt(i) == "平和"){
    						Pinfu = true;
    					}
    				}
    				if(Pinfu && Tumo){
        				Fu = 20;
    				}
    			}
    		}
    	}
	}
	
  // ignore: non_constant_identifier_names
	int Kiriage(double val, int num){
		double d = val / num;
		return d.ceil() * num;
	}
	
  // ignore: non_constant_identifier_names
	void SetScore(){
		if(Han < 5){						          // 満貫以下
			Score = (Math.pow(2, Han + 2) * Fu).toDouble();
			if(Score > 2000) Score = 2000;
		} else if(Han == 5){				      // 満貫
			Score = 2000;
		} else if(6 <= Han && Han < 8 ){	// 跳満
			Score = 3000;
		} else if(8 <= Han && Han < 11 ){	// 倍満
			Score = 4000;
		} else if(11 <= Han && Han < 13 ){// 三倍満
			Score = 6000;
		} else if(13 <= Han){				      // 数え役満
			Score = 8000;
		}
    if(Score <= 0) Chonbo = true;		// 役なしであれば錯和
	}
	
  // ignore: non_constant_identifier_names
	void ChkRyanpeko(){
		List<KumiInfo> copyMentu = []..addAll(Mentu);
    // ignore: non_constant_identifier_names
		int Cnt = 0;
		for(int i = 0; i < copyMentu.length; i++){
			int j;
			for(j = i + 1; j < copyMentu.length; j++){
				if(copyMentu.elementAt(i).Equal(copyMentu.elementAt(j))) break;
			}
			if(j < copyMentu.length){
				copyMentu.removeAt(j);
				copyMentu.removeAt(i);
				Cnt++;
				i--;
			}
		}
		switch(Cnt){
			case 1: Yaku.add("一盃口"); Han++;  break;
			case 2: Yaku.add("二盃口"); Han+=3; break;
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkJyuntyan(){
    // ignore: non_constant_identifier_names
		int i, CtKoutu, CtYaotyu, CtZyun;
		for(i = CtKoutu = CtYaotyu = CtZyun = 0; i < Mentu.length; i++){
			if(Mentu.elementAt(i).Kind == KumiInfo.KOUTU || Mentu.elementAt(i).Kind == KumiInfo.KANTU) CtKoutu++;
			if(Mentu.elementAt(i).Kumi.elementAt(0).IsYaotyu() || Mentu.elementAt(i).Kumi.elementAt(Mentu.elementAt(i).Kumi.length - 1).IsYaotyu()){
				CtYaotyu++;
				if(Mentu.elementAt(i).Kumi.elementAt(0).Kind != HaiInfo.ZIHAI) CtZyun++;
			}
		}
		if(Jyantou.Kumi.elementAt(0).IsYaotyu()){
			CtYaotyu++;
			if(Jyantou.Kumi.elementAt(0).Kind != HaiInfo.ZIHAI) CtZyun++;
		}
		if(CtKoutu >= Mentu.length && !Titoitu){
			Yaku.add("対々和"); Han+=2;
		}
		if(!Jyantou.Kumi.elementAt(0).IsYaotyu() || CtYaotyu < Mentu.length + 1) return;
		if(CtZyun >= Mentu.length + 1 && !Titoitu){
			Yaku.add("純全帯么九"); Han+=2;
			if(Menzen) Han++;
		} else if(CtYaotyu >= Mentu.length + 1 && CtKoutu >= Mentu.length){
			if(Titoitu){
				for(int j = 0; j < Special.length; j++){
					if(!Special.elementAt(j).IsYaotyu()) return;
				}
			}
			Yaku.add("混老頭"); Han+=2;
		} else {
			Yaku.add("混全帯么九"); Han++;
			if(Menzen) Han++;
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkHaitei(){
		if(ci.ModeHaitei){
			Han++;
			if(Tumo){
				Yaku.add("海底摸月");
			} else {
				Yaku.add("河底撈魚");
			}
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkReach(){
		if(ci.ModeReach == Reach.btnReachOn){
			Yaku.add("立直"); Han++;
    } else if(ci.ModeReach == Reach.btnReachDouble){
			Yaku.add("ダブル立直"); Han+=2;
		}
		if(ci.ModeIppatu){
			Yaku.add("一発"); Han++; Chip++;
		}
	}

  // ignore: non_constant_identifier_names
	void ChkTyankan(){
		if(ci.ModeHola == Hola.btnTyankan && !ci.ExistMatiHai(Special)){
			Yaku.add("槍槓"); Han++;
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkRinsyan(){
		if(ci.ModeRinsyan){
			Yaku.add("嶺上開花"); Han++;
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkMenzenTumo(){
		if(Tumo){
			Yaku.add("門前清自摸和"); Han++;
		}
	}
		
  // ignore: non_constant_identifier_names
	void ChkPinfu(){
		// 雀頭
		if(Jyantou.Kumi.elementAt(0).Kind == HaiInfo.ZIHAI){
      if(Jyantou.Kumi.elementAt(0).Number == HaiInfo.HAKU ||
         Jyantou.Kumi.elementAt(0).Number == HaiInfo.HATU ||
         Jyantou.Kumi.elementAt(0).Number == HaiInfo.TYUN
      ){
        return;
      } else {
					if(Jyantou.Kumi.elementAt(0).IsFieldWind()) return;
					if(Jyantou.Kumi.elementAt(0).IsThisWind())  return;
			}
		}
		// 待ち
		for(int i = 0; i < Jyantou.Kumi.length; i++){
			if(Jyantou.Kumi.elementAt(i).Type == HaiInfo.MATI){
				return;	// 単騎
			}
		}
		// 面子
		for(int i = 0; i < Mentu.length; i++){
      if(Mentu.elementAt(i).Kind == KumiInfo.KOUTU || // 刻子
         Mentu.elementAt(i).Kind == KumiInfo.KANTU	  // 槓子
      ){
				return;
			}
			List<HaiInfo> kumi = Mentu.elementAt(i).Kumi;
			for(int j = 0; j < kumi.length; j++){
				if(kumi.elementAt(j).Type == HaiInfo.MATI){
					switch(j){
						case 1:
							return;			// 嵌張
						case 0:
							if(kumi.elementAt(j).Number == 7){
								return; 	// 辺張
							}
							break;
						case 2:
							if(kumi.elementAt(j).Number == 3){
								return; 	// 辺張
							}
							break;
					}
					break;
				}
			}
		}		
		Yaku.add("平和");
		Han++;
	}
	
  // ignore: non_constant_identifier_names
	void ChkTanyao(){
		for(int i = 0; i < Special.length; i++){
			if(Special.elementAt(i).IsYaotyu()) return;
		}
		Yaku.add("断么九 ");
		Han++;
	}
	
  // ignore: non_constant_identifier_names
	void ChkYakuhai(){
		for(int i = 0; i < Mentu.length; i++){
			if(Mentu.elementAt(i).Kind != KumiInfo.KOUTU && Mentu.elementAt(i).Kind != KumiInfo.KANTU) continue;
			if(Mentu.elementAt(i).Kumi.elementAt(0).Kind != HaiInfo.ZIHAI) continue;
			if(Mentu.elementAt(i).Kumi.elementAt(0).Number == HaiInfo.HAKU){
				Yaku.add("白"); Han++;
      } else if(Mentu.elementAt(i).Kumi.elementAt(0).Number == HaiInfo.HATU){
				Yaku.add("発"); Han++;
      } else if(Mentu.elementAt(i).Kumi.elementAt(0).Number == HaiInfo.TYUN){
				Yaku.add("中"); Han++;
      } else {
        if(Mentu.elementAt(i).Kumi.elementAt(0).IsFieldWind()){
          Yaku.add("場風牌"); Han++;
        }
        if(Mentu.elementAt(i).Kumi.elementAt(0).IsThisWind()){
          Yaku.add("自風牌"); Han++;
        }
			}
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkSansyoku(){
		bool pinzu, souzu, manzu;
		for(int i = 0; i < Mentu.length; i++){
			pinzu = souzu = manzu = false;
			if(Mentu.elementAt(i).Kumi.elementAt(0).Kind == HaiInfo.PINZU){
				pinzu = true;
      } else if(Mentu.elementAt(i).Kumi.elementAt(0).Kind == HaiInfo.SOUZU){
				souzu = true;
      } else if(Mentu.elementAt(i).Kumi.elementAt(0).Kind == HaiInfo.MANZU){
				manzu = true;
      } else if(Mentu.elementAt(i).Kumi.elementAt(0).Kind == HaiInfo.ZIHAI){
				continue;
			}
			for(int j = 0; j < Mentu.length; j++){
				if(i == j) continue;
				if(Mentu.elementAt(i).Kumi.elementAt(0).Number != Mentu.elementAt(j).Kumi.elementAt(0).Number) continue;
				if(Mentu.elementAt(i).Kind == KumiInfo.SYUNTU){
					if(Mentu.elementAt(j).Kind != KumiInfo.SYUNTU) continue;
				} else if(Mentu.elementAt(i).Kind == KumiInfo.KOUTU ||
                  Mentu.elementAt(i).Kind == KumiInfo.KANTU){
					if(Mentu.elementAt(j).Kind != KumiInfo.KOUTU && Mentu.elementAt(j).Kind != KumiInfo.KANTU) continue;
				}
				if(Mentu.elementAt(j).Kumi.elementAt(0).Kind == HaiInfo.PINZU){
					pinzu = true;
				} else if(Mentu.elementAt(j).Kumi.elementAt(0).Kind == HaiInfo.SOUZU){
					souzu = true;
				} else if(Mentu.elementAt(j).Kumi.elementAt(0).Kind == HaiInfo.MANZU){
					manzu = true;
				}
			}
			if(pinzu && souzu && manzu){
				if(Mentu.elementAt(i).Kind == KumiInfo.SYUNTU){
					Yaku.add("三色同順");
				} else {
					Yaku.add("三色同刻");
				}
				Han++;
				if(Menzen) Han++;
				return;
			}
		}
	}
	
  // ignore: non_constant_identifier_names
  void ChkTinitu(){
		int idx;
		for(idx = 0; idx < Special.length; idx++){
			if(Special.elementAt(idx).Kind != HaiInfo.ZIHAI){
				break;
			}
		}
		if(idx >= Special.length) return;
    // ignore: non_constant_identifier_names
		bool Tinitu = true;
		for(int i = 0; i < Special.length; i++){
			if(Special.elementAt(idx).Kind != Special.elementAt(i).Kind){
				Tinitu = false;
				if(Special.elementAt(i).Kind != HaiInfo.ZIHAI) return;
			}
		}
		if(Tinitu){
			Yaku.add("清一色"); Han += 5;
		} else {
			Yaku.add("混一色 "); Han += 2;
		}
		if(Menzen) Han++;
	}
		
  // ignore: non_constant_identifier_names
	void ChkIttu(){
		bool p1, p4, p7, s1, s4, s7, m1, m4, m7;
		p1 = p4 = p7 = s1 = s4 = s7 = m1 = m4 = m7 = false;
		for(int i = 0; i < Mentu.length; i++){
			if(Mentu.elementAt(i).Kind == KumiInfo.SYUNTU){
				switch(Mentu.elementAt(i).Kumi.elementAt(0).ImageFile){
					case drawable.p1: p1 = true; break;
					case drawable.p4: p4 = true; break;
					case drawable.p7: p7 = true; break;
					case drawable.s1: s1 = true; break;
					case drawable.s4: s4 = true; break;
					case drawable.s7: s7 = true; break;
					case drawable.m1: m1 = true; break;
					case drawable.m4: m4 = true; break;
					case drawable.m7: m7 = true; break;
          default:                     break;
				}
			}
		}
		if( (p1 && p4 && p7) || (s1 && s4 && s7) || (m1 && m4 && m7) ){
			Yaku.add("一気通貫 ");
			Han++;
			if(Menzen) Han++;			
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkSangen(int cnt){
    // ignore: non_constant_identifier_names
		int CntWhite, CntGreen, CntRed;
		CntWhite = CntGreen = CntRed = 0;
		for(int j = 0; j < Special.length; j++){
			switch(Special.elementAt(j).ImageFile){
				case drawable.white: CntWhite++; break;
				case drawable.green: CntGreen++; break;
				case drawable.red:   CntRed++;   break;
        default:                         break;
			}
		}
		if(CntWhite > 3) CntWhite = 3;
		if(CntGreen > 3) CntGreen = 3;
		if(CntRed > 3)   CntRed = 3;
		if(cnt > CntWhite + CntGreen + CntRed) return;
		if(cnt >= 9){
			Yaku.add("大三元");
			Yakuman++;
		} else {
			Yaku.add("小三元");
			Han += 2;
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkKantu(int num){
    // ignore: non_constant_identifier_names
		int CntKantu = 0;
		for(int i = 0; i < Mentu.length; i++){
			if(Mentu.elementAt(i).Kind == KumiInfo.KANTU) CntKantu++;
		}
		if(num <= CntKantu){
			switch(num){
				case 3:
					Yaku.add("三槓子"); Han += 2;
					break;
				case 4:
					Yaku.add("四槓子"); Yakuman++;
					break;
			}
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkAnkou(int num){
    // ignore: non_constant_identifier_names
		int Ankou = 0;
		for(int i = 0; i < Mentu.length; i++){
			if(Mentu.elementAt(i).Kind == KumiInfo.KOUTU){
        if(Mentu.elementAt(i).IsAnkou()){
          Ankou++;
        }
      } else if(Mentu.elementAt(i).Kind == KumiInfo.KANTU){
				if(Mentu.elementAt(i).Kumi.elementAt(0).AnKan || Mentu.elementAt(i).Kumi.elementAt(0).Type == HaiInfo.TEHAI) Ankou++;
			}
		}
		if(num <= Ankou){
			switch(num){
				case 3:
					Yaku.add("三暗刻"); Han += 2;
					break;
				case 4:
					int i;
	    			for(i = 0; i < Jyantou.Kumi.length; i++){
	    				if(Jyantou.Kumi.elementAt(i).Type == HaiInfo.MATI){
	    					Yaku.add("四暗刻単騎"); Yakuman+=2;
	    					break;
	    				}
	    			}
	    			if(i >= Jyantou.Kumi.length){
						Yaku.add("四暗刻"); Yakuman++;
	    			}
					break;
			}
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkDora(){
		List<HaiInfo> aryDora = [];
		for(int i = 0; i < ci.aryHai.length; i++){
			HaiInfo hai = ci.aryHai.elementAt(i);
			aryDora.add(new HaiInfo(hai.ImageFile, hai.Type, hai.FuroIndex));
			aryDora.elementAt(i).Uradora = hai.Uradora;
		}
		for(int i = aryDora.length - 1; i >= 0; i--){
			HaiInfo hai = aryDora.elementAt(i);
			if(hai.Type == HaiInfo.DORA){
				// ドラ表示牌をドラ牌に変更
				if(hai.Kind == HaiInfo.ZIHAI){
					if(hai.Number == HaiInfo.TON){
						hai.Number = HaiInfo.NAN;
					} else if(hai.Number == HaiInfo.NAN){
						hai.Number = HaiInfo.SHA;
					} else if(hai.Number == HaiInfo.SHA){
						hai.Number = HaiInfo.PE;
					} else if(hai.Number == HaiInfo.PE){
						hai.Number = HaiInfo.TON;
					} else if(hai.Number == HaiInfo.HAKU){
						hai.Number = HaiInfo.HATU;
					} else if(hai.Number == HaiInfo.HATU){
						hai.Number = HaiInfo.TYUN;
					} else if(hai.Number == HaiInfo.TYUN){
						hai.Number = HaiInfo.HAKU;
					}
				} else {
					if(hai.Number == 9){
						hai.Number = 1;
					} else {
						hai.Number++;
					}
				}
			} else {
				aryDora.removeAt(i);
			}
		}
    // ignore: non_constant_identifier_names
		int CntRedDora = 0;
		for(int j = 0; j < Special.length; j++){
			if(Special.elementAt(j).RedDora) CntRedDora++; // 赤ドラ
		}
		if(CntRedDora > 0) Chip += CntRedDora;
    // ignore: non_constant_identifier_names
		int CntDora = CntRedDora;
		for(int i = aryDora.length - 1; i >= 0; i--){
			for(int j = 0; j < Special.length; j++){
				if(Special.elementAt(j).Equal(aryDora.elementAt(i))){
					CntDora++;	// ドラ
					if(aryDora.elementAt(i).Uradora) Chip++;
				}
			}
		}
		// 北ドラ
		CntDora += ci.NorthDora;
		if(CntDora > 0){
			Yaku.add("ドラ" + CntDora.toString());
			Han += CntDora;
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkTenhou(){
		if(ci.ModeFirst){
			if(Tumo){
				if(ci.ModeThisWind == ThisWind.btnThisEast){
					Yaku.add("天和");
				} else {
					Yaku.add("地和");
				}
			} else {
				Yaku.add("人和");
			}
			Yakuman++;
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkSusi(){
    // ignore: non_constant_identifier_names
		int CntEast, CntSouth, CntWest, CntNorth;
		CntEast = CntSouth = CntWest = CntNorth = 0;
		for(int j = 0; j < Special.length; j++){
			switch(Special.elementAt(j).ImageFile){
				case drawable.east:  CntEast++;  break;
				case drawable.south: CntSouth++; break;
				case drawable.west:  CntWest++;  break;
				case drawable.north: CntNorth++; break;
        default:                         break;
			}
		}
		if(CntEast > 3)  CntEast = 3;
		if(CntSouth > 3) CntSouth = 3;
		if(CntWest > 3)  CntWest = 3;
		if(CntNorth > 3) CntNorth = 3;
    // ignore: non_constant_identifier_names
		int CntAll = CntEast + CntSouth + CntWest + CntNorth;
		if(CntAll >= 12){
			Yaku.add("大四喜");
			Yakuman+=2;
		} else if(CntAll >= 11) {
			Yaku.add("小四喜");
			Yakuman++;
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkTuiso(){
		for(int j = 0; j < Special.length; j++){
			if(Special.elementAt(j).Kind != HaiInfo.ZIHAI) return;
		}
		Yaku.add("字一色");
		Yakuman++;
	}
	
  // ignore: non_constant_identifier_names
	void ChkRyuiso(){
		for(int j = 0; j < Special.length; j++){
			switch(Special.elementAt(j).ImageFile){
				case drawable.s2:
				case drawable.s3:
				case drawable.s4:
				case drawable.s6:
				case drawable.s8:
				case drawable.green:
					break;
				default:
					return;
			}
		}
		Yaku.add("緑一色");
		Yakuman++;
	}
	
  // ignore: non_constant_identifier_names
	void ChkTinroto(){
		for(int j = 0; j < Special.length; j++){
			HaiInfo hai = Special.elementAt(j);
			if(hai.Kind == HaiInfo.ZIHAI) return;
			if(hai.Number != 1 && hai.Number != 9) return;
		}
		Yaku.add("清老頭");
		Yakuman++;
	}
	
  // ignore: non_constant_identifier_names
	void ChkTyuren(){
		if(Special.elementAt(0).Kind == HaiInfo.ZIHAI) return;
		if(!Menzen) return;
		// １か９が暗槓の場合は成立しない
		if(Special.length != 14) return;
    // ignore: non_constant_identifier_names
		List<int> Cnt = [0, 0, 0, 0, 0, 0, 0, 0, 0];
		int mati = 0;
		for(int i = 0; i < Special.length; i++){
			HaiInfo hai = Special.elementAt(i);
			if(Special.elementAt(0).Kind != hai.Kind) return;
			Cnt[hai.Number - 1]++;
			if(hai.Type == HaiInfo.MATI){
				mati = hai.Number;
			}
		}
		if(Cnt[0] < 3) return;
		if(Cnt[Cnt.length - 1] < 3) return;
		for(int i = 1; i < Cnt.length - 1; i++){
			if(Cnt[i] < 1) return;
		}
    // ignore: non_constant_identifier_names
		bool Jyunsei;
		if(mati == 1 || mati == Cnt.length){
			Jyunsei = (Cnt[mati - 1] == 4);
		} else {
			Jyunsei = (Cnt[mati - 1] == 2);
		}
		if(Jyunsei){
			Yaku.add("純正九蓮宝燈");
			Yakuman+=2;
		} else {
			Yaku.add("九蓮宝燈");
			Yakuman++;
		}
	}
	
  // ignore: non_constant_identifier_names
	void ChkKokusi(){
		if(Special.length != 14) return;
    // ignore: non_constant_identifier_names
		List<int> Cnt = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		int mati = -1;
		for(int i = 0; i < Special.length; i++){
			HaiInfo hai = Special.elementAt(i);
			if(!hai.IsYaotyu()) return;
			int num = -1;
			if(hai.Kind == HaiInfo.ZIHAI){
				num = hai.Number - 1;
			} else {
				switch(hai.ImageFile){
					case drawable.p1: num = 7;  break;
					case drawable.p9: num = 8;  break;
					case drawable.s1: num = 9;  break;
					case drawable.s9: num = 10; break;
					case drawable.m1: num = 11; break;
					case drawable.m9: num = 12; break;
          default:                    break;
				}
			}
			Cnt[num]++;
			if(hai.Type == HaiInfo.MATI){
				mati = num;
			}
		}
		for(int i = 0; i < Cnt.length; i++){
			if(Cnt[i] < 1 || 2 < Cnt[i]) return;
		}
		if(Cnt[mati] == 2){
			Yaku.add("国士十三面");
			Yakuman+=2;
		} else {
			Yaku.add("国士無双");
			Yakuman++;
		}
		Kokusi = true;
	}
	
  // ignore: non_constant_identifier_names
	void ChkTitoitu(){
		if(Special.length != 14) return;
		for(int i = 0; i < Special.length; i++){
			HaiInfo hai = Special.elementAt(i);			
			if(!hai.Toitu || hai.Koutu || hai.Kantu) return;
		}
		Yaku.add("七対子");
		Han+=2;
		Titoitu = true;
	}
	
  // ignore: non_constant_identifier_names
  String GetScoreStr(){
    String strScore;
    if(Tumo || Chonbo){
      double d = Score * 2;
      int parent = Kiriage(d, 100);
      if(ci.ModeThisWind == ThisWind.btnThisEast){
        if(ci.ModeHola == Hola.btnTumoSanma){
          d = parent * 1.5;
          parent = Kiriage(d, 100);
        }
        strScore = parent.toString() + "ALL";
      } else {
        int child = Kiriage(Score, 100);
        if(ci.ModeHola == Hola.btnTumoSanma){
          d = parent + child / 2;
          parent = Kiriage(d, 100);
          d = child * 1.5;
          child = Kiriage(d, 100);
        }
        strScore = "子" + child.toString() + "親" + parent.toString();
      }
    } else {
      double d = Score * 4;
      if(ci.ModeThisWind == ThisWind.btnThisEast) d *= 1.5;
      strScore = Kiriage(d, 100).toString();
    }
    return strScore;
  }
    
  // ignore: non_constant_identifier_names
  String GetChipStr(){
    String strChip = "";
    if(Chip > 0){
      strChip = Chip.toString() + "枚";
      if(Tumo) strChip += "ALL";
    }
    return strChip;
  }
}
