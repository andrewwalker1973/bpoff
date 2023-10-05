Imports System.Xml
Imports Microsoft.Win32

Public Class WebForm1
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtAction As System.Web.UI.WebControls.TextBox

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Ajax.Utility.RegisterTypeForAjax(GetType(WebForm1))
        If Not IsPostBack Then
            Dim iFuncTp As Integer
            Dim sXML As String
            'DEBUG start
            iFuncTp = Request.QueryString("FuncTp")
            'iFuncTp = 2
            'DEBUG end
            Select Case iFuncTp
                Case 1, 4
                    Page.Controls.Add(New LiteralControl("<xml id='xmlData2'>" & BuildLookupXML() & "</xml>"))
            End Select
        End If
    End Sub

    Public Function BuildLookupXML() As String
        Dim sXML As String
        sXML = "<Lookups>"
        sXML = sXML & "<cat><id>0</id><descr>Financial Control</descr></cat>"
        sXML = sXML & "<cat><id>1</id><descr>Claims</descr></cat>"
        sXML = sXML & "<cat><id>3</id><descr>Commissions</descr></cat>"
        sXML = sXML & "<cat><id>9</id><descr>Contracting</descr></cat>"
        sXML = sXML & "<cat><id>4</id><descr>Annuity Enquiries</descr></cat>"
        sXML = sXML & "<cat><id>5</id><descr>Policy Changes General Enquiries</descr></cat>"
        sXML = sXML & "<cat><id>6</id><descr>Disbursements General Enquiries</descr></cat>"
        sXML = sXML & "<cat><id>7</id><descr>Actuarial</descr></cat>"
        sXML = sXML & "<cat><id>8</id><descr>Multi Access Endowment (MAE)</descr></cat>"
        sXML = sXML & "<sub><id>0</id><CatId>0</CatId><descr>Allocations</descr></sub>"
        sXML = sXML & "<sub><id>19</id><CatId>0</CatId><descr>Reallocations</descr></sub>"
        sXML = sXML & "<sub><id>1</id><CatId>0</CatId><descr>Loan schedules</descr></sub>"
        sXML = sXML & "<sub><id>2</id><CatId>0</CatId><descr>Special Debits</descr></sub>"
        sXML = sXML & "<sub><id>20</id><CatId>0</CatId><descr>Credit Control</descr></sub>"
        sXML = sXML & "<sub><id>3</id><CatId>1</CatId><descr>Death Claim</descr></sub>"
        sXML = sXML & "<sub><id>4</id><CatId>1</CatId><descr>Disability Claim</descr></sub>"
        sXML = sXML & "<sub><id>5</id><CatId>1</CatId><descr>Living Lifestyle Claim</descr></sub>"
        sXML = sXML & "<sub><id>6</id><CatId>1</CatId><descr>Income Disability Claim</descr></sub>"
        sXML = sXML & "<sub><id>7</id><CatId>1</CatId><descr>Medical Lifestyle Death Claim</descr></sub>"
        sXML = sXML & "<sub><id>8</id><CatId>3</CatId><descr>Agency Commissions</descr></sub>"
        sXML = sXML & "<sub><id>9</id><CatId>3</CatId><descr>Broker Commissions</descr></sub>"
        sXML = sXML & "<sub><id>10</id><CatId>3</CatId><descr>Franchise Commissions</descr></sub>"
        sXML = sXML & "<sub><id>11</id><CatId>4</CatId><descr>Payments</descr></sub>"
        sXML = sXML & "<sub><id>12</id><CatId>4</CatId><descr>Tax Certificates</descr></sub>"
        sXML = sXML & "<sub><id>13</id><CatId>4</CatId><descr>General Enquiries</descr></sub>"
        sXML = sXML & "<sub><id>14</id><CatId>7</CatId><descr>What If Quotes</descr></sub>"
        sXML = sXML & "<sub><id>15</id><CatId>7</CatId><descr>Actuarial Correspondence</descr></sub>"
        sXML = sXML & "<sub><id>16</id><CatId>7</CatId><descr>Actuarial Costs and Expenses</descr></sub>"
        sXML = sXML & "<sub><id>17</id><CatId>7</CatId><descr>Medical Lifestyle Specialised Administration</descr></sub>"
        sXML = sXML & "<sub><id>18</id><CatId>7</CatId><descr>Medical Lifestyle Quotes</descr></sub>"
        sXML = sXML & "<sub><id>21</id><CatId>9</CatId><descr>Apply for a new code</descr></sub>"
        sXML = sXML & "<sub><id>22</id><CatId>9</CatId><descr>Terminate a code</descr></sub>"
        sXML = sXML & "<sub><id>23</id><CatId>9</CatId><descr>Transfer code</descr></sub>"
        sXML = sXML & "<sub><id>24</id><CatId>9</CatId><descr>Amend current code details</descr></sub>"
        sXML = sXML & "</Lookups>"
        Return sXML
    End Function

    Public Function GetSecurityContext() As wsMindKey.SecurityContext
        Dim wsMK_SC As New wsMindKey.SecurityContext
        Dim sSC_XML As String

        sSC_XML = "<MSG_InterfaceSecurityContext>"
        sSC_XML = sSC_XML & "<UserName>BPOFF</UserName>"
        sSC_XML = sSC_XML & "<Password/>"
        sSC_XML = sSC_XML & "<Reference>0800020c171d16062c3e2920333a12060911011a</Reference>"
        sSC_XML = sSC_XML & "</MSG_InterfaceSecurityContext>"
        wsMK_SC.ContextXML = sSC_XML
        Return wsMK_SC
    End Function

    Public Function GetXMLMessageHdr()
        Return "<WfMessage xmlns=""http://www.wfmc.org/standards/docs/Wf-XML"" Version=""1.1""><WfTransport><Dialog Type=""synch"" Mode=""Individual"" /></WfTransport>"
    End Function

    Public Function GetXMLMessageFtr()
        Return "</WfMessage>"
    End Function

    Public Function Save(ByVal iID As Integer, ByVal sConNo As String, ByVal sUACFId As String, ByVal sConsCd As String, ByVal sSubject As String, ByVal iCat As Integer, ByVal iSubCat As Integer, ByVal sNote As String, ByVal iStatus As Integer, ByVal sBrokerage As String) As Integer

        Dim sc As SqlClient.SqlConnection
        sc = GetSqlConnection()
        Dim ds As New DataSet
        Dim sda As New SqlClient.SqlDataAdapter("select id, UACFId, WFId, Subject, ConsCode, Contract_Number, Category, Sub_Category, Status, Note, Brokerage from Cases where id = " & iID, sc)
        Dim bNew As Boolean = False
        If iID = 0 Then
            bNew = True
            sda.InsertCommand = New SqlClient.SqlCommand("InsertCase", sc)
            sda.InsertCommand.CommandType = CommandType.StoredProcedure

            sda.InsertCommand.Parameters.Add("@UACFId", SqlDbType.Char, 7, "UACFId")
            sda.InsertCommand.Parameters.Add("@Subject", SqlDbType.Char, 50, "Subject")
            sda.InsertCommand.Parameters.Add("@ConsCode", SqlDbType.Char, 13, "ConsCode")
            sda.InsertCommand.Parameters.Add("@Contract_Number", SqlDbType.Char, 15, "Contract_Number")
            sda.InsertCommand.Parameters.Add("@Category", SqlDbType.Int, 0, "Category")
            sda.InsertCommand.Parameters.Add("@Sub_Category", SqlDbType.Int, 0, "Sub_Category")
            sda.InsertCommand.Parameters.Add("@Status", SqlDbType.Int, 0, "Status")
            sda.InsertCommand.Parameters.Add("@Note", SqlDbType.Char, 250, "Note")
            sda.InsertCommand.Parameters.Add("@Brokerage", SqlDbType.Char, 50, "Brokerage")

            Dim myParm As SqlClient.SqlParameter = sda.InsertCommand.Parameters.Add("@id", SqlDbType.Int, 0, "id")
            myParm.Direction = ParameterDirection.Output

            sc.Open()

            sda.Fill(ds, "Cases")

            Dim newRow As DataRow = ds.Tables("Cases").NewRow()
            newRow("UACFId") = sUACFId
            newRow("Subject") = sSubject
            newRow("ConsCode") = sConsCd
            newRow("Contract_Number") = sConNo
            newRow("Category") = iCat
            newRow("Sub_Category") = iSubCat
            If iStatus > 0 Then
                newRow("Status") = iStatus
            Else
                newRow("Status") = 1
            End If
            newRow("Note") = sNote
            newRow("Brokerage") = sBrokerage
            ds.Tables("Cases").Rows.Add(newRow)

            sda.Update(ds, "Cases")

            sc.Close()

            iID = myParm.Value
        Else
            sda.UpdateCommand = New SqlClient.SqlCommand("UpdateCase", sc)
            sda.UpdateCommand.CommandType = CommandType.StoredProcedure

            sda.UpdateCommand.Parameters.Add("@id", SqlDbType.Int, 0, "id")
            sda.UpdateCommand.Parameters.Add("@Subject", SqlDbType.Char, 50, "Subject")
            sda.UpdateCommand.Parameters.Add("@ConsCode", SqlDbType.Char, 13, "ConsCode")
            sda.UpdateCommand.Parameters.Add("@Contract_Number", SqlDbType.Char, 15, "Contract_Number")
            sda.UpdateCommand.Parameters.Add("@Category", SqlDbType.Int, 0, "Category")
            sda.UpdateCommand.Parameters.Add("@Sub_Category", SqlDbType.Int, 0, "Sub_Category")
            sda.UpdateCommand.Parameters.Add("@Status", SqlDbType.Int, 0, "Status")
            sda.UpdateCommand.Parameters.Add("@Note", SqlDbType.Char, 250, "Note")
            sda.UpdateCommand.Parameters.Add("@Brokerage", SqlDbType.Char, 50, "Brokerage")

            sc.Open()
            sda.Fill(ds, "Cases")

            Dim dt As DataTable = ds.Tables(0)

            Dim CurrRow As DataRow = dt.Rows(0)
            CurrRow("Subject") = sSubject
            CurrRow("ConsCode") = sConsCd
            CurrRow("Contract_Number") = sConNo
            CurrRow("Category") = iCat
            CurrRow("Sub_Category") = iSubCat
            CurrRow("Note") = sNote
            CurrRow("Brokerage") = sBrokerage
            If iStatus > 0 Then
                CurrRow("Status") = iStatus
            End If

            sda.Update(ds, "Cases")

            sc.Close()
        End If

        Return iID
    End Function

    Public Function UpdateWFKey(ByVal iID As Integer, ByVal iWFId As Integer) As Integer

        Dim sc As New SqlClient.SqlConnection
        sc = GetSqlConnection()
        Dim ds As New DataSet
        Dim sda As New SqlClient.SqlDataAdapter("select id, WFId, Status from Cases where id = " & iID, sc)

        sda.UpdateCommand = New SqlClient.SqlCommand("UpdateWFId", sc)
        sda.UpdateCommand.CommandType = CommandType.StoredProcedure

        sda.UpdateCommand.Parameters.Add("@id", SqlDbType.Int, 0, "id")
        sda.UpdateCommand.Parameters.Add("@WFId", SqlDbType.Int, 0, "WFId")
        sda.UpdateCommand.Parameters.Add("@Status", SqlDbType.Int, 0, "Status")

        sc.Open()
        sda.Fill(ds, "Cases")

        Dim dt As DataTable = ds.Tables(0)

        Dim CurrRow As DataRow = dt.Rows(0)
        CurrRow("WFId") = iWFId
        CurrRow("Status") = 2

        sda.Update(ds, "Cases")

        sc.Close()
    End Function

    Public Function UpdateStatus(ByVal iID As Integer, ByVal iStatus As Integer) As Integer

        Dim sc As SqlClient.SqlConnection
        sc = GetSqlConnection()
        Dim ds As New DataSet
        Dim sda As New SqlClient.SqlDataAdapter("select id, Status from Cases where id = " & iID, sc)

        sda.UpdateCommand = New SqlClient.SqlCommand("UpdateStatus", sc)
        sda.UpdateCommand.CommandType = CommandType.StoredProcedure

        sda.UpdateCommand.Parameters.Add("@id", SqlDbType.Int, 0, "id")
        sda.UpdateCommand.Parameters.Add("@Status", SqlDbType.Int, 0, "Status")

        sc.Open()
        sda.Fill(ds, "Cases")

        Dim dt As DataTable = ds.Tables(0)

        Dim CurrRow As DataRow = dt.Rows(0)
        CurrRow("Status") = iStatus

        sda.Update(ds, "Cases")

        sc.Close()
    End Function


    <Ajax.AjaxMethod()> Public Function A_Test() As Boolean
        Return 1
    End Function

    Public Function GetSqlConnection() As SqlClient.SqlConnection

        'Dim regVersion As RegistryKey
        'Dim keyValue As String
        'keyValue = "Software\\Microsoft\\TestApp\\1.0"
        'regVersion = Registry.CurrentUser.OpenSubKey(keyValue, False)
        'Dim intVersion As Integer = 0
        'If (Not regVersion Is Nothing) Then
        '    intVersion = regVersion.GetValue("Version", 0)
        '    regVersion.Close()
        'End If

        'DEBUG - dev
        'Prod
        Dim sc As New SqlClient.SqlConnection("packet size=4096;user id=blueprintlogin;Password=blueprintlogin;data source=""BPSV1"";persist security info=False;initial catalog=BPOFF")
        'PreProd
        'Dim sc As New SqlClient.SqlConnection("packet size=4096;user id=blueprintlogin;Password=blueprintlogin;data source=""SQL-BKP"";persist security info=False;initial catalog=BPOFF")
        'BPDEV2
        'Dim sc As New SqlClient.SqlConnection("packet size=4096;user id=blueprintlogin;Password=blueprintlogin;data source=""BPDEV2"";persist security info=False;initial catalog=BPOFF")
        'blueprnt-dev1
        'Dim sc As New SqlClient.SqlConnection("packet size=4096;user id=blueprintlogin;Password=blueprintlogin;data source=""SQLv01"";persist security info=False;initial catalog=BPOFF")
        Return sc
    End Function

    <Ajax.AjaxMethod()> Public Function A_GetList(ByVal iFuncTp As Integer, ByVal sUACFId As String, ByVal sConsultantCode As String) As String

        Select Case iFuncTp
            Case 1
                Dim sda As New SqlClient.SqlDataAdapter("select * from Cases where UACFId = '" & sUACFId & "' and Status = " & iFuncTp, GetSqlConnection())
                Dim ds As New DataSet
                sda.Fill(ds, "Case")
                Return (ds.GetXml)
            Case 2, 3, 4, 5
                Dim wsMK_PSE As New wsMindKey.PrimaryServiceEntry
                Dim sPSE_XML As String
                Dim sResult As String
                Dim sListTp As String
                If iFuncTp = 2 Then
                    sListTp = "= 'Open.Running'"
                ElseIf iFuncTp = 3 Then
                    sListTp = "like 'Open.NotRunning%'"
                Else
                    sListTp = "= 'Closed.NotRunning.Completed'"
                End If
                wsMK_PSE.SecurityContextValue = GetSecurityContext()
                sPSE_XML = GetXMLMessageHdr()
                sPSE_XML = sPSE_XML & "<WfMessageHeader/>"
                sPSE_XML = sPSE_XML & "<WfMessageBody>"
                sPSE_XML = sPSE_XML & "<GetCaseList.Request StartImmediately=""True"">"
                If sUACFId > "" Then
                    sPSE_XML = sPSE_XML & "<Parameter><Name>UACF_ID</Name><Value>" & sUACFId & "</Value></Parameter>"
                Else
                    sPSE_XML = sPSE_XML & "<Parameter><Name>CONSULTANT_CODE</Name><Value>" & sConsultantCode & "</Value></Parameter>"
                End If
                sPSE_XML = sPSE_XML & "<Parameter><Name>STATUS</Name><Value>" & sListTp & "</Value></Parameter>"
                If iFuncTp = 5 Then
                    sPSE_XML = sPSE_XML & "<Parameter><Name>OLD_LIST</Name><Value>TRUE</Value></Parameter>"
                End If
                sPSE_XML = sPSE_XML & "</GetCaseList.Request>"
                sPSE_XML = sPSE_XML & "</WfMessageBody>"
                sPSE_XML = sPSE_XML & GetXMLMessageFtr()
                sResult = wsMK_PSE.ServiceRequest(sPSE_XML)

                Return (sResult)
        End Select
    End Function

    <Ajax.AjaxMethod()> Public Function A_GetComments(ByVal iID As Integer, ByVal iWFID As Integer) As String
        Dim sda As New SqlClient.SqlDataAdapter("select Note from Cases where id = " & iID, GetSqlConnection())
        Dim ds As New DataSet
        If iWFID = 0 Then
            sda.Fill(ds, "Comment")
            Return ds.GetXml
        Else
            Dim wsMK_PSE As New wsMindKey.PrimaryServiceEntry
            Dim sPSE_XML As String
            Dim sResult As String

            wsMK_PSE.SecurityContextValue = GetSecurityContext()
            sPSE_XML = GetXMLMessageHdr()
            sPSE_XML = sPSE_XML & "<WfMessageHeader><Key>" & iWFID & "</Key></WfMessageHeader>"
            sPSE_XML = sPSE_XML & "<WfMessageBody>"
            sPSE_XML = sPSE_XML & "<GetCaseComments.Request StartImmediately=""True"">"
            sPSE_XML = sPSE_XML & "<ProcessingInstanceKey>" & iID & "</ProcessingInstanceKey>"
            sPSE_XML = sPSE_XML & "</GetCaseComments.Request>"
            sPSE_XML = sPSE_XML & "</WfMessageBody>"
            sPSE_XML = sPSE_XML & GetXMLMessageFtr()
            Return wsMK_PSE.ServiceRequest(sPSE_XML)
        End If
    End Function

    <Ajax.AjaxMethod()> Public Function A_Save(ByVal iID As Integer, ByVal sConNo As String, ByVal sUACFId As String, ByVal sConsCd As String, ByVal sSubject As String, ByVal iCat As Integer, ByVal iSubCat As Integer, ByVal sNote As String, ByVal iStatus As Integer, ByVal sBrokerage As String)
        Return Save(iID, sConNo, sUACFId, sConsCd, sSubject, iCat, iSubCat, sNote, iStatus, sBrokerage)
    End Function

    Public Function AddComment(ByVal iID As Integer, ByVal iWFID As Integer, ByVal sNote As String, ByVal sUSERID As String) As String

        Dim wsMK_PSE As New wsMindKey.PrimaryServiceEntry
        Dim sPSE_XML As String
        Dim sResult As String

        wsMK_PSE.SecurityContextValue = GetSecurityContext()
        sPSE_XML = GetXMLMessageHdr()
        sPSE_XML = sPSE_XML & "<WfMessageHeader><Key>" & iWFID & "</Key></WfMessageHeader>"
        sPSE_XML = sPSE_XML & "<WfMessageBody>"
        sPSE_XML = sPSE_XML & "<ProcessInstanceStateChanged.Request StartImmediately=""True"">"
        sPSE_XML = sPSE_XML & "<ProcessingInstanceKey>" & iID & "</ProcessingInstanceKey>"
        sPSE_XML = sPSE_XML & "<ResultData>"
        sPSE_XML = sPSE_XML & "<Parameter><Name>COMMENTS</Name><Value>" & sNote & "</Value></Parameter>"
        sPSE_XML = sPSE_XML & "<Parameter><Name>USERNAME</Name><Value>" & sUSERID & "</Value></Parameter>"
        sPSE_XML = sPSE_XML & "</ResultData>"
        sPSE_XML = sPSE_XML & "</ProcessInstanceStateChanged.Request>"
        sPSE_XML = sPSE_XML & "</WfMessageBody>"
        sPSE_XML = sPSE_XML & GetXMLMessageFtr()
        sResult = wsMK_PSE.ServiceRequest(sPSE_XML)
        Return sResult

    End Function

    Public Function SendToTeam(ByVal iID As Integer, ByVal iWFID As Integer, ByVal sUSERID As String) As String

        Dim wsMK_PSE As New wsMindKey.PrimaryServiceEntry
        Dim sPSE_XML As String
        Dim sResult As String

        wsMK_PSE.SecurityContextValue = GetSecurityContext()
        sPSE_XML = GetXMLMessageHdr()
        sPSE_XML = sPSE_XML & "<WfMessageHeader><Key>" & iWFID & "</Key></WfMessageHeader>"
        sPSE_XML = sPSE_XML & "<WfMessageBody>"
        sPSE_XML = sPSE_XML & "<AssignToTeam.Request StartImmediately=""True"">"
        sPSE_XML = sPSE_XML & "<ProcessingInstanceKey>" & iID & "</ProcessingInstanceKey>"
        sPSE_XML = sPSE_XML & "<Parameter><Name>USERNAME</Name><Value>" & sUSERID & "</Value></Parameter>"
        sPSE_XML = sPSE_XML & "</AssignToTeam.Request>"
        sPSE_XML = sPSE_XML & "</WfMessageBody>"
        sPSE_XML = sPSE_XML & GetXMLMessageFtr()
        sResult = wsMK_PSE.ServiceRequest(sPSE_XML)

    End Function

    Public Function ChangeState(ByVal iID As Integer, ByVal iWFID As Integer, ByVal sNote As String, ByVal iState As Integer, ByVal sUSERID As String) As String

        Dim wsMK_PSE As New wsMindKey.PrimaryServiceEntry
        Dim sPSE_XML As String
        Dim sResult As String

        wsMK_PSE.SecurityContextValue = GetSecurityContext()
        sPSE_XML = GetXMLMessageHdr()
        sPSE_XML = sPSE_XML & "<WfMessageHeader><Key>" & iWFID & "</Key></WfMessageHeader>"
        sPSE_XML = sPSE_XML & "<WfMessageBody>"
        sPSE_XML = sPSE_XML & "<ChangeProcessInstanceState.Request StartImmediately=""True"">"
        sPSE_XML = sPSE_XML & "<ProcessingInstanceKey>" & iID & "</ProcessingInstanceKey>"
        sPSE_XML = sPSE_XML & "<Parameter><Name>COMMENTS</Name><Value>" & sNote & "</Value></Parameter>"
        sPSE_XML = sPSE_XML & "<Parameter><Name>USERNAME</Name><Value>" & sUSERID & "</Value></Parameter>"
        sPSE_XML = sPSE_XML & "<State>"
        If iState = 2 Then
            sPSE_XML = sPSE_XML & "<Open.Running/>"
            UpdateStatus(iID, iState)
        ElseIf iState = 3 Then
            sPSE_XML = sPSE_XML & "<Open.NotRunning/>"
            UpdateStatus(iID, iState)
        ElseIf iState = 4 Then
            sPSE_XML = sPSE_XML & "<Closed.NotRunning.Completed/>"
            UpdateStatus(iID, iState)
        End If
        sPSE_XML = sPSE_XML & "</State>"
        sPSE_XML = sPSE_XML & "</ChangeProcessInstanceState.Request>"
        sPSE_XML = sPSE_XML & "</WfMessageBody>"
        sPSE_XML = sPSE_XML & GetXMLMessageFtr()
        sResult = wsMK_PSE.ServiceRequest(sPSE_XML)
        Return sResult

    End Function

    <Ajax.AjaxMethod()> Public Function A_AddComment(ByVal iID As Integer, ByVal iWFID As Integer, ByVal sNote As String, ByVal sUSERID As String)
        Return AddComment(iID, iWFID, sNote, sUSERID)
    End Function

    <Ajax.AjaxMethod()> Public Function A_AddCommentAndChangeState(ByVal iID As Integer, ByVal iWFID As Integer, ByVal sNote As String, ByVal iState As Integer, ByVal sUSERID As String)
        'AddComment(iID, iWFID, sNote, sUSERID)
        ChangeState(iID, iWFID, sNote, iState, sUSERID)
        Return sNote
    End Function

    <Ajax.AjaxMethod()> Public Function A_AddCommentAndReAssign(ByVal iID As Integer, ByVal iWFID As Integer, ByVal sNote As String, ByVal iState As Integer, ByVal sUSERID As String)
        AddComment(iID, iWFID, sNote, sUSERID)
        SendToTeam(iID, iWFID, sUSERID)
        UpdateStatus(iID, 2)
        Return 0
    End Function

    <Ajax.AjaxMethod()> Public Function A_Unnasigned_Delete(ByVal iID As Integer)

        Dim sc As SqlClient.SqlConnection
        sc = GetSqlConnection()
        Dim ds As New DataSet
        Dim sda As New SqlClient.SqlDataAdapter("select id from Cases where id = " & iID, sc)

        sda.DeleteCommand = New SqlClient.SqlCommand("DeleteCase", sc)
        sda.DeleteCommand.CommandType = CommandType.StoredProcedure
        sda.DeleteCommand.Parameters.Add("@id", SqlDbType.Int, 0, "id")

        sc.Open()
        sda.Fill(ds, "Cases")

        Dim dt As DataTable = ds.Tables(0)

        Dim CurrRow As DataRow = dt.Rows(0)
        CurrRow.Delete()
        sda.Update(ds, "Cases")

        sc.Close()
        Return iID
    End Function

    <Ajax.AjaxMethod()> Public Function A_SaveAndSend(ByVal iID As Integer, ByVal sConNo As String, ByVal sUACFId As String, ByVal sConsCd As String, ByVal sSubject As String, ByVal iCat As Integer, ByVal sCat As String, ByVal iSubCat As Integer, ByVal sSubCat As String, ByVal sNote As String, ByVal iStatus As Integer, ByVal sBrokerage As String)

        Dim wsMK_PSE As New wsMindKey.PrimaryServiceEntry
        Dim sPSE_XML As String
        Dim sResult As String
        Dim sMKSubCat As String

        Try

            iID = Save(iID, sConNo, sUACFId, sConsCd, sSubject, iCat, iSubCat, sNote, 1, sBrokerage)

            wsMK_PSE.SecurityContextValue = GetSecurityContext()

            sPSE_XML = GetXMLMessageHdr()
            sPSE_XML = sPSE_XML & "<WfMessageHeader><Key>" & iID & "</Key></WfMessageHeader>"
            sPSE_XML = sPSE_XML & "<WfMessageBody>"
            sPSE_XML = sPSE_XML & "<CreateProcessInstance.Request StartImmediately=""True"">"
            sPSE_XML = sPSE_XML & "<ContextData>"
            'Mindkey (sometimes) require a different description to the one we use, set that up here

            If sSubCat = "" Then
                sSubCat = sCat & "." & sSubCat
            End If

            'Mindkey (sometimes) require a different description to the one we use, set that up here
            sMKSubCat = sSubCat
            Select Case sMKSubCat
                Case "Apply for a new code"
                    sMKSubCat = "ACTIVATION"
                Case "Terminate a code"
                    sMKSubCat = "TERMINATION"
                Case "Transfer code"
                    sMKSubCat = "TRANSFER"
                Case "Amend current code details"
                    sMKSubCat = "MAINTENANCE"
                Case "Agency Commissions"
                    sMKSubCat = "AGENCY"
                Case "Broker Commissions"
                    sMKSubCat = "BROKER"
                Case "Franchise Commissions"
                    sMKSubCat = "FRANCHISE"
            End Select

            sPSE_XML = sPSE_XML & "<Parameter><Name>ProcessName</Name><Value>" & sMKSubCat & "</Value></Parameter>"
            sPSE_XML = sPSE_XML & "<Parameter><Name>CONTRACT_NUMBER</Name><Value>" & sConNo & "</Value></Parameter>"
            sPSE_XML = sPSE_XML & "<Parameter><Name>CREATEDBY</Name><Value>" & sUACFId & "</Value></Parameter>"
            sPSE_XML = sPSE_XML & "<Parameter><Name>CONSULTANT_CODE</Name><Value>" & sConsCd & "</Value></Parameter>"
            sPSE_XML = sPSE_XML & "<Parameter><Name>CUSTOM</Name><Value><SUBJECT>" & sSubject & "</SUBJECT><CATEGORY>" & sCat & "</CATEGORY></Value></Parameter>"
            sPSE_XML = sPSE_XML & "<Parameter><Name>Comments</Name><Value>" & sNote & "</Value></Parameter>"
            sPSE_XML = sPSE_XML & "<Parameter><Name>BROKERAGE</Name><Value>" & sBrokerage & "</Value></Parameter>"
            sPSE_XML = sPSE_XML & "</ContextData>"
            sPSE_XML = sPSE_XML & "</CreateProcessInstance.Request>"
            sPSE_XML = sPSE_XML & "</WfMessageBody>"
            sPSE_XML = sPSE_XML & GetXMLMessageFtr()
            sResult = wsMK_PSE.ServiceRequest(sPSE_XML)

            Dim doc As New XmlDocument
            doc.LoadXml(sResult)
            Dim sPIKey As String
            Dim node As XmlNode
            Dim root As XmlNode = doc.DocumentElement
            node = root.SelectSingleNode("//WfMessageBody/CreateProcessInstance.Response/ProcessingInstanceKey")
            sPIKey = node.InnerText

            UpdateWFKey(iID, sPIKey)
            sResult = SendToTeam(iID, sPIKey, sUACFId)

            Return sResult

        Catch e As Exception
            'node = root.SelectSingleNode("//WfMessageBody/Exception/Subject")
            Return Err.Number & " - " & Err.Description
        End Try

    End Function

End Class
