SELECT * --ENDPOINT_NUMBER, ENDPOINT_VALUE
FROM   USER_HISTOGRAMS
WHERE  1=1
--AND    TABLE_NAME='ARC_OLIVE3_DS3_DEVICE' AND COLUMN_NAME='PRODUCT'
AND    TABLE_NAME='ARC_DFA_SEARCH_DELIVERY' AND COLUMN_NAME='LAST_CHANGED_DATE'
--AND endpoint_actual_value  = '