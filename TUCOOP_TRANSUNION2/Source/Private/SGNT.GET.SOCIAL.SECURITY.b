* @ValidationCode : MjotMjg4NTk5NDE3OkNwMTI1MjoxNzA2NzgzMDkxNzkwOlBldGVyOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIyX1NQOS4wOi0xOi0x
* @ValidationInfo : Timestamp         : 01 Feb 2024 11:24:51
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
FUNCTION SGNT.GET.SOCIAL.SECURITY(xmlpayload)
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
*       Get <socialSecurity>
    parsedResp = TUCOOP.TRANSUNION.ParseXml('<socialSecurity source="file">', '</socialSecurity>', xmlpayload)
    
*       Get <number>
    parsedResp = TUCOOP.TRANSUNION.ParseXml('<number>', '</number>', parsedResp)
    
    SocialSecurityNo = parsedResp
RETURN SocialSecurityNo
END
