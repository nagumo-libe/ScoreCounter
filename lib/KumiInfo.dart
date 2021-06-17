import 'CommonInfo.dart' as ci;
import 'package:flutter_application_1/CommonInfo.dart';
import 'package:flutter_application_1/HaiInfo.dart';

class KumiInfo {
  // ignore: non_constant_identifier_names
	late List<HaiInfo> Kumi;	// 牌構成
  // ignore: non_constant_identifier_names
	late int Kind;				// ０：対子　１：順子　２：刻子　３：槓子
  // ignore: non_constant_identifier_names
	static final int TOITU  = 0;
  // ignore: non_constant_identifier_names
	static final int SYUNTU = 1;
  // ignore: non_constant_identifier_names
	static final int KOUTU  = 2;
  // ignore: non_constant_identifier_names
	static final int KANTU  = 3;

	KumiInfo(){
		Kumi = [];
	}
/*
	void copy(KumiInfo obj){
		Kumi = []..addAll(obj.Kumi);
		Kind = obj.Kind;
	}
*/	
  // ignore: non_constant_identifier_names
	void AddToitu(HaiInfo hai1, HaiInfo hai2){
		Kumi.add(hai1);
		Kumi.add(hai2);
		Kind = TOITU;
	}
	
  // ignore: non_constant_identifier_names
	bool Equal(KumiInfo other){
		if(Kind != other.Kind) return false;
		for(int i = 0; i < Kumi.length; i++){
			if(!Kumi.elementAt(i).Equal(other.Kumi.elementAt(i))) return false;
		}
		return true;
	}
	
  // ignore: non_constant_identifier_names
	bool IsAnkou(){
		if(Kind == KOUTU && Kumi.elementAt(0).Type != HaiInfo.FURO){
			for(int i = 0; i < Kumi.length; i++){
				if(Kumi.elementAt(i).Type == HaiInfo.MATI){
					return ci.ModeHola == Hola.btnTumo;
				}
			}
			return true;
		}
		return false;
	}
/*	
  // ignore: non_constant_identifier_names
	public void OutLogKumi(){
		Log.i("Kind", Integer.toString(Kind));
		for(int i = 0; i < Kumi.size(); i++){
			Log.i(Integer.toString(i), Kumi.get(i).GetHaiName());
		}
	}
*/
}
