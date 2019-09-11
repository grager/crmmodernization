      *-----------------------------------------------------------------
      *    COBSV005 - SAMPLE COBOL PROGRAM TO DEMONSTRATE SEARCH ALL 
      *               FUNCTIONALITY   
      * 
      *               COUNTS NUMBER OF EMPLOYEES IN DIFFERENT AREA    
      *               CODES (WHICH HAVE BEEN DIVIDED INTO EIGHT ZONES)
      *                                                                 
      *-----------------------------------------------------------------
      *
      *--------------------PART OF MYTELCO HR APPLICATION-----------
      *                                                                 
      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  COBSV005.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
          SELECT EMPDATA ASSIGN TO VSAMF
             ORGANIZATION IS INDEXED
             ACCESS IS SEQUENTIAL
             RECORD KEY IS EMPDATA-EMPNO.
       
       DATA DIVISION.
       FILE SECTION.
       FD EMPDATA 
          LABEL RECORDS ARE STANDARD
          RECORD CONTAINS 120 CHARACTERS.
       01 EMPDATA-REC.
          05 EMPDATA-EMPNO		PIC X(06).
          05 EMPDATA-NAME		PIC X(34).
          05 EMPDATA-WORKDEPT		PIC X(03).
          05 EMPDATA-AREACODE		PIC X(03).
          05 EMPDATA-HIREDDATE.
             10 EMPDATA-HIREDDATE-YR    PIC X(04).
             10 FILLER			PIC X(01).
             10 EMPDATA-HIREDDATE-MO	PIC X(02).
             10 FILLER			PIC X(01).
             10 EMPDATA-HIREDDATE-DD	PIC X(02).
          05 EMPDATA-OTHDETAILS		PIC X(64).
          
       WORKING-STORAGE SECTION.
       01 STDCODETABLE.
          02 TABLEVALUES.
             03 FILLER         PIC X(03) VALUE "0011NORTH".
             03 FILLER         PIC X(03) VALUE "0021NORTH".
             03 FILLER         PIC X(03) VALUE "0031NORTH".
             03 FILLER         PIC X(03) VALUE "0041NORTH".
             03 FILLER         PIC X(03) VALUE "0051NORTH".
             03 FILLER         PIC X(03) VALUE "0061NORTH".
             03 FILLER         PIC X(03) VALUE "0071NORTH".
             03 FILLER         PIC X(03) VALUE "0081NORTH".
             03 FILLER         PIC X(03) VALUE "0091NORTH".
             03 FILLER         PIC X(03) VALUE "0101NORTH".
             03 FILLER         PIC X(03) VALUE "0111NORTH".
             03 FILLER         PIC X(03) VALUE "0121NORTH".
             03 FILLER         PIC X(03) VALUE "0131NORTH".
             03 FILLER         PIC X(03) VALUE "0141NORTH".
             03 FILLER         PIC X(03) VALUE "0151NORTH".
             03 FILLER         PIC X(03) VALUE "0161NORTH".
             03 FILLER         PIC X(03) VALUE "0171NORTH".
             03 FILLER         PIC X(03) VALUE "0181NORTH".
             03 FILLER         PIC X(03) VALUE "0191NORTH".
             03 FILLER         PIC X(03) VALUE "0201NORTH".
             03 FILLER         PIC X(03) VALUE "0211NORTH".
             03 FILLER         PIC X(03) VALUE "0221NORTH".
             03 FILLER         PIC X(03) VALUE "0231NORTH".
             03 FILLER         PIC X(03) VALUE "0241NORTH".
             03 FILLER         PIC X(03) VALUE "0251NORTH".
             03 FILLER         PIC X(03) VALUE "0261NORTH".
             03 FILLER         PIC X(03) VALUE "0271NORTH".
             03 FILLER         PIC X(03) VALUE "0281NORTH".
             03 FILLER         PIC X(03) VALUE "0291NORTH".
             03 FILLER         PIC X(03) VALUE "0301NORTH".
             03 FILLER         PIC X(03) VALUE "0311NORTH".
             03 FILLER         PIC X(03) VALUE "0321NORTH".
             03 FILLER         PIC X(03) VALUE "0331NORTH".
             03 FILLER         PIC X(03) VALUE "0341NORTH".
             03 FILLER         PIC X(03) VALUE "0351NORTH".
             03 FILLER         PIC X(03) VALUE "0361NORTH".
             03 FILLER         PIC X(03) VALUE "0371NORTH".
             03 FILLER         PIC X(03) VALUE "0381NORTH".
             03 FILLER         PIC X(03) VALUE "0391NORTH".
             03 FILLER         PIC X(03) VALUE "0401NORTH".
             03 FILLER         PIC X(03) VALUE "0411NORTH".
             03 FILLER         PIC X(03) VALUE "0421NORTH".
             03 FILLER         PIC X(03) VALUE "0431NORTH".
             03 FILLER         PIC X(03) VALUE "0441NORTH".
             03 FILLER         PIC X(03) VALUE "0451NORTH".
             03 FILLER         PIC X(03) VALUE "0461NORTH".
             03 FILLER         PIC X(03) VALUE "0471NORTH".
             03 FILLER         PIC X(03) VALUE "0481NORTH".
             03 FILLER         PIC X(03) VALUE "0491NORTH".
             03 FILLER         PIC X(03) VALUE "0501NORTH".
             03 FILLER         PIC X(03) VALUE "0511NORTH".
             03 FILLER         PIC X(03) VALUE "0521NORTH".
             03 FILLER         PIC X(03) VALUE "0531NORTH".
             03 FILLER         PIC X(03) VALUE "0541NORTH".
             03 FILLER         PIC X(03) VALUE "0551NORTH".
             03 FILLER         PIC X(03) VALUE "0561NORTH".
             03 FILLER         PIC X(03) VALUE "0571NORTH".
             03 FILLER         PIC X(03) VALUE "0581NORTH".
             03 FILLER         PIC X(03) VALUE "0591NORTH".
             03 FILLER         PIC X(03) VALUE "0601NORTH".
             03 FILLER         PIC X(03) VALUE "0611NORTH".
             03 FILLER         PIC X(03) VALUE "0621NORTH".
             03 FILLER         PIC X(03) VALUE "0631NORTH".
             03 FILLER         PIC X(03) VALUE "0641NORTH".
             03 FILLER         PIC X(03) VALUE "0651NORTH".
             03 FILLER         PIC X(03) VALUE "0661NORTH".
             03 FILLER         PIC X(03) VALUE "0671NORTH".
             03 FILLER         PIC X(03) VALUE "0681NORTH".
             03 FILLER         PIC X(03) VALUE "0691NORTH".
             03 FILLER         PIC X(03) VALUE "0701NORTH".
             03 FILLER         PIC X(03) VALUE "0711NORTH".
             03 FILLER         PIC X(03) VALUE "0721NORTH".
             03 FILLER         PIC X(03) VALUE "0731NORTH".
             03 FILLER         PIC X(03) VALUE "0741NORTH".
             03 FILLER         PIC X(03) VALUE "0751NORTH".
             03 FILLER         PIC X(03) VALUE "0761NORTH".
             03 FILLER         PIC X(03) VALUE "0771NORTH".
             03 FILLER         PIC X(03) VALUE "0781NORTH".
             03 FILLER         PIC X(03) VALUE "0791NORTH".
             03 FILLER         PIC X(03) VALUE "0801NORTH".
             03 FILLER         PIC X(03) VALUE "0811NORTH".
             03 FILLER         PIC X(03) VALUE "0821NORTH".
             03 FILLER         PIC X(03) VALUE "0831NORTH".
             03 FILLER         PIC X(03) VALUE "0841NORTH".
             03 FILLER         PIC X(03) VALUE "0851NORTH".
             03 FILLER         PIC X(03) VALUE "0861NORTH".
             03 FILLER         PIC X(03) VALUE "0871NORTH".
             03 FILLER         PIC X(03) VALUE "0881NORTH".
             03 FILLER         PIC X(03) VALUE "0891NORTH".
             03 FILLER         PIC X(03) VALUE "0901NORTH".
             03 FILLER         PIC X(03) VALUE "0911NORTH".
             03 FILLER         PIC X(03) VALUE "0921NORTH".
             03 FILLER         PIC X(03) VALUE "0931NORTH".
             03 FILLER         PIC X(03) VALUE "0941NORTH".
             03 FILLER         PIC X(03) VALUE "0951NORTH".
             03 FILLER         PIC X(03) VALUE "0961NORTH".
             03 FILLER         PIC X(03) VALUE "0971NORTH".
             03 FILLER         PIC X(03) VALUE "0981NORTH".
             03 FILLER         PIC X(03) VALUE "0991NORTH".
             03 FILLER         PIC X(03) VALUE "1002NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1012NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1022NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1032NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1042NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1052NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1062NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1072NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1082NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1092NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1102NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1112NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1122NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1132NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1142NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1152NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1162NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1172NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1182NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1192NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1202NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1212NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1222NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1232NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1242NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1252NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1262NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1272NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1282NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1292NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1302NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1312NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1322NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1332NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1342NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1352NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1362NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1372NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1382NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1392NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1402NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1412NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1422NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1432NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1442NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1452NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1462NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1472NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1482NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1492NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1502NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1512NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1522NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1532NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1542NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1552NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1562NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1572NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1582NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1592NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1602NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1612NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1622NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1632NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1642NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1652NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1662NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1672NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1682NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1692NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1702NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1712NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1722NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1732NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1742NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1752NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1762NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1772NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1782NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1792NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1802NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1812NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1822NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1832NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1842NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1852NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1862NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1872NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1882NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1892NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1902NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1912NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1922NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1932NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1942NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1952NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1962NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1972NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1982NORTHEAST".
             03 FILLER         PIC X(03) VALUE "1992NORTHEAST".
             03 FILLER         PIC X(03) VALUE "2004EAST".
             03 FILLER         PIC X(03) VALUE "2014EAST".
             03 FILLER         PIC X(03) VALUE "2024EAST".
             03 FILLER         PIC X(03) VALUE "2034EAST".
             03 FILLER         PIC X(03) VALUE "2044EAST".
             03 FILLER         PIC X(03) VALUE "2054EAST".
             03 FILLER         PIC X(03) VALUE "2064EAST".
             03 FILLER         PIC X(03) VALUE "2074EAST".
             03 FILLER         PIC X(03) VALUE "2084EAST".
             03 FILLER         PIC X(03) VALUE "2094EAST".
             03 FILLER         PIC X(03) VALUE "2104EAST".
             03 FILLER         PIC X(03) VALUE "2114EAST".
             03 FILLER         PIC X(03) VALUE "2124EAST".
             03 FILLER         PIC X(03) VALUE "2134EAST".
             03 FILLER         PIC X(03) VALUE "2144EAST".
             03 FILLER         PIC X(03) VALUE "2154EAST".
             03 FILLER         PIC X(03) VALUE "2164EAST".
             03 FILLER         PIC X(03) VALUE "2174EAST".
             03 FILLER         PIC X(03) VALUE "2184EAST".
             03 FILLER         PIC X(03) VALUE "2194EAST".
             03 FILLER         PIC X(03) VALUE "2204EAST".
             03 FILLER         PIC X(03) VALUE "2214EAST".
             03 FILLER         PIC X(03) VALUE "2224EAST".
             03 FILLER         PIC X(03) VALUE "2234EAST".
             03 FILLER         PIC X(03) VALUE "2244EAST".
             03 FILLER         PIC X(03) VALUE "2254EAST".
             03 FILLER         PIC X(03) VALUE "2264EAST".
             03 FILLER         PIC X(03) VALUE "2274EAST".
             03 FILLER         PIC X(03) VALUE "2284EAST".
             03 FILLER         PIC X(03) VALUE "2294EAST".
             03 FILLER         PIC X(03) VALUE "2304EAST".
             03 FILLER         PIC X(03) VALUE "2314EAST".
             03 FILLER         PIC X(03) VALUE "2324EAST".
             03 FILLER         PIC X(03) VALUE "2334EAST".
             03 FILLER         PIC X(03) VALUE "2344EAST".
             03 FILLER         PIC X(03) VALUE "2354EAST".
             03 FILLER         PIC X(03) VALUE "2364EAST".
             03 FILLER         PIC X(03) VALUE "2374EAST".
             03 FILLER         PIC X(03) VALUE "2384EAST".
             03 FILLER         PIC X(03) VALUE "2394EAST".
             03 FILLER         PIC X(03) VALUE "2404EAST".
             03 FILLER         PIC X(03) VALUE "2414EAST".
             03 FILLER         PIC X(03) VALUE "2424EAST".
             03 FILLER         PIC X(03) VALUE "2434EAST".
             03 FILLER         PIC X(03) VALUE "2444EAST".
             03 FILLER         PIC X(03) VALUE "2454EAST".
             03 FILLER         PIC X(03) VALUE "2464EAST".
             03 FILLER         PIC X(03) VALUE "2474EAST".
             03 FILLER         PIC X(03) VALUE "2484EAST".
             03 FILLER         PIC X(03) VALUE "2494EAST".
             03 FILLER         PIC X(03) VALUE "2504EAST".
             03 FILLER         PIC X(03) VALUE "2514EAST".
             03 FILLER         PIC X(03) VALUE "2524EAST".
             03 FILLER         PIC X(03) VALUE "2534EAST".
             03 FILLER         PIC X(03) VALUE "2544EAST".
             03 FILLER         PIC X(03) VALUE "2554EAST".
             03 FILLER         PIC X(03) VALUE "2564EAST".
             03 FILLER         PIC X(03) VALUE "2574EAST".
             03 FILLER         PIC X(03) VALUE "2584EAST".
             03 FILLER         PIC X(03) VALUE "2594EAST".
             03 FILLER         PIC X(03) VALUE "2604EAST".
             03 FILLER         PIC X(03) VALUE "2614EAST".
             03 FILLER         PIC X(03) VALUE "2624EAST".
             03 FILLER         PIC X(03) VALUE "2634EAST".
             03 FILLER         PIC X(03) VALUE "2644EAST".
             03 FILLER         PIC X(03) VALUE "2654EAST".
             03 FILLER         PIC X(03) VALUE "2664EAST".
             03 FILLER         PIC X(03) VALUE "2674EAST".
             03 FILLER         PIC X(03) VALUE "2684EAST".
             03 FILLER         PIC X(03) VALUE "2694EAST".
             03 FILLER         PIC X(03) VALUE "2704EAST".
             03 FILLER         PIC X(03) VALUE "2714EAST".
             03 FILLER         PIC X(03) VALUE "2724EAST".
             03 FILLER         PIC X(03) VALUE "2734EAST".
             03 FILLER         PIC X(03) VALUE "2744EAST".
             03 FILLER         PIC X(03) VALUE "2754EAST".
             03 FILLER         PIC X(03) VALUE "2764EAST".
             03 FILLER         PIC X(03) VALUE "2774EAST".
             03 FILLER         PIC X(03) VALUE "2784EAST".
             03 FILLER         PIC X(03) VALUE "2794EAST".
             03 FILLER         PIC X(03) VALUE "2804EAST".
             03 FILLER         PIC X(03) VALUE "2814EAST".
             03 FILLER         PIC X(03) VALUE "2824EAST".
             03 FILLER         PIC X(03) VALUE "2834EAST".
             03 FILLER         PIC X(03) VALUE "2844EAST".
             03 FILLER         PIC X(03) VALUE "2854EAST".
             03 FILLER         PIC X(03) VALUE "2864EAST".
             03 FILLER         PIC X(03) VALUE "2874EAST".
             03 FILLER         PIC X(03) VALUE "2884EAST".
             03 FILLER         PIC X(03) VALUE "2894EAST".
             03 FILLER         PIC X(03) VALUE "2904EAST".
             03 FILLER         PIC X(03) VALUE "2914EAST".
             03 FILLER         PIC X(03) VALUE "2924EAST".
             03 FILLER         PIC X(03) VALUE "2934EAST".
             03 FILLER         PIC X(03) VALUE "2944EAST".
             03 FILLER         PIC X(03) VALUE "2954EAST".
             03 FILLER         PIC X(03) VALUE "2964EAST".
             03 FILLER         PIC X(03) VALUE "2974EAST".
             03 FILLER         PIC X(03) VALUE "2984EAST".
             03 FILLER         PIC X(03) VALUE "2994EAST".
             03 FILLER         PIC X(03) VALUE "3005SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3015SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3025SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3035SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3045SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3055SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3065SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3075SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3085SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3095SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3105SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3115SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3125SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3135SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3145SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3155SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3165SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3175SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3185SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3195SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3205SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3215SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3225SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3235SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3245SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3255SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3265SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3275SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3285SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3295SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3305SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3315SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3325SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3335SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3345SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3355SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3365SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3375SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3385SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3395SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3405SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3415SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3425SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3435SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3445SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3455SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3465SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3475SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3485SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3495SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3505SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3515SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3525SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3535SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3545SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3555SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3565SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3575SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3585SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3595SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3605SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3615SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3625SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3635SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3645SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3655SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3665SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3675SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3685SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3695SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3705SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3715SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3725SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3735SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3745SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3755SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3765SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3775SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3785SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3795SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3805SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3815SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3825SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3835SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3845SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3855SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3865SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3875SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3885SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3895SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3905SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3915SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3925SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3935SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3945SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3955SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3965SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3975SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3985SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "3995SOUTHEAST".
             03 FILLER         PIC X(03) VALUE "4006SOUTH".
             03 FILLER         PIC X(03) VALUE "4016SOUTH".
             03 FILLER         PIC X(03) VALUE "4026SOUTH".
             03 FILLER         PIC X(03) VALUE "4036SOUTH".
             03 FILLER         PIC X(03) VALUE "4046SOUTH".
             03 FILLER         PIC X(03) VALUE "4056SOUTH".
             03 FILLER         PIC X(03) VALUE "4066SOUTH".
             03 FILLER         PIC X(03) VALUE "4076SOUTH".
             03 FILLER         PIC X(03) VALUE "4086SOUTH".
             03 FILLER         PIC X(03) VALUE "4096SOUTH".
             03 FILLER         PIC X(03) VALUE "4106SOUTH".
             03 FILLER         PIC X(03) VALUE "4116SOUTH".
             03 FILLER         PIC X(03) VALUE "4126SOUTH".
             03 FILLER         PIC X(03) VALUE "4136SOUTH".
             03 FILLER         PIC X(03) VALUE "4146SOUTH".
             03 FILLER         PIC X(03) VALUE "4156SOUTH".
             03 FILLER         PIC X(03) VALUE "4166SOUTH".
             03 FILLER         PIC X(03) VALUE "4176SOUTH".
             03 FILLER         PIC X(03) VALUE "4186SOUTH".
             03 FILLER         PIC X(03) VALUE "4196SOUTH".
             03 FILLER         PIC X(03) VALUE "4206SOUTH".
             03 FILLER         PIC X(03) VALUE "4216SOUTH".
             03 FILLER         PIC X(03) VALUE "4226SOUTH".
             03 FILLER         PIC X(03) VALUE "4236SOUTH".
             03 FILLER         PIC X(03) VALUE "4246SOUTH".
             03 FILLER         PIC X(03) VALUE "4256SOUTH".
             03 FILLER         PIC X(03) VALUE "4266SOUTH".
             03 FILLER         PIC X(03) VALUE "4276SOUTH".
             03 FILLER         PIC X(03) VALUE "4286SOUTH".
             03 FILLER         PIC X(03) VALUE "4296SOUTH".
             03 FILLER         PIC X(03) VALUE "4306SOUTH".
             03 FILLER         PIC X(03) VALUE "4316SOUTH".
             03 FILLER         PIC X(03) VALUE "4326SOUTH".
             03 FILLER         PIC X(03) VALUE "4336SOUTH".
             03 FILLER         PIC X(03) VALUE "4346SOUTH".
             03 FILLER         PIC X(03) VALUE "4356SOUTH".
             03 FILLER         PIC X(03) VALUE "4366SOUTH".
             03 FILLER         PIC X(03) VALUE "4376SOUTH".
             03 FILLER         PIC X(03) VALUE "4386SOUTH".
             03 FILLER         PIC X(03) VALUE "4396SOUTH".
             03 FILLER         PIC X(03) VALUE "4406SOUTH".
             03 FILLER         PIC X(03) VALUE "4416SOUTH".
             03 FILLER         PIC X(03) VALUE "4426SOUTH".
             03 FILLER         PIC X(03) VALUE "4436SOUTH".
             03 FILLER         PIC X(03) VALUE "4446SOUTH".
             03 FILLER         PIC X(03) VALUE "4456SOUTH".
             03 FILLER         PIC X(03) VALUE "4466SOUTH".
             03 FILLER         PIC X(03) VALUE "4476SOUTH".
             03 FILLER         PIC X(03) VALUE "4486SOUTH".
             03 FILLER         PIC X(03) VALUE "4496SOUTH".
             03 FILLER         PIC X(03) VALUE "4506SOUTH".
             03 FILLER         PIC X(03) VALUE "4516SOUTH".
             03 FILLER         PIC X(03) VALUE "4526SOUTH".
             03 FILLER         PIC X(03) VALUE "4536SOUTH".
             03 FILLER         PIC X(03) VALUE "4546SOUTH".
             03 FILLER         PIC X(03) VALUE "4556SOUTH".
             03 FILLER         PIC X(03) VALUE "4566SOUTH".
             03 FILLER         PIC X(03) VALUE "4576SOUTH".
             03 FILLER         PIC X(03) VALUE "4586SOUTH".
             03 FILLER         PIC X(03) VALUE "4596SOUTH".
             03 FILLER         PIC X(03) VALUE "4606SOUTH".
             03 FILLER         PIC X(03) VALUE "4616SOUTH".
             03 FILLER         PIC X(03) VALUE "4626SOUTH".
             03 FILLER         PIC X(03) VALUE "4636SOUTH".
             03 FILLER         PIC X(03) VALUE "4646SOUTH".
             03 FILLER         PIC X(03) VALUE "4656SOUTH".
             03 FILLER         PIC X(03) VALUE "4666SOUTH".
             03 FILLER         PIC X(03) VALUE "4676SOUTH".
             03 FILLER         PIC X(03) VALUE "4686SOUTH".
             03 FILLER         PIC X(03) VALUE "4696SOUTH".
             03 FILLER         PIC X(03) VALUE "4706SOUTH".
             03 FILLER         PIC X(03) VALUE "4716SOUTH".
             03 FILLER         PIC X(03) VALUE "4726SOUTH".
             03 FILLER         PIC X(03) VALUE "4736SOUTH".
             03 FILLER         PIC X(03) VALUE "4746SOUTH".
             03 FILLER         PIC X(03) VALUE "4756SOUTH".
             03 FILLER         PIC X(03) VALUE "4766SOUTH".
             03 FILLER         PIC X(03) VALUE "4776SOUTH".
             03 FILLER         PIC X(03) VALUE "4786SOUTH".
             03 FILLER         PIC X(03) VALUE "4796SOUTH".
             03 FILLER         PIC X(03) VALUE "4806SOUTH".
             03 FILLER         PIC X(03) VALUE "4816SOUTH".
             03 FILLER         PIC X(03) VALUE "4826SOUTH".
             03 FILLER         PIC X(03) VALUE "4836SOUTH".
             03 FILLER         PIC X(03) VALUE "4846SOUTH".
             03 FILLER         PIC X(03) VALUE "4856SOUTH".
             03 FILLER         PIC X(03) VALUE "4866SOUTH".
             03 FILLER         PIC X(03) VALUE "4876SOUTH".
             03 FILLER         PIC X(03) VALUE "4886SOUTH".
             03 FILLER         PIC X(03) VALUE "4896SOUTH".
             03 FILLER         PIC X(03) VALUE "4906SOUTH".
             03 FILLER         PIC X(03) VALUE "4916SOUTH".
             03 FILLER         PIC X(03) VALUE "4926SOUTH".
             03 FILLER         PIC X(03) VALUE "4936SOUTH".
             03 FILLER         PIC X(03) VALUE "4946SOUTH".
             03 FILLER         PIC X(03) VALUE "4956SOUTH".
             03 FILLER         PIC X(03) VALUE "4966SOUTH".
             03 FILLER         PIC X(03) VALUE "4976SOUTH".
             03 FILLER         PIC X(03) VALUE "4986SOUTH".
             03 FILLER         PIC X(03) VALUE "4996SOUTH".
             03 FILLER         PIC X(03) VALUE "5007SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5017SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5027SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5037SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5047SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5057SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5067SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5077SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5087SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5097SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5107SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5117SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5127SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5137SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5147SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5157SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5167SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5177SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5187SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5197SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5207SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5217SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5227SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5237SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5247SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5257SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5267SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5277SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5287SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5297SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5307SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5317SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5327SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5337SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5347SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5357SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5367SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5377SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5387SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5397SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5407SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5417SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5427SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5437SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5447SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5457SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5467SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5477SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5487SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5497SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5507SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5517SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5527SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5537SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5547SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5557SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5567SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5577SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5587SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5597SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5607SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5617SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5627SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5637SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5647SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5657SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5667SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5677SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5687SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5697SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5707SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5717SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5727SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5737SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5747SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5757SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5767SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5777SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5787SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5797SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5807SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5817SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5827SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5837SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5847SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5857SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5867SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5877SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5887SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5897SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5907SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5917SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5927SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5937SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5947SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5957SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5967SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5977SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5987SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "5997SOUTHWEST".
             03 FILLER         PIC X(03) VALUE "6008WEST".
             03 FILLER         PIC X(03) VALUE "6018WEST".
             03 FILLER         PIC X(03) VALUE "6028WEST".
             03 FILLER         PIC X(03) VALUE "6038WEST".
             03 FILLER         PIC X(03) VALUE "6048WEST".
             03 FILLER         PIC X(03) VALUE "6058WEST".
             03 FILLER         PIC X(03) VALUE "6068WEST".
             03 FILLER         PIC X(03) VALUE "6078WEST".
             03 FILLER         PIC X(03) VALUE "6088WEST".
             03 FILLER         PIC X(03) VALUE "6098WEST".
             03 FILLER         PIC X(03) VALUE "6108WEST".
             03 FILLER         PIC X(03) VALUE "6118WEST".
             03 FILLER         PIC X(03) VALUE "6128WEST".
             03 FILLER         PIC X(03) VALUE "6138WEST".
             03 FILLER         PIC X(03) VALUE "6148WEST".
             03 FILLER         PIC X(03) VALUE "6158WEST".
             03 FILLER         PIC X(03) VALUE "6168WEST".
             03 FILLER         PIC X(03) VALUE "6178WEST".
             03 FILLER         PIC X(03) VALUE "6188WEST".
             03 FILLER         PIC X(03) VALUE "6198WEST".
             03 FILLER         PIC X(03) VALUE "6208WEST".
             03 FILLER         PIC X(03) VALUE "6218WEST".
             03 FILLER         PIC X(03) VALUE "6228WEST".
             03 FILLER         PIC X(03) VALUE "6238WEST".
             03 FILLER         PIC X(03) VALUE "6248WEST".
             03 FILLER         PIC X(03) VALUE "6258WEST".
             03 FILLER         PIC X(03) VALUE "6268WEST".
             03 FILLER         PIC X(03) VALUE "6278WEST".
             03 FILLER         PIC X(03) VALUE "6288WEST".
             03 FILLER         PIC X(03) VALUE "6298WEST".
             03 FILLER         PIC X(03) VALUE "6308WEST".
             03 FILLER         PIC X(03) VALUE "6318WEST".
             03 FILLER         PIC X(03) VALUE "6328WEST".
             03 FILLER         PIC X(03) VALUE "6338WEST".
             03 FILLER         PIC X(03) VALUE "6348WEST".
             03 FILLER         PIC X(03) VALUE "6358WEST".
             03 FILLER         PIC X(03) VALUE "6368WEST".
             03 FILLER         PIC X(03) VALUE "6378WEST".
             03 FILLER         PIC X(03) VALUE "6388WEST".
             03 FILLER         PIC X(03) VALUE "6398WEST".
             03 FILLER         PIC X(03) VALUE "6408WEST".
             03 FILLER         PIC X(03) VALUE "6418WEST".
             03 FILLER         PIC X(03) VALUE "6428WEST".
             03 FILLER         PIC X(03) VALUE "6438WEST".
             03 FILLER         PIC X(03) VALUE "6448WEST".
             03 FILLER         PIC X(03) VALUE "6458WEST".
             03 FILLER         PIC X(03) VALUE "6468WEST".
             03 FILLER         PIC X(03) VALUE "6478WEST".
             03 FILLER         PIC X(03) VALUE "6488WEST".
             03 FILLER         PIC X(03) VALUE "6498WEST".
             03 FILLER         PIC X(03) VALUE "6508WEST".
             03 FILLER         PIC X(03) VALUE "6518WEST".
             03 FILLER         PIC X(03) VALUE "6528WEST".
             03 FILLER         PIC X(03) VALUE "6538WEST".
             03 FILLER         PIC X(03) VALUE "6548WEST".
             03 FILLER         PIC X(03) VALUE "6558WEST".
             03 FILLER         PIC X(03) VALUE "6568WEST".
             03 FILLER         PIC X(03) VALUE "6578WEST".
             03 FILLER         PIC X(03) VALUE "6588WEST".
             03 FILLER         PIC X(03) VALUE "6598WEST".
             03 FILLER         PIC X(03) VALUE "6608WEST".
             03 FILLER         PIC X(03) VALUE "6618WEST".
             03 FILLER         PIC X(03) VALUE "6628WEST".
             03 FILLER         PIC X(03) VALUE "6638WEST".
             03 FILLER         PIC X(03) VALUE "6648WEST".
             03 FILLER         PIC X(03) VALUE "6658WEST".
             03 FILLER         PIC X(03) VALUE "6668WEST".
             03 FILLER         PIC X(03) VALUE "6678WEST".
             03 FILLER         PIC X(03) VALUE "6688WEST".
             03 FILLER         PIC X(03) VALUE "6698WEST".
             03 FILLER         PIC X(03) VALUE "6708WEST".
             03 FILLER         PIC X(03) VALUE "6718WEST".
             03 FILLER         PIC X(03) VALUE "6728WEST".
             03 FILLER         PIC X(03) VALUE "6738WEST".
             03 FILLER         PIC X(03) VALUE "6748WEST".
             03 FILLER         PIC X(03) VALUE "6758WEST".
             03 FILLER         PIC X(03) VALUE "6768WEST".
             03 FILLER         PIC X(03) VALUE "6778WEST".
             03 FILLER         PIC X(03) VALUE "6788WEST".
             03 FILLER         PIC X(03) VALUE "6798WEST".
             03 FILLER         PIC X(03) VALUE "6808WEST".
             03 FILLER         PIC X(03) VALUE "6818WEST".
             03 FILLER         PIC X(03) VALUE "6828WEST".
             03 FILLER         PIC X(03) VALUE "6838WEST".
             03 FILLER         PIC X(03) VALUE "6848WEST".
             03 FILLER         PIC X(03) VALUE "6858WEST".
             03 FILLER         PIC X(03) VALUE "6868WEST".
             03 FILLER         PIC X(03) VALUE "6878WEST".
             03 FILLER         PIC X(03) VALUE "6888WEST".
             03 FILLER         PIC X(03) VALUE "6898WEST".
             03 FILLER         PIC X(03) VALUE "6908WEST".
             03 FILLER         PIC X(03) VALUE "6918WEST".
             03 FILLER         PIC X(03) VALUE "6928WEST".
             03 FILLER         PIC X(03) VALUE "6938WEST".
             03 FILLER         PIC X(03) VALUE "6948WEST".
             03 FILLER         PIC X(03) VALUE "6958WEST".
             03 FILLER         PIC X(03) VALUE "6968WEST".
             03 FILLER         PIC X(03) VALUE "6978WEST".
             03 FILLER         PIC X(03) VALUE "6988WEST".
             03 FILLER         PIC X(03) VALUE "6998WEST".
             03 FILLER         PIC X(03) VALUE "7003NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7013NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7023NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7033NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7043NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7053NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7063NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7073NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7083NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7093NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7103NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7113NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7123NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7133NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7143NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7153NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7163NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7173NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7183NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7193NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7203NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7213NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7223NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7233NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7243NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7253NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7263NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7273NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7283NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7293NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7303NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7313NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7323NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7333NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7343NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7353NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7363NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7373NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7383NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7393NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7403NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7413NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7423NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7433NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7443NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7453NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7463NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7473NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7483NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7493NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7503NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7513NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7523NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7533NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7543NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7553NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7563NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7573NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7583NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7593NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7603NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7613NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7623NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7633NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7643NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7653NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7663NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7673NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7683NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7693NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7703NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7713NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7723NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7733NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7743NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7753NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7763NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7773NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7783NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7793NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7803NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7813NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7823NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7833NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7843NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7853NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7863NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7873NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7883NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7893NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7903NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7913NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7923NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7933NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7943NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7953NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7963NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7973NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7983NORTHWEST".
             03 FILLER         PIC X(03) VALUE "7993NORTHWEST".
             03 FILLER         PIC X(03) VALUE "8009CENTRAL".
             03 FILLER         PIC X(03) VALUE "8019CENTRAL".
             03 FILLER         PIC X(03) VALUE "8029CENTRAL".
             03 FILLER         PIC X(03) VALUE "8039CENTRAL".
             03 FILLER         PIC X(03) VALUE "8049CENTRAL".
             03 FILLER         PIC X(03) VALUE "8059CENTRAL".
             03 FILLER         PIC X(03) VALUE "8069CENTRAL".
             03 FILLER         PIC X(03) VALUE "8079CENTRAL".
             03 FILLER         PIC X(03) VALUE "8089CENTRAL".
             03 FILLER         PIC X(03) VALUE "8099CENTRAL".
             03 FILLER         PIC X(03) VALUE "8109CENTRAL".
             03 FILLER         PIC X(03) VALUE "8119CENTRAL".
             03 FILLER         PIC X(03) VALUE "8129CENTRAL".
             03 FILLER         PIC X(03) VALUE "8139CENTRAL".
             03 FILLER         PIC X(03) VALUE "8149CENTRAL".
             03 FILLER         PIC X(03) VALUE "8159CENTRAL".
             03 FILLER         PIC X(03) VALUE "8169CENTRAL".
             03 FILLER         PIC X(03) VALUE "8179CENTRAL".
             03 FILLER         PIC X(03) VALUE "8189CENTRAL".
             03 FILLER         PIC X(03) VALUE "8199CENTRAL".
             03 FILLER         PIC X(03) VALUE "8209CENTRAL".
             03 FILLER         PIC X(03) VALUE "8219CENTRAL".
             03 FILLER         PIC X(03) VALUE "8229CENTRAL".
             03 FILLER         PIC X(03) VALUE "8239CENTRAL".
             03 FILLER         PIC X(03) VALUE "8249CENTRAL".
             03 FILLER         PIC X(03) VALUE "8259CENTRAL".
             03 FILLER         PIC X(03) VALUE "8269CENTRAL".
             03 FILLER         PIC X(03) VALUE "8279CENTRAL".
             03 FILLER         PIC X(03) VALUE "8289CENTRAL".
             03 FILLER         PIC X(03) VALUE "8299CENTRAL".
             03 FILLER         PIC X(03) VALUE "8309CENTRAL".
             03 FILLER         PIC X(03) VALUE "8319CENTRAL".
             03 FILLER         PIC X(03) VALUE "8329CENTRAL".
             03 FILLER         PIC X(03) VALUE "8339CENTRAL".
             03 FILLER         PIC X(03) VALUE "8349CENTRAL".
             03 FILLER         PIC X(03) VALUE "8359CENTRAL".
             03 FILLER         PIC X(03) VALUE "8369CENTRAL".
             03 FILLER         PIC X(03) VALUE "8379CENTRAL".
             03 FILLER         PIC X(03) VALUE "8389CENTRAL".
             03 FILLER         PIC X(03) VALUE "8399CENTRAL".
             03 FILLER         PIC X(03) VALUE "8409CENTRAL".
             03 FILLER         PIC X(03) VALUE "8419CENTRAL".
             03 FILLER         PIC X(03) VALUE "8429CENTRAL".
             03 FILLER         PIC X(03) VALUE "8439CENTRAL".
             03 FILLER         PIC X(03) VALUE "8449CENTRAL".
             03 FILLER         PIC X(03) VALUE "8459CENTRAL".
             03 FILLER         PIC X(03) VALUE "8469CENTRAL".
             03 FILLER         PIC X(03) VALUE "8479CENTRAL".
             03 FILLER         PIC X(03) VALUE "8489CENTRAL".
             03 FILLER         PIC X(03) VALUE "8499CENTRAL".
             03 FILLER         PIC X(03) VALUE "8509CENTRAL".
             03 FILLER         PIC X(03) VALUE "8519CENTRAL".
             03 FILLER         PIC X(03) VALUE "8529CENTRAL".
             03 FILLER         PIC X(03) VALUE "8539CENTRAL".
             03 FILLER         PIC X(03) VALUE "8549CENTRAL".
             03 FILLER         PIC X(03) VALUE "8559CENTRAL".
             03 FILLER         PIC X(03) VALUE "8569CENTRAL".
             03 FILLER         PIC X(03) VALUE "8579CENTRAL".
             03 FILLER         PIC X(03) VALUE "8589CENTRAL".
             03 FILLER         PIC X(03) VALUE "8599CENTRAL".
             03 FILLER         PIC X(03) VALUE "8609CENTRAL".
             03 FILLER         PIC X(03) VALUE "8619CENTRAL".
             03 FILLER         PIC X(03) VALUE "8629CENTRAL".
             03 FILLER         PIC X(03) VALUE "8639CENTRAL".
             03 FILLER         PIC X(03) VALUE "8649CENTRAL".
             03 FILLER         PIC X(03) VALUE "8659CENTRAL".
             03 FILLER         PIC X(03) VALUE "8669CENTRAL".
             03 FILLER         PIC X(03) VALUE "8679CENTRAL".
             03 FILLER         PIC X(03) VALUE "8689CENTRAL".
             03 FILLER         PIC X(03) VALUE "8699CENTRAL".
             03 FILLER         PIC X(03) VALUE "8709CENTRAL".
             03 FILLER         PIC X(03) VALUE "8719CENTRAL".
             03 FILLER         PIC X(03) VALUE "8729CENTRAL".
             03 FILLER         PIC X(03) VALUE "8739CENTRAL".
             03 FILLER         PIC X(03) VALUE "8749CENTRAL".
             03 FILLER         PIC X(03) VALUE "8759CENTRAL".
             03 FILLER         PIC X(03) VALUE "8769CENTRAL".
             03 FILLER         PIC X(03) VALUE "8779CENTRAL".
             03 FILLER         PIC X(03) VALUE "8789CENTRAL".
             03 FILLER         PIC X(03) VALUE "8799CENTRAL".
             03 FILLER         PIC X(03) VALUE "8809CENTRAL".
             03 FILLER         PIC X(03) VALUE "8819CENTRAL".
             03 FILLER         PIC X(03) VALUE "8829CENTRAL".
             03 FILLER         PIC X(03) VALUE "8839CENTRAL".
             03 FILLER         PIC X(03) VALUE "8849CENTRAL".
             03 FILLER         PIC X(03) VALUE "8859CENTRAL".
             03 FILLER         PIC X(03) VALUE "8869CENTRAL".
             03 FILLER         PIC X(03) VALUE "8879CENTRAL".
             03 FILLER         PIC X(03) VALUE "8889CENTRAL".
             03 FILLER         PIC X(03) VALUE "8899CENTRAL".
             03 FILLER         PIC X(03) VALUE "8909CENTRAL".
             03 FILLER         PIC X(03) VALUE "8919CENTRAL".
             03 FILLER         PIC X(03) VALUE "8929CENTRAL".
             03 FILLER         PIC X(03) VALUE "8939CENTRAL".
             03 FILLER         PIC X(03) VALUE "8949CENTRAL".
             03 FILLER         PIC X(03) VALUE "8959CENTRAL".
             03 FILLER         PIC X(03) VALUE "8969CENTRAL".
             03 FILLER         PIC X(03) VALUE "8979CENTRAL".
             03 FILLER         PIC X(03) VALUE "8989CENTRAL".
             03 FILLER         PIC X(03) VALUE "8999CENTRAL".
             03 FILLER         PIC X(03) VALUE "9009CENTRAL".
             03 FILLER         PIC X(03) VALUE "9019CENTRAL".
             03 FILLER         PIC X(03) VALUE "9029CENTRAL".
             03 FILLER         PIC X(03) VALUE "9039CENTRAL".
             03 FILLER         PIC X(03) VALUE "9049CENTRAL".
             03 FILLER         PIC X(03) VALUE "9059CENTRAL".
             03 FILLER         PIC X(03) VALUE "9069CENTRAL".
             03 FILLER         PIC X(03) VALUE "9079CENTRAL".
             03 FILLER         PIC X(03) VALUE "9089CENTRAL".
             03 FILLER         PIC X(03) VALUE "9099CENTRAL".
             03 FILLER         PIC X(03) VALUE "9109CENTRAL".
             03 FILLER         PIC X(03) VALUE "9119CENTRAL".
             03 FILLER         PIC X(03) VALUE "9129CENTRAL".
             03 FILLER         PIC X(03) VALUE "9139CENTRAL".
             03 FILLER         PIC X(03) VALUE "9149CENTRAL".
             03 FILLER         PIC X(03) VALUE "9159CENTRAL".
             03 FILLER         PIC X(03) VALUE "9169CENTRAL".
             03 FILLER         PIC X(03) VALUE "9179CENTRAL".
             03 FILLER         PIC X(03) VALUE "9189CENTRAL".
             03 FILLER         PIC X(03) VALUE "9199CENTRAL".
             03 FILLER         PIC X(03) VALUE "9209CENTRAL".
             03 FILLER         PIC X(03) VALUE "9219CENTRAL".
             03 FILLER         PIC X(03) VALUE "9229CENTRAL".
             03 FILLER         PIC X(03) VALUE "9239CENTRAL".
             03 FILLER         PIC X(03) VALUE "9249CENTRAL".
             03 FILLER         PIC X(03) VALUE "9259CENTRAL".
             03 FILLER         PIC X(03) VALUE "9269CENTRAL".
             03 FILLER         PIC X(03) VALUE "9279CENTRAL".
             03 FILLER         PIC X(03) VALUE "9289CENTRAL".
             03 FILLER         PIC X(03) VALUE "9299CENTRAL".
             03 FILLER         PIC X(03) VALUE "9309CENTRAL".
             03 FILLER         PIC X(03) VALUE "9319CENTRAL".
             03 FILLER         PIC X(03) VALUE "9329CENTRAL".
             03 FILLER         PIC X(03) VALUE "9339CENTRAL".
             03 FILLER         PIC X(03) VALUE "9349CENTRAL".
             03 FILLER         PIC X(03) VALUE "9359CENTRAL".
             03 FILLER         PIC X(03) VALUE "9369CENTRAL".
             03 FILLER         PIC X(03) VALUE "9379CENTRAL".
             03 FILLER         PIC X(03) VALUE "9389CENTRAL".
             03 FILLER         PIC X(03) VALUE "9399CENTRAL".
             03 FILLER         PIC X(03) VALUE "9409CENTRAL".
             03 FILLER         PIC X(03) VALUE "9419CENTRAL".
             03 FILLER         PIC X(03) VALUE "9429CENTRAL".
             03 FILLER         PIC X(03) VALUE "9439CENTRAL".
             03 FILLER         PIC X(03) VALUE "9449CENTRAL".
             03 FILLER         PIC X(03) VALUE "9459CENTRAL".
             03 FILLER         PIC X(03) VALUE "9469CENTRAL".
             03 FILLER         PIC X(03) VALUE "9479CENTRAL".
             03 FILLER         PIC X(03) VALUE "9489CENTRAL".
             03 FILLER         PIC X(03) VALUE "9499CENTRAL".
             03 FILLER         PIC X(03) VALUE "9509CENTRAL".
             03 FILLER         PIC X(03) VALUE "9519CENTRAL".
             03 FILLER         PIC X(03) VALUE "9529CENTRAL".
             03 FILLER         PIC X(03) VALUE "9539CENTRAL".
             03 FILLER         PIC X(03) VALUE "9549CENTRAL".
             03 FILLER         PIC X(03) VALUE "9559CENTRAL".
             03 FILLER         PIC X(03) VALUE "9569CENTRAL".
             03 FILLER         PIC X(03) VALUE "9579CENTRAL".
             03 FILLER         PIC X(03) VALUE "9589CENTRAL".
             03 FILLER         PIC X(03) VALUE "9599CENTRAL".
             03 FILLER         PIC X(03) VALUE "9609CENTRAL".
             03 FILLER         PIC X(03) VALUE "9619CENTRAL".
             03 FILLER         PIC X(03) VALUE "9629CENTRAL".
             03 FILLER         PIC X(03) VALUE "9639CENTRAL".
             03 FILLER         PIC X(03) VALUE "9649CENTRAL".
             03 FILLER         PIC X(03) VALUE "9659CENTRAL".
             03 FILLER         PIC X(03) VALUE "9669CENTRAL".
             03 FILLER         PIC X(03) VALUE "9679CENTRAL".
             03 FILLER         PIC X(03) VALUE "9689CENTRAL".
             03 FILLER         PIC X(03) VALUE "9699CENTRAL".
             03 FILLER         PIC X(03) VALUE "9709CENTRAL".
             03 FILLER         PIC X(03) VALUE "9719CENTRAL".
             03 FILLER         PIC X(03) VALUE "9729CENTRAL".
             03 FILLER         PIC X(03) VALUE "9739CENTRAL".
             03 FILLER         PIC X(03) VALUE "9749CENTRAL".
             03 FILLER         PIC X(03) VALUE "9759CENTRAL".
             03 FILLER         PIC X(03) VALUE "9769CENTRAL".
             03 FILLER         PIC X(03) VALUE "9779CENTRAL".
             03 FILLER         PIC X(03) VALUE "9789CENTRAL".
             03 FILLER         PIC X(03) VALUE "9799CENTRAL".
             03 FILLER         PIC X(03) VALUE "9809CENTRAL".
             03 FILLER         PIC X(03) VALUE "9819CENTRAL".
             03 FILLER         PIC X(03) VALUE "9829CENTRAL".
             03 FILLER         PIC X(03) VALUE "9839CENTRAL".
             03 FILLER         PIC X(03) VALUE "9849CENTRAL".
             03 FILLER         PIC X(03) VALUE "9859CENTRAL".
             03 FILLER         PIC X(03) VALUE "9869CENTRAL".
             03 FILLER         PIC X(03) VALUE "9879CENTRAL".
             03 FILLER         PIC X(03) VALUE "9889CENTRAL".
             03 FILLER         PIC X(03) VALUE "9899CENTRAL".
             03 FILLER         PIC X(03) VALUE "9909CENTRAL".
             03 FILLER         PIC X(03) VALUE "9919CENTRAL".
             03 FILLER         PIC X(03) VALUE "9929CENTRAL".
             03 FILLER         PIC X(03) VALUE "9939CENTRAL".
             03 FILLER         PIC X(03) VALUE "9949CENTRAL".
             03 FILLER         PIC X(03) VALUE "9959CENTRAL".
             03 FILLER         PIC X(03) VALUE "9969CENTRAL".
             03 FILLER         PIC X(03) VALUE "9979CENTRAL".
             03 FILLER         PIC X(03) VALUE "9989CENTRAL".
             03 FILLER         PIC X(03) VALUE "9999CENTRAL".

          02 FILLERH REDEFINES TABLEVALUES.
             03 AREACODETAB OCCURS 999 TIMES 
                         ASCENDING KEY IS AREACODE
                         INDEXED BY AIDX.
               05 AREACODE     PIC X(03).
               05 ZONENUM      PIC 9.
               05 ZONEDESC     PIC X(09).
       
       01 ZONEDESCCOUNT OCCURS 9 TIMES PIC 99999 VALUE ZEROS.
       
       01 ZONEDESCIDX             PIC 99.
       
       01 WS-EMPDATA-REC.
                 05 WS-EMPDATA-EMPNO		PIC X(06).
                 05 WS-EMPDATA-NAME		PIC X(34).
                 05 WS-EMPDATA-WORKDEPT		PIC X(03).
                 05 WS-EMPDATA-AREACODE		PIC X(03).
                 05 WS-EMPDATA-HIREDDATE.
                    10 WS-EMPDATA-HIREDDATE-YR  PIC X(04).
                    10 WS-FILLER		PIC X(01).
                    10 WS-EMPDATA-HIREDDATE-MO	PIC X(02).
                    10 WS-FILLER		PIC X(01).
                    10 WS-EMPDATA-HIREDDATE-DD	PIC X(02).
                 05 WS-EMPDATA-OTHDETAILS		PIC X(64).
       
       01 HEADINGLINE          PIC X(21) VALUE " ZONEDESC    EMPCOUNT".
       
       01 DISPLAYLINE.
          02 PRNZONEDESC       PIC X(09).
          02 FILLER            PIC X(4) VALUE SPACES.
          02 PRNEMPCOUNT       PIC ZZZZ9.
        
       
      *-----------------------------------------------------------------
      * PROCEDURE DIVISION.                                                
      *-----------------------------------------------------------------
       PROCEDURE DIVISION.
      *-----------------------------------------------------------------
      * THIS MODULE OPENS THE EMPLOYEE DATA FILE AND IMPLEMENTS TABLE     
      * AND ARRAY FACILITIES OF COBOL TO DEMONSTARTE THE CAPABILITIES.
      *-----------------------------------------------------------------
       100-MAIN-MODULE.
          OPEN INPUT EMPDATA.
          
          READ EMPDATA
             AT END SET ENDOFEMPFILE TO TRUE
          END-READ.
          
          MOVE CORRESPONDING EMPDATA-REC TO WS-EMPDATA-REC.
          
          PERFORM UNTIL ENDOFEMPFILE

             SEARCH ALL AREACODETAB 
                 WHEN AREACODE(AIDX) = 	EMPDATA-AREACODE
             	    ADD 1 TO ZONEDESCCOUNT(ZONENUM)
             END-SEARCH	    

             READ EMPDATA
                AT END SET ENDOFEMPFILE TO TRUE
             END-READ

          END-PERFORM.
       
          DISPLAY HEADINGLINE UPON CONSOLE. 
          
          PERFORM VARYING ZONEDESCIDX FROM 1 BY 1 UNTIL ZONEDESCIDX > 9
             MOVE ZONEDESC(ZONEDESCIDX) TO PRNZONEDESC
             MOVE ZONEDESCCOUNT(ZONEDESCIDX) TO PRNEMPCOUNT
             DISPLAY DISPLAYLINE UPON CONSOLE
          END-PERFORM.
       
          CLOSE EMPDATA.
          
   	  STOP RUN.