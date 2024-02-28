$PACKAGE TUCOOP.TRANSUNION
SUBROUTINE TESTFICO
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------

    
    
    endpoint = "https://netaccess-test.transunion.com";
    systemId ='COOPER15'
    systemPassword = 'TuC00p25'
    version = '2.40'
    userRefNumber = ''
    memberCode = '4883343'
    inquirySubscriberPrefixCode = '0622'
    password = 'J2SP'
    processingEnvironment ='standardTest'
    country = 'us'
    language = 'en'
    code= '07000'
    addOnProductCode = '00Q88'
    connectionTimeout = "180"
    sessionTimeout = "120"
    industryCode = 'Q'
    number = '1'
    first ='JANET'
    middlename = ''
    last = 'BUSCH'
    street = '4227 N 27TH AV'
    streetnumber =''
    city = 'PHOENIX'
    state = 'AZ'
    zipcode = '85017'
    socialSecurityNo =''
*666822043
    DOB = '1967/04/17'
    scoreModelProduct = ''
    returnErrorText = 'true'
    inquiryECOADesignator ='individual'
    contractualRelationship = ''
    status = 'current'
    
    payload = '<?xml version="1.0" encoding="UTF-8"?>'
    payload := '<xmlrequest xmlns="http://www.transunion.com/namespace" xsi:schemaLocation="http://www.transunion.com/namespace" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'
    payload := '<systemId>COOPER15</systemId>'
    payload := '<systemPassword>TuC00p25</systemPassword>'
    payload := '<productrequest>'
    payload := '<creditBureau xmlns="http://www.transunion.com/namespace">'

    
    
*    payload = "<?xml version='1.0' encoding='UTF-8'?><xmlrequest xmlns="
*    payload := '"http://www.transunion.com/namespace" xsi:schemaLocation='
*    payload := '"http://www.transunion.com/namespace" xmlns:xsi='
*    payload := '"http://www.w3.org/2001/XMLSchema-instance">'
*    payload := '<systemId>COOPER15</systemId><systemPassword>TuC00p25</systemPassword><productrequest><creditBureau '
*    payload := 'xmlns="http://www.transunion.com/namespace">'
*
   
   
*    t24data = "<?xml version='1.0' encoding='UTF-8'?><xmlrequest xmlns="
*    t24data  := '"http://www.transunion.com/namespace" xsi:schemaLocation='
*    t24data := '"http://www.transunion.com/namespace" xmlns:xsi='
*    t24data := '"http://www.w3.org/2001/XMLSchema-instance">'
*    t24data := '<systemId>COOPER15</systemId><systemPassword>TuC00p25</systemPassword><productrequest><creditBureau '
*    t24data := 'xmlns="http://www.transunion.com/namespace">'
*    t24data := '<version>2.40</version><document>request</document><transactionControl>
*    t24data := '<userRefNumber/><subscriber><industryCode>Q</industryCode><memberCode>4883343</memberCode><inquirySubscriberPrefixCode>0622</inquirySubscriberPrefixCode><password>J2SP</password></subscriber><options><processingEnvironment>standardTest</processingEnvironment><country>us</country><language>en</language></options></transactionControl><product><code>07000</code><subject><number>1</number><subjectRecord><indicative><name><person><first>JANET</first><middle></middle><last>BUSCH</last></person></name><address><status>current</status><street><unparsed>4227 N 27TH AV</unparsed></street><location><city>PHOENIX</city><state>AZ</state><zipCode>85017</zipCode></location></address><socialSecurity><number>666822043</number></socialSecurity><dateOfBirth/></indicative></subjectRecord></subject><responseInstructions><returnErrorText>true</returnErrorText><document/></responseInstructions><permissiblePurpose><inquiryECOADesignator>individual</inquiryECOADesignator></permissiblePurpose></product></creditBureau>'
*



    t24data = "<?xml version='1.0' encoding='UTF-8'?><xmlrequest xmlns="
    t24data := '"http://www.transunion.com/namespace" xsi:schemaLocation='
    t24data := '"http://www.transunion.com/namespace" xmlns:xsi='
    t24data := '"http://www.w3.org/2001/XMLSchema-instance">'
    t24data := '<systemId>':systemId:'</systemId><systemPassword>':systemPassword:'</systemPassword><productrequest><creditBureau '
    t24data := 'xmlns="http://www.transunion.com/namespace">'
    t24data := '<version>':version:'</version><document>request</document><transactionControl>'
    t24data := '<userRefNumber/><subscriber><industryCode>':industryCode:'</industryCode>'
    t24data := '<memberCode>':memberCode:'</memberCode>'
    t24data := '<inquirySubscriberPrefixCode>':inquirySubscriberPrefixCode:'</inquirySubscriberPrefixCode>'
    t24data := '<password>':password:'</password>'
    t24data := '</subscriber><options><processingEnvironment>':processingEnvironment:'</processingEnvironment>'
    t24data := '<country>':country:'</country><language>':language:'</language>'
    t24data :='</options></transactionControl><product><code>':code:'</code><subject><number>':number:'</number>'
    t24data :='<subjectRecord><indicative><name><person><first>':first:'</first>'
    t24data :='<middle/><last>':last:'</last></person></name><address>'
    t24data :='<status>':status:'</status>'
    t24data :='<street><unparsed>':street:'</unparsed></street>'
    t24data :='<location><city>':city:'</city><state>':state:'</state><zipCode>':zipcode:'</zipCode></location>'
    t24data :='</address><socialSecurity><number>':socialSecurityNo:'</number></socialSecurity>'
    t24data :='<dateOfBirth>':DOB:'</dateOfBirth></indicative>'
    t24data :='<addOnProduct>'
    t24data :='<code>00Q88</code>'
    t24data :='<scoreModelProduct>true</scoreModelProduct>'
    t24data :='</addOnProduct>'
    t24data :='</subjectRecord></subject><responseInstructions><returnErrorText>':returnErrorText:'</returnErrorText><document/></responseInstructions>'
    t24data :='<permissiblePurpose><inquiryECOADesignator>':inquiryECOADesignator:'</inquiryECOADesignator></permissiblePurpose></product></creditBureau>'
   
    DEBUG
    
    IF socialSecurityNo EQ '' THEN
        payloadinit = FIELD(t24data,'<socialSecurity><number>',1)
        payloadinit2 = FIELD(t24data,'<socialSecurity><number>',2)
        payload3 = FIELD(payloadinit2,'</number></socialSecurity>',2,9999)
        t24data = payloadinit:'<socialSecurity/>':payload3
    END

    IF DOB EQ '' THEN
        payloaddob = FIELD(t24data,'<dateOfBirth>',1)
        payloaddob2 = FIELD(t24data,'<dateOfBirth>',2)
        payloaddob3 = FIELD(payloaddob2,'</dateOfBirth>',2,9999)
        t24data = payloaddob:'<dateOfBirth/>':payloaddob3
    
    END
   
    request = endpoint:'^':t24data
*:'^':"C:/Users/Peter/Music/COOPER15_SHA2.p12"
  
    UNQ.NO = "" ; Amt = ''
    UNQ.NO = EREPLACE(UNQ.NO,".","")
    SESSION.ID = UNQ.NO[1,12]
    className = 'SgntEntryPoint'
    methodName = 'Sender'
    mypackage = 'com.sgnt.integration'

    CALLJ mypackage:'.':className, methodName, request SETTING ret ON ERROR
        GOSUB errorHandler
        STOP
    END

    CRT "Received from Java: " : ret
    CusNo = "Localtest"
    
    OpIdreq = CusNo:'-':SESSION.ID:'-request.txt'
    Fn.Folder = "C:\TEMENOS\TUCOOP\R22\SIT\T24\UD\FICOTUCOOP\LOG"
    Log.Message = 'Request Sent = ':request:'=============================== Response Received= ':ret
    
    OPENSEQ Fn.Folder,OpIdreq TO ReqFolder THEN
        OPEN.FLAG = 1
        WEOFSEQ ReqFolder
    END ELSE
        CREATE ReqFolder ELSE
            RETURN
        END
    END
    
    WRITESEQ Log.Message TO ReqFolder ELSE
    END
    
    STOP

errorHandler:
    err = SYSTEM(0)

    BEGIN CASE
        CASE err = 1
            CRT "Fatal Error creating Thread!"
        CASE err = 2
            CRT "Cannot find the JVM.dll !"
        CASE err = 3
            CRT "Class " : className : " doesn't exist!"
        CASE err = 4
            CRT "UNICODE conversion error!"
        CASE err = 5
            CRT "Method " : methodName : " doesn't exist!"
        CASE err = 6
            CRT "Cannot find object Constructor!"
        CASE err = 7
            CRT "Cannot instantiate object!"
        CASE @TRUE
            CRT "Unknown error!"
    END CASE



END


END