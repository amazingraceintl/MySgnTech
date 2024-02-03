* @ValidationCode : MjotODg5MDc5NjM4OkNwMTI1MjoxNzA2Nzc4OTkxNTUwOlBldGVyOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIyX1NQOS4wOi0xOi0x
* @ValidationInfo : Timestamp         : 01 Feb 2024 10:16:31
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
FUNCTION SGNT.GET.FILE.SUMMARY(xmlpayload)
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
*       Get <fileSummary>
    parsedResp = TUCOOP.TRANSUNION.ParseXml("<fileSummary>", "</fileSummary>", xmlpayload)
    
*       Get <fileHitIndicator>
    parsedResp = TUCOOP.TRANSUNION.ParseXml("<fileHitIndicator>", "</fileHitIndicator>", parsedResp)
    
    fileHitIndicator = parsedResp
RETURN fileHitIndicator
END
