import 'CommonInfo.dart' as ci;
import 'package:flutter_application_1/CommonInfo.dart';

class HaiInfo {
  // ignore: non_constant_identifier_names
  late int FuroIndex;	// 副露牌の組インデックス　１～４
  // ignore: non_constant_identifier_names
  late int Kind;		// １：筒子　２：索子　３：萬子　４：字牌
  // ignore: non_constant_identifier_names
	static final int PINZU  = 1;
  // ignore: non_constant_identifier_names
	static final int SOUZU  = 2;
  // ignore: non_constant_identifier_names
	static final int MANZU  = 3;
  // ignore: non_constant_identifier_names
	static final int ZIHAI  = 4;
  // ignore: non_constant_identifier_names
	late int Number;		// 字牌以外：１～９　１：東　２：南　３：西　４：北　５：白　６：発　７：中
  // ignore: non_constant_identifier_names
	static final int TON  = 1;
  // ignore: non_constant_identifier_names
	static final int NAN  = 2;
  // ignore: non_constant_identifier_names
	static final int SHA  = 3;
  // ignore: non_constant_identifier_names
	static final int PE   = 4;
  // ignore: non_constant_identifier_names
	static final int HAKU = 5;
  // ignore: non_constant_identifier_names
	static final int HATU = 6;
  // ignore: non_constant_identifier_names
	static final int TYUN = 7;
  // ignore: non_constant_identifier_names
	late bool RedDora;	// 赤ドラ
  // ignore: non_constant_identifier_names
	drawable ImageFile = drawable.p1;	// 画像リソースID
  // ignore: non_constant_identifier_names
  String FileName = '';
  // ignore: non_constant_identifier_names
	late int Type;		// プレビュー画像上で指定した牌のタイプ（暗槓は副露牌）
  // ignore: non_constant_identifier_names
	static final int TEHAI = 1;
  // ignore: non_constant_identifier_names
	static final int FURO  = 2;
  // ignore: non_constant_identifier_names
	static final int MATI  = 3;
  // ignore: non_constant_identifier_names
	static final int DORA  = 4;
  // ignore: non_constant_identifier_names
	late bool Toitu;	// 対子
  // ignore: non_constant_identifier_names
	late bool Syuntu;	// 順子
  // ignore: non_constant_identifier_names
	late bool Sleft;	// 順子　左
  // ignore: non_constant_identifier_names
	late bool Scenter;	// 順子　中
  // ignore: non_constant_identifier_names
	late bool Sright;	// 順子　右
  // ignore: non_constant_identifier_names
	late bool Koutu;	// 刻子
  // ignore: non_constant_identifier_names
	late bool Kantu;	// 槓子
  // ignore: non_constant_identifier_names
	late bool AnKan;	// 暗槓
  // ignore: non_constant_identifier_names
	late bool Flag;	// 処理用フラグ
	//RectF Rect; 		// 判定矩形
  // ignore: non_constant_identifier_names
	late bool Uradora;	// 裏ドラ
  // ignore: non_constant_identifier_names
	late int FrameIndex;	// 枠インデックス

  HaiInfo(drawable id, int type, int idx) {
    ImageFile = id;
    Type = type;
    FuroIndex = idx;
    Kind = Number = FrameIndex = 0;
    RedDora = AnKan = Flag = Uradora = false;
    ResetStatus();
    switch(id){
      case drawable.p1:    FileName = 'p1'; Kind = 1; Number = 1; break;
      case drawable.p2:    FileName = 'p2'; Kind = 1; Number = 2; break;
      case drawable.p3:    FileName = 'p3'; Kind = 1; Number = 3; break;
      case drawable.p4:    FileName = 'p4'; Kind = 1; Number = 4; break;
      case drawable.p5:    FileName = 'p5'; Kind = 1; Number = 5; break;
      case drawable.p5r:   FileName = 'p5r'; Kind = 1; Number = 5; RedDora = true; break;
      case drawable.p6:    FileName = 'p6'; Kind = 1; Number = 6; break;
      case drawable.p7:    FileName = 'p7'; Kind = 1; Number = 7; break;
      case drawable.p8:    FileName = 'p8'; Kind = 1; Number = 8; break;
      case drawable.p9:    FileName = 'p9'; Kind = 1; Number = 9; break;
      case drawable.s1:    FileName = 's1'; Kind = 2; Number = 1; break;
      case drawable.s2:    FileName = 's2'; Kind = 2; Number = 2; break;
      case drawable.s3:    FileName = 's3'; Kind = 2; Number = 3; break;
      case drawable.s4:    FileName = 's4'; Kind = 2; Number = 4; break;
      case drawable.s5:    FileName = 's5'; Kind = 2; Number = 5; break;
      case drawable.s5r:   FileName = 's5r'; Kind = 2; Number = 5; RedDora = true; break;
      case drawable.s6:    FileName = 's6'; Kind = 2; Number = 6; break;
      case drawable.s7:    FileName = 's7'; Kind = 2; Number = 7; break;
      case drawable.s8:    FileName = 's8'; Kind = 2; Number = 8; break;
      case drawable.s9:    FileName = 's9'; Kind = 2; Number = 9; break;
      case drawable.m1:    FileName = 'm1'; Kind = 3; Number = 1; break;
      case drawable.m2:    FileName = 'm2'; Kind = 3; Number = 2; break;
      case drawable.m3:    FileName = 'm3'; Kind = 3; Number = 3; break;
      case drawable.m4:    FileName = 'm4'; Kind = 3; Number = 4; break;
      case drawable.m5:    FileName = 'm5'; Kind = 3; Number = 5; break;
      case drawable.m5r:   FileName = 'm5r'; Kind = 3; Number = 5; RedDora = true; break;
      case drawable.m6:    FileName = 'm6'; Kind = 3; Number = 6; break;
      case drawable.m7:    FileName = 'm7'; Kind = 3; Number = 7; break;
      case drawable.m8:    FileName = 'm8'; Kind = 3; Number = 8; break;
      case drawable.m9:    FileName = 'm9'; Kind = 3; Number = 9; break;
      case drawable.east:  FileName = 'east'; Kind = 4; Number = 1; break;
      case drawable.south: FileName = 'south'; Kind = 4; Number = 2; break;
      case drawable.west:  FileName = 'west'; Kind = 4; Number = 3; break;
      case drawable.north: FileName = 'north'; Kind = 4; Number = 4; break;
      case drawable.white: FileName = 'white'; Kind = 4; Number = 5; break;
      case drawable.green: FileName = 'green'; Kind = 4; Number = 6; break;
      case drawable.red:   FileName = 'red'; Kind = 4; Number = 7; break;
    }
    FileName = 'images/' + FileName + '.gif';
  }

  // ignore: non_constant_identifier_names
  void ResetStatus(){
    Toitu = Syuntu = Koutu = Kantu = false;
  }

  // ignore: non_constant_identifier_names
  bool Equal(HaiInfo hai){
    return Kind == hai.Kind && Number == hai.Number;
  }
  
  // ignore: non_constant_identifier_names
  bool EqualType(HaiInfo hai){
    return Equal(hai) && Type == hai.Type;
  }

  // ignore: non_constant_identifier_names
  bool IsYaotyu(){
    if(Kind == ZIHAI) return true;
    return (Number == 1 || Number == 9);
  }

  // ignore: non_constant_identifier_names
  bool IsFieldWind(){
    if(Kind == ZIHAI){
      switch(ci.ModeFieldWind){
        case FieldWind.btnFieldEast: 	// 場風　東
          if(Number == TON) return true;
          break;
        case FieldWind.btnFieldSouth: // 場風　南
          if(Number == NAN) return true;
          break;
        case FieldWind.btnFieldWest: 	// 場風　西
          if(Number == SHA) return true;
          break;
        case FieldWind.btnFieldNorth: // 場風　北
          if(Number == PE) return true;
          break;
      }
    }
    return false;
  }
  
  // ignore: non_constant_identifier_names
  bool IsThisWind(){
    if(Kind == ZIHAI){
      switch(ci.ModeThisWind){
        case ThisWind.btnThisEast: 		// 自風　東
            if(Number == TON) return true;
          break;
        case ThisWind.btnThisSouth: 	// 自風　南
            if(Number == NAN) return true;
          break;
        case ThisWind.btnThisWest: 		// 自風　西
            if(Number == SHA) return true;
          break;
        case ThisWind.btnThisNorth: 	// 自風　北
            if(Number == PE) return true;
          break;
      }
    }
    return false;
  }
  
  // ignore: non_constant_identifier_names
  void AppendDora(){
    switch(ImageFile){
      case drawable.p5: ImageFile = drawable.p5r; break;
      case drawable.s5: ImageFile = drawable.s5r; break;
      case drawable.m5: ImageFile = drawable.m5r; break;
      default:          return;
    }
    RedDora = true;
  }
  
  // ignore: non_constant_identifier_names
  void ReleaseDora(){
    switch(ImageFile){
      case drawable.p5r: ImageFile = drawable.p5; break;
      case drawable.s5r: ImageFile = drawable.s5; break;
      case drawable.m5r: ImageFile = drawable.m5; break;
      default:           return;
    }
    RedDora = false;
  }
  
  // ignore: non_constant_identifier_names
  String GetHaiName(){
    switch(ImageFile){
      case drawable.p1:    return "一筒";
      case drawable.p2:    return "二筒";
      case drawable.p3:    return "三筒";
      case drawable.p4:    return "四筒";
      case drawable.p5:    return "五筒";
      case drawable.p5r:   return "赤五筒";
      case drawable.p6:    return "六筒";
      case drawable.p7:    return "七筒";
      case drawable.p8:    return "八筒";
      case drawable.p9:    return "九筒";
      case drawable.s1:    return "一索";
      case drawable.s2:    return "二索";
      case drawable.s3:    return "三索";
      case drawable.s4:    return "四索";
      case drawable.s5:    return "五索";
      case drawable.s5r:   return "赤五索";
      case drawable.s6:    return "六索";
      case drawable.s7:    return "七索";
      case drawable.s8:    return "八索";
      case drawable.s9:    return "九索";
      case drawable.m1:    return "一萬";
      case drawable.m2:    return "二萬";
      case drawable.m3:    return "三萬";
      case drawable.m4:    return "四萬";
      case drawable.m5:    return "五萬";
      case drawable.m5r:   return "赤五萬";
      case drawable.m6:    return "六萬";
      case drawable.m7:    return "七萬";
      case drawable.m8:    return "八萬";
      case drawable.m9:    return "九萬";
      case drawable.east:  return "東";
      case drawable.south: return "南";
      case drawable.west:  return "西";
      case drawable.north: return "北";
      case drawable.white: return "白";
      case drawable.green: return "発";
      case drawable.red:   return "中";
      default:             return "";
    }
  }
  
  // ignore: non_constant_identifier_names
  drawable GetSyuntuID(int add){
    int num = Number + add;
    if (Kind == PINZU){
      switch(num){
        case 2: return drawable.p2;
        case 3: return drawable.p3;
        case 4: return drawable.p4;
        case 5: return drawable.p5;
        case 6: return drawable.p6;
        case 7: return drawable.p7;
        case 8: return drawable.p8;
        case 9: return drawable.p9;
      }
    } else if(Kind == SOUZU){
      switch(num){
        case 2: return drawable.s2;
        case 3: return drawable.s3;
        case 4: return drawable.s4;
        case 5: return drawable.s5;
        case 6: return drawable.s6;
        case 7: return drawable.s7;
        case 8: return drawable.s8;
        case 9: return drawable.s9;
      }
    } else if(Kind == MANZU){
      switch(num){
        case 2: return drawable.m2;
        case 3: return drawable.m3;
        case 4: return drawable.m4;
        case 5: return drawable.m5;
        case 6: return drawable.m6;
        case 7: return drawable.m7;
        case 8: return drawable.m8;
        case 9: return drawable.m9;
      }
    }
    return ImageFile;
  }
}
