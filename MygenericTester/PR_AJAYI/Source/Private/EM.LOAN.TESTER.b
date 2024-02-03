* @ValidationCode : MjoxMDQyODcyMzg1OkNwMTI1MjoxNzA2ODYwMDc4MjQxOlBldGVyOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIyX1NQOS4wOi0xOi0x
* @ValidationInfo : Timestamp         : 02 Feb 2024 08:47:58
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
$PACKAGE PR.AJAYI
SUBROUTINE EM.LOAN.TESTER
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------

    $USING EB.SystemTables
    $USING EM.LoanOrigination
    $USING EB.DataAccess

    GOSUB Init
    
RETURN


Init:
    CreditSubjectIdArr = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.CcSubjectId)
    CreditOption  = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.CcOption)
    LoanApplId = EB.SystemTables.getIdNew()
    
    Cred.Subj.Cnt = DCOUNT(CreditSubjectIdArr,@VM)
    
    FOR i = 1 TO Cred.Subj.Cnt
        CurrCredOption = FIELD(CreditOption,@VM, i)
        IF CurrCredOption = 'YES' THEN
            IF i EQ 1 THEN
                Repo<-1> = 20
            END ELSE
                Repo<-1> = 40
            END
            GOSUB WriteCrChkActivity
        END
    NEXT i
RETURN

WriteCrChkActivity:
    FOR ii = 1 TO Cred.Subj.Cnt
        setResultVal = EB.SystemTables.getRNew(EM.LoanOrigination.LoApplication.CcResultId)
        setResultVal<1,ii> = Repo<ii>
        EB.SystemTables.setRNew(EM.LoanOrigination.LoApplication.CcResultId,setResultVal)
    NEXT ii
    
RETURN
END
