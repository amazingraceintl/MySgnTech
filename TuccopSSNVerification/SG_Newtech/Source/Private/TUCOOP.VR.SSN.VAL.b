* @ValidationCode : MjotMTk3NjgwNzgwNjpJU08tODg1OS0xOjE3MDY2MzY2Njc5MjU6UGV0ZXI6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjBfU1AyLjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 30 Jan 2024 18:44:27
* @ValidationInfo : Encoding          : ISO-8859-1
* @ValidationInfo : User Name         : Peter
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : R20_SP2.0
* EB.SystemTables.setEtext(Value)
$PACKAGE SG.Newtech
SUBROUTINE TUCOOP.VR.SSN.VAL
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
    $USING EB.DataAccess
    $USING EB.Foundation
    $USING EB.TransactionControl
    $USING EB.ErrorProcessing
    $USING EB.API
    $USING EB.SystemTables
    $USING ST.CompanyCreation
    $USING ST.Customer
    $USING EB.Updates
    
    GOSUB Init
    GOSUB Proceed
    IF tinType EQ 'S' THEN
        GOSUB GetTransUnionServer
    END ELSE
        RETURN
    END
RETURN
    
Init:
*====
    UNQ.NO = ""
    EB.API.AllocateUniqueTime(UNQ.NO)
    UNQ.NO = EREPLACE(UNQ.NO,".","")
    SESSION.ID = UNQ.NO[1,12]
    CusNo = EB.SystemTables.getIdNew()
    F.Folder = ''
    OpIdreq = CusNo:'-':SESSION.ID:'-request.txt'
                         
    className = 'EntryPoint' ; methodName = 'Sender' ;  mypackage = 'com.temenos.sgtech' ; ApiId = 'SGNT.INTERFACE'
    FN.Ssn.Param = 'F.EB.SSN.VERIFICATION.PARAM' ; F.Ssn.Param = ''
    ParamID = 'SYSTEM' ; Err = '' ; ParamRec = ''
    EB.DataAccess.Opf(FN.Ssn.Param, F.Ssn.Param)
    EB.DataAccess.FRead(FN.Ssn.Param,ParamID,ParamRec,F.Ssn.Param,Err)
    ApplArr = 'CUSTOMER'
    FieldnameArr= "CITY":@VM:"US.STATE":@VM:"TIN.TYPE"
    PosArr = ''
    
    EB.Updates.MultiGetLocRef(ApplArr, FieldnameArr, PosArr)
    CityPos = PosArr<1,1> ; StatePos = PosArr<1,2> ; TinTypePos = PosArr<1,3>
    
    EB.API.GetStandardSelectionDets(ApplArr,R.SS)
    LOCATE "LOCAL.REF" IN R.SS<EB.SystemTables.StandardSelection.SslSysFieldName,1> SETTING POSL12 THEN
        YR.SYS.NO = R.SS<EB.SystemTables.StandardSelection.SslSysFieldNo,POSL12>
    END
    city = EB.SystemTables.getRNew(YR.SYS.NO)<1,CityPos>
    state = EB.SystemTables.getRNew(YR.SYS.NO)<1,StatePos>
    tinType = EB.SystemTables.getRNew(YR.SYS.NO)<1,TinTypePos>
        
RETURN

Proceed:
*======
    FirstName = EB.SystemTables.getRNew(ST.Customer.Customer.EbCusGivenNames)
    LastName = EB.SystemTables.getRNew(ST.Customer.Customer.EbCusFamilyName)
    PostalCode = EB.SystemTables.getRNew(ST.Customer.Customer.EbCusPostCode)
    DOB = EB.SystemTables.getRNew(ST.Customer.Customer.EbCusDateOfBirth)
    Address1 = EB.SystemTables.getRNew(ST.Customer.Customer.EbCusStreet)
    Address2 = EB.SystemTables.getRNew(ST.Customer.Customer.EbCusTownCountry)
    CountryCode = EB.SystemTables.getRNew(ST.Customer.Customer.EbCusResidence)
    Address3 = ''
    DateOfBirth = DOB[5,2]:'/':DOB[7,8]:'/':DOB[1,4]
    
    IF tinType EQ 'S' THEN
        SSN = EB.SystemTables.getRNew(ST.Customer.Customer.EbCusTaxId)
    END ELSE
        SSN = ''
    END
    TUsername = ParamRec<1>
    TPassword = ParamRec<2>
    TSecret   = ParamRec<3>
    SessionUrl= ParamRec<4>
    CaseUrl   = ParamRec<5>
    TokenUrl  = ParamRec<6>
    DetDecUrl = ParamRec<7>
    PublicKey = ParamRec<8>
    BlackBox  = ParamRec<9>
    Ipdesc = ParamRec<20>
    IpAddress = ParamRec<21>
    Fn.Folder= ParamRec<22>
        
    IF Ipdesc EQ 'YES' THEN
        Ipval = IpAddress
    END ELSE
        Ipval = '0'
    END
    
    Request =  TUsername:'^':TPassword:'^':TSecret:'^'
    Request :=+ SessionUrl:'^':CaseUrl:'^':TokenUrl:'^'
    Request :=+ DetDecUrl:'^':PublicKey:'^':Address1:'^':Address2:'^^':city:'^':CountryCode
    Request :=+ '^':FirstName:'^':LastName:'^':PostalCode:'^':state:'^':SSN:'^':DateOfBirth:'^':BlackBox:'^':Ipval
    param = Request
    Log.Message = 'Request Sent = ':param:'==============================='
RETURN

OpenLogFile:
    OPENSEQ Fn.Folder,OpIdreq TO ReqFolder THEN
        OPEN.FLAG = 1
        WEOFSEQ ReqFolder
    END ELSE
        CREATE ReqFolder ELSE
            EB.ErrorProcessing.FatalError("ERROR OPENING FILE POINTER TO ":ReqFolder)
            RETURN
        END
    END
RETURN

ErrorDetails:
    EB.SystemTables.setAf(ST.Customer.Customer.EbCusTaxId)
    EB.SystemTables.setEtext("EB.ERROR- SSN ": Errorlogmsg)
    FMT.ETEXT = Y.STATUS.DESC[9,999]
    EB.ErrorProcessing.StoreEndError()
    
    
RETURN

GetTransUnionServer:
*==================
    IF SSN NE '' THEN
        EB.SystemTables.CallJavaApi(ApiId,param,TResponse,TError)
        CRT 'OUTPUT FROM TRANSUNION IS ... ':TResponse
        BEGIN CASE
            CASE TResponse EQ "2"
                Errorlogmsg = 'This SSN Has Been Flagged'
                GOSUB ErrorDetails
            CASE TResponse EQ "3"
                Errorlogmsg = 'SSN Verification Failed'
                GOSUB ErrorDetails
            CASE TResponse EQ "java.lang.reflect.InvocationTargetException"
                Errorlogmsg = 'Verification Mandatory fields Incomplete'
                GOSUB ErrorDetails
        END CASE
     
        GOSUB OpenLogFile
        Log.Message :=+ 'Response Received= ':TResponse
        WRITESEQ Log.Message TO ReqFolder ELSE
            EB.ErrorProcessing.FatalError("ERROR WRITING INTO FILE ":OUT.REC)
        END
    END ELSE
        Y.STATUS.DESC = 'Input Social Security Number'
        EB.SystemTables.setAf(ST.Customer.Customer.EbCusTaxId)
        EB.SystemTables.setEtext("EB.ERROR-":Y.STATUS.DESC)
        FMT.ETEXT = Y.STATUS.DESC[9,999]
        EB.ErrorProcessing.StoreEndError()
    END
RETURN

END