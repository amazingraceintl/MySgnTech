* @ValidationCode : MjoxNDczNDc5MjU4OkNwMTI1MjoxNzA2NzgzMzcwMTUxOlBldGVyOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIyX1NQOS4wOi0xOi0x
* @ValidationInfo : Timestamp         : 01 Feb 2024 11:29:30
* @ValidationInfo : Encoding          : Cp1252
* @ValidationInfo : User Name         : Peter
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : R22_SP9.0
* @ValidationInfo : Copyright Temenos Headquarters SA 1993-2021. All rights reserved.
$PACKAGE TUCOOP.TRANSUNION
SUBROUTINE SGNT.TU.ONLINE.PROCESS(keyId)
    $INSERT I_F.EB.TU.CREDIT.REPORT
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------


* keyId = <Customer ID> * <EM.LO.APPLICATION ID>
    
    $USING EB.DataAccess
    $USING ST.Customer
    $USING EM.LoanOrigination
    $USING EB.Foundation
    $USING EB.API
    $USING EB.Interface
    $USING EB.LocalReferences
    $USING EB.SystemTables
    

    fnLnAppl = TUCOOP.TRANSUNION.getFnLoanApplFile()
    fvLnAppl = TUCOOP.TRANSUNION.getFvLoanApplFile()
    
    cusId = FIELD(keyId,'*',1)
    loanApplId = FIELD(keyId,'*',2)
    
    IF cusId AND loanApplId THEN
        GOSUB ExtCusDets
        
    END
    
RETURN

ExtCusDets:
    cusRec = ST.Customer.Customer.Read(cusId, cusError)
    IF cusRec THEN

        cusFirstName = cusRec<ST.Customer.Customer.EbCusNameOne>
        cusMiddleName = cusRec<ST.Customer.Customer.EbCusNameTwo>
        cusLastName = cusRec<ST.Customer.Customer.EbCusShortName>
        cusBuildingName = cusRec<ST.Customer.Customer.EbCusStreet>
        cusBuildingNo = cusRec<ST.Customer.Customer.EbCusBuildingNumber>
        cusAddressType = cusRec<ST.Customer.Customer.EbCusAddressType>
        cusCountryDivision = cusRec<ST.Customer.Customer.EbCusCountrySubdivision>
        cusPoBoxNo = cusRec<ST.Customer.Customer.EbCusPoBoxNumber>
        cusDob = cusRec<ST.Customer.Customer.EbCusBirthIncorpDate>
*
        EB.LocalReferences.GetLocRef("CUSTOMER", "SUBURB.TOWN", CityTownPos)
        cusCityTown = cusRec<ST.Customer.Customer.EbCusLocalRef,CityTownPos>
*
        EB.LocalReferences.GetLocRef("CUSTOMER", "POSTAL.CODE", PostalCodePos)
        cusPostalCode = cusRec<ST.Customer.Customer.EbCusLocalRef,PostalCodePos>
*
        EB.LocalReferences.GetLocRef("CUSTOMER", "PROVINCE.STATE", ProvinceStatePos)
        cusState = cusRec<ST.Customer.Customer.EbCusLocalRef,ProvinceStatePos>
*
        DOB = cusRec<ST.Customer.Customer.EbCusBirthIncorpDate>
        DOB = DOB[1,4]:"-":DOB[5,2]:"-":DOB[7,2]
* Get Customer Type i.e. Individual Or Non Individual
        EB.LocalReferences.GetLocRef("CUSTOMER", "CUST.TYPE", CustTypePos)
        cusType = cusRec<ST.Customer.Customer.EbCusLocalRef,CustTypePos>
        BEGIN CASE
            CASE cusType EQ "I"
                customerType = "individual"
            CASE cusType EQ "NI"
                customerType = "Non Individual"
        END CASE
        
* Get Social Security Number from Customer application on Local Ref TUC.SSN
        EB.LocalReferences.GetLocRef("CUSTOMER", "TUC.SSN", ssnPos)
        cusSocialSecurity = cusRec<ST.Customer.Customer.EbCusLocalRef,ssnPos>
      
        sep = @FM
        cusDets = cusFirstName:sep                      ;*1
        cusDets:= cusMiddleName:sep                     ;*2
        cusDets:= cusLastName:sep                       ;*3
        cusDets:= cusBuildingName:sep                   ;*4
        cusDets:= cusBuildingNo:sep                     ;*5
        cusDets:= cusCityTown:sep                       ;*6
        cusDets:= cusState:sep                          ;*7
        cusDets:= cusPostalCode:sep                     ;*8
        cusDets:= cusSocialSecurity:sep                 ;*9
        cusDets:= DOB:sep                               ;*10
        cusDets:= customerType                          ;*11
        
        GOSUB ExtLoanApplDets
    END ELSE
        CRT 'Missing Customer ID - ':cusId
    
    END

RETURN

ExtLoanApplDets:
    
    EB.DataAccess.FRead(fnLnAppl, loanApplId, loanApplRec, fvLnAppl, loanErr)
    IF loanApplRec THEN
*
                
        TUCOOP.TRANSUNION.OnlineProcess(cusDets, response)
        respStatus = response["|",1,1]
        IF respStatus EQ "00" THEN
            

            GOSUB GetFileSummary
*
            GOSUB GetFicoScore
*
            GOSUB GetPersonNames
*
            GOSUB GetSocialSecurity
*
            GOSUB GetTotalSummary
*
            GOSUB UpdateCreditReport

        END
    END ELSE
        CRT 'Missing Loan Application ID - ':loanApplId
    END

    
RETURN

GetFicoScore:
    FicoScore = TUCOOP.TRANSUNION.GetFicoScore(response)
RETURN

GetPersonNames:
    AllNames = TUCOOP.TRANSUNION.GetPersonNames(response)
    FirstName = AllNames<1>
    MiddleName = AllNames<2>
    LastName = AllNames<3>
RETURN

GetFileSummary:
    fileHitIndicator = TUCOOP.TRANSUNION.GetFileSummary(response)
RETURN

GetSocialSecurity:
    SocialSecurity =  TUCOOP.TRANSUNION.GetSocialSecurity(response)
RETURN

GetTotalSummary:
    
    TUCOOP.TRANSUNION.GetTotalSummary(response, TotalInquiryCount, TotalHighCredit, TotalCreditLimit, TotalCurrentBalance, TotalPastDue, TotalMonthlyPayment)
RETURN

UpdateCreditReport:
    
    TerminationDate = ""
    spRecord<EB.TU.3.LOAN.ID>          = loanApplId
    spRecord<EB.TU.3.CUSTOMER.NUMBER>  = cusId
    spRecord<EB.TU.3.FICO.SCORE>       = FicoScore
    spRecord<EB.TU.3.FIRST.NAME>       = FirstName
    spRecord<EB.TU.3.MIDDLE.NAME>      = MiddleName
    spRecord<EB.TU.3.LAST.NAME>        = LastName
    spRecord<EB.TU.3.SOCIAL.SECURITY>  = SocialSecurity
    spRecord<EB.TU.3.FILE.HIT.INDICATOR>   = fileHitIndicator
    spRecord<EB.TU.3.TOTAL.INQUIRY.COUNT>  = TotalInquiryCount
    spRecord<EB.TU.3.TOTAL.HIGH.CREDIT>    = TotalHighCredit
    spRecord<EB.TU.3.TOTAL.CREDIT.LIMIT>   = TotalCreditLimit
    spRecord<EB.TU.3.TOTAL.CURRENT.BALANCE>  = TotalCurrentBalance
    spRecord<EB.TU.3.TOTAL.PAST.DUE>         = TotalPastDue
    spRecord<EB.TU.3.TOTAL.MONTHLY.PAYMENT>  = TotalMonthlyPayment
    
    appName = "EB.TU.CREDIT.REPORT"
    ofsFunc = "I"
    process = "PROCESS"
    versionName = "EB.TU.CREDIT.REPORT,OFS"
    refNumber = cusId:".":loanApplId
    gtsMode = ""
    noOfAuth = 0
    ofsReq = ""
    
    EB.Foundation.OfsBuildRecord(appName, ofsFunc, process, versionName, gtsMode, noOfAuth, refNumber, spRecord, ofsReq)
    ofsRes = "" ; result = "" ; statusCode = ""; statusCodeMsg = ""
    ofsSourceId = "GENERIC.OFS.PROCESS"
    
    EB.API.Ocomo("Posting OFS record for SGNT.TU.ONLINE.PROCESS... ST.TU.CREDIT.REPORT")
    
    EB.API.Ocomo("OFS Request : ":ofsReq)
    
    EB.Interface.OfsCallBulkManager(ofsSourceId, ofsReq, ofsRes, txnCommitted)
    
    EB.API.Ocomo("OFS Result : ":ofsRes)
    
    result = ofsRes[',',1,1]
    statusCode = result['/',3,1]

    IF statusCode < 0 THEN
        
        result = ofsRes[',',2,1]
        statusCodeMsg = result['=',2,1]

        IF statusCode = "-2" THEN       ;* Handle overrides
            temp1 = ofsRes['/',4,1]
            statusCodeMsg = temp1[19,40]
        END
    
        EB.API.Ocomo("OFS record posting FAILED. Error Msg:":statusCodeMsg)
      
    END ELSE

* Execute this when posted successfully.
       
        bankUniqueRef = ofsRes['/',1,1]
        
        EB.API.Ocomo("OFS record posted successfully in table ST.TU.CREDIT.REPORT. ID is: ":bankUniqueRef)

    END
    
    EB.API.Ocomo("Processng TRANSUNION ONLINE Process is COMPLETE...")
RETURN
END
