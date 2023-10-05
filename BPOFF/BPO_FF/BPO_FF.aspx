<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BPO_FF.aspx.vb" Inherits="BPO_FF.WebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%--***********************************************************************************************************************************************
                                MAINTENANCE HISTORY

 #Chander (Changes done by Zensar)  25/02/2014 Converted below function using Jquery XML DOM Parser to make compatible with other browsers for FEBC Project.
  
  BuildCats
  BuildCatsArray
  BuildSubsArray
  BuildSubs
  CatHasSubs
  SetRowFocus
  ShowHelp
  GetComments_CB
  GetUserIDAndConslts
  PrintHistory
  PrintHelp
  GetBTMNote              //new function written by Chander 
  RemoveCaseFromXML
  getxmlwfid               //new function written by Chander
  BuildListFromXMLPart2
  BuildCats
  BuildSubs
  CatHasSubs
  HideHelp
  SetFlag                 //new function written by Chander
  getxml                  //new function written by Chander
  BuildListFromXMLPart2
  document.getElementById() is replaced by document.All() in entire page //all is only compatible to IE
 
  Chander  27/02/2014 -- Added the W3C HTML Standardization like opening and closing of tags,DOCTYPE,type="text/css or type="text/javascript", 
                         all tags in Lower case, Jquery Library etc
  Chander  27/02/2014--  New XML DOM Parser function which is compatible with all other browsers
                       var doc = $.parseXML() To parse XML and it works on all browser previous(var doc = new ActiveXObject("Microsoft.XMLDOM") Work only in IE
                       $(doc).find("item").length Calculate not of item in XML
  Chander  28/02/2014--  var oXMLHTTP = new ActiveXObject("Microsoft.XMLHTTP) this works only in IE replaced by var oXMLHTTP = new XMLHttpRequest() which works in all Browsers                                            
 
************************************************************************************************************************************************--%>
    <title>WebForm1</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
    <meta content="JavaScript" name="vs_defaultClientScript" />
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />

    <script type="text/javascript" src="jquery-1.7.2.js"></script> <%--****Chander Jquery reference*****--%>
    
    <%--***Chander****--%>
    <script type="text/javascript">
        
        // JQuery function set for all browser's actual height.
        $(document).ready(function() {
            var viewportHeight = document.documentElement.clientHeight
            || document.documentElement.clientHeight
            || document.body.clientHeight;
            viewportHeight = viewportHeight - 170;
            viewportHeightdivContent = viewportHeight - 10;
            if ($.browser.msie && Number($.browser.version) < 9) {
                viewportHeightdivContent = viewportHeightdivContent + 140;

            }
            $('#divContentInner').height(viewportHeight);
          
            $('#divList').height(viewportHeightdivContent);
            $('#divHelpInner').height(viewportHeight);
            $('#divContent').height(viewportHeightdivContent);
            $("#divFFMain").hide();
            $("#divAllNotes").hide();
            $("#divContent").css("visibility", "visible");
            $("#xmlData2").hide();
            $("#xmlDataOldClosed").hide();
            if ($("#divContentInnerHdr").css("display") == "none") {
                $("#divContent").css("height", 475);  //chander
            }
        });
       
    </script>    
 
  <%--****chander****--%>
    <style type="text/css">
        #imgicon
        {
            margin-left: 2px;
            margin-right: 2px;
            margin-top: 2px;	
        	
        }
        #xmlDataOldClosed
        {
            display: none;
        }
        .bl_gray
        {
            background: #ccc;
            border: 1px solid #000;
            padding: 5px;
        }
        .clr
        {
            clear: both;
        }
        .div_lft
        {
            width: 49%;
            float: left;
            position: relative;
            margin-top: 10px;
        }
        .div_help
        {
            position: relative;
            width: 20%;
            margin-left: 2%;
            margin-top: 10px;
            float: right;
            display: none;
        }
        .div_rgt
        {
            width: 49%;
            float: right;
            position: relative;
            background: #646464;
            margin-top: 10px;
        }
        td.tdUAH1
        {
            padding: 5px 10px 0;
        }
        #xmlData
        {
            display: none;
        }
        #divListRow
        {
            position: relative;
        }
        .tableList1
        {
            background: #99ccff;
        }
        .rowcolor
        {
            background-color: #99CCFF;
            border: 3px solid #99CCFF;
        }
        iframe
        {
            overflow: hidden;
        }
        .Unread
        {
            background: url(Images/white.png) no-repeat center center !important;
        }
        .read
        {
            background: url(Images/red.png) no-repeat center center !important;
        }
        INPUT.bTB.btnAdd
        {
            background: url(Images/new.png) no-repeat center center !important;
        }
        INPUT.bTB.btndelete
        {
            background: url(Images/close.png) no-repeat center center !important;
        }
        INPUT.bTB.btnhelp
        {
            background: url(Images/question.png) no-repeat center center !important;
        }
        INPUT.bTB.addcmt
        {
            background: url(Images/add.png) no-repeat center center !important;
        }
        INPUT.bTB2.btnclose
        {
            background: url(Images/close.png) no-repeat center center !important;
        }
        INPUT.bTB.btnprint
        {
            background: url(Images/print.png) no-repeat center center !important;
        }
        INPUT.bTB.btnsave
        {
            background: url(Images/save.png) no-repeat center center !important;
        }
        INPUT.bTB.btnsent
        {
            background: url(Images/sent.png) no-repeat center center !important;
        }
        INPUT.bTB.closeitem
        {
            background: url(Images/closeditem.png) no-repeat center center !important;
        }
    </style>
    <!-- changes end. -->

    <link href="BPO_FF.css" type="text/css" rel="stylesheet" />
</head>
<body onload='InitialisePage(document.getElementById("txtAction").value)' ms_positioning="GridLayout">
    <form id="Form1" method="post" runat="server" style="height: 505px">
    <div id="divBanner" style="visibility: hidden; background-color: #5a84b7; margin-bottom: 10px">
        &nbsp;</div>
    <div class="btm_main" style="clear: both; background-color: rgb(235, 231, 226); padding: 5px;
        border: 1px solid #000;">
        <div id="divFind" style="border: 1px solid #036; visibility: hidden; background-color: #ebe7e2;
            margin-bottom: 0px;">
            two</div>
        <div class="div_lft" style="width: 49.5%; float: left; border: 1px solid #000; min-height: 475px;">
            <div id="divListHdr" style="border-bottom: 1px solid #036; visibility: hidden; background-color: #fff;
                height: 26px; overflow: hidden;">
                &nbsp;</div>
            <div id="divList" style="border-top: 0; visibility: hidden; overflow:auto; background-color: #fff; position:relative ">
                &nbsp;</div>
        </div>
        <div class="bl_help" style="display: none; width: 20%; float: right; margin: 10px 0 0 0.5%">
            <div id="divHelp" style="border: 1px solid #000; visibility: hidden; background-color: #fff;">
            </div>
            <div id="divHelpInner" style="visibility: hidden; cursor: pointer; overflow: auto;
                background-color: #fff; border: 1px solid black">
            </div>
        </div>
        <div class="div_rgt" style="width: 49.5%; float: right; border: 1px solid #000; background: #fff;">
            <div id="divBusy" style="visibility: hidden; background-color: #fff; position: absolute;
                margin: auto; left: 150px; right: 0; bottom: 0; top: 350px; line-height: 20px;
                height: 20px; width: 110px;">
                <table class="tableBusy" cellpadding="0" cellspacing="0" width="100%" border="0">
                    <tr>
                        <td valign="middle">
                            busy transferring data
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divContentInnerHdr" style="visibility: visible; background-color: #fff;
                display: none;">
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="tdH2">
                            &nbsp;Comment History
                        </td>
                        <td align="right" valign="middle" class="tdH2">
                            <input class="bTB btnprint" style="cursor: pointer" type="button" title="Print" onclick="PrintHistory();"
                                text="Print" onmouseover="ShowTip(this);" onmouseout="HideTip(this);">&nbsp;
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divAllNotes" style="visibility: visible; overflow: auto">
                <div id="divNewNoteHdr" style="visibility: hidden; background-color: #fff;">
                    &nbsp;</div>
                <div id="divNewNoteBody" style="visibility: hidden; overflow: auto; background-color: #fff;">
                </div>
            </div>
            <div id="divContent" style="visibility: hidden; background-color: #fff; margin: 3px;
                border: 1px solid #000; overflow: auto;">
                <div id="divContentInner" style="visibility: hidden; background-color: #fff;">
                </div>
            </div>
        </div>
        <div class="clr" style="clear: both;">
        </div>
    </div>
    <div id="divFFMain" style="border: 1px solid #036; background-color: #ebe7e2;">
        &nbsp;</div>
    <%-- ******Existing code******--%>
    <%--   <div id="divContentInnerHdr" style="visibility: hidden; background-color: #fff;">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="tdH2">
                    &nbsp;Comment History
                </td>
                <td align="right" valign="middle" class="tdH2">
                    <input class="bTB" type="button" value="Ê" onclick="PrintHistory();" text="Print"
                        onmouseover="ShowTip(this);" onmouseout="HideTip(this);">&nbsp;
                </td>
            </tr>
        </table>
    </div>--%>
    <%--   ******End here******--%>
    <div id="divContentInnerBody" style="visibility: hidden; background-color: #fff;
        overflow: auto; display: none;">
        &nbsp;</div>
    <%-- ******Exsiting Code******--%>
    <%--    <div id="divNewNote" style="border: 1px solid #000; visibility: hidden; background-color: #fff;">--%>
    <%--        <div id="divNewNoteHdr" style="visibility: hidden; background-color: #fff;">
            &nbsp;</div>
    </div>
    <div id="divNewNoteBody" style="visibility: hidden; overflow: auto; background-color: #fff;">
    </div>--%>
    <%--  
    <div id="divAllNotes" style="visibility: hidden; overflow: auto">
    </div>--%>
    <%--  ******End here******--%>
    <div id="divTT" style="border-right: 1px solid #000; border-bottom: 1px solid #000;
        visibility: hidden; overflow: auto; background-color: #fff; display: none;">
        &nbsp;</div>
    <div id="divPrint" style="visibility: visible; background-color: #fff; display: none;">
        &nbsp;</div>
    <!--DEBUG-->
    <!--1=new,2=submitted,3=inbox,4=closed-->
    <input id="txtAction" type="hidden" value='<%=Request.QueryString("FuncTp")%>' />
    <!--<input id=txtAction type=hidden value='1'>-->
    <!--DEBUG-->
    <input id="txtUacfId" type="hidden" />
    <input id="txtUserType" type="hidden" />
    <input id="txtMyConsultantCode" type="hidden" />
    </form>


    <script type="text/javascript">

        var iBorders = new Number(5);
        var bgDebug = 0;
        function InitialisePage(sAction) 
        {
            //MWP alert(sAction)
            GetUserIDAndConslts(sAction);
            ShowBanner(sAction);

            //       ******Existing Code******

//            divFFMain.style.width = divBanner.offsetWidth;
//            divFFMain.style.top = divBanner.offsetTop + divBanner.offsetHeight + 10;
//            divFFMain.style.left = divBanner.offsetLeft;
//            divFFMain.style.height = document.body.offsetHeight - divBanner.offsetHeight - 20;

            //       ******End Here******
            
            ShowFind(sAction);
            
            document.getElementById("divAllNotes").innerHTML = '';
        

            //	TestAjax()
            GetListXML(sAction);
            if (document.getElementById("txtAction").value == 1) {
                document.getElementById("divList").innerHTML = "<center><p>--- no messages found ---</p></center>"
                SetRowFocus();
            }
        }

        function ShowBanner(sAction) {
            var sTitle = new String('');
            switch (sAction) {
                case '1':
                    document.getElementById("divContentInnerHdr").style.visibility = 'hidden'; //chander
                    sTitle = 'New Items';
                    break
                case '2':
                    sTitle = 'Submitted Items';
                    break
                case '3':
                    sTitle = 'Inbox Items';
                    break
                case '4':
                    sTitle = 'Closed items';
                    break
            }
            var s = new String('');
            s += '<table width="100%" cellpadding="0" cellspacing="0" border="0">';
            s += '<tr bgcolor="#003366"><td width="70%">&nbsp;</td><td width="30%" align="center"><font color=white face=Arial size=3><b>BTM</b><font></td></tr>';
            s += '<tr bgcolor="#003366"><td>&nbsp;</td><td align="center"><font color="white" face="Arial" size="2">' + sTitle + '</font></td></tr>';
            s += '</table>';
            document.getElementById("divBanner").innerHTML = s;
            //******Existing Code******
           // divBanner.style.top = 10;
            // divBanner.style.left = document.getElementById("txtAction").offsetLeft + 10;
            //******End here******
            divBanner.style.visibility = 'visible';
            
        }

        function ShowFindOLD(sAction) {
            switch (sAction) {
                case '1':
                    document.getElementById("divFind").innerHTML = '';
                    return (0);
                    break
                default:
                    break
            }
            var s = new String('');
            s = '<table width="100%" cellspacing="0" cellpadding="0" border="0">';
            s += '<tr><td class=tdH4>&nbsp;Only show matches for contract number:&nbsp;<input class="txtDataInput" type="text" id="txtFindContract" value="" onchange="ClearWFNo()">&nbsp;or work flow number:&nbsp;<input class="txtDataInput" type=text id="txtFindWFNo" value="" onchange="ClearContractNo()">&nbsp;<input class="bTBFind" type=button value="Find Now" onclick="FilterList(1)">&nbsp;<input class="bTBFind" type=button value="Clear" onclick="FilterList(0)"></td></tr>';
            s += '</table>';

            document.getElementById("divFind").innerHTML = s;

            //******Existing Code******
            
//            divFind.style.width = divFFMain.offsetWidth - (iBorders * 2);
//            divFind.style.top = divFFMain.offsetTop + iBorders;
            // divFind.style.left = divFFMain.offsetLeft + iBorders;

            //******End here******
            divFind.style.visibility = 'visible';
        }

        function ShowFind(sAction) {
            var s = new String('');
            if (sAction == '1') 
            {
                s += '<table width="100%" cellspacing="0" cellpadding="0"><tr><td class="tdInfoHdr"><img id="imgicon" alt="" src="Images/newicon.png" /></td><td class="tdInfo">Click the New icon on the toolbar below to create a new item</td></tr></table>';
            }
            else {
                s = '<table width="100%" cellspacing="0" cellpadding="0" border="0">';
                if (document.getElementById("txtUserType").value != 'X')
                 {
                    s += '<tr><td class="tdH4">&nbsp;Show items that: <input type="radio" name="rbListFor" id="rbUACF" checked="1" onclick="ShowHideConsSel(this.id);GetListXML(' + sAction + ')">I submitted <input type="radio" name="rbListFor" id="rbConsCd" onclick="ShowHideConsSel(this.id)">were submitted for consultant code...&nbsp;&nbsp;' + BuildConsultantSelection() + '&nbsp;<input type="button" class="bTBFind" id="btConslts" value="get list" style="visibility:hidden;" onclick="GetListXML(' + sAction + ')"></td></tr>';
                }
                else 
                {
                    s += '<tr><td class="tdH4">&nbsp;Show items that: <input type="radio" name="rbListFor" id="rbUACF" checked="1" onclick="ShowHideConsSel(this.id);GetListXML(' + sAction + ')">I submitted <input type=radio name="rbListFor" id="rbConsCd" onclick="ShowHideConsSel(this.id)">were submitted for consultant code...&nbsp;&nbsp;<input type=text class="txtDataInput" id="selConslts" value="' + BuildConsultantSelection() + '" onchange="SetTxtConsultant(this.value)">&nbsp;<input type="button" class="bTBFind" id="btConslts" value="get list" style="visibility:hidden" onclick="GetListXML(' + sAction + ')"></td></tr>';
                }
                
                s += '<tr><td>&nbsp;</td></tr>';
                s += '<tr><td class="tdH4">&nbsp;Only show matches for contract number:&nbsp;<input class="txtDataInput" type="text" id="txtFindContract" value="" onchange="ClearWFNo()">&nbsp;or work flow number:&nbsp;<input class="txtDataInput" type="text" id="txtFindWFNo" value="" onchange="ClearContractNo()">&nbsp;<input class="bTBFind" type="button" value="Find Now" onclick="FilterList(1)">&nbsp;<input class="bTBFind" type="button" value="Clear" onclick="FilterList(0)"></td></tr>';
                s += '</table>';
            }

            document.getElementById("divFind").innerHTML = s;

            //******Existing Code******
            
//            divFind.style.width = divFFMain.offsetWidth - (iBorders * 2);
//            divFind.style.top = divFFMain.offsetTop + iBorders
//            divFind.style.left = divFFMain.offsetLeft + iBorders;

            //******end here******
            divFind.style.visibility = 'visible';

            if (sAction > 1) {
                try {
                    document.getElementById("selConslts").style.visibility = 'hidden';
                }
                catch (e) { }
            }
        }

        function SetTxtConsultant(s) 
        {
            document.getElementById("txtMyConsultantCode").value = s;
        }

        function SetDebug() 
        {
            if (bgDebug) { bgDebug = 0 } else { bgDebug = 1 }
        }

        function ShowHideConsSel(sId) 
        {
            if (bgDebug) { alert('in ShowHideConsSel. parm1=' + sId) }
            if (bgDebug) { BuildConsultantSelection() }
            if (sId == 'rbConsCd') {
                try { document.getElementById("selConslts").style.visibility = 'visible' } catch (e) { }
                document.getElementById("btConslts").style.visibility = 'visible';
                if (bgDebug) { alert('in ShowHideConsSel. Set btConslts.style.visibility to visible') }
            }
            else {
                try { document.getElementById("selConslts").style.visibility = 'hidden' } catch (e) { }
                document.getElementById("btConslts").style.visibility = 'hidden';
            }
        }

        function BuildConsultantSelection() {
            if (bgDebug) { alert('in BuildConsultantSelection') }
            if (gsConsltSel > '') {
                if (bgDebug) { alert('in BuildConsultantSelection. gsConsltSel = ' + gsConsltSel) }
                return gsConsltSel;
            }
            else {
                if (bgDebug) { alert('in BuildConsultantSelection. txtMyConsultantCode = ' + document.getElementById("txtMyConsultantCode").value) }
                return document.getElementById("txtMyConsultantCode").value;
            }
        }

        function ClearWFNo() {
            document.getElementById("txtFindWFNo").value = '';
        }

        function ClearContractNo() {
            document.getElementById("txtFindContract").value = '';
        }

        function FilterList(i) 
        {
            wfid.length = 0;
            if (i == 0) 
            {

                ClearContractNo(); ClearWFNo()
            }
            
            ShowList(document.getElementById("txtAction").value);
        }

        function BusyProcessing(i)
         {
             if (document.getElementById("divBusy").style.visibility == 'hidden') 
            {
                return 0;
            }
            
            else 
            {
                if (i == '1') 
                {
                    // potential to show alert if process is still busy...			
                }
                return 1;
            }
        }

        var gsNoRec = '<center><p class=pNoRec>--- no messages found ---</p></center>';
        function ShowList(sAction) 
        {

            

            var s = new String('');
            s += '<table width="100%" cellspacing="0" cellpadding="0" border="0">';
            //Setup bar/table containing function buttons
            switch (sAction) {
                case '1':
                    s += '<tr><td class="tdH2">&nbsp;New Items&nbsp;</td><td align="right" valign="middle"class="tdH2"><input style="cursor:pointer" class="bTB btnAdd" type="button" title="Create New Item" onclick="BTMCreate()" ttText="Create new item" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB btnsave" title="Save Without Submiting" style="cursor:pointer" type="button"  onclick="MoveNewNoteToContext(); SaveNew(giContextCurr, 1)" ttText="Save without submitting" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB btnsent" type="button" title="Submit" style="cursor:pointer" onclick="if(!BusyProcessing(1)){ValSaveAndSend()}" ttText="Submit" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB btndelete" style="cursor:pointer" type="button" title="Delete"  ttText="Delete" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" onclick="Unnasigned_Delete()">&nbsp;<input class="bTB btnhelp" type="button" ttText="Help" style="cursor:pointer" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" title="Help" onclick="ShowHelp(1)">&nbsp;</td></tr>';
                    break;
                case '2':
                    s += '<tr><td class="tdH2">&nbsp;Submitted Items&nbsp;</td><td align="right" valign="middle" class="tdH2"><input class="bTB addcmt" style="cursor:pointer" title="Add Comment" type="button"  onclick="AddNewComment()" ttText="Add comment" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB btnsent" style="cursor:pointer" type="button" title="Submit" onclick="if(!BusyProcessing(1)){AddComment()}" ttText="Submit" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB btnhelp" style="cursor:pointer" title="Help" type="button"  ttText="Help" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" onclick="ShowHelp(2)">&nbsp;</td></tr>';
                    break;
                case '3':
                    s += '<tr><td class="tdH2">&nbsp;Inbox&nbsp;</td><td align="right" valign="middle" class="tdH2"><input class="bTB addcmt" style="cursor:pointer" title="Add Comment" type="button" onclick="AddNewComment()" ttText="Add comment" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB btnsent" style="cursor:pointer" title="Submit" type="button"  onclick="if(!BusyProcessing(1)){AddCommentAndChangeState(2)}" ttText="Submit" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB closeitem" type="button" onclick="AddCommentAndChangeState(4)" ttText="Close Item" title="Close Item" style="cursor:pointer" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB btnhelp" type="button" style="cursor:pointer" title="Help" ttText="Help" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" onclick="ShowHelp(3)">&nbsp;</td></tr>'
                    break;
                case '4':
                    s += '<tr><td class="tdH2">&nbsp;Closed&nbsp;</td><td align="right" valign="middle" class="tdH2"><input class="bTB addcmt" style="cursor:pointer" title="Add Comment" type="button"  onclick="AddNewComment()" ttText="Add comment" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB btnsent" style="cursor:pointer" title="Submit" type="button" onclick="if(!BusyProcessing(1)){AddCommentAndReAssign(2)}" ttText="Submit" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB btnhelp"  style="cursor:pointer" title="Help" type="button"  ttText="Help" onmouseover="ShowTip(this)" onmouseout="HideTip(this)" onclick="ShowHelp(4)">&nbsp;</td></tr>';
                    break;
            }
            s += '</table>';

            document.getElementById("divListHdr").innerHTML = s;
           
            //divListHdr.style.width = (divBanner.offsetWidth / 2) - (2 * iBorders);               //******Existing Code******
            if (document.getElementById("divFind").innerHTML > '') 
            {
                //                divListHdr.style.top = divFind.offsetTop + divFind.offsetHeight + iBorders        //******Existing Code******
             }
             else 
            {
                //                divListHdr.style.top = divFFMain.offsetTop + iBorders                            //******Existing Code******     
           }

           //divListHdr.style.left = divBanner.offsetLeft + iBorders;                                     //******Existing Code******
            divListHdr.style.visibility = 'visible';

            document.getElementById("divList").innerHTML = BuildListFromXML();
           
            PositionListDivs();

            //******Existing Code******
            
//            divList.style.width = divListHdr.offsetWidth;
//            divList.style.top = divListHdr.offsetTop + divListHdr.offsetHeight;
//            divList.style.left = divListHdr.offsetLeft;
            //            divList.style.height = divFFMain.offsetHeight - divFind.offsetHeight - divListHdr.offsetHeight - 12;

            //******End here******
            divList.style.visibility = 'visible';
            
            ShowContent();
            
            if (document.getElementById("txtAction").value == 1) {
            
                InitialiseCatsAndSubs();
            
            }
            
            SetRowFocus();

        }

        function InitialiseCatsAndSubs() 
        {
            
            var s = '';
          
            for (i = 0; i < giContext; i++) {
           
            BuildSubs(document.getElementById("CatTC", i).value, i);
           
                document.getElementById("rbCat" + document.getElementById("CatTC", i).value + String(i)).checked = true;     //******Chander******
                try {
                    document.getElementById("rbSub" + String(document.getElementById("SubCatTC", i).value) + String(i)).checked = true;
                 
                 } catch (e) { }
            }
        }

        function SetCat(iContext, iTC) 
        {
            
            document.getElementById("SubCatTC", giContextCurr).value = '';
            document.getElementById("CatTC", iContext).value = iTC;
        }

        function SetSub(iContext, iTC) 
        {
            
            document.getElementById("SubCatTC", iContext).value = iTC;
        }

        function ShowContent() {
            
            if (document.getElementById("txtAction").value != 1) {
                var s = '<table width=100% cellspacing=0 cellpadding=0>';
                s += "<tr><td>&nbsp;</td></tr>";
                s += '</table>';
                document.getElementById("divContent").innerHTML = s;
            }
            //******Existing Code******

//            divContent.style.top = divList.offsetTop - divListHdr.offsetHeight;
//            divContent.style.height = divList.offsetHeight + divListHdr.offsetHeight;
//            divContent.style.left = divList.offsetLeft + divList.offsetWidth + iBorders;
            //divContent.style.width = (divBanner.offsetWidth / 2) - (2 * iBorders);

            //******End here******
            
            divContent.style.visibility = 'visible';
        }

        function ShowHelp(iTopic) {

            //******Chander******
            
            $('.bl_help, #divHelp, #divHelpInner').css('display', 'block');
            $('.div_rgt').css('width', '28.5%');
            $("#tNew").width(310);
            var sURL = '';

            //******end here******

            //        var oXMLHTTP = new ActiveXObject("Microsoft.XMLHTTP");
            var oXMLHTTP = new XMLHttpRequest();                                       //Chander
            var s = '<table width="100%" cellspacing="0" cellpadding="0" border="0">';
            s += '<tr><td class="tdH2">&nbsp;BTM Requests Help</td><td class="tdH2" align="right" valign="middle"><input class="bTB btnprint" style="cursor:pointer" type="button" title="Print"  onclick="PrintHelp()" ttText="Print" onmouseover="ShowTip(this)" onmouseout="HideTip(this)">&nbsp;<input class="bTB2 btnclose" style="cursor:pointer" bType="2" title="Close" ttText="" type=button  onclick="HideHelp()" onmouseover="ShowTip(this)" onmouseout="HideTip(this)"></td></tr>';   //chander
            s += '</table>';
            switch (iTopic) 
            {
                case 0:
                    sURL = './/help/btm overview.asp';
                    break;
                case 1:
                    sURL = './/help/new_items_what_do_you_want_to_do.asp';
                    break;
                case '1.1':
                    sURL = './/help/Learn_about_the_New_Items_Folder.asp';
                    break;
                case '1.2':
                    sURL = './/help/Creating_a_new_item_and_submitting_it_for_processing.asp';
                    break;
                case '1.3':
                    sURL = './/help/Creating_and_saving_a_new_item_without_submitting_it_for_processing.asp';
                    break;
                case '1.4':
                    sURL = './/help/Editing_and_submitting_a_saved_item_in_the_New_Items_Folder.asp';
                    break;
                case '1.5':
                    sURL = './/help/Deleting_a_saved_item_in_the_New_Items_Folder.asp';
                    break;
                case 2:
                    sURL = './/help/submitted_items_what_do_you_want_to_do.asp';
                    break;
                case '2.1':
                    sURL = './/help/Learn about the Submitted Items Page.asp';
                    break;
                case '2.2':
                    sURL = './/help/Checking the Workflow Number for a Submitted Item.asp';
                    break;
                case '2.3':
                    sURL = './/help/Reviewing_the_Date_an_Item_was_Submitted.asp';
                    break;
                case '2.4':
                    sURL = './/help/Monitoring_progress_on_a_Submitted_Item.asp';
                    break;
                case '2.5':
                    sURL = './/help/Adding a comment to a submitted item and resubmitting it.asp';
                    break;
                case '2.6':
                    sURL = './/help/Search for a submitted item by contract number.asp';
                    break;
                case '2.7':
                    sURL = './/help/Search for a submitted item by workflow number.asp';
                    break;
                case 3:
                    sURL = './/help/inbox_what_do_you_want_to_do.asp';
                    break;
                case '3.1':
                    sURL = './/help/Learn about the Inbox Items folder.asp';
                    break;
                case '3.2':
                    sURL = './/help/view a reply to a workflow item.asp';
                    break;
                case '3.3':
                    sURL = './/help/Add a comment to an Inbox item.asp';
                    break;
                case '3.4':
                    sURL = './/help/Close an Inbox Item.asp';
                    break;
                case '3.5':
                    sURL = './/help/Search for an item in the Inbox by contract number.asp';
                    break;
                case '3.6':
                    sURL = './/help/Search for an Inbox item by workflow number.asp';
                    break;
                case 4:
                    sURL = './/help/closed items_what_do_you_want_to_do.asp';
                    break;
                case '4.1':
                    sURL = './/help/Learn about the Closed Items folder.asp';
                    break;
                case '4.2':
                    sURL = './/help/Add a comment to a closed item and submit it.asp';
                    break;
                case '4.3':
                    sURL = './/help/Search for a closed item by contract number.asp';
                    break;
                case '4.4':
                    sURL = './/help/search for a closed item by workflow number.asp';
                    break;
            }

            oXMLHTTP.open("POST", sURL, false);
            oXMLHTTP.send();
            document.getElementById("divHelpInner").innerHTML = oXMLHTTP.responseText;
            document.getElementById("divHelp").innerHTML = s;
            document.getElementById("divHelp").style.visibility = 'visible';
            document.getElementById("divHelpInner").style.visibility = 'visible';


            if (document.getElementById("divHelp").style.visibility == 'hidden') 
            {
                $('.div_rgt').css('width', '27%');
                //divContent.style.width = divContent.offsetWidth / 2;                                   //******Existing Code******
                
                if (document.getElementById("divContentInner").style.visibility != 'hidden') 
                {
                    divContentInner.style.width = (divContentInner.offsetWidth / 2) - lngBorders;
                }

                //====Existing Code===
                
//                divHelp.style.top = divContent.offsetTop;                                          
//                divHelp.style.height = divContent.offsetHeight
  //                divHelp.style.left = divContent.offsetLeft + divContent.offsetWidth + lngBorders;
 //                divHelp.style.width = ((divBanner.offsetWidth / 2) - (2 * lngBorders)) / 2;

                //******End here******


                divHelp.style.visibility = 'visible';                  //Chander
                divHelp.style.display = 'block';                        //Chander
                $('.div_help').css('display', 'block');                 //Chander

                //******Existing Code******

                //divHelpInner.style.top = divHelp.offsetTop + 28;
                //divHelpInner.style.height = divHelp.offsetHeight - 30;
                //divHelpInner.style.left = divHelp.offsetLeft + 2;
                 // divHelpInner.style.width = divHelp.offsetWidth - 4;

                //******End here******
              
              
                divHelpInner.style.visibility = 'visible';
                divHelpInner.style.display = 'block';
            }


            //******Existing Code******

//            if (document.getElementById("divHelp").style.visibility == 'hidden') {
//                divContent.style.width = divContent.offsetWidth / 2;
//                if (document.getElementById("divContentInner").style.visibility != 'hidden') {
//                    divContentInner.style.width = (divContentInner.offsetWidth / 2) - iBorders;
//                    divContentInnerHdr.style.width = (divContentInnerHdr.offsetWidth / 2) - iBorders - 3;
//                    if (divContentInnerBody.offsetWidth > 0) {
//                        divContentInnerBody.style.width = (divContentInnerBody.offsetWidth / 2) - iBorders - 3;
//                    }
//                }
//                if (document.getElementById("divNewNote").style.visibility != 'hidden') {
//                    divNewNote.style.width = (divNewNote.offsetWidth / 2) - iBorders;
//                    divNewNoteHdr.style.width = (divNewNoteHdr.offsetWidth / 2) - iBorders - 3;
//                    divNewNoteBody.style.width = (divNewNoteBody.offsetWidth / 2) - iBorders - 3;
//                }
//                divHelp.style.top = divContent.offsetTop;
//                divHelp.style.height = divContent.offsetHeight;

//                divHelp.style.left = divContent.offsetLeft + divContent.offsetWidth + iBorders;
//                divHelp.style.width = divContent.offsetWidth;
//                divHelp.style.visibility = 'visible';

//                divHelpInner.style.top = divHelp.offsetTop + 28;
//                divHelpInner.style.height = divHelp.offsetHeight - 30;

//                divHelpInner.style.left = divHelp.offsetLeft + 2;
//                divHelpInner.style.width = divHelp.offsetWidth - 4;
//                divHelpInner.style.visibility = 'visible';
            //            }

            //******End here******

           
        }

        function HideHelp() {
        
            //Chander(To adjust Design part)
            $('.bl_help').css('display', 'none');
            $('.div_rgt').css('width', '49%');
            $("#tNew").width(549);
            divHelp.style.visibility = 'hidden';
            divHelpInner.style.visibility = 'hidden';
            divHelp.style.display = 'none';
            divHelpInner.style.display = 'none';
            divContentInner.style.width = (divContentInner.offsetWidth + lngBorders) * 2;
            ShowContent();
            $('.div_rgt').css('width', '49.3%');
            $('.div_help').css('display', 'none');

            //******End here******


            //******Existing Code******
            
//            divHelp.style.visibility = 'hidden';
//            divHelpInner.style.visibility = 'hidden';
//            divNewNote.style.width = (divNewNote.offsetWidth + iBorders) * 2;
//            divNewNoteHdr.style.width = (divNewNoteHdr.offsetWidth + iBorders + 3) * 2;
//            divNewNoteBody.style.width = (divNewNoteBody.offsetWidth + iBorders + 3) * 2;
//            divContent.style.width = divContent.offsetWidth * 2;
//            ShowContent();
//            if (document.getElementById("divContentInner").style.visibility != 'hidden') {
//                divContentInner.style.width = (divContentInner.offsetWidth + iBorders) * 2;
//                divContentInnerHdr.style.width = (divContentInnerHdr.offsetWidth + iBorders + 3) * 2;
//                divContentInnerBody.style.width = (divContentInnerBody.offsetWidth + iBorders + 3) * 2;
            //            }

            //******Existing Code******
        }

        function ShowTip(o) {
            if (o.bType == 2) {
                //o.className = 'bTB2Hover'; //******Existing Code******
            }
            else {
                //o.className = 'bTBHover'; //******Existing Code******
            }
            if (o.ttText > '') {
                divTT.innerHTML = '<p class="pTT">&nbsp;' + o.ttText + '&nbsp;</p>';
                divTT.style.top = event.clientY + 20;
                divTT.style.left = event.clientX;
                divTT.style.visibility = 'visible';
            }
        }

        function HideTip(o) {
            divTT.style.visibility = 'hidden';
            if (o.bType == 2) {
                //o.className = 'bTB2'; //******Existing Code******
            }
            else {
                //o.className = 'bTB';  //******Existing Code******
            }
        }

        var goCurrRow = 0;
        var gbDirty = 0;
        var giContext = 0; // VIP used to set context in terms of array offset for all controls
        var giContextCurr = 0;  // VIP used to track current context
        
        //Chander
        function GetBTMNote() {
            document.getElementById("divContent").innerHTML = '<textarea id="tNew" style="height:442px; width:552px" ></textarea>';
            var hdr = '<table width=100%>'
            hdr += '<tr><td class=tdHDetail1 align=center>Comments</td></tr>'
            hdr += '</table>'
            document.getElementById("divContentInnerHdr").innerHTML = hdr;
            document.getElementById("divContentInnerHdr").style.display = "block"
            document.getElementById("divContentInnerHdr").style.backgroundColor = "#0B0499";
            document.getElementById("divContentInnerHdr").style.visibility = 'visible';
            if ($(".bl_help").css("display") == "block") { $("#tNew").css("width", 310); } 
        }

        //******End Here******

        function BTMCreate(o) {
            $(".rowcolor").removeClass("rowcolor");
            var height = $("#divContent").height(); //chander
            var width = $("#divContent").width();   //chander
            $("#divContent").css("height", 451);  //chander
            GetBTMNote(); //chander
            
            // bubble em up... top list item must always have context 0
            for (i = giContext; i > 0; i--) { document.getElementById("ListRow", i - 1).ContextRow = i }

            var s = '<div id="divListRow">';
            s += '<table width="100%" cellpadding="0" cellspacing="0" border="0" class="tableList" id="ListRow" onclick="MoveNewNoteToContext();getxml(this); if(KillRowFocus('+giContextCurr+', this)){SetRowFocus(this)}" ContextRow="' + Number(0) + '">';

            s += '<tr><td colspan="2" class="tdListH">Ensure that you enter a comment in the Comments section</td></tr>';
            s += '<tr><td colspan="2" class="tdListH">on the right after completing all the information below.</td></tr>';
            s += '<tr><td colspan=2 class=tdListH>&nbsp;</td></tr>';
            s += '<tr><td class="tdListH" width=30%>Contract number:</td><td><input class="txtInp" type=text id="txtContractNo" name="txtContractNo" maxlength=15 onchange="gbDirty=1"><input type=hidden id="CaseID" value=0><input type=hidden id="CatTC" value=""><input type=hidden id="SubCatTC" value=""><input type=hidden id="WFID" value="0"></td></tr>';
            s += '<tr><td class="tdListH">Subject:</td><td><input class="txtInp" type=text id="txtSubject" name="txtSubject" maxlength=50 onchange="gbDirty=1"></td></tr>';

            s += '<tr>';
            s += '<td colspan=2>';

            s += '<table width=100% bgcolor="white" cellpadding=0>';

            if (gsConsltSel > '') 
            {
                s += '<tr><td class="tdList" width=30%>Consultant code:</td><td>' + gsConsltSel + '<input class="txtInp" type=hidden id="txtConsCode" name="txtConsCode"></td></tr>';
            }
            else {
                s += '<tr><td class="tdList" width=30%>Consultant code:</td><td><input class="txtInp" type=text id="txtConsCode" name="txtConsCode" size=11 maxlength=13 onchange="gbDirty=1"></td></tr>';
            }

            s += '<tr><td class="tdList" width=30%>Brokerage name:</td><td><input class="txtInp" type=text id="txtBrokerage" name="txtBrokerage" size=40 maxlength=50 onchange="gbDirty=1"></td></tr>';
            s += '<tr><td colspan=2><table width=100% cellspacing=0 cellpadding=0>';
            s += BuildCats(giContext);
            s += '</table>';
            s += '</td></tr></table>';

            s += '</td>';
            s += '</tr>';

            s += '</table>';
            s += '</div>';

            // this is sneaky!!!
            document.getElementById("divAllNotes").innerHTML = '<textarea id="txtNewNote" style="visibility:hidden; height:0; width:0" rows=10></textarea><br>' + document.getElementById("divAllNotes").innerHTML

            if (giContext == 0) { document.getElementById("divList").innerHTML = '' }
            giContext++;
            s += document.getElementById("divList").innerHTML;

            document.getElementById("divList").innerHTML = s;

            PositionListDivs();
            //                        KillRowFocus(Number(giContextCurr + 1));
            KillRowFocus(1);
            SetRowFocus();
            gbDirty = 1;
        }

        //******Existing Code******
        
        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************

//       function BuildCats(iContextRow) {
//            if (gaCats[0] == '') { BuildCatsArray(); BuildSubsArray() }
//            var s = ''
//            try {
//                var doc = new ActiveXObject("Microsoft.XMLDOM")
//                doc.loadXML(xmlData2.innerHTML)
//                var nodes = new ActiveXObject("Microsoft.XMLDOM")
//                nodes.async = "false"
//                var Cat = doc.getElementsByTagName("cat")
//                if (Cat.length > 0) {
//                    for (i = 0; i < Cat.length; i++) {
//                        wrk = ''
//                        nodes.loadXML(Cat.item(i).xml)
//                        s += '<tr><td class="tdH6"><input id="rbCat' + nodes.documentElement.selectSingleNode("/cat/id").text + String(iContextRow) + '" name="rbCat' + iContextRow + '" type=radio tc=' + nodes.documentElement.selectSingleNode("/cat/id").text + ' onclick="SetCat(giContextCurr, this.tc); BuildSubs(this.tc, giContextCurr)">' + nodes.documentElement.selectSingleNode("/cat/descr").text + '</td></tr>'
//                    }
//                    s = '<tr><td class="tdH6" width=50%>Request relates to:</td><td class="tdH6" width=50% valign=top rowspan=' + String(i) + '><div id="divOpts" style="position:inline; visibility:visible">&nbsp;</div></td></tr>' + s
//                }
//                else {
//                    s = '<tr><td class="tdH6">&nbsp;NO CATEGORY DATA FOUND</td></tr>'
//                }
//            }
//            catch (e) {
//                s = '<tr><td class="tdH6">&nbsp;CATEGORY DATA COULD NOT BE PROCESSED</td></tr>'
//            }
//            return s
//        }


        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************
        
        //Chander        
        function BuildCats(iContextRow) 
        {
                if (gaCats[0] == '') {
                BuildCatsArray();
                BuildSubsArray();
            }
            var s = ''
            try {
                var var_xmlData_innerHTML = (xmlData2.innerHTML).toUpperCase();
                var doc = $.parseXML(var_xmlData_innerHTML);
                
                var len = $(doc).find('CAT').length;
          
                if (len > 0) {
                    wrk = ''
                    var i = 0;   //Variable i to get rowspan - Chander
                    $(doc).find('CAT').each(function() 
                    {
                        i = i + 1;
                        wrk = '';
                        tc = $(this).find('ID').text();
                        s += '<tr><td class="tdH6"><input id="rbCat' + $(this).find('ID').text() + String(iContextRow) + '" name="rbCat' + iContextRow + '" type=radio tc=' + $(this).find('ID').text() + ' onclick="SetCat(' + giContextCurr + ',' + tc + '); BuildSubs(' + tc + ', ' + giContextCurr + ')">' + $(this).find('DESCR').text() + '</td></tr>';
                    });
                    s = '<tr><td class="tdH6" width=50% >Request relates to:</td><td class="tdH6" width=50% valign=top rowspan=' + String(i) + '><div id="divOpts" style="position:inline; visibility:visible">&nbsp;</div></td></tr>' + s;

                }
                else {

                    s = '<tr><td class="tdH6">&nbsp;NO CATEGORY DATA FOUND</td></tr>';
                }

            }
            catch (e) {
                s = '<tr><td class="tdH6">&nbsp;CATEGORY DATA COULD NOT BE PROCESSED</td></tr>'
            }
            return s
        }

        //******End here******

        //******Existing Code******
        
        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************

//        function BuildCatsArray() {
//            var doc = new ActiveXObject("Microsoft.XMLDOM")
//            doc.loadXML(xmlData2.innerHTML)
//            var nodes = new ActiveXObject("Microsoft.XMLDOM")
//            nodes.async = "false"
//            var Cat = doc.getElementsByTagName("cat")
//            for (i = 0; i < Cat.length; i++) {
//                nodes.loadXML(Cat.item(i).xml)
//                gaCats[Number(nodes.documentElement.selectSingleNode("/cat/id").text)] = nodes.documentElement.selectSingleNode("/cat/descr").text
//            }
//        }


        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************

        //Chander
        var gaCats = new Array('');
        function BuildCatsArray() {
     
            var var_xmlData_innerHTML = (xmlData2.innerHTML).toUpperCase();
            var doc = $.parseXML(var_xmlData_innerHTML);

            $(doc).find('CAT').each(function() {
                gaCats[Number($(this).find('ID').text())] = $(this).find('DESCR').text();
                
            });
            
        }

        //******End here******

        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************
        //******Existing Code******

//        function BuildSubsArray() {
//            var doc = new ActiveXObject("Microsoft.XMLDOM")
//            doc.loadXML(xmlData2.innerHTML)
//            var nodes = new ActiveXObject("Microsoft.XMLDOM")
//            nodes.async = "false"
//            var Sub = doc.getElementsByTagName("sub")
//            for (i = 0; i < Sub.length; i++) {
//                nodes.loadXML(Sub.item(i).xml)
//                gaSubs[Number(nodes.documentElement.selectSingleNode("/sub/id").text)] = nodes.documentElement.selectSingleNode("/sub/descr").text
//            }
//        }


        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************

        //Chander
        var gaSubs = new Array();

        function BuildSubsArray()
         {
           
            var var_xmlData_innerHTML = (xmlData2.innerHTML).toUpperCase();
            var doc = $.parseXML(var_xmlData_innerHTML);
           
            $(doc).find('SUB').each(function() {
                gaSubs[Number($(this).find('ID').text())] = $(this).find('DESCR').text();
            });
        }
        //******End here******


        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************
        //******Existing Code******

//        function BuildSubs(iCatID, iContextRow) {
//            var s = ''
//            var wrk = ''
//            try {
//                var doc = new ActiveXObject("Microsoft.XMLDOM")
//                doc.loadXML(xmlData2.innerHTML)
//                var nodes = new ActiveXObject("Microsoft.XMLDOM")
//                nodes.async = "false"
//                var Sub = doc.getElementsByTagName("sub")
//                if (Sub.length > 0) {
//                    var i = 0
//                    var bFound1 = 0
//                    while (i < Sub.length) {
//                        nodes.loadXML(Sub.item(i).xml)
//                        if (iCatID == nodes.documentElement.selectSingleNode("/sub/CatId").text) {
//                            bFound1 = 1
//                            wrk = "rbSub" + nodes.documentElement.selectSingleNode("/sub/id").text + String(iContextRow)
//                            s += '<tr><td class="tdH6"><input id="rbSub' + nodes.documentElement.selectSingleNode("/sub/id").text + String(iContextRow) + '" name="rbSub' + String(iContextRow) + '" type=radio tc=' + nodes.documentElement.selectSingleNode("/sub/id").text + ' onclick="SetSub(giContextCurr, this.tc)">' + nodes.documentElement.selectSingleNode("/sub/descr").text + '</td></tr>'
//                        }
//                        i++
//                    }
//                    if (bFound1 > 0) {
//                        s = '<tr><td class="tdH6">for:</td></tr>' + s
//                    }
//                }
//                else {
//                    s = '<tr><td class="tdH6">&nbsp;NO SUB CATEGORY DATA FOUND</td></tr>'
//                }
//            }
//            catch (e) {
//                s = '<tr><td class="tdH6">&nbsp;SUB CATEGORY DATA COULD NOT BE PROCESSED</td></tr>'
//            }
//            s = '<table width=100% cellspacing=0 cellpadding=0>' + s
//            s += '</table>'

//            document.all("divOpts", iContextRow).innerHTML = s
//            document.all("divOpts", iContextRow).style.visibility = "visible"
//        }


        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************

        //Chander                 
        function BuildSubs(iCatID, iContextRow) 
        {
            
            var s = ''
            var wrk = ''
            try {
             
                var var_xmlData_innerHTML = (xmlData2.innerHTML).toUpperCase();
                var doc = $.parseXML(var_xmlData_innerHTML);
               
                var len = $(doc).find('SUB').length;
               
                if (len > 0) {
                    var i = 0;
                    var bFound1 = 0;
                    $(doc).find('SUB').each(function() {
                        if (iCatID == $(this).find('CATID').text()) {
                            bFound1 = 1;
                            wrk = "rbSub" + $(this).find('ID').text() + String(iContextRow);
                           
                            tc = $(this).find('ID').text();
                            s += '<tr><td class="tdH6"><input id="rbSub' + $(this).find('ID').text() + String(iContextRow) + '" name="rbSub' + String(iContextRow) + '" type=radio tc=' + $(this).find('ID').text() + ' onclick="SetSub(' + 0 + ',' + tc + ')" />' + $(this).find('DESCR').text() + '</td></tr>';
                        }
                    });
                    if (bFound1 > 0) {
                        s = '<tr><td class="tdH6">for:</td></tr>' + s;
                    }

                }
                else {

                    s = '<tr><td class="tdH6">&nbsp;NO SUB CATEGORY DATA FOUND</td></tr>';
                }
            }
            catch (e) {
                s = '<tr><td class="tdH6">&nbsp;SUB CATEGORY DATA COULD NOT BE PROCESSED</td></tr>'
            }
            s = '<table width=100% cellspacing=0 cellpadding=0>' + s;
            s += '</table>';

            document.getElementById("divOpts", iContextRow).innerHTML = s;
            document.getElementById("divOpts", iContextRow).style.visibility = "visible";
        }

        //******End here******

        //******Existing Code******
//        function mouseHandler(e) {
//      
//            if ($("e.id").hasClass("tableList1")) {
//                $("e.id").removeClass("tableList1");
//            }
//            else {
//                $("#divList table").removeClass("tableList1");
//                $(this).addClass("tableList1");
//                $("e.id").addClass("tableList1");
//            }
        //        }
        //******Existing Code******

        function SetRowFocus(o) {
            try {
                var bFirst = 0;

                if (!o) {
                  
                    bFirst = 1;
                    var i = Number(NextFocusRow());
                    if (Number(i) > -1) {
                        var o = document.getElementById("ListRow", i);
                    }
                    else {
                        if (document.getElementById("txtAction").value != 4) {
                            document.getElementById("divList").innerHTML = gsNoRec;
                        }
                        divNewNote.style.visibility = 'hidden';
                        divNewNoteHdr.style.visibility = 'hidden';
                        divNewNoteBody.style.visibility = 'hidden';
                        
                        //*****Existing Code*****
//                        divContentInner.style.top = divContent.offsetTop + 8;
//                        divContentInner.style.left = divContent.offsetLeft + 8;
//                        divContentInner.style.height = divContent.offsetHeight - 16;
                        //                        divContentInner.style.width = divContent.offsetWidth - 16;
                        //******End here********
                          
                        divContentInner.style.visibility = 'visible';
                        document.getElementById("divContentInner").innerHTML = '';
                        divContentInnerHdr.style.visibility = 'hidden';
                        document.getElementById("divContentInnerBody").innerHTML = '';
                        return 0;
                    }
                }
                
                if (giContextCurr != o.ContextRow || bFirst == 1) {
                    var id=(o.id).toString();
                 
                    if(id=="ListRow"){                               //Chander
                    goCurrRow = o;
                    
                    o.className = 'rowcolor';
                    giContextCurr = o.ContextRow;
                   
                    //******Chander( to make compatible with IE 7,8 and all others browser)******              
                  
                    if ($.browser.msie && Number($.browser.version) < 9) {
                        
                        GetwfidComments(i, wfid[Number(o.ContextRow)]);
                       
                    }
                    else {
                        GetComments(o.ContextRow);
                       
                    }
                    //******End here******               
                    if (document.getElementById("txtAction").value == 1) { document.getElementById("txtContractNo", giContextCurr).focus() }
                      }
                }
            }
            catch (e) {
            }
        }

        function NextFocusRow() 
        {
           
            var r = new Number(-1);
            try {
                for (i = 0; i < giContext; i++) {
                    if (document.getElementById("divListRow", i).style.visibility != 'hidden' && document.getElementById("divListRow", i).specialtype != 'hdr') {
                        return i;
                    }
                }
            }
            catch (e) { }
            return r;
        }

        function KillRowFocus(i, o) {
           
            return 1;
            try 
            {
                
                if (o) {
                    if (i == o.ContextRow) {
                       
                        return 0; }
                        if (GoBackCosDirty()) {
                          
                    return 0; }
                }

                document.getElementById("ListRow", i).className = 'tableList';
                document.getElementById("divContentInner").innerHTML = '';
                document.getElementById("divNewNote").innerHTML = '';
                document.getElementById("divNewNoteHdr").innerHTML = '';
                document.getElementById("divNewNoteBody").innerHTML = '';
            }
            catch (e) {return 0; }
            return 1;
        }

        function GoBackCosDirty() {
           
            if (gbDirty) {
                var answer = confirm('You have made changes that have not been saved/sent. Press OK to proceed WITHOUT saving. Press cancel to go back and save your changes.');
                if (answer) {
                    gbDirty = 0;
                    return 0;
                }
                else {
                    return 1;
                }
            }
            return 0;
        }

        function MoveNewNoteToContext() {
         
            try { document.getElementById("txtNewNote", giContextCurr).value = document.getElementById("tNew").value } catch (e) { }
        }

        function ContractNumberRequired(sCat, sSubCat) {
            if (Number(sSubCat) != 8 // Agency Commissions
		&& Number(sSubCat) != 9 // Broker Commissions
		&& Number(sSubCat) != 10 // Franchise Commissions
		&& Number(sSubCat) != 21 // Apply for a new code
		&& Number(sSubCat) != 22 // Terminate a code
		&& Number(sSubCat) != 23 // Transfer code
		&& Number(sSubCat) != 24
		&& Number(sSubCat) != 26 // Apply for a new code agency
		&& Number(sSubCat) != 27 // Terminate a code agency
		&& Number(sSubCat) != 28 // Transfer code agency
		&& Number(sSubCat) != 29) {
                return 1;
            }
            else {
                return 0;
            }
        }

        function BrokerageRequired(sSubCat) 
        {
            if (Number(sSubCat) == 21) // Apply for a new code
            {
                return 1;
            }
            else {
                return 0;
            }

            if (Number(sSubCat) == 26) // Apply for a new code agency
            {
                return 1;
            }
            else {
                return 0;
            }
        }

        function ConsCodeRequired(sSubCat)
         {
            if (Number(sSubCat) == 8 // Agency Commissions
		|| Number(sSubCat) == 9 // Broker Commissions
		|| Number(sSubCat) == 10 // Franchise Commissions
		|| Number(sSubCat) == 22 // Terminate a code
		|| Number(sSubCat) == 23 // Transfer code
		|| Number(sSubCat) == 24 // Amend current code details
		|| Number(sSubCat) == 27 // Terminate a code
		|| Number(sSubCat) == 28 // Transfer code
		|| Number(sSubCat) == 29) {
                return 1;
            }
            else {
                return 0;
            }
        }
        var CatHasSubsFlag = 0;
        function ValSaveAndSend() {
            if (Number(NextFocusRow()) < 0) {
               
                NothingToDo('no messages');
                return 0;
              }

            var iMyRef = Number(document.getElementById("CaseID", giContextCurr).value);
            var sConNo = document.getElementById("txtContractNo", giContextCurr).value;
            var sUACFId = document.getElementById("txtUacfId").value;
            var sSubject = document.getElementById("txtSubject", giContextCurr).value;
            var sBrokerage = document.getElementById("txtBrokerage", giContextCurr).value;
            var sConsCd = document.getElementById("txtConsCode", giContextCurr).value;      
            var sCat = document.getElementById("CatTC", giContextCurr).value;
            var sSubCat = document.getElementById("SubCatTC", giContextCurr).value;
            MoveNewNoteToContext();
            var sNote = document.getElementById("tNew", giContextCurr).value;
            var bConNoError = 0;


            if (!sCat > '') {
                ShowVal('A category which the request relates to is compulsory');
                return;
            }

            if (CatHasSubs(Number(sCat)) && (!sSubCat > '')) {
                ShowVal('A sub category for the category that the request relates to is compulsory');
                return;
            }

            //contract number validation
            //firstly, is it compulsory, forbidden or optional
            if (ContractNumberRequired(sCat, sSubCat)) 
            {
                //contract number is required
                if (!sConNo > '')
                 {
                    ShowVal('Contract number is compulsory'); document.getElementById("txtContractNo", giContextCurr).focus();
                    return;
                }
            }
            else //Contract number is not required
            {
                //Contract number is optional on Commissions category so don't block them if they captured one
                if (Number(sSubCat) != 8 // Agency Commissions
			&& Number(sSubCat) != 9 // Broker Commissions
			&& Number(sSubCat) != 10) // Franchise Commissions
                {
                    if (sConNo > '') {
                        alert('The contract number is not required. Please remove anything entered into the contract number field');
                        document.getElementById("txtContractNo", giContextCurr).focus();
                        document.getElementById("txtContractNo", giContextCurr).select();
                        return;
                    }
                }
            }

            //if a con no has been captured then make sure it conforms to a set of rules.
            if (sConNo > '') {
                if (!IsAlphaNumeric(sConNo)) {
                    bConNoError = 1;
                }
                if (!(sConNo.length == 14 || sConNo.length == 11 || sConNo.length == 10 || sConNo.length == 5 || sConNo.length == 4)) {
                    bConNoError = 1;
                }
                if (sConNo.length == 10 && sConNo.substring(0, 2) != '00') {
                    bConNoError = 1;
                }
                if (bConNoError) {
                    bConNoError = 1;
                    alert('The contract number is not valid. Refer to the help for information on valid contract numbers');
                    document.getElementById("txtContractNo", giContextCurr).focus();
                    document.getElementById("txtContractNo", giContextCurr).select();
                    return;
                }
            }

            if (!sSubject > '') { ShowVal('Subject is compulsory'); document.getElementById("txtSubject", giContextCurr).focus(); return }

            if (ContractNumberRequired(sCat, sSubCat)) {
                if (!sConsCd > '') {
                    ShowVal('Please enter a consultant code');
                    document.getElementById("txtConsCode", giContextCurr).focus();
                    return;
                }
            }

            if (BrokerageRequired(sSubCat)) {
                if (!sBrokerage > '') {
                    alert('Please enter the Brokerage Name');
                    document.getElementById("txtBrokerage", giContextCurr).focus();
                    return;
                }
                else {
                    if (!IsValidAlpha(sBrokerage)) {
                        alert("The Brokerage name can only contain alpha, numeric and the following special characters - ' / ( ) & . , ");
                        document.getElementById("txtBrokerage", giContextCurr).focus();
                        document.getElementById("txtBrokerage", giContextCurr).select();
                        return;
                    }
                }
            }

            if (ConsCodeRequired(sSubCat)) {
                if (!sConsCd > '') {
                    alert('Please enter a Consultant Code');
                    document.getElementById("txtConsCode", giContextCurr).focus();
                    return;
                }
            }

            if (sConsCd > '') {
                //not allowed on this sub cat.
                if (Number(sSubCat) == 21) // Contracting - Apply for a new code
                {
                    alert('Consultant Code not allowed for this Sub Category.');
                    document.getElementById("txtConsCode", giContextCurr).focus();
                    document.getElementById("txtConsCode", giContextCurr).select();
                    return;
                }

                if (Number(sSubCat) == 26) // Contracting - Apply for a new code
                {
                    alert('Consultant Code not allowed for this Sub Category.');
                    document.getElementById("txtConsCode", giContextCurr).focus();
                    document.getElementById("txtConsCode", giContextCurr).select();
                    return;
                }
                //optional for the other sub cats so if it is entered then check it is valid.
                if (!IsNumeric(sConsCd)) {
                    alert('Consultant Code must contain numeric values only');
                    document.getElementById("txtConsCode", giContextCurr).focus();
                    document.getElementById("txtConsCode", giContextCurr).select();
                    return;
                }
                if (sConsCd.length != 13) {
                    alert('Consultant Code must be 13 characters long');
                    document.getElementById("txtConsCode", giContextCurr).focus();
                    document.getElementById("txtConsCode", giContextCurr).select();
                    return
                }
            }

            if (!sNote > '') { ShowVal('Comments are compulsory'); document.getElementById("tNew").focus(); return }
          
            var iSubCat = 0;
            var flag = 0;
            
            if (CatHasSubsFlag) {
             
                iSubCat = Number(sSubCat);
                sSubCat = gaSubs[iSubCat];
            }
            else {
                sSubCat = gaCats[Number(sCat)];           
            }
//            if (CatHasSubs(Number(sCat))) {
//                iSubCat = Number(sSubCat); sSubCat = gaSubs[iSubCat]
//                alert("CatHasSubs iSubCat " + iSubCat);
//                alert("CatHasSubs sSubCat " + gaSubs[iSubCat]);
//            }
//            else {
//                iSubCat = Number(sSubCat);
//                sSubCat = gaSubs[iSubCat];
//                
//                alert("Else" + sSubCat);
//                alert("sshubcat" + iSubCat);
//            }
            document.getElementById("divContentInnerHdr").innerHTML = "";
            document.getElementById("divContent").innerHTML = "";
            //SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, Number(sCat), gaCats[Number(sCat)], iSubCat, sSubCat, sNote, 2, sBrokerage);
        //    SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, Number(sCat), gaCats[Number(sCat)], Number(iSubCat), sSubCat, sNote, 2, sBrokerage);
            //  SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, Number(sCat), gaCats[Number(sCat)], iSubCat, sSubCat, sNote, 2, sBrokerage);
            //To send data to mindkey in right format for these options
            if (sSubCat == "APPLY FOR A NEW CODE AGENCY") {
                sSubCat = "Apply for a new code agency"; 
            }
            if (sSubCat == "TERMINATE A CODE AGENCY")
            { sSubCat = "Terminate a code agency"; }
            if (sSubCat == "TRANSFER CODE AGENCY")
            { sSubCat = "Transfer code agency"; }
            if (sSubCat == "AMEND CURRENT CODE DETAILS AGENCY")
            { sSubCat = "Amend current code details agency"; }
            if (sSubCat == "APPLY FOR A NEW CODE") {
                sSubCat = "Apply for a new code";
            }
            if (sSubCat == "TERMINATE A CODE") {
                sSubCat = "Terminate a code";
            }
            if (sSubCat == "TRANSFER CODE") {
                sSubCat = "Transfer code";
            }
            if (sSubCat == "AMEND CURRENT CODE DETAILS") {
                sSubCat = "Amend current code details";
            }
            if (sSubCat == "AGENCY COMMISSIONS")
            { sSubCat = "Agency Commissions"; }
            if (sSubCat == "BROKER COMMISSIONS")
            { sSubCat = "Broker Commissions"; }
            if (sSubCat == "FRANCHISE COMMISSIONS")
            {sSubCat = "Franchise Commissions"; }
        
            
           
           
            SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, Number(sCat), gaCats[Number(sCat)], iSubCat, sSubCat, sNote, 2, sBrokerage);
            //SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, iCat, sCat, iSubCat, sSubCat, sNote, iStatus, sBrokerage)
            $("#divContent").css("height", 475);
        }

        function IsNumeric(s) {
            var sValid = "0123456789";
            var sChar;
            var bResult = true;

            for (i = 0; i < s.length && bResult == true; i++) {
                sChar = s.charAt(i);
                if (sValid.indexOf(sChar) == -1) {
                    bResult = false;
                }
            }
            return bResult;
        }

        function IsValidAlpha(s) {
            var sValid = " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-'/()&.,";
            var sChar;
            var bResult = true;

            for (i = 0; i < s.length && bResult == true; i++) {
                sChar = s.charAt(i);
                if (sValid.indexOf(sChar) == -1) {
                    bResult = false;
                }
            }
            return bResult;
        }

        function IsAlphaNumeric(s) {
            //this has been updated to accomodate CAL contract numbers, so...
            //make sure that it containg only alphanumeric chars, also it must contain at least one numeric char.
            var sValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
            var sChar;
            var iIndex;
            var bResult = true;
            var bHasNumeric = false;

            for (iIndex = 0; iIndex < s.length && bResult == true; iIndex++) {
                sChar = s.charAt(iIndex);
                if (IsNumeric(sChar)) {
                    bHasNumeric = true;
                }
                if (sValid.indexOf(sChar) == -1) {
                    bResult = false;
                }
            }

            if (bHasNumeric == false) {
                bResult = false;
            }

            return bResult
        }

        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************
        //******Existing Code******

//        function CatHasSubs(iCat) {
//            var doc = new ActiveXObject("Microsoft.XMLDOM")
//            doc.loadXML(xmlData2.innerHTML)
//            var nodes = new ActiveXObject("Microsoft.XMLDOM")
//            nodes.async = "false"
//            var Sub = doc.getElementsByTagName("sub")
//            if (Sub.length > 0) {
//                var bFound1 = 0
//                for (i = 0; i < Sub.length; i++) {
//                    nodes.loadXML(Sub.item(i).xml)
//                    if (iCat == nodes.documentElement.selectSingleNode("/sub/CatId").text) {
//                        return 1
//                    }
//                }
//            }
//            return 0
//        }


        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************

        //Chander
       
        function CatHasSubs(iCat) {

       
            var var_xmlData_innerHTML = (xmlData2.innerHTML).toUpperCase();
            var doc = $.parseXML(var_xmlData_innerHTML);
        

            var len = $(doc).find('SUB').length;
            var flag = false;
            if (len > 0) 
            {
                $(doc).find('SUB').each(function() {
                    if (iCat == $(this).find('CATID').text()) {
                        
                        CatHasSubsFlag = 1;
                        return false;

                        //return true;
                        //alert("$(this).find('CATID').text()" + $(this).find('CATID').text());
                    }
                });
            }
            if (CatHasSubsFlag == 1) {return false ;}
           
            CatHasSubsFlag = 0;
        }

        //******End here******

        function ShowVal(sValTxt) {
            alert(sValTxt + ' - please enter/select a valid value');
        }

        var giRetry = 0;
        var giSaveNewi = 0;
        function SaveNew(i, bNotify) {
            giSaveNewi = i;

            if (Number(NextFocusRow()) < 0) { NothingToDo('no messages'); return 0 }
            var iMyRef = Number(document.getElementById("CaseID", i).value);
            var sConNo = document.getElementById("txtContractNo", i).value;
            var sUACFId = document.getElementById("txtUacfId").value;
            var sSubject = document.getElementById("txtSubject", i).value;
            var sBrokerage = document.getElementById("txtBrokerage", i).value;
            var sConsCd = document.getElementById("txtConsCode", i).value;
            var sCat = document.getElementById("CatTC", i).value;
            var sSubCat = document.getElementById("SubCatTC", i).value;
            var sNote = document.getElementById("txtNewNote", i).value;
            var iStatus = 0;
            gbDirty = 0;

            ShowBusy();
            try { var response = WebForm1.A_Save(iMyRef, sConNo, sUACFId, sConsCd, sSubject, Number(sCat), Number(sSubCat), sNote, iStatus, sBrokerage, SaveNew_CB); if (bNotify) { alert("This work item has been successfully saved") } }
            catch (e) { AjaxEH('SaveNew', e) }
        }

        function SaveNew_CB(r) {
            if (r.error != null) {
                if (giRetry < 3) {
                    giRetry++;
                    SaveNew(giSaveNewi, 0);
                    return 0;
                }
                giRetry = 0;
                CallBackEH('SaveNew', r.error);
                return 0;
            }

            giRetry = 0;
            document.getElementById("CaseID", giContextCurr).value = r.value;
            HideBusy();
        }

        var giSaveAndSendMyRef = 0;
        var gsSaveAndSendConNo = '';
        var gsSaveAndSendUACFId = '';
        var gsSaveAndSendConsCd = '';
        var gsSaveAndSendSubject = '';
        var gsSaveAndSendBrokerage = '';
        var giSaveAndSendCat = '';
        var gsSaveAndSendCat = '';
        var giSaveAndSendSubCat = '';
        var gsSaveAndSendSubCat = '';
        var gsSaveAndSendNote = '';
        var giSaveAndSendStatus = '';
        function SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, iCat, sCat, iSubCat, sSubCat, sNote, iStatus, sBrokerage) {

            giSaveAndSendMyRef = iMyRef;
            gsSaveAndSendConNo = sConNo;
            gsSaveAndSendUACFId = sUACFId;
            gsSaveAndSendConsCd = sConsCd;
            gsSaveAndSendSubject = sSubject;
            gsSaveAndSendBrokerage = sBrokerage;
            giSaveAndSendCat = iCat;
            gsSaveAndSendCat = sCat;
            giSaveAndSendSubCat = iSubCat;
            gsSaveAndSendSubCat = sSubCat;
            gsSaveAndSendNote = sNote;
            giSaveAndSendStatus = iStatus;

            gbDirty = 0;
            ShowBusy();
            //	XMLHTTPRequest("BPO_HTTP_Request.asp?function=StoreAuditContNo&pstrSuccess=C&pstrTransType=BTM" + String(iSubCat) + "&pstrContNo=" + sConNo)

            sSubject = sSubject.replace(/&/g, '&amp;');
            sNote = sNote.replace(/&/g, '&amp;');
            sBrokerage = sBrokerage.replace(/&/g, '&amp;');
            
            
            try { var response = WebForm1.A_SaveAndSend(iMyRef, sConNo, sUACFId, sConsCd, sSubject, iCat, sCat, iSubCat, sSubCat, sNote, iStatus, sBrokerage, SaveAndSend_CB) }
            catch (e) {
                AjaxEH('SaveAndSend', e);
            }
        }

        function SaveAndSend_CB(r) {
           
            if (r.error != null) {
                if (giRetry < 3) {
                    giRetry++;
                 
                    SaveAndSend(giSaveAndSendMyRef, gsSaveAndSendConNo, gsSaveAndSendUACFId, gsSaveAndSendConsCd, gsSaveAndSendSubject, giSaveAndSendCat, gsSaveAndSendCat, giSaveAndSendSubCat, gsSaveAndSendSubCat, gsSaveAndSendNote, giSaveAndSendStatus, gsSaveAndSendBrokerage);
                    return 0;
                }
                giRetry = 0;
                CallBackEH('SaveAndSend', r.error);
                return 0;
            }

            giRetry = 0;

            CheckXMLForException('SaveAndSend', r.value);

            HideBusy();

            //alert(document.getElementById("txtAction").value)
            //	switch(document.getElementById("txtAction").value)
            //		{
            //		case '1':
            //			document.getElementById("divFind").innerHTML = ''
            //			return(0)
            //			break
            //		default :
            //			break
            //		}


            switch (giSaveAndSendCat) {
                case '5':
                    giSaveAndSendSubCat = 999;
                    break
                case '6':
                    giSaveAndSendSubCat = 998;
                    break
                case '8':
                    giSaveAndSendSubCat = 997;
                    break
            }

            XMLHTTPRequest("BPO_HTTP_Request.asp?function=StoreAuditContNo&pstrSuccess=C&pstrTransType=BTM" + String(giSaveAndSendSubCat) + "&pstrContNo=" + gsSaveAndSendConNo);

            if (document.getElementById("txtAction").value == 1) {
                //alert('GetListXML(1)')
                document.getElementById("divAllNotes").innerHTML = '';
                GetListXML(1);
            }
            else {
                ReOrderList();
            }
        }

        function NothingToDo(s) {
            //	alert('Nothing to do: ' + s)
            alert('No messages to submit');
        }

        function Unnasigned_Delete() {
            if (Number(NextFocusRow()) < 0) { NothingToDo('no messages'); return 0 }

            ShowBusy();
            
            var iMyRef = Number(document.getElementById("CaseID", giContextCurr).value);
            

            if (iMyRef > 0) {
                var answer = confirm('Are you sure that you want to delete this request?');
                if (answer) {
                    try {
                        var response = WebForm1.A_Unnasigned_Delete(iMyRef, Unnasigned_Delete_CB)
                        document.getElementById("divContent").innerHTML = '';
                        document.getElementById("divContentInnerHdr").innerHTML = '';
                     }
                    catch (e) { AjaxEH('Unnasigned_Delete', e) }
                }
            }
            else {
                document.getElementById("divContent").innerHTML = '';
                document.getElementById("divContentInnerHdr").innerHTML = '';
                document.getElementById("divContentInnerHdr").style.display = "none";
                document.getElementById("divAllNotes").innerHTML = '';
                GetListXML(1);
            }
            $("#divContent").css("height", 475);  //Chander(Adust design part)
        }

        function Unnasigned_Delete_CB(r) {
            if (r.error != null) {
                CallBackEH('Unnasigned_Delete', r.error);
                return 0;
            }

            CheckXMLForException('Unnasigned_Delete', r.value);
            HideBusy();

            document.getElementById("divAllNotes").innerHTML = '';
            GetListXML(1);
        }

        function AddComment() {
           
            if (Number(NextFocusRow()) < 0) { NothingToDo('no messages'); return 0 }

            var i = giContextCurr;
            if (!document.getElementById("tNew")) { alert('Comments are compulsory - please enter/select a valid value'); AddNewComment(); document.getElementById("tNew").focus(); return }
            if (!document.getElementById("tNew").value > '') { alert('Comments are compulsory - please enter/select a valid value'); AddNewComment(); document.getElementById("tNew").focus(); return }

            gbDirty = 0;

            var s = '';
            var s = document.getElementById("tNew").value;
            s = s.replace(/&/g, '&amp;');

            ShowBusy();
            try { 
            var response = WebForm1.A_AddComment(document.getElementById("CaseID", i).value, document.getElementById("WFID", i).value, s, document.getElementById("txtUacfId").value, AddComment_CB) }
            catch (e) { AjaxEH('AddComment', e) }
        }

        function AddComment_CB(r) {
            
            if (r.error != null) {
                CallBackEH('AddComment', r.error);
                return 0;
            }
            CheckXMLForException('AddComment', r.value);
            HideBusy();
            GetComments(giContextCurr);
            document.getElementById("divAllNotes").innerHTML = "";
        }

        var giAddCommentAndChangeStateState = 0;
        function AddCommentAndChangeState(iState) {
            giAddCommentAndChangeStateState = iState;
            if (Number(NextFocusRow()) < 0) { NothingToDo('no messages'); return 0 }
            var i = giContextCurr;
            var sNote = ' ';
            if (Number(iState) == 4) {
                if (document.getElementById("tNew")) {
                    sNote = document.getElementById("tNew").value;
                }
            }
            else 
            {
                if (!document.getElementById("tNew")) { alert('Comments are compulsory - please enter/select a valid value'); AddNewComment(); document.getElementById("tNew").focus(); return }
                if (!document.getElementById("tNew").value > '') { alert('Comments are compulsory - please enter/select a valid value'); AddNewComment(); document.getElementById("tNew").focus(); return }
                sNote = document.getElementById("tNew").value;
            }

            gbDirty = 0;
            ShowBusy();
            try { var response = WebForm1.A_AddCommentAndChangeState(document.getElementById("CaseID", i).value, document.getElementById("WFID", i).value, sNote, iState, document.getElementById("txtUacfId").value, AddCommentAndChangeState_CB) }
            catch (e) { AjaxEH('AddCommentAndChangeState', e) }
            document.getElementById("divAllNotes").style.display = "none";
            divContentInnerHdr.style.display = 'block'
            $("#divContent").css("height", 451);
        }

        function AddCommentAndChangeState_CB(r) {
            if (r.error != null) {
                if (giRetry < 3) {
                    giRetry++;
                    AddCommentAndChangeState(giAddCommentAndChangeStateState);
                    return 0;
                }
                giRetry = 0;
                CallBackEH('AddCommentAndChangeState', r.error);
                return 0;
            }

            giRetry = 0;
            CheckXMLForException('AddCommentAndChangeState', r.value);
            HideBusy();
            RemoveCaseFromXML(document.getElementById("CaseID", giContextCurr).value);
            ReOrderList();
        }

        var giAddCommentAndReAssignState = 0;
        function AddCommentAndReAssign(iState) {
            giAddCommentAndReAssignState = iState;
            if (Number(NextFocusRow()) < 0) { NothingToDo('no messages'); return 0 }
            var i = giContextCurr;
            if (oldflag == 'old') { alert('Function not available for items closed more than 2 weeks ago'); return 0 }

            var sNote = ' '

            if (Number(iState) == 4) {
                if (document.getElementById("tNew")) {
                    sNote = document.getElementById("tNew").value;
                }
            }
            else {
                if (!document.getElementById("tNew")) {  alert('Comments are compulsory - please enter/select a valid value'); AddNewComment(); document.getElementById("tNew").focus(); return }
                if (!document.getElementById("tNew").value > '') {  alert('Comments are compulsory - please enter/select a valid value'); AddNewComment(); document.getElementById("tNew").focus(); return }
                sNote = document.getElementById("tNew").value;
            }

            gbDirty = 0;
            ShowBusy();
            try { var response = WebForm1.A_AddCommentAndReAssign(document.getElementById("CaseID", i).value, document.getElementById("WFID", i).value, sNote, iState, document.getElementById("txtUacfId").value, AddCommentAndReAssign_CB) }
            catch (e) { AjaxEH('AddCommentAndReAssign', e) }

            document.getElementById("divAllNotes").style.display = "none";
            divContentInnerHdr.style.display = 'block'
            $("#divContent").css("height", 451);
            
        }

        function AddCommentAndReAssign_CB(r) {
            if (r.error != null) {
                if (giRetry < 3) {
                    giRetry++;
                    AddCommentAndReAssign(giAddCommentAndReAssignState);
                    return 0;
                }
                giRetry = 0;
                CallBackEH('AddCommentAndReAssign', r.error);
                return 0;
            }

            giRetry = 0;
            CheckXMLForException('AddCommentAndReAssign', r.value);
            HideBusy();
            RemoveCaseFromXML(document.getElementById("CaseID", giContextCurr).value);
            ReOrderList();
        }

        function TestAjax() {
            ShowBusy();
            try { var response = WebForm1.A_Test(TestAjax_CB) }
            catch (e) { AjaxEH('TestAjax', e) }
        }

        function TestAjax_CB(r) {
            if (r.error != null) {
                CallBackEH('TestAjax', r.error);
                return 0;
            }
           
        }


        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************
        //******Existing Code******

//        function CheckXMLForException(fNme, s) {
//            return 0;

//            if (s == '') { MainEH(fNme, s); return 1 }
//            var i = 0;
//            var doc = new ActiveXObject("Microsoft.XMLDOM");
//            doc.loadXML(s);
//            var nodes = new ActiveXObject("Microsoft.XMLDOM");
//            nodes.async = "false";
//            var Exception = doc.getElementsByTagName("Exception");
//            try {
//                if (Exception.length > 0) { MainEH(fNme, s); return 1 }
//            }
//            catch (e) { }
        //        }


        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************
        
        //Chander     
        function CheckXMLForException(fNme, s) {
        
            return 0

            if (s == '') { MainEH(fNme, s); return 1 }
            var i = 0
            var var_xmlData_innerHTML = s.toUpperCase();
                var sample = var_xmlData_innerHTML.replace(new RegExp("&LT;", "gm"), "ZZ");
                var sample1 = sample.replace(new RegExp("&GT;", "gm"), "YY");
                var sample2 = sample1.replace(new RegExp("&", "gm"), "");
                var doc = $.parseXML(sample2);

          //  var doc = $.parseXML(var_xmlData_innerHTML);
            var len = $(doc).find("EXCEPTION").length;
            try {
                if (len > 0) { MainEH(fNme, s); return 1 }
            }
            catch (e) { }
        }

        //******End here******

        var giGetListXMLFuncTp = 0;
        function GetListXML(iFuncTp) 
        {
            
            giGetListXMLFuncTp = iFuncTp;

            var sUACFId = document.getElementById("txtUacfId").value;
            var sConsultantCode = '';

            try {
                if (document.getElementById("rbConsCd").checked == 1) {
                    sUACFId = '';
                    try { sConsultantCode = document.getElementById("txtMyConsultantCode").value } catch (e) { }
                }
            }
            catch (e) { }
           
            ShowBusy();
            try 
            {
                var response = WebForm1.A_GetList(Number(iFuncTp), sUACFId, sConsultantCode, GetListXML_CB) 
                
             }
            catch (e) { AjaxEH('GetListXML', e) }

        }

        function GetListXML_CB(r) {
           
            
            
            
            if (r.error != null) {
                if (giRetry < 3) {
                    giRetry++;
                    GetListXML(giGetListXMLFuncTp);
                    return 0;
                }
                giRetry = 0;
                CallBackEH('GetListXML', r.error);
                return 0;
            }
           
            giRetry = 0;
            CheckXMLForException('GetListXML', r.value);
            
            xmlData.innerHTML = r.value;

            HideBusy();
           
            ShowList(document.getElementById("txtAction").value);
            
        }

        function GetListXMLOldClosed() {
            var sUACFId = document.getElementById("txtUacfId").value;
            var sConsultantCode = '';

            try {
                if (document.getElementById("rbConsCd").checked == 1) {
                    sUACFId = '';
                    try { sConsultantCode = document.getElementById("txtMyConsultantCode").value } catch (e) { }
                }
            }
            catch (e) { }

            ShowBusy();
            try { var response = WebForm1.A_GetList(5, sUACFId, sConsultantCode, GetListXMLOldClosed_CB) }
            catch (e) { AjaxEH('GetListXMLOldClosed', e) }

        }

        function GetListXMLOldClosed_CB(r) {
            if (r.error != null) {
                CallBackEH('GetListXMLOldClosed', r.error);
                return 0;
            }

            CheckXMLForException('GetListXMLOldClosed', r.value);
            xmlDataOldClosed.innerHTML = r.value;
            HideBusy();
            ShowList(document.getElementById("txtAction").value);
        }

        function AjaxEH(fNme, e) {
            MainEH(fNme, e);
            alert('Error on call to AJAX function: ' + fNme + ' - ' + e);
            alert('Recipient system currently not available. Please try again later');
        }

        function CallBackEH(fNme, e) {
            MainEH(fNme, e);
            alert('Error returned to: ' + fNme + '_CB - ' + e);
            alert('Recipient system currently not available. Please try again later');
        }

        function MainEH(fNme, e) {
            HideBusy();
            XMLHTTPRequest("BPO_HTTP_Request.asp?function=LogError&pstrPageName=BPO_FF.aspx&pstrPolNo=0&pstrErrorMess=Error in function" + fNme + "&pstrErrorDesc=" + e + "&pstrErrorType=i&pstrSourceDll=BPO_FF.dll&pstrRetCode=0095");
        }

        function ShowBusy() {
            //******Existing Code******
//            divBusy.style.top = window.screen.height - (window.screen.height * 0.3);
            //            divBusy.style.left = window.screen.width - (window.screen.width * 0.35);
            //******End here******
            document.getElementById('divBusy').style.visibility = 'visible';
        }

        function HideBusy() {
            gbBusy = 0;
           document.getElementById('divBusy').style.visibility = 'hidden';
        }

        function PositionListDivs() {
          
            try {
//                for (i = 1; i < giContext; i++) // NB: start offset is 1 - first one is where it should be by default so dont mess with it
//                {
//                    divListRow(Number(i)).style.top = divListRow(Number(i - 1)).offsetTop + divListRow(Number(i - 1)).offsetHeight + 3;
//                }
            }
            catch (e) { }
        }

        function ReOrderList() {
            try {
                GetListXML(document.getElementById("txtAction").value);
                var i = giContextCurr;
                var iRowToSetFocusTo = 0;
                var iNextTop = 0;
                if (divListRow.length > 1) {
                    divListRow(Number(i)).style.visibility = 'hidden';
                    iNextTop = divListRow(Number(i)).offsetTop;

                    for (i; i < giContext; i++) {
                        if (divListRow(Number(i)).style.visibility != 'hidden') {
                            if (iRowToSetFocusTo == 0) {
                                iRowToSetFocusTo = i;
                            }
                            divListRow(Number(i)).style.top = iNextTop;
                            iNextTop = divListRow(Number(i)).offsetTop + divListRow(Number(i)).offsetHeight + 3;
                        }
                    }

                    KillRowFocus(giContextCurr);
                    if (iRowToSetFocusTo > 0) {
                        SetRowFocus(document.getElementById("ListRow", iRowToSetFocusTo));
                    }
                    else {
                        SetRowFocus();
                    }
                }
                else {
                    divListRow.style.visibility = 'hidden';
                    KillRowFocus(i);
                    SetRowFocus();
                }
                GetListXML(document.getElementById("txtAction").value);
            }
            catch (e) { }
        }

        function AddNewComment() {
            //Chander    
            if (oldflag == 'old') { alert('Function not available for items closed more than 2 weeks ago'); return 0 }       
            var hdr = '<table width=100%>'                                                              
            hdr += '<tr><td class=tdHDetail1 align=center bgcolor="#003366">Comments</td></tr>'    // to visible text area for adding comments
            hdr += '</table><textarea id="tNew" style="height:100px; width:549px ;margin:2px 0px 1px 8px" ></textarea>'
            document.getElementById("divAllNotes").innerHTML = hdr;
            
            document.getElementById("divAllNotes").style.display = "block";
            document.getElementById("divAllNotes").style.visibility = "visible";
            var divheight = $("#div_rgt").height() - $("#divContentInnerHdr").height();
            $("#divAllNotes").height(130);
            $("#divContent").height(320);
            if ($(".bl_help").css("display") == "block") { $("#tNew").css("width", 310); } //Chander

            //******End here******

            //******Existing Code******
//            if (Number(NextFocusRow()) < 0) { NothingToDo('no messages'); return 0 }
//            var i = giContextCurr
//            if (document.getElementById("divListRow", i).specialtype == 'old') { alert('Function not available for items closed more than 2 weeks ago'); return 0 }
//            gbDirty = 1;
//            var s = '<table width=100%>';
//            s += '<tr><td class=tdHDetail1 align=center>Comments</td></tr>';
//            s += '</table>';
//            document.getElementById("divNewNoteHdr").innerHTML = s;
//            s = '<table width=100%>';
//            s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=7>' + document.getElementById("txtNewNote", giContextCurr).value + '</textarea></td></tr>';
//            s += '</table>';             
//            document.getElementById("divNewNoteBody").innerHTML = s;
//            divNewNote.style.top = divContent.offsetTop + iBorders;
//            divNewNote.style.left = divContent.offsetLeft + iBorders;
//            divNewNote.style.height = (divContent.offsetHeight / 3) - (iBorders * 2);
            //            divNewNote.style.width = divContentInner.offsetWidth;
            //******End Here******
            
            divNewNote.style.visibility = 'visible';

            SetNewNoteCoords();

            //******Existing Code******
//            divContentInner.style.top = divNewNote.offsetTop + divNewNote.offsetHeight + iBorders;
//            divContentInner.style.height = divContent.offsetHeight - divNewNote.offsetHeight - (iBorders * 2) - 2;

//            divContentInnerHdr.style.top = divContentInner.offsetTop + 1;
//            divContentInnerBody.style.top = divContentInnerHdr.offsetTop + divContentInnerHdr.offsetHeight;
            //            divContentInnerBody.style.height = divContentInner.offsetHeight - divContentInnerHdr.offsetHeight - (iBorders * 2) - 2;

            //******End Here******
        }

        function SetNewNoteCoords() {
            //******Existing Code******
//            divNewNoteHdr.style.top = divNewNote.offsetTop + 1;
//            divNewNoteHdr.style.left = divNewNote.offsetLeft + 1;
//            divNewNoteHdr.style.width = divNewNote.offsetWidth - 2;
//            divNewNoteBody.style.top = divNewNoteHdr.offsetTop + divNewNoteHdr.offsetHeight + 1;
//            divNewNoteBody.style.left = divNewNote.offsetLeft + 1;
//            divNewNoteBody.style.width = divNewNoteHdr.offsetWidth - 2;
            //            divNewNoteBody.style.height = divNewNote.offsetHeight - divNewNoteHdr.offsetHeight - 3;
            //******End here******
            divNewNoteHdr.style.visibility = 'visible';
            divNewNoteBody.style.visibility = 'visible';
        }

        var giGetCommentsi = 0;
        function GetComments(i) {
           
            giGetCommentsi = i;
            if (document.getElementById("txtAction").value == 1 && (document.getElementById("txtNewNote", giContextCurr).value > '' || Number(document.getElementById("CaseID", i).value) < 1)) {
                var s = '<table width=100%>';
                s += '<tr><td class=tdHDetail1 align=center>Comments</td></tr>';
                s += '</table>';
                document.getElementById("divNewNoteHdr").innerHTML = s;

                s = '<table width=100%>';
                s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=30>' + document.getElementById("txtNewNote", giContextCurr).value + '</textarea></td></tr>';
                s += '</table>';
                document.getElementById("divNewNoteBody").innerHTML = s;

                //******Existing Code******

//                divNewNote.style.top = divContent.offsetTop + iBorders;
//                divNewNote.style.left = divContent.offsetLeft + iBorders;
//                divNewNote.style.height = divContent.offsetHeight - (iBorders * 2);
                //                divNewNote.style.width = divContent.offsetWidth - (iBorders * 2);

                //******End Here******
                divNewNote.style.visibility = 'visible';

                SetNewNoteCoords();
            }
            else {
                ShowBusy();
                try {
                     var response= WebForm1.A_GetComments(document.getElementById("CaseID", i).value, document.getElementById("WFID", i).value, GetComments_CB);
                   
                    
                }
                catch (e) { AjaxEH('GetComments', e) }
            }
        }


        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************
        //******Existing Code******

//        function GetComments_CB(r) {
//            if (r.error != null) {
//                if (giRetry < 3) {
//                    giRetry++
//                    GetComments(giGetCommentsi)
//                    return 0
//                }
//                giRetry = 0
//                CallBackEH('GetComments', r.error)
//                return 0
//            }

//            giRetry = 0
//            var s = ''
//            var wrk = ''

//            CheckXMLForException('AddCommentAndReAssign', r.value)
//            try {
//                var doc = new ActiveXObject("Microsoft.XMLDOM")
//                doc.async = "false"
//                var nodes = new ActiveXObject("Microsoft.XMLDOM")
//                nodes.async = "false"
//                var nodes2 = new ActiveXObject("Microsoft.XMLDOM")
//                nodes2.async = "false"
//                doc.loadXML(r.value)
//                var Comments = doc.getElementsByTagName("Comment")

//                var i = 0
//                if (document.all("txtAction").value == 1) // unassigned
//                {
//                    s = '<table width=100%>'
//                    if (Comments.length > 0) {
//                        nodes.loadXML(Comments.item(0).xml)
//                        s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=30>' + nodes.documentElement.selectSingleNode("/Comment/Note").text + '</textarea></td></tr>'
//                    }
//                    else {
//                        s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=30></textarea></td></tr>'
//                    }
//                    s += '</table>'
//                }
//                else {
//                    while (i < Comments.length) {
//                        nodes.loadXML(Comments.item(i).xml)
//                        wrk = "<tr><td  class=tdH5 width=10%>From:</td><td class=tdH6>" + nodes.documentElement.selectSingleNode("/Comment/User").text + "</td></tr>"
//                        wrk += "<tr><td  class=tdH5 width=10%>Sent:</td><td class=tdH6>" + nodes.documentElement.selectSingleNode("/Comment/Date").text + "</td></tr>"
//                        wrk += "<tr><td class=tdH6 colspan=2>" + nodes.documentElement.selectSingleNode("/Comment/Text").text + "</td></tr>"
//                        wrk += "<tr><td class=tdH7 colspan=2>__________________________________</td></tr>"
//                        i++
//                        s = wrk + s
//                    }
//                    s = '<table width=100%>' + s + '</table>'
//                }
//            }
//            catch (e) {
//                HideBusy()
//                s = ''
//            }

//            if (document.all("txtAction").value == 1) {
//                divNewNote.style.top = divContent.offsetTop + iBorders
//                divNewNote.style.left = divContent.offsetLeft + iBorders
//                divNewNote.style.height = divContent.offsetHeight - (iBorders * 2)
//                divNewNote.style.width = divContent.offsetWidth - (iBorders * 2)
//                divNewNote.style.visibility = 'visible'

//                SetNewNoteCoords()

//                document.all("divNewNoteHdr").innerHTML = '<table width=100%><tr><td class=tdHDetail1 align=center>Comments</td></tr></table>'
//                document.all("divNewNoteBody").innerHTML = s
//            }
//            else {
//                divNewNote.style.width = divContent.offsetWidth - (iBorders * 2)
//                divNewNote.style.visibility = 'hidden'
//                divNewNoteHdr.style.width = divContent.offsetWidth - (iBorders * 2)
//                divNewNoteHdr.style.visibility = 'hidden'
//                divNewNoteBody.style.width = divContent.offsetWidth - (iBorders * 2)
//                divNewNoteBody.style.visibility = 'hidden'
//                divContentInner.style.top = divContent.offsetTop + iBorders
//                divContentInner.style.left = divContent.offsetLeft + iBorders
//                divContentInner.style.height = divContent.offsetHeight - (iBorders * 2)
//                divContentInner.style.width = divContent.offsetWidth - (iBorders * 2)
//                divContentInner.style.visibility = 'visible'

//                divContentInnerHdr.style.top = divContentInner.offsetTop + 1
//                divContentInnerHdr.style.left = divContentInner.offsetLeft + 1
//                divContentInnerHdr.style.width = divContentInner.offsetWidth - 2

//                divContentInnerBody.style.top = divContentInnerHdr.offsetTop + divContentInnerHdr.offsetHeight
//                divContentInnerBody.style.left = divContentInner.offsetLeft + iBorders
//                divContentInnerBody.style.width = divContentInner.offsetWidth - (iBorders * 2)
//                divContentInnerBody.style.height = divContentInner.offsetHeight - divContentInnerHdr.offsetHeight - (iBorders * 2)

//                document.all("divContentInnerBody").innerHTML = s
//                divContentInnerHdr.style.visibility = 'visible'
//                divContentInnerBody.style.visibility = 'visible'
//            }
//            HideBusy()
//        }


        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************
 
        //Chander
        function GetComments_CB(r) {
            if (r.error != null) {
                if (giRetry < 3) {
                    giRetry++
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
            try {
                   
                var var_xmlData_innerHTML = (r.value).toUpperCase();
                //******Chander (to decode unorganised XML)******
                var sample = var_xmlData_innerHTML.replace(new RegExp("&LT;", "gm"), "ZZ");
                var sample1 = sample.replace(new RegExp("&GT;", "gm"), "YY");
                var sample2 = sample1.replace(new RegExp("&", "gm"), "");
                //******end here******  

                var doc = $.parseXML(sample2);

                var i = 0
                if (document.getElementById("txtAction").value == 1) // unassigned
                {
                    s = '<table width=100%>'
                    if (len > 0) {
                        $(doc).find("COMMENT").each(function() {

                            s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=30>' + $(this).find('NOTE').text() + '</textarea></td></tr>'

                        });
                    }
                    else {
                        s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=30></textarea></td></tr>'
                    }
                    s += '</table>'
                }
                else {
                    $(doc).find("COMMENT").each(function() {

                        wrk = "<tr><td  class=tdH5 width=10%>From:</td><td class=tdH6>" + $(this).find('USER').text() + "</td></tr>"
                        wrk += "<tr><td  class=tdH5 width=10%>Sent:</td><td class=tdH6>" + $(this).find('DATE').text() + "</td></tr>"
                        //******Chander( to decode unorganised XML)******

                        var sam = ($(this).find('TEXT').text()).replace(new RegExp("ZZ", "gm"), "<");
                        var sam1 = sam.replace(new RegExp("YY", "gm"), ">");
                        var sam2 = sam1.replace(new RegExp(":AMP;NBSP;", "gm"), "&nbsp;");
                        var sam3 = sam2.replace(new RegExp("AMP;NBSP;", "gm"), "&nbsp;");

                        //******end here******
                        wrk += "<tr><td class=tdH6 colspan=2>" + sam3 + "</td></tr>"
                        wrk += "<tr><td class=tdH7 colspan=2>__________________________________</td></tr>"

                        s = wrk + s
                    });
                    s = '<table width=100%>' + s + '</table>'
                }
            }
          
            catch (e) {
                HideBusy()
                s = ''
            }
          
            if (document.getElementById("txtAction").value == 1) {
                //******Existing Code******
                //		divNewNote.style.top = divContent.offsetTop + iBorders
                //		divNewNote.style.left = divContent.offsetLeft + iBorders
                //		divNewNote.style.height = divContent.offsetHeight - (iBorders * 2)
                //		divNewNote.style.width = divContent.offsetWidth - (iBorders * 2)
                divNewNote.style.visibility = 'visible'

                SetNewNoteCoords()

                document.getElementById("divNewNoteHdr").innerHTML = '<table width=100%><tr><td class=tdHDetail1 align=center>Comments</td></tr></table>'
                document.getElementById("divNewNoteBody").innerHTML = s
            }
            else {

               
                document.getElementById("divContent").innerHTML = s
                document.getElementById('divBusy').style.visibility = 'hidden';
               
                document.getElementById("divAllNotes").style.display = "none";
               
                divContentInnerHdr.style.display = 'block'
               
                    $("#divContent").css("height", 451);  //chander
               
                divContentInnerHdr.style.visibility = 'visible'
                divContentInnerBody.style.visibility = 'visible'

              /*  divNewNote.style.visibility = 'visible' //CZP
                divNewNoteHdr.style.visibility = 'visible'
                divNewNoteBody.style.visibility = 'visible'*/
                HideBusy();
                //******Existing Code******
                //divNewNote.style.width = divContent.offsetWidth - (iBorders * 2)
           /*  divNewNote.style.visibility = 'hidden';   //czp
                //******Existing Code******
                //divNewNoteHdr.style.width = divContent.offsetWidth - (iBorders * 2)
                divNewNoteHdr.style.visibility = 'hidden';
                //******Existing Code******
                //divNewNoteBody.style.width = divContent.offsetWidth - (iBorders * 2)
                divNewNoteBody.style.visibility = 'hidden';*/
                //******Existing Code******
                //divContentInner.style.top = divContent.offsetTop + iBorders
                //		divContentInner.style.left = divContent.offsetLeft + iBorders
                //divContentInner.style.height = divContent.offsetHeight - (iBorders * 2)
                //		divContentInner.style.width = divContent.offsetWidth - (iBorders * 2)
                $("#divContentInner").css("visibility", "visible");
                /*divContentInner.style.visibility = 'visible';*/
                //******Existing Code******
                //		divContentInnerHdr.style.top = divContentInner.offsetTop + 1
                //		divContentInnerHdr.style.left = divContentInner.offsetLeft + 1
                //		divContentInnerHdr.style.width = divContentInner.offsetWidth - 2
                //		
                //		divContentInnerBody.style.top = divContentInnerHdr.offsetTop + divContentInnerHdr.offsetHeight
                //		divContentInnerBody.style.left = divContentInner.offsetLeft + iBorders
                //		divContentInnerBody.style.width = divContentInner.offsetWidth - (iBorders * 2)
                //		divContentInnerBody.style.height = divContentInner.offsetHeight - divContentInnerHdr.offsetHeight - (iBorders * 2)

                //                document.getElementById("divContentInnerBody").innerHTML = s

//                document.getElementById("divContent").innerHTML = s
//                divContentInnerHdr.style.visibility = 'visible'
//                divContentInnerBody.style.visibility = 'visible'

//                divNewNote.style.visibility = 'visible'
//                divNewNoteHdr.style.visibility = 'visible'
                //                divNewNoteBody.style.visibility = 'visible'
               //******End Here******

            }

        }
        
        //******End here******
   
         //Chander
        function XMLHTTPRequest(sURL) 
        {
            var xmlhttp;
            var reply;   
            xmlhttp = new XMLHttpRequest();          // To make compatible with all other browsers
        //	var oXMLHTTP = new ActiveXObject("Microsoft.XMLHTTP") 
            xmlhttp.open("POST", sURL, false);
            xmlhttp.send();
            return xmlhttp.responseText;
        }    

        //******End Here******


        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************
        //******Existing Code******

//        function GetUserIDAndConslts(sAction) {
//            var i = 0
//            var j = 0

//            var doc = new ActiveXObject("Microsoft.XMLDOM")
//            doc.async = "false";
//            var nodes = new ActiveXObject("Microsoft.XMLDOM")
//            nodes.async = "false";
//            //DEBUG start
//            //to undo debug changes put the call to the function back in and comment out the hard coded XML
//            doc.loadXML(XMLHTTPRequest('BOPFF_GetUserAndConslts.asp'))
//            //	doc.loadXML("<UserData><UserID>GMM1512</UserID>" +
//            //				"<MyConsCode>0290000000001</MyConsCode>" +
//            //				"<UserType>X</UserType></UserData>")
//            //DEBUG end
//            document.all("txtUacfId").value = doc.getElementsByTagName("UserID")[0].firstChild.nodeValue
//            document.all("txtUserType").value = doc.getElementsByTagName("UserType")[0].firstChild.nodeValue
//            try { document.all("txtMyConsultantCode").value = doc.getElementsByTagName("MyConsCode")[0].firstChild.nodeValue } catch (e) { }
//            var Conslts = doc.getElementsByTagName("ConsCode")
//            if (Conslts.length == 0) { gsConsltSel = '' }
//            else {
//                var wrk = '<option>' + ' select a code' + '</option>'
//                var sConsCd = ''
//                gaLinkedCons[0] = ''
//                while (i < Conslts.length) {
//                    sConsCd = ''
//                    nodes.loadXML(Conslts.item(i).xml)
//                    try {
//                        wrk += '<option>' + nodes.getElementsByTagName("ConsCode")[0].firstChild.nodeValue + '</option>'
//                        sConsCd = nodes.getElementsByTagName("ConsCode")[0].firstChild.nodeValue
//                        gaLinkedCons[j + 1] = sConsCd
//                        j++
//                    }
//                    catch (e) { }
//                    i++
//                }
//                var s = '<select id="selConslts" onchange="SetConsCode(this.selectedIndex, ' + sAction + ')">' + wrk + '</select>'
//                gsConsltSel = s
//            }
//        }


        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************
   
        var gaLinkedCons = new Array();
        var gsConsltSel = '';
        //Chander
        function GetUserIDAndConslts(sAction) 
        {
           
            var i = 0
            var j = 0
            var conscosde;
            
            // use the doc object to create XML
        //   var doc = $.parseXML("<UserData><UserID>MXG0712</UserID><MyConsCode>0000000000000</MyConsCode><UserType>X</UserType><ConsCode>0290000000001</ConsCode></UserData>");
           var doc= $.parseXML(XMLHTTPRequest('BOPFF_GetUserAndConslts.asp'));
           
            var len = $(doc).find('UserData').length;
            try 
            {
            
            $(doc).find("UserData").each(function() 
            {
                document.getElementById("txtUacfId").value = $(this).find('UserID').text();
                document.getElementById("txtUserType").value = $(this).find('UserType').text();
                document.getElementById("txtMyConsultantCode").value = $(this).find('MyConsCode').text();
            });

            }
            catch (e) 
            {

            }

            var Conslts = $(doc).find('ConsCode');

            if (Conslts.length == 0) 
            {
                gsConsltSel = ''
            }
            
            else 
            {                
                var wrk = '<option>' + ' select a code' + '</option>'
                var sConsCd = ''
                gaLinkedCons[0] = ''
                while (i < Conslts.length) 
                {
                    sConsCd = ''
                    // use the doc object to create XML
//                    nodes.loadXML(Conslts.item(i).xml)
                    try {
                    
                        // use the doc object to create XML    
                        wrk += '<option>' + doc.getElementsByTagName("ConsCode")[0].firstChild.nodeValue + '</option>'
                        sConsCd = doc.getElementsByTagName("ConsCode")[0].firstChild.nodeValue
                        gaLinkedCons[j + 1] = sConsCd
                        j++
                    }
                    catch (e) { }
                    i++
                }

                var s = '<select id="selConslts" onchange="SetConsCode(this.selectedIndex, ' + sAction + ')">' + wrk + '</select>'
                
                gsConsltSel = s
            }
        }


        //******End here******

        function SetConsCode(i, sAction) 
        {           
            document.getElementById("txtMyConsultantCode").value = gaLinkedCons[i];
            try 
            {
                document.getElementById("txtConsCode").value = gaLinkedCons[i]
            }

            catch (e) 
            {
            }
            
            //	if(sAction > 1)
            //		{
            //		GetListXML(sAction)
            //		}
        }


        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************
        //******Existing Code******
//        function RemoveCaseFromXML(id) {
//            var i = 0
//            var wrk = ''
//            var bFound = 0
//            var doc = new ActiveXObject("Microsoft.XMLDOM")
//            var doc2 = new ActiveXObject("Microsoft.XMLDOM")
//            doc.loadXML(xmlData.innerHTML)
//            var nodes = new ActiveXObject("Microsoft.XMLDOM")
//            nodes.async = "false"
//            var Cases = doc.getElementsByTagName("Case")

//            while (i < Cases.length) {
//                wrk = ''
//                nodes.loadXML(Cases.item(i).xml)
//                if (String(nodes.documentElement.selectSingleNode("/Case/ID").text) == String(id)) {
//                    bFound = 1
//                    doc2 = Cases.item(i).parentNode
//                    doc2.removeChild(Cases.item(i))
//                    xmlData.innerHTML = doc2.xml
//                    break
//                }
//                i++
//            }

//            if (bFound == 0) {
//                doc.loadXML(xmlDataOldClosed.innerHTML)
//                nodes = new ActiveXObject("Microsoft.XMLDOM")
//                Cases = doc.getElementsByTagName("Case")

//                i = 0
//                while (i < Cases.length) {
//                    wrk = ''
//                    nodes.loadXML(Cases.item(i).xml)

//                    if (nodes.documentElement.selectSingleNode("/Case/ID").text == id) {
//                        bFound = true
//                        doc2 = Cases.item(i).parentNode
//                        doc2.removeChild(Cases.item(i))
//                        xmlDataOldClosed.innerHTML = doc2.xml
//                        break
//                    }
//                    i++
//                }
//            }
//        }

        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************


        //Chander
        function RemoveCaseFromXML(id) {
            var i = 0;
            var wrk = '';
            var bFound = 0;
            var doc = $.parseXML(((xmlData.innerHTML).toUpperCase()).replace(new RegExp("&AMP;", "gm"), "AND"));
            var len = $(doc).find("CASE").length;
            $(doc).find("CASE").each(function() {
                wrk = '';
                if (String($(this).find("ID").text()) == String(id)) {
                    bFound = 1;
                    var doc1 = doc;
                    doc = $(this).remove();
                    //                    doc2 = Cases.item(i).parentNode;
                    //                    doc2.removeChild(Cases.item(i));
                    xmlData.innerHTML = doc.xml;
                    doc = doc1;
                    return false;
                }

            });
            if (bFound == 0)
             {
                 var doc = $.parseXML(((xmlDataOldClosed.innerHTML).toUpperCase()).replace(new RegExp("&", "gm"), "AND"));
                 var len = $(doc).find("CASE").length;
                 $(doc).find("CASE").each(function() {
                     wrk = '';
                     if (String($(this).find(ID).text()) == String(id)) {
                         bFound = 1;
                         var doc1 = doc;
                         doc = $(this).remove();
                         //                    doc2 = Cases.item(i).parentNode;
                         //                    doc2.removeChild(Cases.item(i));
                         xmlDataOldClosed.innerHTML = doc.xml;
                         doc = doc1;
                         return false;
                     }


                 });

            }
        }

        //******End here******

        var sShowOld = '+';
        function BuildListFromXML() {
            giContext = 0;
            var s = '';
            var sCat = '';
            var sSubCat = '';
            try {
                document.getElementById("divAllNotes").innerHTML = '';
                s = BuildListFromXMLPart2(0);

                if (document.getElementById("txtAction").value == 4) 
                {
                    s += '<div id="divListRow" style="position:relative;BORDER-BOTTOM: lightgrey 1px outset" specialtype="hdr">';
                    s += '<table width=100% class="tableList" id="ListRow1" onclick="" ContextRow="' + giContext + '">';
                    s += '<tr>';
                    s += '<td class="tdListH" valign=center><input type=button style="cursor:pointer" class="bShowOld" value="' + sShowOld + '" onclick="HideShowOld()">&nbsp;older than 2 weeks<input type=hidden id="CaseID" value=""><input type=hidden id="WFID" value=""></td>';
                    s += '</tr>';
                    s += '</table>';
                    s += '</div>';
                    document.getElementById("divAllNotes").innerHTML = document.getElementById("divAllNotes").innerHTML + '<textarea id="txtNewNote" style="visibility:hidden; height:0; width:0" rows=10></textarea><br>';
                    giContext++;

                    if (xmlDataOldClosed.innerHTML > '') 
                    {
                        s += BuildListFromXMLPart2(1);
                    }
                }
            }
            catch (e) { }
            return (s);
        }

        //  ******************************************************************************************************************************************************************
        //  Two New function added(GetwfidComments,getxmlwfid) to get comment history and change color of row at row selecting event in Submitted , Inbox and closed Item Link
        //  ******************************************************************************************************************************************************************

        
        //Chander
        var wfid = new Array();        
        function GetwfidComments(i,wfid) {
            giGetCommentsi = i;
            if (document.getElementById("txtAction").value == 1 && (document.getElementById("txtNewNote", giContextCurr).value > '' || Number(document.getElementById("CaseID", i).value) < 1)) {
                var s = '<table width=100%>';
                s += '<tr><td class=tdHDetail1 align=center>Comments</td></tr>';
                s += '</table>';
                document.getElementById("divNewNoteHdr").innerHTML = s;

                s = '<table width=100%>';
                s += '<tr><td class=tdH6 colspan=2><textarea id="tNew" style="width:100%" rows=30>' + document.getElementById("txtNewNote", giContextCurr).value + '</textarea></td></tr>';
                s += '</table>';
                document.getElementById("divNewNoteBody").innerHTML = s;
                divNewNote.style.visibility = 'visible';

                SetNewNoteCoords();
            }
            else {
                ShowBusy();
                try {

                    var response = WebForm1.A_GetComments(document.getElementById("CaseID", i).value, wfid, GetComments_CB);


                }
                catch (e) { AjaxEH('GetComments', e) }
            }
        }

       function getxml(obj) {
            if ($(obj).hasClass("rowcolor")) {
                return;
            } else {
                var retVal = confirm("You have made changes that have not been saved/sent.Press ok to proceed WITHOUT saving.press cancel to go back and save your changes.");
                if (retVal == true) {
                    $(".rowcolor").removeClass("rowcolor");
                    $(obj).addClass("rowcolor");
                }
           
            }
        }

        function getxmlwfid(gwfid, obj) {

            if ($("#divAllNotes").css('display') == "block") {
                var retVal = confirm("You have made changes that have not been saved/sent.Press ok to proceed WITHOUT saving.press cancel to go back and save your changes.");
                if (retVal == true) {
                    $("#divContent").css("height", 450);
                    $(".rowcolor").removeClass("rowcolor");

                    $(obj).addClass("rowcolor");
                    doc = $.parseXML(((xmlData.innerHTML).toUpperCase()).replace("&", "and"));
                    var len = $(doc).find("CASE").length;
                    if (gwfid > len) {                                      //Chander(for close item)
                        GetwfidComments(i, wfid[gwfid-1]);
                    }
                    else {
                        GetwfidComments(i, wfid[gwfid]);
                    }

                    return true;
                }
                else {
                    document.getElementById("divAllNotes").style.display == block;
                    return false;
                }
            
            }

            $(".rowcolor").removeClass("rowcolor");
          
            $(obj).addClass("rowcolor");
            doc = $.parseXML(((xmlData.innerHTML).toUpperCase()).replace("&", "and"));
            var len = $(doc).find("CASE").length;
            if (gwfid > len) {
                GetwfidComments(i, wfid[gwfid - 1]);
            }
            else {
                GetwfidComments(i, wfid[gwfid]);
            }

        }


        //******End here******

        //  *****************************************************
        //  Old XML DOM Parser function only compatible with IE 7
        //  *****************************************************

        //******Existing Code******
//        function BuildListFromXMLPart2(iListTp) {
//            var s = ''
//            var sCat = ''
//            var sSubCat = ''
//            var sSpecialType = ''
//            try {
//                var doc = new ActiveXObject("Microsoft.XMLDOM")
//                if (iListTp == 0) {
//                    doc.loadXML(xmlData.innerHTML)
//                }
//                else {
//                    doc.loadXML(xmlDataOldClosed.innerHTML)
//                    sSpecialType = 'old'
//                }
//                var nodes = new ActiveXObject("Microsoft.XMLDOM")
//                nodes.async = "false"
//                var Cases = doc.getElementsByTagName("Case")

//                if (Cases.length > 0) {
//                    var i = 0
//                    while (i < Cases.length) {
//                        wrk = ''
//                        nodes.loadXML(Cases.item(i).xml)
//                        if (document.all("txtAction").value == 1) {
//                            s += '<div id="divListRow" style="position:absolute; BORDER-BOTTOM: lightgrey 1px outset" specialtype="">'
//                            s += '<table width=100% class="tableList" id="ListRow" onclick="MoveNewNoteToContext(); if(KillRowFocus(giContextCurr, this)){SetRowFocus(this)}" ContextRow="' + giContext + '">'
//                            s += '<tr><td colspan=2 class=tdListH>Ensure that you enter a comment in the Comments section</td></tr>'
//                            s += '<tr><td colspan=2 class=tdListH>on the right after completing all the information below.</td></tr>'
//                            s += '<tr><td colspan=2 class=tdListH>&nbsp;</td></tr>'
//                            s += '<tr><td class="tdListH" width=30%>Contract number:</td><td><input class="txtInp" type=text id="txtContractNo" name="txtContractNo" value="' + nodes.documentElement.selectSingleNode("/Case/Contract_Number").text + '" onchange="gbDirty=1"><input type=hidden id="CaseID" value="' + nodes.documentElement.selectSingleNode("/Case/ID").text + '"><input type=hidden id="CatTC" value="' + nodes.documentElement.selectSingleNode("/Case/Category").text + '"><input type=hidden id="SubCatTC" value="' + nodes.documentElement.selectSingleNode("/Case/Sub_Category").text + '"><input type=hidden id="WFID" value="0"></td></tr>'

//                            s += '<tr><td class="tdListH">Subject:</td><td><input class="txtInp" type=text id="txtSubject" name="txtSubject" value="' + nodes.documentElement.selectSingleNode("/Case/Subject").text + '" onchange="gbDirty=1"></td></tr>'

//                            s += '<tr>'
//                            s += '<td colspan=2>'

//                            s += '<table width=100% bgcolor="white" cellpadding=0>'

//                            if (gsConsltSel > '') {
//                                s += '<tr><td class="tdList" width=30%>Consultant code:</td><td>' + gsConsltSel + '<input class="txtInp" type=hidden id="txtConsCode" name="txtConsCode" value="' + nodes.documentElement.selectSingleNode("/Case/ConsCode").text + '"></td></tr>'
//                            }
//                            else {
//                                s += '<tr><td class="tdList" width=30%>Consultant code:</td><td><input class="txtInp" type=text id="txtConsCode" name="txtConsCode" value="' + nodes.documentElement.selectSingleNode("/Case/ConsCode").text + '" size=11 maxlength=13 onchange="gbDirty=1"></td></tr>'
//                            }

//                            //include a Brokerage field
//                            s += '<tr><td class="tdList" width=30%>Brokerage name:</td><td><input class="txtInp" type=text id="txtBrokerage" name="txtBrokerage" value="' + nodes.documentElement.selectSingleNode("/Case/Brokerage").text + '" size=40 maxlength=50 onchange="gbDirty=1"></td></tr>'

//                            s += '<tr><td colspan=2><table width=100% cellspacing=0 cellpadding=0>'
//                            s += BuildCats(i)
//                            s += '</table>'
//                            s += '</td></tr></table>'

//                            s += '</td>'
//                            s += '</tr>'
//                            s += '</table>'
//                            s += '</div>'
//                            document.all("divAllNotes").innerHTML = document.all("divAllNotes").innerHTML + '<textarea id="txtNewNote" style="visibility:hidden; height:0; width:0" rows=10></textarea><br>'
//                            giContext++
//                        }
//                        else {
//                            if ((document.all("txtFindContract").value == '' && document.all("txtFindWFNo").value == '') || (document.all("txtFindContract").value == nodes.documentElement.selectSingleNode("/Case/Contract_Number").text) || (document.all("txtFindWFNo").value == nodes.documentElement.selectSingleNode("/Case/WFID").text)) {
//                                sCat = nodes.documentElement.selectSingleNode("/Case/Category").text
//                                sSubCat = nodes.documentElement.selectSingleNode("/Case/Sub_Category").text
//                                s += '<div id="divListRow" style="position:absolute; BORDER-BOTTOM: lightgrey 1px outset" specialtype="' + sSpecialType + '">'
//                                s += '<table width=100% class="tableList" id="ListRow" onclick="MoveNewNoteToContext(); if(KillRowFocus(giContextCurr, this)){SetRowFocus(this)}" ContextRow="' + giContext + '">'
//                                s += '<tr>'
//                                s += '<td class="tdListH" width=50%>Contract #&nbsp;' + nodes.documentElement.selectSingleNode("/Case/Contract_Number").text + '<input type=hidden id="CaseID" value="' + nodes.documentElement.selectSingleNode("/Case/ID").text + '"><input type=hidden id="WFID" value="' + nodes.documentElement.selectSingleNode("/Case/WFID").text + '"></td>'
//                                s += '<td class="tdListH" colspan=2 width=50% align=right>Work Flow #&nbsp' + nodes.documentElement.selectSingleNode("/Case/WFID").text + '</td>'
//                                s += '</tr>'
//                                s += '<tr>'
//                                s += '<td class="tdList" colspan=3>Subject: ' + nodes.documentElement.selectSingleNode("/Case/Subject").text + '</td>'
//                                s += '</tr>'
//                                s += '<tr>'
//                                s += '<td class="tdList" colspan=3>Brokerage name: ' + nodes.documentElement.selectSingleNode("/Case/Brokerage").text + '</td>'
//                                s += '</tr>'
//                                s += '<tr>'
//                                s += '<td class="tdList" colspan=3>Consultant code: ' + nodes.documentElement.selectSingleNode("/Case/ConsCode").text + '</td>'
//                                s += '</tr>'
//                                s += '<tr>'
//                                s += '<td class="tdList" width=50% colspan=2>This request relates to: ' + sCat + ' for: ' + sSubCat + '</td>'

//                                if (document.all("txtAction").value == 3) {
//                                    if (nodes.documentElement.selectSingleNode("/Case/FLAG").text == 0) {
//                                        s += '<td class="tdFlagUnread" align=right width=10%>P</td>'
//                                    }
//                                    else {
//                                        s += '<td class="tdFlag" align=right width=10%>P</td>'
//                                    }
//                                }
//                                else {
//                                    s += '<td width=10%>&nbsp;</td>'
//                                }
//                                s += '</tr>'
//                                s += '</table>'
//                                s += '</div>'
//                                document.all("divAllNotes").innerHTML = document.all("divAllNotes").innerHTML + '<textarea id="txtNewNote" style="visibility:hidden; height:0; width:0" rows=10></textarea><br>'
//                                giContext++
//                            }
//                        }
//                        i++
//                    }
//                }
//            }
//            catch (e) { }
//            return (s)
        //        }

        //  ***********************************************************************     
        //  New XML DOM Parser function which is compatible with all other browsers
        //  ***********************************************************************

        //Chander 
        function BuildListFromXMLPart2(iListTp) {
            
            var s = ''
            var sCat = ''
            var sSubCat = ''
            var sSpecialType = ''
            try {

                var doc;
                var var_xmlData_innerHTML;
                var var_xmlDataOldClosed_innerHTML;
                if (iListTp == 0) {
                    var i = 0;

                    doc = $.parseXML(((xmlData.innerHTML).toUpperCase()).replace(new RegExp("&AMP;", "gm"), "AND"));
                    var len = $(doc).find("CASE").length;         
                }
                else {
                    doc = $.parseXML(((xmlDataOldClosed.innerHTML).toUpperCase()).replace(new RegExp("&AMP;", "gm"), "AND"));
                    sSpecialType = 'old';
                    var len = $(doc).find("CASE").length;
                    i=wfid.length;
                }
              
                var len = $(doc).find("CASE").length;
               
               
                if (len > 0) {

                    $(doc).find("CASE").each(function () {

                        //				nodes.loadXML(Cases.item(i).xml)

                        if (document.getElementById("txtAction").value == 1) {
                            s += '<div id="divListRow" style="position:relative; BORDER-BOTTOM: lightgrey 1px outset" specialtype="">';
                            s += '<table width=100% class="tableList" id="ListRow" onclick="MoveNewNoteToContext();getxmlwfid(' + giContext + ',this); if(KillRowFocus(' + giContextCurr + ',this)){SetRowFocus(this)}" ContextRow="' + giContext + '">';
                            s += '<tr><td colspan=2 class=tdListH>Ensure that you enter a comment in the Comments section</td></tr>';
                            s += '<tr><td colspan=2 class=tdListH>on the right after completing all the information below.</td></tr>';
                            s += '<tr><td colspan=2 class=tdListH>&nbsp;</td></tr>';
                            s += '<tr><td class="tdListH" width=30%>Contract number:</td><td><input class="txtInp" type=text id="txtContractNo" name="txtContractNo" value="' + $(this).find('CONTRACT_NUMBER').text() + '" onchange="gbDirty=1"><input type=hidden id="CaseID" value="' + $(this).find('ID').text() + '"><input type=hidden id="CatTC" value="' + $(this).find('CATEGORY').text() + '"><input type=hidden id="SubCatTC" value="' + $(this).find('SUB_CATEGORY').text() + '"><input type=hidden id="WFID" value="0"></td></tr>';

                            s += '<tr><td class="tdListH">Subject:</td><td><input class="txtInp" type=text id="txtSubject" name="txtSubject" value="' + $(this).find('SUBJECT').text() + '" onchange="gbDirty=1"></td></tr>';

                            s += '<tr>';
                            s += '<td colspan=2>';

                            s += '<table width=100% bgcolor="white" cellpadding=0>';

                            if (gsConsltSel > '') {
                                s += '<tr><td class="tdList" width=30%>Consultant code:</td><td>' + gsConsltSel + '<input class="txtInp" type=hidden id="txtConsCode" name="txtConsCode" value="' + $(this).find('CONSCODE').text() + '"></td></tr>';
                            }
                            else {
                                s += '<tr><td class="tdList" width=30%>Consultant code:</td><td><input class="txtInp" type=text id="txtConsCode" name="txtConsCode" value="' + $(this).find('CONSCODE').text() + '" size=11 maxlength=13 onchange="gbDirty=1"></td></tr>';
                            }

                            //include a Brokerage field
                            s += '<tr><td class="tdList" width=30%>Brokerage name:</td><td><input class="txtInp" type=text id="txtBrokerage" name="txtBrokerage" value="' + $(this).find('BROKERAGE').text() + '" size=40 maxlength=50 onchange="gbDirty=1"></td></tr>';

                            s += '<tr><td colspan=2><table width=100% cellspacing=0 cellpadding=0>';
                            s += BuildCats(i);
                            s += '</table>';
                            s += '</td></tr></table>';

                            s += '</td>';
                            s += '</tr>';
                            s += '</table>';
                            s += '</div>';
                            if (len != 0) {

                                GetBTMNote();

                                $('#tNew').val($(this).find('NOTE').text());
                            }



                            // document.getElementById("divAllNotes).innerHTML = document.getElementById("divAllNotes").innerHTML + '<textarea id="txtNewNote" style="visibility:visible; height:0; width:0" rows=10></textarea><br>';
                            giContext++;

                        }
                        else {
                            if ((document.getElementById("txtFindContract").value == '' && document.getElementById("txtFindWFNo").value == '') || (document.getElementById("txtFindContract").value == $(this).find('CONTRACT_NUMBER').text()) || (document.getElementById("txtFindWFNo").value == $(this).find('WFID').text())) {
                         if (iListTp == 1) { wfid[i] = $(this).find("WFID").text(); i = i + 1; }
                        else {
                            wfid[i] = $(this).find("WFID").text();   //putting WFID in wfid array
                            i = i + 1;
                            wrk = '';
                        }
                                sCat = $(this).find('category').text();
                                sSubCat = $(this).find('sub_category').text();
                                s += '<div id="divListRow" style="position:relative; BORDER-BOTTOM: lightgrey 1px outset" onclick="SetFlag(this);" class="' + sSpecialType + '">';
                                s += '<table width=100% class="tableList" id="ListRow" onclick="MoveNewNoteToContext();getxmlwfid(' + giContext + ',this); if(KillRowFocus(' + giContextCurr + ',this)){SetRowFocus(this)}" ContextRow="' + giContext + '">';
                                s += '<tr>';
                                s += '<td class="tdListH" width=50%>Contract #&nbsp;' + $(this).find('CONTRACT_NUMBER').text() + '<input type=hidden id="CaseID" value="' + $(this).find('ID').text() + '"><input type=hidden id="WFID" value="' + $(this).find('WFID').text() + '"></td>';
                                s += '<td class="tdListH" colspan=2 width=50% align=right>Work Flow #&nbsp' + $(this).find('WFID').text() + '</td>';
                                s += '</tr>';
                                s += '<tr>';
                                s += '<td class="tdList" colspan=3>Subject: ' + $(this).find('SUBJECT').text() + '</td>';
                                s += '</tr>';
                                s += '<tr>';
                                s += '<td class="tdList" colspan=3>Brokerage name: ' + $(this).find('BROKERAGE').text() + '</td>';
                                s += '</tr>';
                                s += '<tr>';
                                s += '<td class="tdList" colspan=3>Consultant code: ' + $(this).find('CONSCODE').text() + '</td>';
                                s += '</tr>';
                                s += '<tr>';
                                s += '<td class="tdList" width=50% colspan=2>This request relates to: ' + $(this).find('CATEGORY').text() + ' for: ' + $(this).find('SUB_CATEGORY').text() + '</td>';

                                if (document.getElementById("txtAction").value == 3) {
                                    if ($(this).find('FLAG').text() == 0) {
                                        s += '<td class="Unread" align=right width=10%></td>'; //chander
                                    }
                                    else {
                                        s += '<td class="read" align=right width=10%></td>'; //chander
                                    }
                                }
                                else {
                                    s += '<td width=10%>&nbsp;</td>';
                                }
                                s += '</tr>';
                                s += '</table>';
                                s += '</div>';

                                document.getElementById("divAllNotes").innerHTML = document.getElementById("divAllNotes").innerHTML + '<textarea id="txtNewNote" style="visibility:hidden; height:0; width:0" rows=10></textarea><br>';
                                giContext++;
                            }
                        }

                    });
                   
                }


            }

            catch (e) { }
            return (s)

        }


        //******End here******


        //Chander(function to stop adding comments Function not available for items closed more than 2 weeks ago in closed item link)
        var oldflag;
        function SetFlag(o)
        {
            if ($(o).attr('class') == "old") 
            {
               oldflag = "old";
            }
           else {
               oldflag = ""; 
             }
       }

       //*****End Here******

        function HideShowOld() {
            if (sShowOld == '+') {
                sShowOld = '-';
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
                //		s += '<Brokerage>Randburg Broker</Brokerage>'
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
                //		s += '<Brokerage>Sandton Broker</Brokerage>'
                //		s += '<ID>501</ID>'
                //		s += '<FLAG></FLAG>'
                //		s += '</Case>'
                //		s += '</CaseList>'
                //		xmlDataOldClosed.innerHTML = s
                //		ShowList(document.getElementById("txtAction").value)
                GetListXMLOldClosed();
            }
            else {
                sShowOld = '+';
                xmlDataOldClosed.innerHTML = '';
                ShowList(document.getElementById("txtAction").value);
            }
        }

        var sVisibility = new Array();
        function HideDivsForPrint() {
     
            sVisibility[0] = divFind.style.visibility;
            sVisibility[1] = divListHdr.style.visibility;
            sVisibility[2] = divList.style.visibility;
            sVisibility[3] = divContent.style.visibility;
            sVisibility[4] = divContentInner.style.visibility;
            sVisibility[5] = divContentInnerHdr.style.visibility;
            sVisibility[6] = divContentInnerBody.style.visibility;
            sVisibility[7] = divNewNote.style.visibility;
            sVisibility[8] = divNewNoteHdr.style.visibility;
            sVisibility[9] = divNewNoteBody.style.visibility;
            sVisibility[10] = divHelp.style.visibility;
            sVisibility[11] = divHelpInner.style.visibility;
            sVisibility[12] = divAllNotes.style.visibility;
            sVisibility[13] = divTT.style.visibility;
            sVisibility[14] = divBusy.style.visibility;
            sVisibility[15] = divFFMain.style.visibility;

            try {
                sVisibility[16] = divOpts.style.visibility;
            }
            catch (e) { }

            try {
                sVisibility[17] = document.getElementById("selConslts").style.visibility;
                sVisibility[18] = document.getElementById("btConslts").style.visibility;
            }
            catch (e) { }
            
            divFind.style.visibility = 'hidden';
            divListHdr.style.visibility = 'hidden';
            divList.style.visibility = 'hidden';
            divContent.style.visibility = 'hidden';
            divContentInner.style.visibility = 'hidden';
            divContentInnerHdr.style.visibility = 'hidden';
            divContentInnerBody.style.visibility = 'hidden';
            divNewNote.style.visibility = 'hidden';
            divNewNoteHdr.style.visibility = 'hidden';
            divNewNoteBody.style.visibility = 'hidden';
            divHelp.style.visibility = 'hidden';
            divHelpInner.style.visibility = 'hidden';
            divAllNotes.style.visibility = 'hidden';
            divTT.style.visibility = 'hidden';
            divBusy.style.visibility = 'hidden';
            divFFMain.style.visibility = 'hidden';

            try {
                divOpts.style.visibility = 'hidden';
            }
            catch (e) { }

            try {
                document.getElementById("selConslts").style.visibility = 'hidden';
                document.getElementById("btConslts").style.visibility = 'hidden';
            }
            catch (e) { }
        }

        function ShowDivsAfterPrint() {
            divFind.style.visibility = sVisibility[0];
            divListHdr.style.visibility = sVisibility[1];
            divList.style.visibility = sVisibility[2];
            divContent.style.visibility = sVisibility[3];
            divContentInner.style.visibility = sVisibility[4];
            divContentInnerHdr.style.visibility = sVisibility[5];
            divContentInnerBody.style.visibility = sVisibility[6];
            divNewNote.style.visibility = sVisibility[7];
            divNewNoteHdr.style.visibility = sVisibility[8];
            divNewNoteBody.style.visibility = sVisibility[9];
            divHelp.style.visibility = sVisibility[10];
            divHelpInner.style.visibility = sVisibility[11];
            divAllNotes.style.visibility = sVisibility[12];
            divTT.style.visibility = sVisibility[13];
            divBusy.style.visibility = sVisibility[14];
            divFFMain.style.visibility = sVisibility[15];

            try {
                divOpts.style.visibility = sVisibility[16];
            }
            catch (e) { }

            try {
                document.getElementById("selConslts").style.visibility = sVisibility[17];
                document.getElementById("btConslts").style.visibility = sVisibility[18];
            }
            catch (e) { }
        }

        function PrintHistory() {
           
          
            var old = document.body.innerHTML;
            document.body.innerHTML =
              "<html><head><title></title></head><body onload='window.close()'>" + document.getElementById("divBanner").innerHTML + "<br/>" + "<table width='100%' border='2px'><tr><td><center><b>BTM Item</b></center></td></tr></table>" + "<br/>" + "<table>" + $('.rowcolor').html() + "</table>" + "<br/>" + "<table width='100%' border='2px'><tr><td><center><b>Comment History</b></center></td></tr></table>" + "<br />" + document.getElementById("divContent").innerHTML + "</body>";

            window.print();
            document.body.innerHTML = old;
            //******Existing Code******
            
//            document.getElementById("divPrint").innerHTML = '<table width=100% border=1 cellpadding=0 cellspacing=0><tr><td align=center><font face=Arial size=2><b>BTM Item</b></font></td></tr></table><br>';
//            document.getElementById("divPrint").innerHTML += document.getElementById("divListRow", giContextCurr).innerHTML;
//            document.getElementById("divPrint").innerHTML += '<br><table width=100% border=1 cellpadding=0 cellspacing=0><tr><td align=center><font face=Arial size=2><b>Comment History</b></font></td></tr></table><br>';
//            document.getElementById("divPrint").innerHTML += document.getElementById("divContentInnerBody").innerHTML;
//            divPrint.style.visibility = 'visible';
//            divPrint.style.left = divFFMain.offsetLeft;
//            divPrint.style.top = divFFMain.offsetTop;

//            HideDivsForPrint();
//            window.print();
//            ShowDivsAfterPrint();

//            divPrint.style.visibility = 'hidden';
 //            document.getElementById("divPrint").innerHTML = '';
            //            divPrint.style.height = 0;
           //******End Here******


        }



        function PrintHelp() {
 

           var old = document.body.innerHTML;
            
           document.body.innerHTML ="<html><head><title></title></head><body>" + document.getElementById("divBanner").innerHTML + "<br/>" + document.getElementById("divHelpInner").innerHTML + "</body>";

            window.print();

       document.body.innerHTML = old;
        }
        function hide()
         {  
             
            $("#divList").css("display", "none");
             $("#divListHdr").css("display", "none");
             $("#divContent").css("display", "none");
             $(".div_rgt").css("display", "none");
            $(".div_lft").css("display", "none");
            $(".btm_main").css("display", "none");
            $("#divBanner").css("display", "none");
             $("#divFind").css("display", "none");
            $("#divHelpInner").css("display", "none");
            $("#divHelp").css("display", "none");
            $("#divPrint").css("display", "block");
           

          }

          function show()
          {
                      $("#divList").css("display", "block");
                     $("#divListHdr").css("display", "block");
                     $("#divContent").css("display", "block");
                    $(".div_rgt").css("display", "block");
                    $(".div_lft").css("display", "block");
            $(".btm_main").css("display", "block");
            $("#divBanner").css("display", "block");
             $("#divFind").css("display", "block");
            $("#divHelpInner").css("display", "block");
            $("#divHelp").css("display", "block");
            $("#divPrint").css("display", "none");


          }

          //*******Existing Code*******
//            document.getElementById("divPrint").innerHTML = document.getElementById("divHelpInner").innerHTML;
////            $("#divPrint").html($(.divPrint).html());
//            //            alert("helpdiv");
//            $("#divhelp").print();
//            divPrint.style.visibility = 'visible';
//            divPrint.style.left = divFFMain.offsetLeft;
//            divPrint.style.top = divFFMain.offsetTop;
////            HideDivsForPrint();
//divFind.style.visibility = 'hidden';
//            divListHdr.style.display = "none";
//            divList.style.display = "none";
//            divContent.style.display = "none";
//            divContentInner.style.display = "none";
//            divContentInnerHdr.style.display = "none";
//            divContentInnerBody.style.display = "none";
//            divNewNote.style.display = "none";
//            divNewNoteHdr.style.display = "none";
//            divNewNoteBody.style.display = "none";
//            divHelp.style.display = "none";
//            divHelpInner.style.display = "none";
//            divAllNotes.style.display = "none";
//            divTT.style.display = "none";
//            divBusy.style.display = "none";
//            divFFMain.style.display = "none";

//           
////            ShowDivsAfterPrint();

//            divPrint.style.visibility = 'hidden';
//            document.getElementById("divPrint").innerHTML = '';
//            divPrint.style.height = 0;
          //        }
//******End here******

    </script>

    <xml id='xmlData'></xml>
    <xml id='xmlDataOldClosed'></xml>
</body>
</html>
