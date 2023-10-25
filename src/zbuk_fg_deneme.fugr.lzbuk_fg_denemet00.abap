*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZBUK_T_SCARR....................................*
DATA:  BEGIN OF STATUS_ZBUK_T_SCARR                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZBUK_T_SCARR                  .
CONTROLS: TCTRL_ZBUK_T_SCARR
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZBUK_T_SCARR                  .
TABLES: ZBUK_T_SCARR                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
