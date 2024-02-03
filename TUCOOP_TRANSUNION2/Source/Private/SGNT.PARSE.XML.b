* @ValidationCode : MjoyOTI2MjgxMTpDcDEyNTI6MTcwNjc4MzE1MTc2MzpQZXRlcjotMTotMTowOjA6ZmFsc2U6Ti9BOlIyMl9TUDkuMDotMTotMQ==
* @ValidationInfo : Timestamp         : 01 Feb 2024 11:25:51
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
FUNCTION SGNT.PARSE.XML(xmlopentag,xmlclosetag,xmlMessage)

    result = FIELD(xmlMessage,xmlopentag,2)
    result = FIELD(result,xmlclosetag,1)
RETURN (result)
END
