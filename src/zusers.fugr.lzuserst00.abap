*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZUSERS..........................................*
DATA:  BEGIN OF STATUS_ZUSERS                        .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUSERS                        .
CONTROLS: TCTRL_ZUSERS
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZUSERS                        .
TABLES: ZUSERS                         .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
