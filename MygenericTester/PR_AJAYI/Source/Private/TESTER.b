* @ValidationCode : MjotNTMzNjE2NDYxOkNwMTI1MjoxNzA2NzkzOTQ4MTYxOlBldGVyOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIyX1NQOS4wOi0xOi0x
* @ValidationInfo : Timestamp         : 01 Feb 2024 14:25:48
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
PROGRAM TESTER
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------

    DEBUG
    paramId = 'TRANSUNION'
    paramName = 'URL'
    paramValue =''

    CALL EB.LIB.GET.PARAM( paramId, paramName, paramValue, Error )
    
    CRT 'RESULT IS -': paramValue
    
RETURN(paramValue)
END
END
