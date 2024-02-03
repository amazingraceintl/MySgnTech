* @ValidationCode : MjoxMjkxMzY5NDUwOkNwMTI1MjoxNjU3MjI2MTIxODA4Omt1ZHphbmFpLm1hc2l3YTotMTotMTowOjE6ZmFsc2U6Ti9BOlIyMF9TUDI5LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 07 Jul 2022 22:35:21
* @ValidationInfo : Encoding          : Cp1252
* @ValidationInfo : User Name         : kudzanai.masiwa
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : true
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : R20_SP29.0
$PACKAGE TUCOOP.TRANSUNION
SUBROUTINE SGNT.TU.ONLINE.PROCESS.LOAD
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History : 
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
    $USING EB.DataAccess

    fnCreditChkAct = 'F.SGNT.TU.ONLINE.PROCESS.LIST'
    fCreditChkAct = ''
    EB.DataAccess.Opf(fnCreditChkAct, fCreditChkAct)


    FN.LN.APPL = 'F.EM.LO.APPLICATION'
    FV.LN.APPL = ''
    EB.DataAccess.Opf(FN.LN.APPL, FV.LN.APPL)
    
    TUCOOP.TRANSUNION.setFnLoanApplFile(FN.LN.APPL)
    TUCOOP.TRANSUNION.setFvLoanApplFile(FV.LN.APPL)
    
    
RETURN
END
