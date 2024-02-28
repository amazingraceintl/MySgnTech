* @ValidationCode : MjotMzE3NTY1OTQ6Q3AxMjUyOjE3MDcyMDU3NDgwMjA6UGV0ZXI6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjJfU1A5LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 06 Feb 2024 08:49:08
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
