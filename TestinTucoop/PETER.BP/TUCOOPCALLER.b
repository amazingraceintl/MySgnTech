* @ValidationCode : MjotMTU1MjUxMDcyOklTTy04ODU5LTE6MTcwMTcyMDI2NTc5NzpQZXRlcjotMTotMTowOjA6ZmFsc2U6Ti9BOlIyMF9TUDIuMDotMTotMQ==
* @ValidationInfo : Timestamp         : 04 Dec 2023 21:04:25
* @ValidationInfo : Encoding          : ISO-8859-1
* @ValidationInfo : User Name         : Peter
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : R20_SP2.0
SUBROUTINE TUCOOPCALLER
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
    DEBUG
    
* CALLJ "mypackage.mytestclass","mymethod", p SETTING ret
   
    
    className = 'EntryPoint'
    methodName = 'Sender'
* methodName = "$" : methodName
    mypackage = 'com.temenos.sgtech'
*param = 'Cooperativa_Ahorro_y_Credito_TestSite^830058098b40451d8ccb366a3c88a372^ae9361c550484a838ca5b6ef0c578488^https://app.trustev.com/api/v2.0/session^https://app.trustev.com/api/v2.0/case^https://app.trustev.com/api/v2.0/token^https://app.trustev.com/api/v2.1/detaileddecision/^4448edc64c334237b402bc2656953dad^1600 PARK PLACE^1600 PARK PLACE^^ATLANTA^US^PATRICK^TESTP^30326^GA^666010017^4/30/1972'
*param = 'Cooperativa_Ahorro_y_Credito_TestSite^830058098b40451d8ccb366a3c88a372^ae9361c550484a838ca5b6ef0c578488^https://app.trustev.com/api/v2.0/session^https://app.trustev.com/api/v2.0/case^https://app.trustev.com/api/v2.0/token^https://app.trustev.com/api/v2.1/detaileddecision/^4448edc64c334237b402bc2656953dad^PARK PLACE^^^ATLANTA^US^PATRICK^TESTP^30326^GA^666010016^19720430^XYZ'
*param3 = "Cooperativa_Ahorro_y_Credito_TestSite^830058098b40451d8ccb366a3c88a372^ae9361c550484a838ca5b6ef0c578488^https://app.trustev.com/api/v2.0/session^https://app.trustev.com/api/v2.0/case^https://app.trustev.com/api/v2.0/token^https://app.trustev.com/api/v2.1/detaileddecision/^4448edc64c334237b402bc2656953dad^1600 PARK PLACE^1600 PARK PLACE^^ATLANTA^US^PATRICK^TESTP^30326^GA^666010016^19720430^XYZ"
*param4 = "Cooperativa_Ahorro_y_Credito_TestSite^830058098b40451d8ccb366a3c88a372^ae9361c550484a838ca5b6ef0c578488^https://app.trustev.com/api/v2.0/session^https://app.trustev.com/api/v2.0/case^https://app.trustev.com/api/v2.0/token^https://app.trustev.com/api/v2.1/detaileddecision/^4448edc64c334237b402bc2656953dad^^1600 PARK PLACE^^ATLANTA^US^PATRICK^TESTP^30326^GA^121212121^04/30/1972^XYZ"
   
    param6 = "Cooperativa_Ahorro_y_Credito_TestSite^830058098b40451d8ccb366a3c88a372^ae9361c550484a838ca5b6ef0c578488^https://app.trustev.com/api/v2.0/session^https://app.trustev.com/api/v2.0/case^https://app.trustev.com/api/v2.0/token^https://app.trustev.com/api/v2.1/detaileddecision/^4448edc64c334237b402bc2656953dad^1600 PARK PLACE^1600 PARK PLACE^^ATLANTA^US^PATRICK^TESTP^30326^GA^666010016^04/30/1972^XYZQ^0"
   
*param5 = "Cooperativa_Ahorro_y_Credito_TestSite^830058098b40451d8ccb366a3c88a372^ae9361c550484a838ca5b6ef0c578488^https://app.trustev.com/api/v2.0/session^https://app.trustev.com/api/v2.0/case^https://app.trustev.com/api/v2.0/token^https://app.trustev.com/api/v2.1/detaileddecision/^4448edc64c334237b402bc2656953dad^1600 PARK PLACE^1600 PARK PLACE^^ATLANTA^US^PATRICKTTT^TESTP^30326^GA^666010016^04/30/1972^XYZQ^092.168.18.4"
    param7 = "Cooperativa_Ahorro_y_Credito_TestSite^830058098b40451d8ccb366a3c88a372^ae9361c550484a838ca5b6ef0c578488^https://app.trustev.com/api/v2.0/session^https://app.trustev.com/api/v2.0/case^https://app.trustev.com/api/v2.0/token^https://app.trustev.com/api/v2.1/detaileddecision/^4448edc64c334237b402bc2656953dad^POST BOX NO 1-289123^LAGOS^^^NG^JOHN^^^^666010016^//^XYZQ^185.107.57.7"
    param8 = "Cooperativa_Ahorro_y_Credito_TestSite^830058098b40451d8ccb366a3c88a372^ae9361c550484a838ca5b6ef0c578488^https://app.trustev.com/api/v2.0/session^https://app.trustev.com/api/v2.0/case^https://app.trustev.com/api/v2.0/token^https://app.trustev.com/api/v2.1/detaileddecision/^4448edc64c334237b402bc2656953dad^7033 Kittyhawk Av^^^Los Angeles^US^Martin^Abad^90045^CA^666-01-1271^10/01/1981^XYZQ^185.107.57.7"
   
    CALLJ mypackage:'.':className, methodName, param8 SETTING ret ON ERROR
        GOSUB errorHandler
        STOP
    END

    CRT "Received from Java: " : ret
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
