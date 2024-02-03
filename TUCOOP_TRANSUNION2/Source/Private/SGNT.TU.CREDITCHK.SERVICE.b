* @ValidationCode : MjotMTEzMjg3NTcyNzpDcDEyNTI6MTcwNjk0NjU0MTM4NDpQZXRlcjotMTotMTowOjA6ZmFsc2U6Ti9BOlIyMl9TUDkuMDotMTotMQ==
* @ValidationInfo : Timestamp         : 03 Feb 2024 08:49:01
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
SUBROUTINE SGNT.TU.CREDITCHK.SERVICE
    $INSERT I_F.EB.TU.CREDIT.REPORT
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
    $USING EB.DataAccess
    $USING ST.Customer
    $USING EM.LoanOrigination
    $USING EB.Foundation
    $USING EB.API
    $USING EB.Interface
    $USING EB.ErrorProcessing
    $USING EB.LocalReferences
    $USING EB.SystemTables
       
    
    DEBUG
    Locdata = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.LocalRef)
    EB.LocalReferences.GetLocRef("EM.LO.APPLICATION", "LN.CRCHECKFALG", LncrFlagPos)
    DescValue = Locdata<1,LncrFlagPos>
        
    IF DescValue EQ 'YES' THEN
        GOSUB Init
    END ELSE
        RETURN
    END
RETURN
    
Init:
*====
*fnLnAppl = TUCOOP.TRANSUNION.getFnLoanApplFile()
*fvLnAppl = TUCOOP.TRANSUNION.getFvLoanApplFile()
    
    CreditSubjectIdArr = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.CcSubjectId)
    CreditOption  = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.CcOption)
 
    loanApplId = EB.SystemTables.getIdNew()
    Cred.Subj.Cnt = DCOUNT(CreditSubjectIdArr,@VM)
    FOR i = 1 TO Cred.Subj.Cnt
        CurrCredOption = FIELD(CreditOption,@VM, i)
        cusId = FIELD(CreditSubjectIdArr,@VM, i)
        IF CurrCredOption = 'YES' THEN
            GOSUB ExtCusDets
            IF i EQ 1 THEN
                Repo<-1> = FicoScore
            END ELSE
                Repo<-1> = FicoScore
            END
            FicoScore = ''
            GOSUB WriteCrChkActivity
        END
    NEXT i
RETURN

WriteCrChkActivity:
*================
    FOR ii = 1 TO Cred.Subj.Cnt
        setResultVal = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.CcResultId)
        setResultVal<1,ii> = Repo<ii>
        EB.SystemTables.setRNew(EM.LoanOrigination.LoApplication.CcResultId,setResultVal)
    NEXT ii
    
RETURN
    
ExtCusDets:
*=========
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
        
*  cusPostalCode = cusRec<ST.Customer.Customer.EbCusPostCode>
* cusCityTown = cusRec<ST.Customer.Customer.EbCusTownCountry>
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
                
        EB.LocalReferences.GetLocRef("CUSTOMER", "TIN.TYPE", tintypPos)
        cusTintype = cusRec<ST.Customer.Customer.EbCusLocalRef,tintypPos>
        IF cusTintype EQ 'S' THEN
            cusSocialSecurity = cusRec<ST.Customer.Customer.EbCusTaxId>
        END ELSE
            cusSocialSecurity = ''
        END
                 
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
*==============
    IF loanApplId THEN
        TUCOOP.TRANSUNION.OnlineProcess(cusDets, response)
        respStatus = response["|",1,1]
        IF respStatus EQ "00" THEN
            GOSUB GetFileSummary
            GOSUB GetFicoScore
            GOSUB GetPersonNames
            GOSUB GetSocialSecurity
            GOSUB GetTotalSummary
            GOSUB UpdateCreditReport
        END
    END ELSE
        CRT 'Missing Loan Application ID - ':loanApplId
    END
RETURN

GetFicoScore:
*==============
    FicoScore = TUCOOP.TRANSUNION.GetFicoScore(response)
RETURN

GetPersonNames:
*==============
    AllNames = TUCOOP.TRANSUNION.GetPersonNames(response)
    FirstName = AllNames<1>
    MiddleName = AllNames<2>
    LastName = AllNames<3>
RETURN

GetFileSummary:
*==============
    fileHitIndicator = TUCOOP.TRANSUNION.GetFileSummary(response)
RETURN

GetSocialSecurity:
*==============
    SocialSecurity =  TUCOOP.TRANSUNION.GetSocialSecurity(response)
RETURN

GetTotalSummary:
*==============
    TUCOOP.TRANSUNION.GetTotalSummary(response, TotalInquiryCount, TotalHighCredit, TotalCreditLimit, TotalCurrentBalance, TotalPastDue, TotalMonthlyPayment)
RETURN

UpdateCreditReport:
    loanApplIdKey = loanApplId:'.':cusId
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
    EB.DataAccess.FWrite('EB.TU.CREDIT.REPORT', loanApplIdKey, spRecord)
    
RETURN
END