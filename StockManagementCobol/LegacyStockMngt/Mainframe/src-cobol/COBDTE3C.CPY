000001 01  WORK-DATES.                                                  00000001
000002                                                                  00000002
000003     03  WRK-DATE.                                                00000003
000004         05  WRK-DATE-YY           PIC XX.                        00000004
000005         05  WRK-DATE-MM           PIC XX.                        00000005
000006         05  WRK-DATE-DD           PIC XX.                        00000006
000007                                                                  00000007
000008     03  WRK-DATE-RED REDEFINES WRK-DATE.                         00000008
000009         05  WRK-DTE-YY            PIC XX.                        00000009
000010         05  WRK-DTE-MM            PIC XX.                        00000010
000011         05  WRK-DTE-MM-NUM REDEFINES WRK-DTE-MM  PIC 99.         00000011
000012         05  WRK-DTE-DD            PIC XX.                        00000012
000013         05  WRK-DTE-DD-NUM REDEFINES WRK-DTE-DD  PIC 99.         00000013
000014                                                                  00000014
000015     03  WRK-DATE-YYDDD.                                          00000015
000016         05  WRK-DATE-YY           PIC XX.                        00000016
000017         05  WRK-DATE-DDD          PIC XXX.                       00000017
000018                                                                  00000018
000019     03  WRK-DATE-YYDDD-RED REDEFINES WRK-DATE-YYDDD.             00000019
000020         05  FILLER                PIC XX.                        00000020
000021         05  WRK-DATE-DDD-NUM      PIC 999.                       00000021
000022                                                                  00000022
000023     03  WRK-YEAR-YYYY.                                           00000023
000024         05  WRK-YEAR-19           PIC XX  VALUE "19".            00000024
000025         05  WRK-YEAR-YY           PIC XX.                        00000025
000026     03  WRK-YEAR-YYYY-NUM REDEFINES WRK-YEAR-YYYY PIC 9(4).      00000026
000027     03  WRK-LEAP                  PIC 9.                         00000027
000028                                                                  00000028
000029     03  WRK-DATE-MMXDDXYY.                                       00000029
000030         05  WRK-DATE-MM           PIC XX.                        00000030
000031         05  F1                    PIC X.                         00000031
000032         05  WRK-DATE-DD           PIC XX.                        00000032
000033         05  F2                    PIC X.                         00000033
000034         05  WRK-DATE-YY           PIC XX.                        00000034
000035                                                                  00000035
000036     03  WRK-DATE-YYXDDXMM.                                       00000036
000037         05  WRK-DATE-YY           PIC XX.                        00000037
000038         05  F1                    PIC X.                         00000038
000039         05  WRK-DATE-DD           PIC XX.                        00000039
000040         05  F2                    PIC X.                         00000040
000041         05  WRK-DATE-MM           PIC XX.                        00000041
000042                                                                  00000042
000043     03  WRK-MONTH-DAYS            PIC X(24)  VALUE               00000043
000044         "312831303130313130313031".                              00000044
000045     03  WRK-MTH-DAYS REDEFINES WRK-MONTH-DAYS PIC 99 OCCURS 12.  00000045
