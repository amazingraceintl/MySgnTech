* @ValidationCode : MjoxNTIyMzE0NTkyOkNwMTI1MjoxNzA2Nzc3NjczMzMxOlBldGVyOi0xOi0xOjA6MDpmYWxzZTpOL0E6UjIyX1NQOS4wOi0xOi0x
* @ValidationInfo : Timestamp         : 01 Feb 2024 09:54:33
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
$USING EB.SystemTables
$USING TUC.Utility
SUBROUTINE SGNT.TU.API.CALL(args,response)
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*
*args<1> = First Name
*args<2> = Middle Name
*args<3> = Last Name
*args<4> = Street
*args<5> = Street Number
*args<6> = City
*args<7> = State
*args<8> = Zip Code
*args<9> = Social Security
*args<10> = Date Of Birth
*args<11> = Customer Type
*
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------

    response = " "
    GOSUB Process:
RETURN

Process:
    GOSUB Init
    GOSUB BuildPayload
    GOSUB ExecuteRequest
RETURN
Init:
   
    paramId = "TRANSUNION"
    endpoint = TUC.Utility.GetParam(paramId, "URL") ;*"http://localhost:8180"
    version = '2.8'
    userRefNumber = TUC.Utility.GetParam(paramId, "USER.REF.NUMBER");*'20999'
    memberCode = TUC.Utility.GetParam(paramId, "MEMBER.CODE");*'4883343'
    inquirySubscriberPrefixCode = TUC.Utility.GetParam(paramId, "INQUIRY.SUBSCRIBER.PREFIX.CODE");*'0622'
    password = TUC.Utility.GetParam(paramId, "PASSWORD");*'J2SP'
    processingEnvironment = TUC.Utility.GetParam(paramId, "PROCESSING.ENVIRONMENT");*'standardTest'; *production/standardTest
    country = TUC.Utility.GetParam(paramId, "COUNTRY");*'us' ;*us/canada
    language = TUC.Utility.GetParam(paramId, "LANGUAGE");* en/sp/fr
    code= TUC.Utility.GetParam(paramId, "PRODUCT.CODE");*'07000'
    addOnProductCode = TUC.Utility.GetParam(paramId, "FICO.SCORE.PRODUCT.CODE");*'00Q88'
    connectionTimeout = TUC.Utility.GetParam(paramId, "connectionTimeout");*"180"
    sessionTimeout = TUC.Utility.GetParam(paramId, "sessionTimeout");*"120"
    industryCode = TUC.Utility.GetParam(paramId, "INDUSTRY.CODE");* Q
    
    number = '1'
    firstname = args<1>
    middlename = args<2>
    lastname = args<3>
    street = args<4>
    streetnumber = args<5>
    city = args<6>
    state = args<7>
    zipcode = args<8>;*'60750';*args<5>
    socialSecurity = args<9>;*'666125812';*args<7>
    DOB = args<10>;*"1967-04-17"
    scoreModelProduct = 'true'
    returnErrorText = 'true'
    inquiryECOADesignator = "individual";*'individual'
    contractualRelationship = "individual";*'individual or Joint'
    
RETURN

BuildPayload:
   
    payload = '<?xml version="1.0"?>'
    payload := '<creditBureau xmlns="http://www.transunion.com/namespace" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'
    payload := '<document>request</document>'
    payload := '<version>':version:'</version>'
    payload := '<transactionControl>'
    payload :=   '<userRefNumber>':userRefNumber:'</userRefNumber>'
    payload :=   '<subscriber>'
    payload :=      '<industryCode>':industryCode:'</industryCode>'
    payload :=      '<memberCode>':memberCode:'</memberCode>'
    payload :=      '<inquirySubscriberPrefixCode>':inquirySubscriberPrefixCode:'</inquirySubscriberPrefixCode>'
    payload :=      '<password>':password:'</password>'
    payload :=   '</subscriber>'
    payload :=   '<options>'
    payload :=      '<processingEnvironment>':processingEnvironment:'</processingEnvironment>'
    payload :=      '<country>':country:'</country>'
    payload :=      '<language>':language:'</language>'
    payload :=      '<contractualRelationship>':contractualRelationship:'</contractualRelationship>'
    payload :=      '<pointOfSaleIndicator>none</pointOfSaleIndicator>'
    payload :=   '</options>'
    payload := '</transactionControl>'
    payload :=  '<product>'
    payload :=     '<code>':code:'</code>'
    payload :=     '<subject>'
    payload :=        '<number>':number:'</number>'
    payload :=        '<subjectRecord>'
    payload :=           '<indicative>'
    payload :=             '<name>'
    payload :=                '<person>'
    payload :=                  '<first>':firstname:'</first>'
    payload :=                  '<middle>':middlename:'</middle>'
    payload :=                  '<last>':lastname:'</last>'
    payload :=                '</person>'
    payload :=             '</name>'
    payload :=             '<address>'
    payload :=               '<status>current</status>'
    payload :=               '<street>'
    payload :=                 '<number>':streetnumber:'</number>'
    payload :=                 '<name>':street:'</name>'
    payload :=                 '<preDirectional>W</preDirectional>'
    payload :=                 '<type>RD</type>'
    payload :=               '</street>'
    payload :=               '<location>'
    payload :=                 '<city>':city:'</city>'
    payload :=                 '<state>':state:'</state>'
    payload :=                 '<zipCode>':zipcode:'</zipCode>'
    payload :=               '</location>'
    payload :=            '</address>'
    payload :=            '<socialSecurity>'
    payload :=              '<number>':socialSecurity:'</number>'
    payload :=            '</socialSecurity>'
    payload :=            '<dateOfBirth>':DOB:'</dateOfBirth>'
    payload :=           '</indicative>'
    payload :=           '<addOnProduct>'
    payload :=             '<code>':addOnProductCode:'</code>'
    payload :=             '<scoreModelProduct>':scoreModelProduct:'</scoreModelProduct>'
    payload :=           '</addOnProduct>'
    payload :=         '</subjectRecord>'
    payload :=      '</subject>'
    payload :=      '<responseInstructions>'
    payload :=        '<returnErrorText>':returnErrorText:'</returnErrorText>'
    payload :=        '<document/>'
    payload :=      '</responseInstructions>'
    payload :=      '<permissiblePurpose>'
    payload :=         '<inquiryECOADesignator>':inquiryECOADesignator:'</inquiryECOADesignator>'
    payload :=      '</permissiblePurpose>'
    payload :=   '</product>'
    payload :='</creditBureau>'
    request = "endPoint*":endpoint:"|connectionTimeout*":connectionTimeout:"|sessionTimeout*":sessionTimeout:"|headers*Content-Type: application/xml|payload*":payload:"|requestType*postRequest";
RETURN

ExecuteRequest:
    TUCOOP.TRANSUNION.InvokeHttpClient(request, response)

    PRINT response
RETURN
END