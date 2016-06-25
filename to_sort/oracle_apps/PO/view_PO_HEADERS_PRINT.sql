-- PO_HEADERS_PRINT view
SELECT   PH.TYPE_LOOKUP_CODE  "PO_TYPE"
,        PH.SEGMENT1          "PO_NUM"
,        PH.REVISION_NUM
,        PH.PRINT_COUNT
,        PH.CREATION_DATE
,        PH.PRINTED_DATE
,        PH.REVISED_DATE
,        PH.START_DATE
,        PH.END_DATE
,        PH.NOTE_TO_VENDOR
,        HRE.FIRST_NAME
,        HRE.LAST_NAME
,        PH.AGENT_ID
,        HRE2.FIRST_NAME
,        HRE2.LAST_NAME
,        PHA.AGENT_ID
,        NVL(PH.BLANKET_TOTAL_AMOUNT, '')
,        PH.CANCEL_FLAG
,        PH.CONFIRMING_ORDER_FLAG
,        PH.ACCEPTANCE_REQUIRED_FLAG
,        PH.ACCEPTANCE_DUE_DATE
,        FCC.CURRENCY_CODE
,        FCC.NAME
,        PH.RATE
,        PH.SHIP_VIA_LOOKUP_CODE SHIP_VIA
,        PLC1.DISPLAYED_FIELD
,        PLC2.DISPLAYED_FIELD
,        T.NAME
,        NVL(PVS.CUSTOMER_NUM,VN.CUSTOMER_NUM)
,        VN.SEGMENT1
,        VN.VENDOR_NAME
,        PVS.ADDRESS_LINE1
,        PVS.ADDRESS_LINE2
,        PVS.ADDRESS_LINE3
,        PVS.CITY
,        DECODE(PVS.STATE, NULL, DECODE(PVS.PROVINCE, NULL, PVS.COUNTY, PVS.PROVINCE), PVS.STATE)
,        PVS.ZIP
,        FTE3.TERRITORY_SHORT_NAME
,        '('||PVS.AREA_CODE||') '||PVS.PHONE, PVC.FIRST_NAME, PVC.LAST_NAME, '('||PVC.AREA_CODE||') '||PVC.PHONE
,        PH.ATTRIBUTE1
,        PH.ATTRIBUTE2
,        PH.ATTRIBUTE3
,        PH.ATTRIBUTE4
,        PH.ATTRIBUTE5
,        PH.ATTRIBUTE6
,        PH.ATTRIBUTE7
,        PH.ATTRIBUTE8
,        PH.ATTRIBUTE9
,        PH.ATTRIBUTE10
,        PH.ATTRIBUTE11
,        PH.ATTRIBUTE12
,        PH.ATTRIBUTE13
,        PH.ATTRIBUTE14
,        PH.ATTRIBUTE15
,        PH.VENDOR_SITE_ID
,        PH.BILL_TO_LOCATION_ID
,        PH.SHIP_TO_LOCATION_ID
,        PH.PO_HEADER_ID
,        TO_NUMBER(NULL)
,        DECODE(PH.APPROVED_FLAG,'Y','Y','N')
,        PVS.LANGUAGE
,        PH.VENDOR_ID
,        TO_DATE(NULL)
,        PH.CONSIGNED_CONSUMPTION_FLAG
FROM     PO_LOOKUP_CODES PLC1
,        PO_LOOKUP_CODES PLC2
,        FND_CURRENCIES_TL FCC
,        PO_VENDORS VN
,        PO_VENDOR_SITES PVS
,        PO_VENDOR_CONTACTS PVC
,        HR_EMPLOYEES HRE
,        PER_PEOPLE_F HRE2
,        AP_TERMS T
,        PO_HEADERS PH
,        PO_HEADERS_ARCHIVE PHA
,        FND_TERRITORIES_TL FTE3 
WHERE    1=1
AND      NVL(PH.USER_HOLD_FLAG,'N') = 'N'
AND      VN.VENDOR_ID = PH.VENDOR_ID
AND      PVS.VENDOR_SITE_ID = PH.VENDOR_SITE_ID
AND      PH.VENDOR_CONTACT_ID = PVC.VENDOR_CONTACT_ID(+)
AND      HRE.EMPLOYEE_ID = PH.AGENT_ID
AND      HRE2.PERSON_ID(+) = PHA.AGENT_ID
AND      HRE2.EMPLOYEE_NUMBER(+) IS NOT NULL
AND      TRUNC(SYSDATE) BETWEEN HRE2.EFFECTIVE_START_DATE(+) AND HRE2.EFFECTIVE_END_DATE(+)
AND      PH.TERMS_ID = T.TERM_ID (+)
AND      PH.TYPE_LOOKUP_CODE IN ('STANDARD','BLANKET','CONTRACT','PLANNED')
AND      FCC.CURRENCY_CODE = PH.CURRENCY_CODE
AND      FCC.LANGUAGE = USERENV('LANG')
AND      NVL(PHA.REVISION_NUM, 0) = 0
AND      PH.PO_HEADER_ID = PHA.PO_HEADER_ID(+)
AND      PLC1.LOOKUP_CODE (+) = PH.FOB_LOOKUP_CODE
AND      PLC1.LOOKUP_TYPE (+) = 'FOB'
AND      PLC2.LOOKUP_CODE (+) = PH.FREIGHT_TERMS_LOOKUP_CODE
AND      PLC2.LOOKUP_TYPE (+) = 'FREIGHT TERMS'
AND      PVS.COUNTRY = FTE3.TERRITORY_CODE (+)
AND      DECODE(FTE3.TERRITORY_CODE, NULL, '1', FTE3.language) = DECODE(FTE3.TERRITORY_CODE, NULL, '1', USERENV('LANG'))


UNION ALL

SELECT 'RELEASE', PH.SEGMENT1, PR.REVISION_NUM, PR.PRINT_COUNT, PR.CREATION_DATE, PR.PRINTED_DATE, PR.REVISED_DATE, TO_DATE(NULL), TO_DATE(NULL), PH.NOTE_TO_VENDOR, HRE.FIRST_NAME, HRE.LAST_NAME, PR.AGENT_ID, HRE2.FIRST_NAME, HRE2.LAST_NAME, PRA.AGENT_ID, TO_NUMBER(NULL), PR.CANCEL_FLAG, '', PR.ACCEPTANCE_REQUIRED_FLAG, PR.ACCEPTANCE_DUE_DATE, FCC.CURRENCY_CODE, FCC.NAME, PH.RATE, PH.SHIP_VIA_LOOKUP_CODE SHIP_VIA, PLC1.DISPLAYED_FIELD, PLC2.DISPLAYED_FIELD, T.NAME, NVL(PVS.CUSTOMER_NUM,VN.CUSTOMER_NUM), VN.SEGMENT1, VN.VENDOR_NAME, PVS.ADDRESS_LINE1, PVS.ADDRESS_LINE2, PVS.ADDRESS_LINE3, PVS.CITY, DECODE(PVS.STATE, NULL, DECODE(PVS.PROVINCE, NULL, PVS.COUNTY, PVS.PROVINCE), PVS.STATE), PVS.ZIP, FTE3.TERRITORY_SHORT_NAME, '('||PVS.AREA_CODE||') '||PVS.PHONE, PVC.FIRST_NAME, PVC.LAST_NAME, '('||PVC.AREA_CODE||') '||PVC.PHONE, PR.ATTRIBUTE1, PR.ATTRIBUTE2, PR.ATTRIBUTE3, PR.ATTRIBUTE4, PR.ATTRIBUTE5, PR.ATTRIBUTE6, PR.ATTRIBUTE7, PR.ATTRIBUTE8, PR.ATTRIBUTE9, PR.ATTRIBUTE10, PR.ATTRIBUTE11, PR.ATTRIBUTE12, PR.ATTRIBUTE13, PR.ATTRIBUTE14, PR.ATTRIBUTE15, PH.VENDOR_SITE_ID, PH.BILL_TO_LOCATION_ID, PH.SHIP_TO_LOCATION_ID, PH.PO_HEADER_ID, PR.PO_RELEASE_ID, DECODE(PR.APPROVED_FLAG,'Y','Y','N'), PVS.LANGUAGE, PH.VENDOR_ID, PR.RELEASE_DATE, PR.CONSIGNED_CONSUMPTION_FLAG FROM PO_LOOKUP_CODES PLC1, PO_LOOKUP_CODES PLC2, FND_CURRENCIES_TL FCC, PO_VENDORS VN, PO_VENDOR_SITES PVS, PO_VENDOR_CONTACTS PVC, HR_EMPLOYEES HRE, PER_PEOPLE_F HRE2, AP_TERMS T, PO_RELEASES PR, PO_HEADERS PH, PO_RELEASES_ARCHIVE PRA, FND_TERRITORIES_TL FTE3 WHERE PH.TYPE_LOOKUP_CODE IN ('BLANKET','PLANNED') AND PH.PO_HEADER_ID = PR.PO_HEADER_ID AND VN.VENDOR_ID = PH.VENDOR_ID AND PVS.VENDOR_SITE_ID = PH.VENDOR_SITE_ID AND PH.VENDOR_CONTACT_ID = PVC.VENDOR_CONTACT_ID(+) AND HRE.EMPLOYEE_ID = PR.AGENT_ID AND HRE2.PERSON_ID (+) = PRA.AGENT_ID AND HRE2.EMPLOYEE_NUMBER(+) IS NOT NULL AND TRUNC(SYSDATE) BETWEEN HRE2.EFFECTIVE_START_DATE(+) AND HRE2. EFFECTIVE_END_DATE(+) AND PH.TERMS_ID = T.TERM_ID (+) AND FCC.CURRENCY_CODE = PH.CURRENCY_CODE AND FCC.LANGUAGE = USERENV('LANG') AND NVL(PRA.REVISION_NUM, 0) = 0 AND PR.PO_RELEASE_ID = PRA.PO_RELEASE_ID(+) AND PLC1.LOOKUP_CODE (+) = PH.FOB_LOOKUP_CODE AND PLC1.LOOKUP_TYPE (+) = 'FOB' AND PLC2.LOOKUP_CODE (+) = PH.FREIGHT_TERMS_LOOKUP_CODE AND PLC2.LOOKUP_TYPE (+) = 'FREIGHT TERMS' AND PVS.COUNTRY = FTE3.TERRITORY_CODE (+) AND DECODE(FTE3.TERRITORY_CODE, NULL, '1', FTE3.language) = DECODE(FTE3.TERRITORY_CODE, NULL, '1', USERENV('LANG'))   