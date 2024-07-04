CLASS zpopulate_status DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpopulate_status IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

      DATA: lt_procobj_st TYPE STANDARD TABLE OF zfstb_procobj_st,
           lt_proclog_st type standard table of zfstb_proclog_st.

      lt_procobj_st = VALUE #( ( status = '1' text = 'IN PROGRESS' )
                               ( status = '2' text = 'COMPLETED' )
                               ( status = '3' text = 'ERROR' ) ).


      lt_proclog_st = VALUE #( ( status = '1' text = 'NEW' )
                               ( status = '2' text = 'IN PROGRESS' )
                               ( status = '3' text = 'COMPLETED' )
                               ( status = '4' text = 'ERROR' )
                               ( status = '5' text = 'USER ACTION' ) ).

      MODIFY zfstb_procobj_st FROM TABLE @lt_procobj_st.
      MODIFY zfstb_proclog_st FROM TABLE @lt_proclog_st.

  ENDMETHOD.
ENDCLASS.
