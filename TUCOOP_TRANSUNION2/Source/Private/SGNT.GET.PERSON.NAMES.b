* @ValidationCode : MjozNzMyODkzNTpDcDEyNTI6MTcwNjc4MTAyNzkyOTpQZXRlcjotMTotMTowOjA6ZmFsc2U6Ti9BOlIyMl9TUDkuMDotMTotMQ==
* @ValidationInfo : Timestamp         : 01 Feb 2024 10:50:27
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
FUNCTION SGNT.GET.PERSON.NAMES(xmlpayload)
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------

*       Get <person>
    parsedResp = TUCOOP.TRANSUNION.ParseXml("<person>", "</person>", xmlpayload)
*       Get <first>
    FirstName = TUCOOP.TRANSUNION.ParseXml("<first>", "</first>", parsedResp)
*       Get <middle>
    MiddleName = TUCOOP.TRANSUNION.ParseXml("<middle>", "</middle>", parsedResp)
*       Get <last>
    LastName = TUCOOP.TRANSUNION.ParseXml("<last>", "</last>", parsedResp)
    
    result = FirstName:@FM:MiddleName:@FM:LastName
RETURN result
END
