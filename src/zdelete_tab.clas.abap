CLASS zdelete_tab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zdelete_tab IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DELETE FROM zfstb_processobj WHERE process_uuid IS NOT NULL.
    DELETE FROM zfstb_processlog WHERE process_uuid IS NOT NULL.
  ENDMETHOD.
ENDCLASS.
