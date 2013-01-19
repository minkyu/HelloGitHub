//
//  tm.m
//  KobusReservation
//
//  Created by hongjun kim on 11. 10. 26..
//  Copyright (c) 2011년 앱달. All rights reserved.
//

#import "Reservation.h"

@implementation Reservation

@end

/*
<form  name="FrmCad" action="reservation01_4.jsp" method="post"  id="FrmCad" onSubmit="return fc_Select()" autocomplete="off">

<input type="radio" name="cad_flag" value="1" onClick="updatetitle(this.value)" />
<input name="pCAD_NO" type="text" style="width:120px" class="box" size="16 autocomplete="off="off" /></td>
<select  name="pVIL_YEAR" class="box">
<select name="pVIL_MONTH" class="box">
<input type="password" name="pUSR_JUMIN" class="box" size="7" maxlength="10" /></td>
<input type="image" id="p111" src="/images/image01/re_btn2.gif"  border="0" /></td>
<input type ="hidden" name = "koreng" 	value="0" />
<input type="hidden" name= "pTim_tim" value="1315">
<input type="hidden" name= "pSeat_no">
<input type="hidden" name= "pTic_cod" value="false">
<input type="hidden" name= "pTer_fr" value="010">
<input type="hidden" name= "pTer_to" value="130">
<input type="hidden" name= "pBus_gra" value="2">
<input type="hidden" name= "pCor_cod" value="03">
<input type="hidden" name= "pTer_sfr" value="010">
<input type="hidden" name= "pTer_sto" value="130">
<input type="hidden" name= "pTim_dte" value="20111024">
<input type="hidden" name= "pCnt_100" value="0">
<input type="hidden" name= "pCnt_050" value="1">
<input type="hidden" name="pFee_100" value="5400"/>
<input type="hidden" name="pFee_050" value="2700"/>
<input type="hidden" name="pSer_num" value="0"/>
<input type="hidden" name="pUsrCard" value="1"/>
<input type="hidden" name="pCardform" value="yak"/>
<input type="hidden" name= "pSev_call" value="true">
<input type = "hidden" name = "pGet_Lin" value="1">
<input type = "hidden" name = "pChg_Ter_To" value="000">
<input type = "hidden" name = "pChg_Tim_Tim" value="0000">
<input type = "hidden" name = "pLin_tim" value="60">
<input type = "hidden" name = "pExc_amt" value="0">
<input type = "hidden" name = "pExm_amt" value="0">
<input type = "hidden" name = "sTago_Gubun" value="">

function  fc_Select() {
	
	
	var str = "";
	var d = document.FrmCad;
    var radiovalue;
    var sum = 0;
    var getlist =new Array(10);
    var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
    var vencod = "";
    var odd = 0;
	
    buf = new Array(7);
	
    radiovalue = document.FrmCad.koreng.value ;
    vencod = document.FrmCad.pUSR_JUMIN.value ;
	
	
	if(full_seat > check_seat){
		alert("예약/예매 좌석을 선택해 주십시요!");
		return false;
	}// if(full_seat의 끝
	
	var sSeat= "";
	
	sSeat = sSeat + document.SeatForm.c1.value;
	document.FrmCad.pSeat_no.value = sSeat;
	
	
}*/