<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BPO_FF.aspx.vb" Inherits="BPO_FF.WebForm1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>WebForm1</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="BPO_FF.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body onload='InitialisePage(document.all("txtAction").value)' MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<div id="divFFMain" style="BORDER-RIGHT: navy 1px outset; BORDER-TOP: navy 1px outset; Z-INDEX: 101; VISIBILITY: visible; BORDER-LEFT: navy 1px outset; BORDER-BOTTOM: navy 1px outset; POSITION: absolute; BACKGROUND-COLOR: rgb(235,231,226)"></div>
			<div id="divBanner" style="Z-INDEX: 102; VISIBILITY: hidden; POSITION: absolute; BACKGROUND-COLOR: #5a84b7"></div>
			<div id="divFind" style="BORDER-RIGHT: navy 1px outset; BORDER-TOP: navy 1px outset; Z-INDEX: 103; LEFT: 240px; VISIBILITY: hidden; BORDER-LEFT: navy 1px outset; BORDER-BOTTOM: navy 1px outset; POSITION: absolute; TOP: 16px; BACKGROUND-COLOR: rgb(235,231,226)">two</div>
			<div id="divListHdr" style="BORDER-RIGHT: navy 1px outset; BORDER-TOP: navy 1px outset; Z-INDEX: 104; VISIBILITY: hidden; BORDER-LEFT: navy 1px outset; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255)"></div>
			<div id="divList" style="BORDER-RIGHT: navy 1px outset; Z-INDEX: 105; VISIBILITY: hidden; OVERFLOW: auto; BORDER-LEFT: navy 1px outset; BORDER-BOTTOM: navy 1px outset; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255)"></div>
			<div id="divContent" style="BORDER-RIGHT: black 1px outset; BORDER-TOP: black 1px outset; Z-INDEX: 107; VISIBILITY: hidden; BORDER-LEFT: black 1px outset; BORDER-BOTTOM: black 1px outset; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255)"></div>
			<div id="divContentInner" style="BORDER-RIGHT: black 1px outset; BORDER-TOP: black 1px outset; Z-INDEX: 108; VISIBILITY: hidden; BORDER-LEFT: black 1px outset; BORDER-BOTTOM: black 1px outset; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255)">&nbsp;</div>
			<div id="divContentInnerHdr" style="Z-INDEX: 108; VISIBILITY: hidden; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255)"><table width=100% cellpadding=0 cellspacing=0><tr><td class=tdH2>&nbsp;Comment History</td><td align=right valign=centre class=tdH2><input class="bTB" type=button value="Ê" onclick="PrintHistory()" ttText="Print" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;</td></tr></table></div>
			<div id="divContentInnerBody" style="Z-INDEX: 108; VISIBILITY: hidden; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255); overflow: auto"></div>
			<div id="divNewNote" style="BORDER-RIGHT: black 1px outset; BORDER-TOP: black 1px outset; Z-INDEX: 109; VISIBILITY: hidden; BORDER-LEFT: black 1px outset; BORDER-BOTTOM: black 1px outset; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255)">&nbsp;</div>
			<div id="divNewNoteHdr" style="Z-INDEX: 109; VISIBILITY: hidden; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255)"></div>
			<div id="divNewNoteBody" style="Z-INDEX: 109; VISIBILITY: hidden; OVERFLOW: auto; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255)"></div>
			<div id="divHelp" style="BORDER-RIGHT: black 1px outset; BORDER-TOP: black 1px outset; Z-INDEX: 110; VISIBILITY: hidden; BORDER-LEFT: black 1px outset; BORDER-BOTTOM: black 1px outset; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,255)"></div>
			<div id="divHelpInner" style="BORDER:none; Z-INDEX: 110; VISIBILITY: hidden; POSITION: absolute; overflow: auto; BACKGROUND-COLOR: white"></div>
			<div id="divAllNotes" style="Z-INDEX: 111; VISIBILITY: hidden; OVERFLOW: auto"></div>
			<div id="divTT" style="BORDER-RIGHT: black 1px outset; Z-INDEX: 112; VISIBILITY: hidden; OVERFLOW: auto; BORDER-BOTTOM: navy 1px outset; POSITION: absolute; BACKGROUND-COLOR: rgb(255,255,225)"></div>
			<div id="divBusy" style="Z-INDEX: 113; VISIBILITY: hidden; POSITION: absolute; BACKGROUND-COLOR: white"><table class=tableBusy><tr><td valign=middle>busy transferring data </td></tr></table></div>
			<div id="divPrint" style="Z-INDEX: 120;VISIBILITY: hidden; POSITION: absolute; background-color:white; width:98%"></div>
			<br>
			<input id=txtAction type=hidden value='<%=Request.QueryString("FuncTp")%>'>
			<input id=txtUacfId type=hidden>
			<input id=txtUserType type=hidden>
			<input id=txtMyConsultantCode type=hidden>
		</form>

<script language="javascript">

var iBorders = new Number(5)
var bgDebug = 0
function InitialisePage(sAction)
{
	GetUserIDAndConslts(sAction)
	
	ShowBanner(sAction)
	divFFMain.style.width = divBanner.offsetWidth
	divFFMain.style.top = divBanner.offsetTop + divBanner.offsetHeight + 10
	divFFMain.style.left = divBanner.offsetLeft
	divFFMain.style.height = document.body.offsetHeight - divBanner.offsetHeight - 20
	ShowFind(sAction)
	document.all("divAllNotes").innerHTML = ''
	
	TestAjax()
	
	GetListXML(sAction)
}
  
function ShowBanner(sAction)
{
	var sTitle = new String('')
	switch(sAction)
		{
		case '1':
			sTitle = 'New Items'
			break
		case '2':
			sTitle = 'Submitted Items'
			break
		case '3':
			sTitle = 'Inbox Items'
			break
		case '4':
			sTitle = 'Closed items'
			break
		}
	var s = new String('')
	s += '<table width=102% cellpadding=0 cellspacing=0>'
	s += '<tr bgcolor="rgb(0,46,99)"><td width=70%>&nbsp;</td><td width=30% align=center><font color=white face=Arial size=3><b>BTM</b><font></td></tr>'
	s += '<tr bgcolor="rgb(0,46,99)" onclick="SetDebug(); alert(1)"><td>&nbsp;</td><td align=center><font color=white face=Arial size=2>' + sTitle + '</font></td></tr>'
	s += '</table>'
	document.all("divBanner").innerHTML = s
	divBanner.style.top = 10
	divBanner.style.left = document.all("txtAction").offsetLeft + 10
	divBanner.style.visibility='visible'
}
	
function ShowFindOLD(sAction)
{
	switch(sAction)
		{
		case '1':
			document.all("divFind").innerHTML = ''
			return(0)
			break
		default :
			break
		}
	var s = new String('')
	s = '<table width=100% cellspacing=0 cellpadding=0>'
	s += '<tr><td class=tdH4>&nbsp;Only show matches for contract number:&nbsp;<input class="txtDataInput" type=text id="txtFindContract" value="" onchange="ClearWFNo()">&nbsp;or work flow number:&nbsp;<input class="txtDataInput" type=text id="txtFindWFNo" value="" onchange="ClearContractNo()">&nbsp;<input class="bTBFind" type=button value="Find Now" onclick="FilterList(1)">&nbsp;<input class="bTBFind" type=button value="Clear" onclick="FilterList(0)"></td></tr>'
	s += '</table>'

	document.all("divFind").innerHTML = s

	divFind.style.width = divFFMain.offsetWidth - (iBorders * 2)
	divFind.style.top = divFFMain.offsetTop + iBorders
	divFind.style.left = divFFMain.offsetLeft + iBorders
	divFind.style.visibility = 'visible'
}
	
function ShowFind(sAction)
{
	var s = new String('')
	if(sAction == '1')
		{
		s += '<table width=100% cellspacing=0 cellpadding=0><tr><td class=tdInfoHdr>i</td><td class=tdInfo>Click the New icon on the toolbar below to create a new item</td></tr></table>'
		}
	else
		{
		s = '<table width=100% cellspacing=0 cellpadding=0>'
		if(document.all("txtUserType").value != 'X')
			{
			s += '<tr><td class=tdH4>&nbsp;Show items that: <input type=radio name="rbListFor" id="rbUACF" checked=1 onclick="ShowHideConsSel(this.id);GetListXML(' + sAction + ')">I submitted <input type=radio name="rbListFor" id="rbConsCd" onclick="ShowHideConsSel(this.id)">were submitted for consultant code...&nbsp;&nbsp;' + BuildConsultantSelection() + '&nbsp;<input type=button class="bTBFind" id="btConslts" value="get list" style="visibility:hidden" onclick="GetListXML(' + sAction + ')"></td></tr>'
			}
		else
			{
			s += '<tr><td class=tdH4>&nbsp;Show items that: <input type=radio name="rbListFor" id="rbUACF" checked=1 onclick="ShowHideConsSel(this.id);GetListXML(' + sAction + ')">I submitted <input type=radio name="rbListFor" id="rbConsCd" onclick="ShowHideConsSel(this.id)">were submitted for consultant code...&nbsp;&nbsp;<input type=text class="txtDataInput" id="selConslts" value="' + BuildConsultantSelection() + '" onchange="SetTxtConsultant(this.value)">&nbsp;<input type=button class="bTBFind" id="btConslts" value="get list" style="visibility:hidden" onclick="GetListXML(' + sAction + ')"></td></tr>'
			}
		s += '<tr><td>&nbsp;</td></tr>'
		s += '<tr><td class=tdH4>&nbsp;Only show matches for contract number:&nbsp;<input class="txtDataInput" type=text id="txtFindContract" value="" onchange="ClearWFNo()">&nbsp;or work flow number:&nbsp;<input class="txtDataInput" type=text id="txtFindWFNo" value="" onchange="ClearContractNo()">&nbsp;<input class="bTBFind" type=button value="Find Now" onclick="FilterList(1)">&nbsp;<input class="bTBFind" type=button value="Clear" onclick="FilterList(0)"></td></tr>'
		s += '</table>'
		}

	document.all("divFind").innerHTML = s

	divFind.style.width = divFFMain.offsetWidth - (iBorders * 2)
	divFind.style.top = divFFMain.offsetTop + iBorders
	divFind.style.left = divFFMain.offsetLeft + iBorders
	divFind.style.visibility = 'visible'
	
	if(sAction > 1)
		{
		try
			{
			document.all("selConslts").style.visibility = 'hidden'
			}
		catch(e){}
		}
}

function SetTxtConsultant(s)
{
	document.all("txtMyConsultantCode").value = s
}

function SetDebug()
{
	if(bgDebug){bgDebug=0}else{bgDebug=1}
}

function ShowHideConsSel(sId)
{
if(bgDebug){alert('in ShowHideConsSel. parm1=' + sId)}
if(bgDebug){BuildConsultantSelection()}
	if(sId == 'rbConsCd')
		{
		try{document.all("selConslts").style.visibility = 'visible'}catch(e){}
		document.all("btConslts").style.visibility = 'visible'
if(bgDebug){alert('in ShowHideConsSel. Set btConslts.style.visibility to visible')}
		}
	else
		{
		try{document.all("selConslts").style.visibility = 'hidden'}catch(e){}
		document.all("btConslts").style.visibility = 'hidden'
		}
}

function BuildConsultantSelection()
{
if(bgDebug){alert('in BuildConsultantSelection')}
	if(gsConsltSel > '')
		{
if(bgDebug){alert('in BuildConsultantSelection. gsConsltSel = ' + gsConsltSel)}
		return gsConsltSel
		}
	else
		{
if(bgDebug){alert('in BuildConsultantSelection. txtMyConsultantCode = ' + document.all("txtMyConsultantCode").value)}
		return document.all("txtMyConsultantCode").value
		}
}
	
function ClearWFNo()
{
	document.all("txtFindWFNo").value = ''
}
	
function ClearContractNo()
{
	document.all("txtFindContract").value = ''
}
	
function FilterList(i)
{
	if(i==0){ClearContractNo(); ClearWFNo()}
	ShowList(document.all("txtAction").value)
}

function BusyProcessing(i)
{
	if(document.all("divBusy").style.visibility == 'hidden')
		{
		return 0
		}
	else
		{
		if(i=='1')
			{
// potential to show alert if process is still busy...			
			}
		return 1
		}
}

var gsNoRec = '<center><p class=pNoRec>--- no messages found ---</p></center>'
function ShowList(sAction)
{
	var s = new String('')
	s += '<table width=100% cellspacing=0 cellpadding=0>'
	switch(sAction)
		{
		case '1':
			s += '<tr><td class=tdH2>&nbsp;New Items&nbsp;</td><td align=right valign=centre class=tdH2><input class="bTB" type=button value="" onclick="BTMCreate()" ttText="Create new item" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="Í" onclick="MoveNewNoteToContext(); SaveNew(giContextCurr, 1)" ttText="Save without submitting" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="" onclick="if(!BusyProcessing(1)){ValSaveAndSend()}" ttText="Submit" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="r" ttText="Delete" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" onclick="Unnasigned_Delete()">&nbsp;<input class="bTB" type=button ttText="Help" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" value="s" onclick="ShowHelp(1)">&nbsp;</td></tr>'
			break
		case '2':
			s += '<tr><td class=tdH2>&nbsp;Submitted Items&nbsp;</td><td align=right valign=centre class=tdH2><input class="bTB" type=button value="" onclick="AddNewComment()" ttText="Add comment" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="" onclick="if(!BusyProcessing(1)){AddComment()}" ttText="Submit" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="s" ttText="Help" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" onclick="ShowHelp(2)">&nbsp;</td></tr>'
			break
		case '3':
			s += '<tr><td class=tdH2>&nbsp;Inbox&nbsp;</td><td align=right valign=centre class=tdH2><input class="bTB" type=button value="" onclick="AddNewComment()" ttText="Add comment" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="" onclick="if(!BusyProcessing(1)){AddCommentAndChangeState(2)}" ttText="Submit" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="x" onclick="AddCommentAndChangeState(4)" ttText="Close item" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="s" ttText="Help" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" onclick="ShowHelp(3)">&nbsp;</td></tr>'
			break
		case '4':
			s += '<tr><td class=tdH2>&nbsp;Closed&nbsp;</td><td align=right valign=centre class=tdH2><input class="bTB" type=button value="" onclick="AddNewComment()" ttText="Add comment" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="" onclick="if(!BusyProcessing(1)){AddCommentAndReAssign(2)}" ttText="Submit" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB" type=button value="s" ttText="Help" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" onclick="ShowHelp(4)">&nbsp;</td></tr>'
			break
		}
	s += '</table>'

	document.all("divListHdr").innerHTML = s
	
	divListHdr.style.width = (divBanner.offsetWidth / 2) - (2 * iBorders)
	if(document.all("divFind").innerHTML > ''){divListHdr.style.top = divFind.offsetTop + divFind.offsetHeight + iBorders}
	else{divListHdr.style.top = divFFMain.offsetTop + iBorders}
	
	divListHdr.style.left = divBanner.offsetLeft + iBorders
	divListHdr.style.visibility = 'visible'
	
	document.all("divList").innerHTML = BuildListFromXML()
		
	PositionListDivs()

	divList.style.width = divListHdr.offsetWidth
	divList.style.top = divListHdr.offsetTop + divListHdr.offsetHeight
	divList.style.left = divListHdr.offsetLeft
	divList.style.height = divFFMain.offsetHeight - divFind.offsetHeight - divListHdr.offsetHeight - 12
	divList.style.visibility = 'visible'
	
	ShowContent()

	if(document.all("txtAction").value == 1)
		{
		InitialiseCatsAndSubs()
		}
	
	SetRowFocus()
}

function InitialiseCatsAndSubs()
{
	var s = ''
	for(i=0;i<giContext;i++)
		{
		BuildSubs(document.all("CatTC", i).value, i)
		document.all("rbCat" + document.all("CatTC", i).value + String(i)).checked=1
		try{document.all("rbSub" + document.all("SubCatTC", i).value + String(i)).checked=1}catch(e){}
		}
}

function SetCat(iContext, iTC)
{
	document.all("SubCatTC", giContextCurr).value = ''
	document.all("CatTC", iContext).value = iTC
}
	
function SetSub(iContext, iTC)
{
	document.all("SubCatTC", iContext).value = iTC
}
			
function ShowContent()
{
	var s = '<table width=100% cellspacing=0 cellpadding=0>'
	s += "<tr><td>&nbsp;</td></tr>"
	s += '</table>'
	document.all("divContent").innerHTML = s

	divContent.style.top = divList.offsetTop - divListHdr.offsetHeight
	divContent.style.height = divList.offsetHeight + divListHdr.offsetHeight
	divContent.style.left = divList.offsetLeft + divList.offsetWidth + iBorders
	divContent.style.width = (divBanner.offsetWidth / 2) - (2 * iBorders)
	divContent.style.visibility = 'visible'
}
			
function ShowHelp(iTopic)
{
		var sURL = ''
		var oXMLHTTP = new ActiveXObject("Microsoft.XMLHTTP");
		var s = '<table width=100% cellspacing=0 cellpadding=0>'
		s += '<tr><td class=tdH2>&nbsp;BTM Requests Help</td><td  class=tdH2 align=right valign=centre><input class="bTB" type=button value="Ê" onclick="PrintHelp()" ttText="Print" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class=bTB2 bType=2 ttText="" type=button value="Ñ" onclick="HideHelp()" onmouseover="ShowTip(this)" onmouseout="HideTip(this)"></td></tr>'
		s += '</table>'
		switch(iTopic)
			{
			case 0:
				sURL = './/help/btm overview.asp'
				break
			case 1:
				sURL = './/help/new_items_what_do_you_want_to_do.asp'
				break
			case '1.1':
				sURL = './/help/Learn_about_the_New_Items_Folder.asp'
				break
			case '1.2':
				sURL = './/help/Creating_a_new_item_and_submitting_it_for_processing.asp'
				break
			case '1.3':
				sURL = './/help/Creating_and_saving_a_new_item_without_submitting_it_for_processing.asp'
				break
			case '1.4':
				sURL = './/help/Editing_and_submitting_a_saved_item_in_the_New_Items_Folder.asp'
				break
			case '1.5':
				sURL = './/help/Deleting_a_saved_item_in_the_New_Items_Folder.asp'
				break
			case 2:
				sURL = './/help/submitted_items_what_do_you_want_to_do.asp'
				break
			case '2.1':
				sURL = './/help/Learn about the Submitted Items Page.asp'
				break
			case '2.2':
				sURL = './/help/Checking the Workflow Number for a Submitted Item.asp'
				break
			case '2.3':
				sURL = './/help/Reviewing_the_Date_an_Item_was_Submitted.asp'
				break
			case '2.4':
				sURL = './/help/Monitoring_progress_on_a_Submitted_Item.asp'
				break
			case '2.5':
				sURL = './/help/Adding a comment to a submitted item and resubmitting it.asp'
				break
			case '2.6':
				sURL = './/help/Search for a submitted item by contract number.asp'
				break
			case '2.7':
				sURL = './/help/Search for a submitted item by workflow number.asp'
				break
			case 3:
				sURL = './/help/inbox_what_do_you_want_to_do.asp'
				break
			case '3.1':
				sURL = './/help/Learn about the Inbox Items folder.asp'
				break
			case '3.2':
				sURL = './/help/view a reply to a workflow item.asp'
				break
			case '3.3':
				sURL = './/help/Add a comment to an Inbox item.asp'
				break
			case '3.4':
				sURL = './/help/Close an Inbox Item.asp'
				break
			case '3.5':
				sURL = './/help/Search for an item in the Inbox by contract number.asp'
				break
			case '3.6':
				sURL = './/help/Search for an Inbox item by workflow number.asp'
				break
			case 4:
				sURL = './/help/closed items_what_do_you_want_to_do.asp'
				break
			case '4.1':
				sURL = './/help/Learn about the Closed Items folder.asp'
				break
			case '4.2':
				sURL = './/help/Add a comment to a closed item and submit it.asp'
				break
			case '4.3':
				sURL = './/help/Search for a closed item by contract number.asp'
				break
			case '4.4':
				sURL = './/help/search for a closed item by workflow number.asp'
				break
			}
			
		oXMLHTTP.open("POST", sURL, false)
		oXMLHTTP.send()
		document.all("divHelpInner").innerHTML = oXMLHTTP.responseText
		
		document.all("divHelp").innerHTML = s

	if(document.all("divHelp").style.visibility == 'hidden')
		{
		divContent.style.width = divContent.offsetWidth / 2
		
		if(document.all("divContentInner").style.visibility != 'hidden')
			{
			divContentInner.style.width = (divContentInner.offsetWidth / 2) - iBorders
			divContentInnerHdr.style.width = (divContentInnerHdr.offsetWidth / 2) - iBorders - 3
			if(divContentInnerBody.offsetWidth > 0)
				{
				divContentInnerBody.style.width = (divContentInnerBody.offsetWidth / 2) - iBorders - 3
				}
			}
		if(document.all("divNewNote").style.visibility != 'hidden')
			{
			divNewNote.style.width = (divNewNote.offsetWidth / 2) - iBorders
			divNewNoteHdr.style.width = (divNewNoteHdr.offsetWidth / 2) - iBorders - 3
			divNewNoteBody.style.width = (divNewNoteBody.offsetWidth / 2) - iBorders - 3
			}
	
		divHelp.style.top = divContent.offsetTop
		divHelp.style.height = divContent.offsetHeight
				
		divHelp.style.left = divContent.offsetLeft + divContent.offsetWidth + iBorders
		divHelp.style.width = divContent.offsetWidth
		divHelp.style.visibility = 'visible'
		
		divHelpInner.style.top = divHelp.offsetTop + 28
		divHelpInner.style.height = divHelp.offsetHeight - 30
		
		divHelpInner.style.left = divHelp.offsetLeft + 2
		divHelpInner.style.width = divHelp.offsetWidth - 4
		divHelpInner.style.visibility = 'visible'
		}
}
	
function HideHelp()
{
	divHelp.style.visibility = 'hidden'
	divHelpInner.style.visibility = 'hidden'
	divNewNote.style.width = (divNewNote.offsetWidth + iBorders) * 2
	divNewNoteHdr.style.width = (divNewNoteHdr.offsetWidth + iBorders + 3) * 2
	divNewNoteBody.style.width = (divNewNoteBody.offsetWidth + iBorders + 3) * 2
	
	divContent.style.width = divContent.offsetWidth * 2
	
	ShowContent()
	
	if(document.all("divContentInner").style.visibility != 'hidden')
		{
		divContentInner.style.width = (divContentInner.offsetWidth + iBorders) * 2
		divContentInnerHdr.style.width = (divContentInnerHdr.offsetWidth + iBorders + 3) * 2
		divContentInnerBody.style.width = (divContentInnerBody.offsetWidth + iBorders + 3) * 2
		}
}

function ShowTip(o)
{
	if(o.bType==2)
		{
		o.className = 'bTB2Hover'
		}
	else
		{
		o.className = 'bTBHover'
		}
	if(o.ttText > '')
		{
		divTT.innerHTML = '<p class=pTT>&nbsp;' + o.ttText + '&nbsp;</p>'
		divTT.style.top = event.clientY + 20
		divTT.style.left = event.clientX
		divTT.style.visibility = 'visible'
		}
}

function HideTip(o)
{
	divTT.style.visibility = 'hidden'
	if(o.bType==2)
		{
		o.className = 'bTB2'
		}
	else
		{
		o.className = 'bTB'
		}
}
   
var goCurrRow = 0
var gbDirty = 0
var giContext = 0 // VIP used to set context in terms of array offset for all controls
var giContextCurr = 0 // VIP used to track current context
function BTMCreate(o)
{
	// bubble em up... top list item must always have context 0
	for(i=giContext;i>0;i--){document.all("ListRow", i - 1).ContextRow = i}
	
	var s = '<div id="divListRow" style="position:absolute">'
	s += '<table width=100% class="tableList" id="ListRow" onclick="MoveNewNoteToContext(); if(KillRowFocus(giContextCurr, this)){SetRowFocus(this)}" ContextRow="' + Number(0) + '">'

	s += '<tr><td colspan=2 class=tdListH>Ensure that you enter a comment in the Comments section</td></tr>'
	s += '<tr><td colspan=2 class=tdListH>on the right after completing all the information below.</td></tr>'
	s += '<tr><td colspan=2 class=tdListH>&nbsp;</td></tr>'
	s += '<tr><td class="tdListH" width=30%>Contract number:</td><td><input class="txtInp" type=text id="txtContractNo" name="txtContractNo" maxlength=15 onchange="gbDirty=1"><input type=hidden id="CaseID" value=0><input type=hidden id="CatTC" value=""><input type=hidden id="SubCatTC" value=""><input type=hidden id="WFID" value="0"></td></tr>'
	s += '<tr><td class="tdListH">Subject:</td><td><input class="txtInp" type=text id="txtSubject" name="txtSubject" maxlength=50 onchange="gbDirty=1"></td></tr>'
	
	s += '<tr>'
	s += '<td colspan=2>'
	
	s += '<table width=100% bgcolor="white" cellpadding=0>'

	if(gsConsltSel > '')
		{
		s += '<tr><td class="tdList" width=30%>Consultant code:</td><td>' + gsConsltSel + '<input class="txtInp" type=hidden id="txtConsCode" name="txtConsCode"></td></tr>'
		}
	else
		{
		s += '<tr><td class="tdList" width=30%>Consultant code:</td><td><input class="txtInp" type=text id="txtConsCode" name="txtConsCode" size=11 maxlength=13 onchange="gbDirty=1"></td></tr>'
		}
	
	s += '<tr><td colspan=2><table width=100% cellspacing=0 cellpadding=0>'
	s += BuildCats(giContext)
	s += '</table>'
	s += '</td></tr></table>'
	
	s += '</td>'
	s += '</tr>'
	
	s += '</table>'
	s += '</div>'
	
	// this is sneaky!!!
	document.all("divAllNotes").innerHTML = '<textarea id="txtNewNote" style="visibility:hidden; height:0; width:0" rows=10></textarea><br>' + document.all("divAllNotes").innerHTML

	if(giContext==0){document.all("divList").innerHTML = ''}
	giContext ++
	s += document.all("divList").innerHTML
	
	document.all("divList").innerHTML = s
	
	PositionListDivs()
	
	KillRowFocus(Number(giContextCurr + 1))
		
	SetRowFocus()
	gbDirty = 1
}

function BuildCats(iContextRow)
{
	if(gaCats[0]==''){BuildCatsArray();BuildSubsArray()}
	var s = ''
		try
			{
			var doc = new ActiveXObject("Microsoft.XMLDOM")
			doc.loadXML(xmlData2.innerHTML)
			var nodes = new ActiveXObject("Microsoft.XMLDOM")
			nodes.async="false"
			var Cat = doc.getElementsByTagName("cat")
			if(Cat.length > 0)
				{
				for(i=0;i<Cat.length;i++)
					{
					wrk = ''
					nodes.loadXML(Cat.item(i).xml)
					s += '<tr><td class="tdH6"><input id="rbCat' + nodes.documentElement.selectSingleNode("/cat/id").text + String(iContextRow) + '" name="rbCat' + iContextRow + '" type=radio tc=' + nodes.documentElement.selectSingleNode("/cat/id").text + ' onclick="SetCat(giContextCurr, this.tc); BuildSubs(this.tc, giContextCurr)">' + nodes.documentElement.selectSingleNode("/cat/descr").text + '</td></tr>'
					}
				s = '<tr><td class="tdH6" width=50%>Request relates to:</td><td class="tdH6" width=50% valign=top rowspan=' + String(i) + '><div id="divOpts" style="position:inline; visibility:visible">&nbsp;</div></td></tr>' + s
				}
			else
				{
				s = '<tr><td class="tdH6">&nbsp;NO CATEGORY DATA FOUND</td></tr>'
				}
			}
		catch(e)
			{
			s = '<tr><td class="tdH6">&nbsp;CATEGORY DATA COULD NOT BE PROCESSED</td></tr>'
			}
	return s
}

var gaCats = new Array('')
function BuildCatsArray()
{
	var doc = new ActiveXObject("Microsoft.XMLDOM")
	doc.loadXML(xmlData2.innerHTML)
	var nodes = new ActiveXObject("Microsoft.XMLDOM")
	nodes.async="false"
	var Cat = doc.getElementsByTagName("cat")
	for(i=0;i<Cat.length;i++)
		{
		nodes.loadXML(Cat.item(i).xml)
		gaCats[Number(nodes.documentElement.selectSingleNode("/cat/id").text)] = nodes.documentElement.selectSingleNode("/cat/descr").text
		}
}
	
var gaSubs = new Array()
function BuildSubsArray()
{
	var doc = new ActiveXObject("Microsoft.XMLDOM")
	doc.loadXML(xmlData2.innerHTML)
	var nodes = new ActiveXObject("Microsoft.XMLDOM")
	nodes.async="false"
	var Sub = doc.getElementsByTagName("sub")
	for(i=0;i<Sub.length;i++)
		{
		nodes.loadXML(Sub.item(i).xml)
		gaSubs[Number(nodes.documentElement.selectSingleNode("/sub/id").text)] = nodes.documentElement.selectSingleNode("/sub/descr").text
		}
}
	
function BuildSubs(iCatID, iContextRow)
{
	var s = ''
	var wrk = ''
	try
		{
		var doc = new ActiveXObject("Microsoft.XMLDOM")
		doc.loadXML(xmlData2.innerHTML)
		var nodes = new ActiveXObject("Microsoft.XMLDOM")
		nodes.async="false"
		var Sub = doc.getElementsByTagName("sub")
		if(Sub.length > 0)
			{
			var i = 0
			var bFound1 = 0
			while(i < Sub.length)
				{
				nodes.loadXML(Sub.item(i).xml)
				if(iCatID == nodes.documentElement.selectSingleNode("/sub/CatId").text)
					{
					bFound1 = 1
					wrk = "rbSub" + nodes.documentElement.selectSingleNode("/sub/id").text + String(iContextRow)
					s += '<tr><td class="tdH6"><input id="rbSub' + nodes.documentElement.selectSingleNode("/sub/id").text + String(iContextRow) + '" name="rbSub' + String(iContextRow) + '" type=radio tc=' + nodes.documentElement.selectSingleNode("/sub/id").text + ' onclick="SetSub(giContextCurr, this.tc)">' + nodes.documentElement.selectSingleNode("/sub/descr").text + '</td></tr>'
					}
				i ++
				}
			if(bFound1 > 0)
				{
				s = '<tr><td class="tdH6">for:</td></tr>' + s
				}
			}
		else
			{
			s = '<tr><td class="tdH6">&nbsp;NO SUB CATEGORY DATA FOUND</td></tr>'
			}
		}
	catch(e)
		{
		s = '<tr><td class="tdH6">&nbsp;SUB CATEGORY DATA COULD NOT BE PROCESSED</td></tr>'
		}
	s = '<table width=100% cellspacing=0 cellpadding=0>' + s
	s += '</table>'
	
	document.all("divOpts", iContextRow).innerHTML = s
	document.all("divOpts", iContextRow).style.visibility = "visible"
}

function SetRowFocus(o)
{
	try
		{
		var bFirst = 0
		
		if(!o)
			{
			bFirst = 1
			var i = Number(NextFocusRow())
			if(Number(i) > -1)
				{
				var o = document.all("ListRow", i)
				}
			else
				{
				if(document.all("txtAction").value != 4)
					{
					document.all("divList").innerHTML = gsNoRec
					}
				divNewNote.style.visibility = 'hidden'
				divNewNoteHdr.style.visibility = 'hidden'
				divNewNoteBody.style.visibility = 'hidden'
				divContentInner.style.top = divContent.offsetTop + 8
				divContentInner.style.left = divContent.offsetLeft + 8
				divContentInner.style.height = divContent.offsetHeight - 16
				divContentInner.style.width = divContent.offsetWidth - 16
				divContentInner.style.visibility = 'visible'
				document.all("divContentInner").innerHTML = ''
				divContentInnerHdr.style.visibility = 'hidden'
				document.all("divContentInnerBody").innerHTML = ''
				return 0
				}
			}
			
		if(giContextCurr!=o.ContextRow || bFirst==1)
			{
			goCurrRow = o
			o.className = 'tableListSelected'
			giContextCurr = o.ContextRow			
			GetComments(o.ContextRow)
			if(document.all("txtAction").value == 1){document.all("txtContractNo", giContextCurr).focus()}
			}
		}
	catch(e)
		{
		}
}

function NextFocusRow()
{
	var r = new Number(-1)
	try
		{
		for(i=0;i<giContext;i++)
			{
			if(document.all("divListRow", i).style.visibility != 'hidden' &&  document.all("divListRow", i).specialtype != 'hdr')
				{
				return i
				}
			}
		}
	catch(e){}
	return r
}

function KillRowFocus(i, o)
{
	try
		{
		if(o)
			{
			if(i == o.ContextRow){return 0}
			if(GoBackCosDirty()){return 0}
			}
			
		document.all("ListRow", i).className='tableList'
		document.all("divContentInner").innerHTML = ''
		document.all("divNewNote").innerHTML = ''
		document.all("divNewNoteHdr").innerHTML = ''
		document.all("divNewNoteBody").innerHTML = ''
		}
	catch(e){return 0}
	return 1
}
	
function GoBackCosDirty()
{
	if(gbDirty)
		{
		var answer = confirm('You have made changes that have not been saved/sent. Press OK to proceed WITHOUT saving. Press cancel to go back and save your changes.')
		if (answer)
			{
			gbDirty = 0
			return 0
			}
		else
			{
			return 1
			}
		}
	return 0
}
	
function MoveNewNoteToContext()
{
	try{document.all("txtNewNote", giContextCurr).value = document.all("tNew").value}catch(e){}
}

function ContractNumberRequired(sSubCat)
{
	if(Number(sSubCat) != 8 && Number(sSubCat) != 9 && Number(sSubCat) != 10)
		{
		return 1
		}
	else
		{
		return 0
		}
}

function ValSaveAndSend()
{
	if(Number(NextFocusRow())<0){NothingToDo('no messages'); return 0}
	
	var iMyRef = Number(document.all("CaseID", giContextCurr).value)
	var sConNo = document.all("txtContractNo", giContextCurr).value
	var sUACFId = document.all("txtUacfId").value
	var sSubject = document.all("txtSubject", giContextCurr).value
	var sConsCd = document.all("txtConsCode", giContextCurr).value
	var sCat = document.all("CatTC", giContextCurr).value
	var sSubCat = document.all("SubCatTC", giContextCurr).value
	MoveNewNoteToContext()
	var sNote = document.all("txtNewNote", giContextCurr).value

	var bConNoError = 0
	if(ContractNumberRequired(sSubCat))
		{
		if(!sConNo > ''){ShowVal('Contract number is compulsory'); document.all("txtContractNo", giContextCurr).focus(); return}
		if(sConNo > '')
			{
			if(!IsNumeric(sConNo))
				{
				bConNoError = 1
				}
			if(!(sConNo.length == 14 || sConNo.length == 11 || sConNo.length == 10 || sConNo.length == 5 || sConNo.length == 4))
				{
				bConNoError = 1
				}			
			if(sConNo.length == 10 && sConNo.substring(0, 2) != '00')
				{
				bConNoError = 1
				}
			if(bConNoError)
				{
				bConNoError = 1
				alert('The contract number is not valid. Refer to the help for information on valid contract numbers')
				document.all("txtContractNo", giContextCurr).focus()
				return
				}
			}
		}
	if(!sSubject > ''){ShowVal('Subject is compulsory'); document.all("txtSubject", giContextCurr).focus(); return}
	if(ContractNumberRequired(sSubCat))
		{
		if(!sConsCd > ''){ShowVal('Consultant code is compulsory'); document.all("txtConsCode", giContextCurr).focus(); document.all("txtConsCode", giContextCurr).select(); return}
		}
	if(!sCat > ''){ShowVal('A category which the request relates to is compulsory'); return}
	if(CatHasSubs(Number(sCat)) && (!sSubCat > '')){ShowVal('A sub category for the category that the request relates to is compulsory'); return}
	if(!sNote > ''){ShowVal('Comments are compulsory'); document.all("tNew").focus(); return}
	
	var iSubCat = 0
	if(CatHasSubs(Number(sCat))){iSubCat = Number(sSubCat); sSubCat = gaSubs[iSubCat]}
	else {sSubCat = gaCats[Number(sCat)]}
	
	SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, Number(sCat), gaCats[Number(sCat)], iSubCat, sSubCat, sNote, 2)
}

function IsNumeric(s)
   {
   var sValid = "0123456789"
   var sChar
   var bResult = true

   for (i = 0; i < s.length && bResult == true; i++)
      {
      sChar = s.charAt(i)
      if (sValid.indexOf(sChar) == -1)
         {
         bResult = false
         }
      }
   return bResult
   }


function CatHasSubs(iCat)
{
	var doc = new ActiveXObject("Microsoft.XMLDOM")
	doc.loadXML(xmlData2.innerHTML)
	var nodes = new ActiveXObject("Microsoft.XMLDOM")
	nodes.async="false"
	var Sub = doc.getElementsByTagName("sub")
	if(Sub.length > 0)
		{
		var bFound1 = 0
		for(i=0;i<Sub.length;i++)
			{
			nodes.loadXML(Sub.item(i).xml)
			if(iCat == nodes.documentElement.selectSingleNode("/sub/CatId").text)
				{
				return 1
				}
			}
		}
	return 0
}
			
function ShowVal(sValTxt)
{
	alert(sValTxt + ' - please enter/select a valid value')
}

var giRetry = 0
var giSaveNewi = 0
function SaveNew(i, bNotify)
{
	giSaveNewi = i

	if(Number(NextFocusRow())<0){NothingToDo('no messages'); return 0}
	var iMyRef = Number(document.all("CaseID", i).value)
	var sConNo = document.all("txtContractNo", i).value
	var sUACFId = document.all("txtUacfId").value
	var sSubject = document.all("txtSubject", i).value
	var sConsCd = document.all("txtConsCode", i).value
	var sCat = document.all("CatTC", i).value
	var sSubCat = document.all("SubCatTC", i).value
	var sNote = document.all("txtNewNote", i).value
	var iStatus = 0
	gbDirty = 0
		
	ShowBusy()
	try{var response = WebForm1.A_Save(iMyRef, sConNo, sUACFId, sConsCd, sSubject, Number(sCat), Number(sSubCat), sNote, iStatus, SaveNew_CB); if(bNotify){alert("This work item has been successfully saved")}}
	catch(e){AjaxEH('SaveNew', e)}
}
		
function SaveNew_CB(r)
{
	if(r.error != null)
		{
		if(giRetry < 3)
			{
			giRetry ++
			SaveNew(giSaveNewi, 0)
			return 0
			}
		giRetry = 0
		CallBackEH('SaveNew', r.error)
		return 0
		}
		
	giRetry = 0
	document.all("CaseID", giContextCurr).value = r.value
	HideBusy()
}

var giSaveAndSendMyRef = 0
var gsSaveAndSendConNo = ''
var gsSaveAndSendUACFId = ''
var gsSaveAndSendConsCd = ''
var gsSaveAndSendSubject = ''
var giSaveAndSendCat = ''
var gsSaveAndSendCat = ''
var giSaveAndSendSubCat = ''
var gsSaveAndSendSubCat = ''
var gsSaveAndSendNote = ''
var giSaveAndSendStatus = ''		
function SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, iCat, sCat, iSubCat, sSubCat, sNote, iStatus)
{
if(bgDebug){alert(sSubCat)}
	giSaveAndSendMyRef = iMyRef
	gsSaveAndSendConNo = sConNo
	gsSaveAndSendUACFId = sUACFId
	gsSaveAndSendConsCd = sConsCd
	gsSaveAndSendSubject = sSubject
	giSaveAndSendCat = iCat
	gsSaveAndSendCat = sCat
	giSaveAndSendSubCat = iSubCat
	gsSaveAndSendNote = sNote
	giSaveAndSendStatus = iStatus

	gbDirty = 0
	ShowBusy()
//	XMLHTTPRequest("BPO_HTTP_Request.asp?function=StoreAuditContNo&pstrSuccess=C&pstrTransType=BTM" + String(iSubCat) + "&pstrContNo=" + sConNo)
	
	sSubject = sSubject.replace(/&/g, '&amp;')
	sNote = sNote.replace(/&/g, '&amp;')
	
	try{var response = WebForm1.A_SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, iCat, sCat, iSubCat, sSubCat, sNote, iStatus, SaveAndSend_CB)}
	catch(e){AjaxEH('SaveAndSend', e)}
}

function SaveAndSend_CB(r)
{
if(bgDebug){alert(r.error)}
	if(r.error != null)
		{
		if(giRetry < 3)
			{
if(bgDebug){alert(giRetry)}
			giRetry ++
			SaveAndSend(giSaveAndSendMyRef, gsSaveAndSendConNo, gsSaveAndSendUACFId, gsSaveAndSendConsCd, gsSaveAndSendSubject, giSaveAndSendCat, gsSaveAndSendCat, giSaveAndSendSubCat, gsSaveAndSendSubCat, gsSaveAndSendNote, giSaveAndSendStatus)
			return 0
			}
		giRetry = 0
		CallBackEH('SaveAndSend', r.error)
		return 0
		}
	
	giRetry = 0
			
	CheckXMLForException('SaveAndSend', r.value)
				
	HideBusy()
	
//alert(document.all("txtAction").value)
//	switch(document.all("txtAction").value)
//		{
//		case '1':
//			document.all("divFind").innerHTML = ''
//			return(0)
//			break
//		default :
//			break
//		}
	

	switch(giSaveAndSendCat)
		{
		case '5':
			giSaveAndSendSubCat = 999
			break
		case '6':
			giSaveAndSendSubCat = 998
			break
		case '8':
			giSaveAndSendSubCat = 997
			break
		}
		
	XMLHTTPRequest("BPO_HTTP_Request.asp?function=StoreAuditContNo&pstrSuccess=C&pstrTransType=BTM" + String(giSaveAndSendSubCat) + "&pstrContNo=" + gsSaveAndSendConNo)
	
	if(document.all("txtAction").value==1)
		{
//alert('GetListXML(1)')	
		document.all("divAllNotes").innerHTML = ''
		GetListXML(1)
		}
	else
		{
		ReOrderList()
		}
}

function NothingToDo(s)
{
//	alert('Nothing to do: ' + s)
	alert('No messages to submit')
}
		
function Unnasigned_Delete()
{
	if(Number(NextFocusRow())<0){NothingToDo('no messages'); return 0}
		
	ShowBusy()
	var iMyRef = Number(document.all("CaseID", giContextCurr).value)
	
	if(iMyRef > 0)
		{
		var answer = confirm('Are you sure that you want to delete this request?')
		if(answer)
			{
			try{var response = WebForm1.A_Unnasigned_Delete(iMyRef, Unnasigned_Delete_CB)}
			catch(e){AjaxEH('Unnasigned_Delete', e)}
			}
		}
	else
		{
		document.all("divAllNotes").innerHTML = ''
		GetListXML(1)
		}
}

function Unnasigned_Delete_CB(r)
{
	if(r.error != null)
		{
		CallBackEH('Unnasigned_Delete', r.error)
		return 0
		}
					
	CheckXMLForException('Unnasigned_Delete', r.value)			
	HideBusy()
		
	document.all("divAllNotes").innerHTML = ''
	GetListXML(1)
}

			
function AddComment()
{
	if(Number(NextFocusRow())<0){NothingToDo('no messages'); return 0}
	
	var i = giContextCurr
	if(!document.all("tNew")){AddNewComment(); ShowVal('Comments are compulsory'); document.all("tNew").focus(); return}
	if(!document.all("tNew").value > ''){ShowVal('Comments are compulsory'); document.all("tNew").focus(); return}

	gbDirty = 0
	
	var s = ''
	var s = document.all("tNew").value
	s = s.replace(/&/g, '&amp;')
	
	ShowBusy()
	try{var response = WebForm1.A_AddComment(document.all("CaseID", i).value, document.all("WFID", i).value, s, document.all("txtUacfId").value, AddComment_CB)}
	catch(e){AjaxEH('AddComment', e)}
}
		
function AddComment_CB(r)
{
	if(r.error != null)
		{
		CallBackEH('AddComment', r.error)
		return 0
		}
	CheckXMLForException('AddComment', r.value)
	HideBusy()
	GetComments(giContextCurr)
}

var giAddCommentAndChangeStateState = 0
function AddCommentAndChangeState(iState)
{
	giAddCommentAndChangeStateState = iState
	if(Number(NextFocusRow())<0){NothingToDo('no messages'); return 0}
	var i = giContextCurr
	var sNote = ' '
		
	if(Number(iState) == 4)
		{
		if(document.all("tNew"))
			{
			sNote = document.all("tNew").value
			}
		}
	else
		{
		if(!document.all("tNew")){AddNewComment(); ShowVal('Comments are compulsory'); document.all("tNew").focus(); return}
		if(!document.all("tNew").value > ''){ShowVal('Comments are compulsory'); document.all("tNew").focus(); return}
		sNote = document.all("tNew").value
		}

	gbDirty = 0	
	ShowBusy()
	try{var response = WebForm1.A_AddCommentAndChangeState(document.all("CaseID", i).value, document.all("WFID", i).value, sNote, iState, document.all("txtUacfId").value, AddCommentAndChangeState_CB)}
	catch(e){AjaxEH('AddCommentAndChangeState', e)}
}
			
function AddCommentAndChangeState_CB(r)
	{
	if(r.error != null)
		{	
		if(giRetry < 3)
			{
			giRetry ++
			AddCommentAndChangeState(giAddCommentAndChangeStateState)
			return 0
			}
		giRetry = 0
		CallBackEH('AddCommentAndChangeState', r.error)
		return 0
		}
		
	giRetry = 0
	CheckXMLForException('AddCommentAndChangeState', r.value)
	HideBusy()
	RemoveCaseFromXML(document.all("CaseID", giContextCurr).value)
	ReOrderList()
}

var giAddCommentAndReAssignState = 0
function AddCommentAndReAssign(iState)
{
	giAddCommentAndReAssignState = iState

	if(Number(NextFocusRow())<0){NothingToDo('no messages'); return 0}
	var i = giContextCurr
	if(document.all("divListRow", i).specialtype == 'old'){alert('Function not available for items closed more than 2 weeks ago'); return 0}
	
	var sNote = ' '
		
	if(Number(iState) == 4)
		{
		if(document.all("tNew"))
			{
			sNote = document.all("tNew").value
			}
		}
	else
		{
		if(!document.all("tNew")){AddNewComment(); ShowVal('Comments are compulsory'); document.all("tNew").focus(); return}
		if(!document.all("tNew").value > ''){ShowVal('Comments are compulsory'); document.all("tNew").focus(); return}
		sNote = document.all("tNew").value
		}

	gbDirty = 0	
	ShowBusy()
	try{var response = WebForm1.A_AddCommentAndReAssign(document.all("CaseID", i).value, document.all("WFID", i).value, sNote, iState, document.all("txtUacfId").value, AddCommentAndReAssign_CB)}
	catch(e){AjaxEH('AddCommentAndReAssign', e)}
}
		
function AddCommentAndReAssign_CB(r)
{
	if(r.error != null)
		{
		if(giRetry < 3)
			{
			giRetry ++
			AddCommentAndReAssign(giAddCommentAndReAssignState)
			return 0
			}
		giRetry = 0
		CallBackEH('AddCommentAndReAssign', r.error)
		return 0
		}
		
	giRetry = 0
	CheckXMLForException('AddCommentAndReAssign', r.value)
	HideBusy()
	RemoveCaseFromXML(document.all("CaseID", giContextCurr).value)
	ReOrderList()
}

function TestAjax()
{
	ShowBusy()
	try{var response = WebForm1.A_Test(TestAjax_CB)}
	catch(e){AjaxEH('TestAjax', e)}
}
		
function TestAjax_CB(r)
{
	if(r.error != null)
		{
		CallBackEH('TestAjax', r.error)
		return 0
		}
}

function CheckXMLForException(fNme, s)
{
	return 0
	
	if(s == ''){MainEH(fNme, s); return 1}
	var i = 0
	var doc = new ActiveXObject("Microsoft.XMLDOM")
	doc.loadXML(s)
	var nodes = new ActiveXObject("Microsoft.XMLDOM")
	nodes.async="false"
	var Exception = doc.getElementsByTagName("Exception")
	try
		{
		if(Exception.length > 0){MainEH(fNme, s); return 1}
		}
	catch(e){}		
}

var giGetListXMLFuncTp = 0
function GetListXML(iFuncTp)
{
	giGetListXMLFuncTp = iFuncTp
	
	var sUACFId = document.all("txtUacfId").value
	var sConsultantCode = ''
	
	try
		{
		if(document.all("rbConsCd").checked==1)
			{
			sUACFId = ''
			try{sConsultantCode = document.all("txtMyConsultantCode").value}catch(e){}
			}
		}
	catch(e){}
	
	ShowBusy()
	try{var response = WebForm1.A_GetList(Number(iFuncTp), sUACFId, sConsultantCode, GetListXML_CB)}
	catch(e){AjaxEH('GetListXML', e)}
}
		
function GetListXML_CB(r)
{
	if(r.error != null)
		{
		if(giRetry < 3)
			{
			giRetry ++
			GetListXML(giGetListXMLFuncTp)
			return 0
			}
		giRetry = 0
		CallBackEH('GetListXML', r.error)
		return 0
		}
		
	giRetry = 0
	CheckXMLForException('GetListXML', r.value)
	xmlData.innerHTML = r.value
	HideBusy()
	ShowList(document.all("txtAction").value)
}

function GetListXMLOldClosed()
{
	var sUACFId = document.all("txtUacfId").value
	var sConsultantCode = ''
	
	try
		{
		if(document.all("rbConsCd").checked==1)
			{
			sUACFId = ''
			try{sConsultantCode = document.all("txtMyConsultantCode").value}catch(e){}
			}
		}
	catch(e){}
	
	ShowBusy()
	try{var response = WebForm1.A_GetList(5, sUACFId, sConsultantCode, GetListXMLOldClosed_CB)}
	catch(e){AjaxEH('GetListXMLOldClosed', e)}
}
		
function GetListXMLOldClosed_CB(r)
{
	if(r.error != null)
		{
		CallBackEH('GetListXMLOldClosed', r.error)
		return 0
		}
		
	CheckXMLForException('GetListXMLOldClosed', r.value)
	xmlDataOldClosed.innerHTML = r.value
	HideBusy()
	ShowList(document.all("txtAction").value)
}
					
function AjaxEH(fNme, e)
{
	MainEH(fNme, e)
//	alert('Error on call to AJAX function: ' + fNme + ' - ' + e)
	alert('Recipient system currently not available. Please try again later')
}
		
function CallBackEH(fNme, e)
{
	MainEH(fNme, e)
	if(bgDebug){alert('Error returned to: ' + fNme + '_CB - ' + e)}
	alert('Recipient system currently not available. Please try again later')
}
		
function MainEH(fNme, e)
{
	HideBusy()
	XMLHTTPRequest("BPO_HTTP_Request.asp?function=LogError&pstrPageName=BPO_FF.aspx&pstrPolNo=0&pstrErrorMess=Error in function" + fNme + "&pstrErrorDesc=" + e + "&pstrErrorType=i&pstrSourceDll=BPO_FF.dll&pstrRetCode=0095")
}
	
function ShowBusy()
{	
	divBusy.style.top = window.screen.height - (window.screen.height * 0.3)
	divBusy.style.left = window.screen.width - (window.screen.width * 0.35)
	divBusy.style.visibility = 'visible'
}
		
function HideBusy()
{
	gbBusy = 0
	divBusy.style.visibility = 'hidden'
}
		
function PositionListDivs()
{
	try
		{		
		for(i=1;i<giContext;i++) // NB: start offset is 1 - first one is where it should be by default so dont mess with it
			{
			divListRow(Number(i)).style.top = divListRow(Number(i - 1)).offsetTop + divListRow(Number(i - 1)).offsetHeight + 3
			}
		}
	catch(e){}
}
		
function ReOrderList()
{
	try
		{
		var i = giContextCurr
		var iRowToSetFocusTo = 0
		var iNextTop = 0
		if(divListRow.length > 1)
			{
			divListRow(Number(i)).style.visibility = 'hidden'
			iNextTop = divListRow(Number(i)).offsetTop
					
			for(i;i<giContext;i++)
				{
				if(divListRow(Number(i)).style.visibility != 'hidden')
					{
					if(iRowToSetFocusTo==0)
						{
						iRowToSetFocusTo = i
						}
					divListRow(Number(i)).style.top = iNextTop
					iNextTop = divListRow(Number(i)).offsetTop + divListRow(Number(i)).offsetHeight + 3
					}
				}
					
			KillRowFocus(giContextCurr)
			if(iRowToSetFocusTo > 0)
				{
				SetRowFocus(document.all("ListRow", iRowToSetFocusTo))
				}
			else
				{
				SetRowFocus()
				}
			}
		else
			{
			divListRow.style.visibility = 'hidden'
			KillRowFocus(i)
			SetRowFocus()
			}
		}
	catch(e){}
}
	
function AddNewComment()
{
	if(Number(NextFocusRow())<0){NothingToDo('no messages'); return 0}
	var i = giContextCurr
	if(document.all("divListRow", i).specialtype == 'old'){alert('Function not available for items closed more than 2 weeks ago'); return 0}
	
	gbDirty = 1
	
	var s = '<table width=100%>'
	s += '<tr><td class=tdHDetail1 align=center>Comments</td></tr>'
	s += '</table>'
	document.all("divNewNoteHdr").innerHTML = s
	
	s = '<table width=100%>'
	s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=7>' + document.all("txtNewNote", giContextCurr).value + '</textarea></td></tr>'
	s += '</table>'
	document.all("divNewNoteBody").innerHTML = s
	
	divNewNote.style.top = divContent.offsetTop + iBorders
	divNewNote.style.left = divContent.offsetLeft + iBorders
	divNewNote.style.height = (divContent.offsetHeight / 3) - (iBorders * 2)
	divNewNote.style.width = divContentInner.offsetWidth
	divNewNote.style.visibility = 'visible'
	
	SetNewNoteCoords()
		
	divContentInner.style.top = divNewNote.offsetTop + divNewNote.offsetHeight + iBorders
	divContentInner.style.height = divContent.offsetHeight - divNewNote.offsetHeight - (iBorders * 2) - 2
	
	divContentInnerHdr.style.top = divContentInner.offsetTop + 1
	divContentInnerBody.style.top = divContentInnerHdr.offsetTop + divContentInnerHdr.offsetHeight
	divContentInnerBody.style.height = divContentInner.offsetHeight - divContentInnerHdr.offsetHeight - (iBorders * 2) - 2
}

function SetNewNoteCoords()
{
	divNewNoteHdr.style.top = divNewNote.offsetTop + 1
	divNewNoteHdr.style.left = divNewNote.offsetLeft + 1
	divNewNoteHdr.style.width = divNewNote.offsetWidth - 2
	divNewNoteBody.style.top = divNewNoteHdr.offsetTop + divNewNoteHdr.offsetHeight + 1
	divNewNoteBody.style.left = divNewNote.offsetLeft + 1
	divNewNoteBody.style.width = divNewNoteHdr.offsetWidth - 2
	divNewNoteBody.style.height = divNewNote.offsetHeight - divNewNoteHdr.offsetHeight - 3
	divNewNoteHdr.style.visibility = 'visible'
	divNewNoteBody.style.visibility = 'visible'
}
	
var giGetCommentsi = 0
function GetComments(i)
{
	giGetCommentsi = i
	if(document.all("txtAction").value == 1 && (document.all("txtNewNote", giContextCurr).value > '' || Number(document.all("CaseID", i).value) < 1))
		{		
		var s = '<table width=100%>'
		s += '<tr><td class=tdHDetail1 align=center>Comments</td></tr>'
		s += '</table>'
		document.all("divNewNoteHdr").innerHTML = s
	
		s = '<table width=100%>'
		s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=30>' + document.all("txtNewNote", giContextCurr).value + '</textarea></td></tr>'
		s += '</table>'
		document.all("divNewNoteBody").innerHTML = s
		
		divNewNote.style.top = divContent.offsetTop + iBorders
		divNewNote.style.left = divContent.offsetLeft + iBorders
		divNewNote.style.height = divContent.offsetHeight - (iBorders * 2)
		divNewNote.style.width = divContent.offsetWidth - (iBorders * 2)
		divNewNote.style.visibility = 'visible'
		
		SetNewNoteCoords()
		}
	else
		{
		ShowBusy()
		try{var response = WebForm1.A_GetComments(document.all("CaseID", i).value, document.all("WFID", i).value, GetComments_CB)}
		catch(e){AjaxEH('GetComments', e)}
		}
}
		
function GetComments_CB(r)
{
	if(r.error != null)
		{
		if(giRetry < 3)
			{
			giRetry ++
			GetComments(giGetCommentsi)
			return 0
			}
		giRetry = 0
		CallBackEH('GetComments', r.error)
		return 0
		}
		
	giRetry = 0
	var s = ''
	var wrk = ''
	
	CheckXMLForException('AddCommentAndReAssign', r.value)
	try
		{
		var doc = new ActiveXObject("Microsoft.XMLDOM")
		doc.async="false"
		var nodes = new ActiveXObject("Microsoft.XMLDOM")
		nodes.async="false"
		var nodes2 = new ActiveXObject("Microsoft.XMLDOM")
		nodes2.async="false"
		doc.loadXML(r.value)
		var Comments=doc.getElementsByTagName("Comment")
			
		var i = 0
		if(document.all("txtAction").value == 1) // unassigned
			{
			s = '<table width=100%>'
			if(Comments.length > 0)
				{
				nodes.loadXML(Comments.item(0).xml)
				s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=30>' + nodes.documentElement.selectSingleNode("/Comment/Note").text + '</textarea></td></tr>'
				}
			else
				{
				s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=30></textarea></td></tr>'
				}
			s += '</table>'
			}
		else
			{
			while(i < Comments.length)
				{
				nodes.loadXML(Comments.item(i).xml)
				wrk = "<tr><td  class=tdH5 width=10%>From:</td><td class=tdH6>" + nodes.documentElement.selectSingleNode("/Comment/User").text + "</td></tr>"
				wrk += "<tr><td  class=tdH5 width=10%>Sent:</td><td class=tdH6>" + nodes.documentElement.selectSingleNode("/Comment/Date").text + "</td></tr>"
				wrk += "<tr><td class=tdH6 colspan=2>" + nodes.documentElement.selectSingleNode("/Comment/Text").text + "</td></tr>"
				wrk += "<tr><td class=tdH7 colspan=2>__________________________________</td></tr>"
				i ++
				s = wrk + s
				}		
			s = '<table width=100%>' + s + '</table>'
			}
		}
	catch(e)
		{
		HideBusy()
		s = ''
		}
			
	if(document.all("txtAction").value==1)
		{
		divNewNote.style.top = divContent.offsetTop + iBorders
		divNewNote.style.left = divContent.offsetLeft + iBorders
		divNewNote.style.height = divContent.offsetHeight - (iBorders * 2)
		divNewNote.style.width = divContent.offsetWidth - (iBorders * 2)
		divNewNote.style.visibility = 'visible'

		SetNewNoteCoords()
		
		document.all("divNewNoteHdr").innerHTML = '<table width=100%><tr><td class=tdHDetail1 align=center>Comments</td></tr></table>'
		document.all("divNewNoteBody").innerHTML = s
		}
	else
		{
		divNewNote.style.width = divContent.offsetWidth - (iBorders * 2)
		divNewNote.style.visibility = 'hidden'
		divNewNoteHdr.style.width = divContent.offsetWidth - (iBorders * 2)
		divNewNoteHdr.style.visibility = 'hidden'
		divNewNoteBody.style.width = divContent.offsetWidth - (iBorders * 2)
		divNewNoteBody.style.visibility = 'hidden'
		divContentInner.style.top = divContent.offsetTop + iBorders
		divContentInner.style.left = divContent.offsetLeft + iBorders
		divContentInner.style.height = divContent.offsetHeight - (iBorders * 2)
		divContentInner.style.width = divContent.offsetWidth - (iBorders * 2)
		divContentInner.style.visibility = 'visible'

		divContentInnerHdr.style.top = divContentInner.offsetTop + 1
		divContentInnerHdr.style.left = divContentInner.offsetLeft + 1
		divContentInnerHdr.style.width = divContentInner.offsetWidth - 2
		
		divContentInnerBody.style.top = divContentInnerHdr.offsetTop + divContentInnerHdr.offsetHeight
		divContentInnerBody.style.left = divContentInner.offsetLeft + iBorders
		divContentInnerBody.style.width = divContentInner.offsetWidth - (iBorders * 2)
		divContentInnerBody.style.height = divContentInner.offsetHeight - divContentInnerHdr.offsetHeight - (iBorders * 2)
		
		document.all("divContentInnerBody").innerHTML = s
		divContentInnerHdr.style.visibility = 'visible'
		divContentInnerBody.style.visibility = 'visible'
		}
	HideBusy()
}

function XMLHTTPRequest(sURL)
{
	var oXMLHTTP = new ActiveXObject("Microsoft.XMLHTTP")
	oXMLHTTP.open("POST", sURL, false)
	oXMLHTTP.send(" ")
	return oXMLHTTP.responseText
}

var gaLinkedCons = new Array()	
var gsConsltSel = ''
function GetUserIDAndConslts(sAction)
{
	var i = 0
	var j = 0
	var doc = new ActiveXObject("Microsoft.XMLDOM")
	doc.async="false"
	var nodes = new ActiveXObject("Microsoft.XMLDOM")
	nodes.async="false"
	doc.loadXML(XMLHTTPRequest('BOPFF_GetUserAndConslts.asp'))
	
	document.all("txtUacfId").value = doc.getElementsByTagName("UserID")[0].firstChild.nodeValue
	document.all("txtUserType").value = doc.getElementsByTagName("UserType")[0].firstChild.nodeValue
	try{document.all("txtMyConsultantCode").value = doc.getElementsByTagName("MyConsCode")[0].firstChild.nodeValue}catch(e){}
	
	var Conslts = doc.getElementsByTagName("ConsCode")
	if(Conslts.length==0){gsConsltSel=''}
	else
		{
		var wrk = '<option>' + ' select a code' + '</option>'
		var sConsCd = ''
		gaLinkedCons[0] = ''
		while(i < Conslts.length)
			{
			sConsCd = ''
			nodes.loadXML(Conslts.item(i).xml)
			try
				{
				wrk += '<option>' + nodes.getElementsByTagName("ConsCode")[0].firstChild.nodeValue + '</option>'
				sConsCd = nodes.getElementsByTagName("ConsCode")[0].firstChild.nodeValue
				gaLinkedCons[j + 1] = sConsCd
				j ++
				}
			catch(e){}	
			i ++
			}
		var s = '<select id="selConslts" onchange="SetConsCode(this.selectedIndex, ' + sAction + ')">' + wrk + '</select>'
		gsConsltSel = s
		}
}

function SetConsCode(i, sAction)
{
	document.all("txtMyConsultantCode").value = gaLinkedCons[i]
	try{document.all("txtConsCode").value = gaLinkedCons[i]}catch(e){}
//	if(sAction > 1)
//		{
//		GetListXML(sAction)
//		}
}
	
function RemoveCaseFromXML(id)
{
	var i = 0
	var wrk = ''
	var bFound = 0
	var doc = new ActiveXObject("Microsoft.XMLDOM")
	var doc2 = new ActiveXObject("Microsoft.XMLDOM")
	doc.loadXML(xmlData.innerHTML)
	var nodes = new ActiveXObject("Microsoft.XMLDOM")
	nodes.async="false"
	var Cases = doc.getElementsByTagName("Case")
		
	while(i < Cases.length)
		{
		wrk = ''
		nodes.loadXML(Cases.item(i).xml)
			if(String(nodes.documentElement.selectSingleNode("/Case/ID").text) == String(id))
				{
				bFound = 1	
				doc2 = Cases.item(i).parentNode
				doc2.removeChild(Cases.item(i))
				xmlData.innerHTML = doc2.xml
				break
				}
		i ++
		}
	
	if(bFound == 0)
		{
		doc.loadXML(xmlDataOldClosed.innerHTML)
		nodes = new ActiveXObject("Microsoft.XMLDOM")
		Cases = doc.getElementsByTagName("Case")
		
		i = 0
		while(i < Cases.length)
			{
			wrk = ''
			nodes.loadXML(Cases.item(i).xml)
			
				if(nodes.documentElement.selectSingleNode("/Case/ID").text == id)
					{
					bFound = true	
					doc2 = Cases.item(i).parentNode
					doc2.removeChild(Cases.item(i))
					xmlDataOldClosed.innerHTML = doc2.xml
					break
					}
			i ++
			}
		}
}

var sShowOld = '+'
function BuildListFromXML()
{
	giContext = 0
	var s = ''
	var sCat = ''
	var sSubCat = ''
	try
		{
		document.all("divAllNotes").innerHTML = ''
		s = BuildListFromXMLPart2(0)
		
		if(document.all("txtAction").value == 4)
			{		
			s += '<div id="divListRow" style="position:absolute; BORDER-BOTTOM: lightgrey 1px outset" specialtype="hdr">'
			s += '<table width=100% class="tableList" id="ListRow" onclick="" ContextRow="' + giContext + '">'
			s += '<tr>'
			s += '<td class="tdListH" valign=center><input type=button class="bShowOld" value="' + sShowOld + '" onclick="HideShowOld()">&nbsp;older than 2 weeks<input type=hidden id="CaseID" value=""><input type=hidden id="WFID" value=""></td>'
			s += '</tr>'
			s += '</table>'
			s += '</div>'
			document.all("divAllNotes").innerHTML = document.all("divAllNotes").innerHTML + '<textarea id="txtNewNote" style="visibility:hidden; height:0; width:0" rows=10></textarea><br>'
			giContext ++

			if(xmlDataOldClosed.innerHTML > '')
				{	
				s += BuildListFromXMLPart2(1)
				}
			}
		}
	catch(e){}
	return(s)
}

function BuildListFromXMLPart2(iListTp)
{
	var s = ''
	var sCat = ''
	var sSubCat = ''
	var sSpecialType = ''
	try
		{
		var doc = new ActiveXObject("Microsoft.XMLDOM")
		if(iListTp == 0)
			{
			doc.loadXML(xmlData.innerHTML)
			}
		else
			{
			doc.loadXML(xmlDataOldClosed.innerHTML)
			sSpecialType = 'old'
			}
		var nodes = new ActiveXObject("Microsoft.XMLDOM")
		nodes.async="false"
		var Cases = doc.getElementsByTagName("Case")
		if(Cases.length > 0)
			{
			var i = 0
			while(i < Cases.length)
				{
				wrk = ''
				nodes.loadXML(Cases.item(i).xml)
				if(document.all("txtAction").value == 1)
					{
					s += '<div id="divListRow" style="position:absolute; BORDER-BOTTOM: lightgrey 1px outset" specialtype="">'
					s += '<table width=100% class="tableList" id="ListRow" onclick="MoveNewNoteToContext(); if(KillRowFocus(giContextCurr, this)){SetRowFocus(this)}" ContextRow="' + giContext + '">'
					s += '<tr><td colspan=2 class=tdListH>Ensure that you enter a comment in the Comments section</td></tr>'
					s += '<tr><td colspan=2 class=tdListH>on the right after completing all the information below.</td></tr>'
					s += '<tr><td colspan=2 class=tdListH>&nbsp;</td></tr>'
					s += '<tr><td class="tdListH" width=30%>Contract number:</td><td><input class="txtInp" type=text id="txtContractNo" name="txtContractNo" value="' + nodes.documentElement.selectSingleNode("/Case/Contract_Number").text + '" onchange="gbDirty=1"><input type=hidden id="CaseID" value="' + nodes.documentElement.selectSingleNode("/Case/ID").text + '"><input type=hidden id="CatTC" value="' + nodes.documentElement.selectSingleNode("/Case/Category").text + '"><input type=hidden id="SubCatTC" value="' + nodes.documentElement.selectSingleNode("/Case/Sub_Category").text + '"><input type=hidden id="WFID" value="0"></td></tr>'
					
					s += '<tr><td class="tdListH">Subject:</td><td><input class="txtInp" type=text id="txtSubject" name="txtSubject" value="' + nodes.documentElement.selectSingleNode("/Case/Subject").text + '" onchange="gbDirty=1"></td></tr>'
					
					s += '<tr>'
					s += '<td colspan=2>'
						
					s += '<table width=100% bgcolor="white" cellpadding=0>'

					if(gsConsltSel > '')
						{
						s += '<tr><td class="tdList" width=30%>Consultant code:</td><td>' + gsConsltSel + '<input class="txtInp" type=hidden id="txtConsCode" name="txtConsCode" value="' + nodes.documentElement.selectSingleNode("/Case/ConsCode").text + '"></td></tr>'
						}
					else
						{
						s += '<tr><td class="tdList" width=30%>Consultant code:</td><td><input class="txtInp" type=text id="txtConsCode" name="txtConsCode" value="' + nodes.documentElement.selectSingleNode("/Case/ConsCode").text + '" size=11 maxlength=13 onchange="gbDirty=1"></td></tr>'
						}
						
					s += '<tr><td colspan=2><table width=100% cellspacing=0 cellpadding=0>'
					s += BuildCats(i)
					s += '</table>'
					s += '</td></tr></table>'
					
					s += '</td>'
					s += '</tr>'
					s += '</table>'
					s += '</div>'
					document.all("divAllNotes").innerHTML = document.all("divAllNotes").innerHTML + '<textarea id="txtNewNote" style="visibility:hidden; height:0; width:0" rows=10></textarea><br>'
					giContext ++
					}
				else
					{
					if((document.all("txtFindContract").value == '' && document.all("txtFindWFNo").value == '') || (document.all("txtFindContract").value == nodes.documentElement.selectSingleNode("/Case/Contract_Number").text) || (document.all("txtFindWFNo").value == nodes.documentElement.selectSingleNode("/Case/WFID").text))
						{
						sCat = nodes.documentElement.selectSingleNode("/Case/Category").text
						sSubCat = nodes.documentElement.selectSingleNode("/Case/Sub_Category").text
						s += '<div id="divListRow" style="position:absolute; BORDER-BOTTOM: lightgrey 1px outset" specialtype="' + sSpecialType + '">'
						s += '<table width=100% class="tableList" id="ListRow" onclick="MoveNewNoteToContext(); if(KillRowFocus(giContextCurr, this)){SetRowFocus(this)}" ContextRow="' + giContext + '">'
						s += '<tr>'
						s += '<td class="tdListH" width=50%>Contract #&nbsp;' + nodes.documentElement.selectSingleNode("/Case/Contract_Number").text + '<input type=hidden id="CaseID" value="' + nodes.documentElement.selectSingleNode("/Case/ID").text + '"><input type=hidden id="WFID" value="' + nodes.documentElement.selectSingleNode("/Case/WFID").text + '"></td>'
						s += '<td class="tdListH" colspan=2 width=50% align=right>Work Flow #&nbsp' + nodes.documentElement.selectSingleNode("/Case/WFID").text + '</td>'
						s += '</tr>'
						s += '<tr>'
						s += '<td class="tdList" colspan=3>Subject: ' + nodes.documentElement.selectSingleNode("/Case/Subject").text + '</td>'
						s += '</tr>'
						s += '<tr>'
						s += '<td class="tdList" colspan=3>Consultant code: ' + nodes.documentElement.selectSingleNode("/Case/ConsCode").text + '</td>'
						s += '</tr>'
						s += '<tr>'
						s += '<td class="tdList" width=50% colspan=2>This request relates to: ' + sCat + ' for: ' + sSubCat + '</td>'
						
						if(document.all("txtAction").value == 3)
							{
							if(nodes.documentElement.selectSingleNode("/Case/FLAG").text == 0)
								{
								s += '<td class="tdFlagUnread" align=right width=10%>P</td>'
								}
							else
								{
								s += '<td class="tdFlag" align=right width=10%>P</td>'
								}
							}
						else
							{
							s += '<td width=10%>&nbsp;</td>'
							}
						s += '</tr>'
						s += '</table>'
						s += '</div>'
						document.all("divAllNotes").innerHTML = document.all("divAllNotes").innerHTML + '<textarea id="txtNewNote" style="visibility:hidden; height:0; width:0" rows=10></textarea><br>'
						giContext ++
						}
					}
				i ++
				}
			}
		}
	catch(e){}
	return(s)
}

function HideShowOld()
{
	if(sShowOld == '+')
		{
		sShowOld = '-'
//		Set up test data...		
//		var s = ''
//		s += '<CaseList>'
//		s += '<Case>'
//		s += '<WFID>123456</WFID>'
//		s += '<Subject>1111</Subject>'
//		s += '<Contract_Number>999</Contract_Number>'
//		s += '<ConsCode>1111</ConsCode>'
//		s += '<Category>Financial Control</Category>'
//		s += '<Sub_Category>Re Allocation</Sub_Category>'
//		s += '<ID>500</ID>'
//		s += '<FLAG></FLAG>'
//		s += '</Case>'
//		s += '<Case>'
//		s += '<WFID>654321</WFID>'
//		s += '<Subject>1111</Subject>'
//		s += '<Contract_Number>1111</Contract_Number>'
//		s += '<ConsCode>1111</ConsCode>'
//		s += '<Category>Financial Control</Category>'
//		s += '<Sub_Category>Re Allocation</Sub_Category>'
//		s += '<ID>501</ID>'
//		s += '<FLAG></FLAG>'
//		s += '</Case>'
//		s += '</CaseList>'
//		xmlDataOldClosed.innerHTML = s
//		ShowList(document.all("txtAction").value)
		GetListXMLOldClosed()
		}
	else
		{
		sShowOld = '+'
		xmlDataOldClosed.innerHTML = ''
		ShowList(document.all("txtAction").value)
		}
}

var sVisibility = new Array()
function HideDivsForPrint()
{
	sVisibility[0] = divFind.style.visibility
	sVisibility[1] = divListHdr.style.visibility
	sVisibility[2] = divList.style.visibility
	sVisibility[3] = divContent.style.visibility
	sVisibility[4] = divContentInner.style.visibility
	sVisibility[5] = divContentInnerHdr.style.visibility
	sVisibility[6] = divContentInnerBody.style.visibility
	sVisibility[7] = divNewNote.style.visibility
	sVisibility[8] = divNewNoteHdr.style.visibility
	sVisibility[9] = divNewNoteBody.style.visibility
	sVisibility[10] = divHelp.style.visibility
	sVisibility[11] = divHelpInner.style.visibility
	sVisibility[12] = divAllNotes.style.visibility
	sVisibility[13] = divTT.style.visibility
	sVisibility[14] = divBusy.style.visibility
	sVisibility[15] = divFFMain.style.visibility
	
	try
		{
		sVisibility[16] = divOpts.style.visibility
		}
	catch(e){}
	
	try
		{
		sVisibility[17] = document.all("selConslts").style.visibility
		sVisibility[18] = document.all("btConslts").style.visibility
		}
	catch(e){}	
				
	divFind.style.visibility = 'hidden'
	divListHdr.style.visibility = 'hidden'
	divList.style.visibility = 'hidden'
	divContent.style.visibility = 'hidden'
	divContentInner.style.visibility = 'hidden'
	divContentInnerHdr.style.visibility = 'hidden'
	divContentInnerBody.style.visibility = 'hidden'
	divNewNote.style.visibility = 'hidden'
	divNewNoteHdr.style.visibility = 'hidden'
	divNewNoteBody.style.visibility = 'hidden'
	divHelp.style.visibility = 'hidden'
	divHelpInner.style.visibility = 'hidden'
	divAllNotes.style.visibility = 'hidden'
	divTT.style.visibility = 'hidden'
	divBusy.style.visibility = 'hidden'
	divFFMain.style.visibility = 'hidden'
	
	try
		{	
		divOpts.style.visibility = 'hidden'
		}
	catch(e){}		
	
	try
		{	
		document.all("selConslts").style.visibility = 'hidden'
		document.all("btConslts").style.visibility = 'hidden'
		}
	catch(e){}		
}

function ShowDivsAfterPrint()
{
	divFind.style.visibility = sVisibility[0]
	divListHdr.style.visibility = sVisibility[1]
	divList.style.visibility = sVisibility[2]
	divContent.style.visibility = sVisibility[3]
	divContentInner.style.visibility = sVisibility[4]
	divContentInnerHdr.style.visibility = sVisibility[5]
	divContentInnerBody.style.visibility = sVisibility[6]
	divNewNote.style.visibility = sVisibility[7]
	divNewNoteHdr.style.visibility = sVisibility[8]
	divNewNoteBody.style.visibility = sVisibility[9]
	divHelp.style.visibility = sVisibility[10]
	divHelpInner.style.visibility = sVisibility[11]
	divAllNotes.style.visibility = sVisibility[12]
	divTT.style.visibility = sVisibility[13]
	divBusy.style.visibility = sVisibility[14]
	divFFMain.style.visibility = sVisibility[15]
	
	try
		{	
		divOpts.style.visibility = sVisibility[16]
		}
	catch(e){}		
	
	try
		{
		document.all("selConslts").style.visibility = sVisibility[17]
		document.all("btConslts").style.visibility = sVisibility[18]
		}
	catch(e){}		
}

function PrintHistory()
{
	document.all("divPrint").innerHTML = '<table width=100% border=1 cellpadding=0 cellspacing=0><tr><td align=center><font face=Arial size=2><b>BTM Item</b></font></td></tr></table><br>'
	document.all("divPrint").innerHTML += document.all("divListRow", giContextCurr).innerHTML
	document.all("divPrint").innerHTML += '<br><table width=100% border=1 cellpadding=0 cellspacing=0><tr><td align=center><font face=Arial size=2><b>Comment History</b></font></td></tr></table><br>'
	document.all("divPrint").innerHTML += document.all("divContentInnerBody").innerHTML
	divPrint.style.visibility = 'visible'
	divPrint.style.left = divFFMain.offsetLeft
	divPrint.style.top = divFFMain.offsetTop
	
	HideDivsForPrint()
	window.print()
	ShowDivsAfterPrint()

	divPrint.style.visibility = 'hidden'		
	document.all("divPrint").innerHTML = ''
	divPrint.style.height = 0
}

function PrintHelp()
{
	document.all("divPrint").innerHTML = document.all("divHelpInner").innerHTML
	divPrint.style.visibility = 'visible'
	divPrint.style.left = divFFMain.offsetLeft
	divPrint.style.top = divFFMain.offsetTop
	HideDivsForPrint()
	window.print()
	ShowDivsAfterPrint()

	divPrint.style.visibility = 'hidden'		
	document.all("divPrint").innerHTML = ''
	divPrint.style.height = 0
}

</script>
<xml id='xmlData'></xml>
<xml id='xmlDataOldClosed'></xml>
</body>
</HTML>
