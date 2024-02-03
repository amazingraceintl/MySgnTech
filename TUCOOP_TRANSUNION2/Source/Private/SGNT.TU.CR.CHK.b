* @ValidationCode : MjoxOTc0NTExOTk3OkNwMTI1MjoxNzA2NzkyMTUyMjYxOlBldGVyOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIyX1NQOS4wOi0xOi0x
* @ValidationInfo : Timestamp         : 01 Feb 2024 13:55:52
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
SUBROUTINE SGNT.TU.CR.CHK
    $USING EB.SystemTables
    $USING EM.LoanOrigination
    $USING EB.DataAccess
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
    GOSUB Init
RETURN


Init:
*Fileid = 'F.SGNT.TU.ONLINE.PROCESS.LIST'
*  CreditSubjectIdArr = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.EloaCcSubjectId)
* CreditOption  = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.EloaCcOption)
    
    CreditSubjectIdArr = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.CcSubjectId)
    CreditOption  = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.CcOption)
    
    
    
    
 
    LoanApplId = EB.SystemTables.getIdNew()
    
    Cred.Subj.Cnt = DCOUNT(CreditSubjectIdArr,@VM)
    
    FOR i = 1 TO Cred.Subj.Cnt
        CurrCredOption = FIELD(CreditOption,@VM, i)
        IF CurrCredOption = 'YES' THEN
            CreditSubject = FIELD(CreditSubjectIdArr,@VM, i)
            GOSUB WriteCrChkActivity
        END
    NEXT i
RETURN

WriteCrChkActivity:
    
    Vkey = CreditSubject:'*':LoanApplId
    Rec = Vkey
    EB.DataAccess.FWrite('F.SGNT.TU.ONLINE.PROCESS.LIST', Vkey, Rec)
   
RETURN
END