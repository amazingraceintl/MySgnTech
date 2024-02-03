* @ValidationCode : Mjo5ODgwMTAxODQ6Q3AxMjUyOjE3MDY3NzcwMjY5ODQ6UGV0ZXI6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjJfU1A5LjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 01 Feb 2024 09:43:46
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
FUNCTION SGNT.GET.FICOSCORE(xmlpayload)
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------

*       Get <scoreModel>
    parsedResp = TUCOOP.TRANSUNION.ParseXml("<scoreModel>", "</scoreModel>", xmlpayload)
*       Get <score>
    parsedResp = TUCOOP.TRANSUNION.ParseXml("<score>", "</score>", parsedResp)
*       Get <results> - Fico Score
    parsedResp = TUCOOP.TRANSUNION.ParseXml("<results>", "</results>", parsedResp)
    
    ficoScore = parsedResp
RETURN ficoScore
END
