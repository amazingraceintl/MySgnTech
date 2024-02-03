* @ValidationCode : MjotMjA1NzA0MDMwMjpDcDEyNTI6MTcwNjc4MzEzNjg2NjpQZXRlcjotMTotMTowOjA6ZmFsc2U6Ti9BOlIyMl9TUDkuMDotMTotMQ==
* @ValidationInfo : Timestamp         : 01 Feb 2024 11:25:36
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
SUBROUTINE SGNT.GET.TOTAL.SUMMARY(xmlPayload,totalInquiryCount,totalHighCredit,totalCreditLimit,totalCurrentBalance,totalPastDue,totalMonthlyPayment)
*-----------------------------------------------------------------------------
*
*-----------------------------------------------------------------------------
* Modification History :
*-----------------------------------------------------------------------------

*-----------------------------------------------------------------------------
*       Get <creditSummary>
    parsedResp = TUCOOP.TRANSUNION.ParseXml('<creditSummary>', '</creditSummary>', xmlPayload)
    parsedResp2 = parsedResp
*       Get <recordCounts>
    parsedResp = TUCOOP.TRANSUNION.ParseXml('<recordCounts reportingPeriod="totalHistory">', '</recordCounts>', parsedResp)

*       Get <totalInquiryCount>
    totalInquiryCount = TUCOOP.TRANSUNION.ParseXml('<totalInquiryCount>', '</totalInquiryCount>', parsedResp)
*       Get <totalAmount>
    parsedResp2 = TUCOOP.TRANSUNION.ParseXml('<totalAmount>', '</totalAmount>', parsedResp2)
*       Get <highCredit>
    totalHighCredit = TUCOOP.TRANSUNION.ParseXml("<highCredit>", "</highCredit>", parsedResp2)
*       Get <creditLimit>
    totalCreditLimit = TUCOOP.TRANSUNION.ParseXml("<creditLimit>", "</creditLimit>", parsedResp2)
*       Get <currentBalance>
    totalCurrentBalance = TUCOOP.TRANSUNION.ParseXml("<currentBalance>", "</currentBalance>", parsedResp2)
*       Get <pastDue>
    totalPastDue = TUCOOP.TRANSUNION.ParseXml("<pastDue>", "</pastDue>", parsedResp2)
*       Get <monthlyPayment>
    totalMonthlyPayment = TUCOOP.TRANSUNION.ParseXml("<monthlyPayment>", "</monthlyPayment>", parsedResp2)
RETURN
END
