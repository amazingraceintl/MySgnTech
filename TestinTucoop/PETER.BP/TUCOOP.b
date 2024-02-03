* @ValidationCode : MjotMTQ4MjM5NDM1NzpJU08tODg1OS0xOjE3MDE3MjAxMTI2MTM6UGV0ZXI6LTE6LTE6MDowOmZhbHNlOk4vQTpSMjBfU1AyLjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 04 Dec 2023 21:01:52
* @ValidationInfo : Encoding          : ISO-8859-1
* @ValidationInfo : User Name         : Peter
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : R20_SP2.0
PROGRAM TUCOOP
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*----------------------------------------------------------------------------
    
    DOB ='19720430'
    DateOfBirth1 = DOB[1,4]
    DateOfBirth2 = DOB[5,6]
    DateOfBirth3 = DOB[7,8]
    
    CRT 'Final value':DateOfBirth2:'/':DateOfBirth3:'/':DateOfBirth1
    
    
    
    className = 'EntryPoint'
    methodName = 'SgtransUnion'
* methodName = "$" : methodName
    param = 'Cooperativa_Ahorro_y_Credito_TestSite^830058098b40451d8ccb366a3c88a372^https://app.trustev.com/api/v2.0/session^https://app.trustev.com/api/v2.0/case^https://app.trustev.com/api/v2.0/token^https://app.trustev.com/api/v2.1/detaileddecision/^4448edc64c334237b402bc2656953dad^1600 PARK PLACE^""^""^ATLANTA^US^PATRICK^TESTP^30326^GA^666010016^4/30/1972'

*    CALLJ className,methodName, param SETTING ret ON ERROR
*        GOSUB errorHandler
*        STOP
*    END
*
*    CRT "Received from Java: " : ret
*    STOP

*errorHandler:
*    err = SYSTEM(0)
*
*    BEGIN CASE
*        CASE err = 1
*            CRT "Fatal Error creating Thread!"
*        CASE err = 2
*            CRT "Cannot find the JVM.dll !"
*        CASE err = 3
*            CRT "Class " : className : " doesn't exist!"
*        CASE err = 4
*            CRT "UNICODE conversion error!"
*        CASE err = 5
*            CRT "Method " : methodName : " doesn't exist!"
*        CASE err = 6
*            CRT "Cannot find object Constructor!"
*        CASE err = 7
*            CRT "Cannot instantiate object!"
*        CASE @TRUE
*            CRT "Unknown error!"
*    END CASE


END
