with vs as (
    select  rownum rnum,
            inst_id,
            sid,
            serial#,
            status,
            username,
            last_call_et,
            command,
            machine,
            osuser,
            module,
            action,
            resource_consumer_group,
            client_info,
            client_identifier,
            type,
            terminal,
            sql_id
    from gv$session
    ) 
select  vs.inst_id, vs.sid,
        serial# serial,
        vs.sql_id,
        vs.username "Username",
        case when vs.status = 'ACTIVE' 
        then last_call_et 
        else null end "Seconds in Wait",
        decode( vs.command,  
                0,null, 
                1,'CRE TAB', 
                2,'INSERT', 
                3,'SELECT', 
                4,'CRE CLUSTER', 
                5,'ALT CLUSTER', 
                6,'UPDATE', 
                7,'DELETE', 
                8,'DRP CLUSTER', 
                9,'CRE INDEX', 
                10,'DROP INDEX', 
                11,'ALT INDEX', 
                12,'DROP TABLE', 
                13,'CRE SEQ', 
                14,'ALT SEQ', 
                15,'ALT TABLE', 
                16,'DROP SEQ', 
                17,'GRANT', 
                18,'REVOKE', 
                19,'CRE SYN', 
                20,'DROP SYN', 
                21,'CRE VIEW', 
                22,'DROP VIEW', 
                23,'VAL INDEX', 
                24,'CRE PROC', 
                25,'ALT PROC', 
                26,'LOCK TABLE', 
                28,'RENAME', 
                29,'COMMENT', 
                30,'AUDIT', 
                31,'NOAUDIT', 
                32,'CRE DBLINK', 
                33,'DROP DBLINK', 
                34,'CRE DB', 
                35,'ALTER DB', 
                36,'CRE RBS', 
                37,'ALT RBS', 
                38,'DROP RBS', 
                39,'CRE TBLSPC', 
                40,'ALT TBLSPC', 
                41,'DROP TBLSPC', 
                42,'ALT SESSION', 
                43,'ALT USER', 
                44,'COMMIT', 
                45,'ROLLBACK', 
                46,'SAVEPOINT', 
                47,'PL/SQL EXEC', 
                48,'SET XACTN', 
                49,'SWITCH LOG', 
                50,'EXPLAIN', 
                51,'CRE USER', 
                52,'CRE ROLE', 
                53,'DROP USER', 
                54,'DROP ROLE', 
                55,'SET ROLE', 
                56,'CRE SCHEMA', 
                57,'CRE CTLFILE', 
                58,'ALTER TRACING', 
                59,'CRE TRIGGER', 
                60,'ALT TRIGGER', 
                61,'DRP TRIGGER', 
                62,'ANALYZE TAB', 
                63,'ANALYZE IX', 
                64,'ANALYZE CLUS', 
                65,'CRE PROFILE', 
                66,'DRP PROFILE', 
                67,'ALT PROFILE', 
                68,'DRP PROC', 
                69,'DRP PROC', 
                70,'ALT RESOURCE', 
                71,'CRE SNPLOG', 
                72,'ALT SNPLOG', 
                73,'DROP SNPLOG', 
                74,'CREATE SNAP', 
                75,'ALT SNAP', 
                76,'DROP SNAP', 
                79,'ALTER ROLE', 
                79,'ALTER ROLE', 
                85,'TRUNC TAB', 
                86,'TRUNC CLUST', 
                88,'ALT VIEW', 
                91,'CRE FUNC', 
                92,'ALT FUNC', 
                93,'DROP FUNC', 
                94,'CRE PKG', 
                95,'ALT PKG', 
                96,'DROP PKG', 
                97,'CRE PKG BODY', 
                98,'ALT PKG BODY', 
                99,'DRP PKG BODY', 
                to_char(vs.command)
                ) "Command",
        vs.machine "Machine",
        vs.osuser "OS User", 
        lower(vs.status) "Status",
        vs.module "Module",
        vs.action "Action",
        vs.resource_consumer_group,
        vs.client_info,
        vs.client_identifier
from    vs 
where   vs.username is not null
and     nvl(vs.osuser,'x') <> 'SYSTEM'
and     vs.type <> 'BACKGROUND'
and     username = 'OLIVE'
order by 1,2,3