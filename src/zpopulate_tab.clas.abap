CLASS zpopulate_tab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpopulate_tab IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: ls_processobj type zfstb_processobj,
          ls_processlog TYPE zfstb_processlog,
          lt_processobj TYPE STANDARD TABLE OF zfstb_processobj,
          lt_processlog TYPE STANDARD TABLE OF zfstb_processlog.

        DATA(uuid_gen) = cl_uuid_factory=>create_system_uuid(  ).
        DATA(lv_uuid) = uuid_gen->create_uuid_x16(  ).
        lt_processobj = VALUE #(
                          ( process_uuid = lv_uuid
                            process_category = 'DEMO'
                            process_status_code = '3'
                            created_by = 'Arjan Vailly'

                            ) ).

         lt_processlog = VALUE #(
                            ( process_uuid = lv_uuid
                            process_stepno = '1'
                            process_step_status = '1'
                            created_by = 'Messi'
                            )

                            ( process_uuid = lv_uuid
                            process_stepno = '2'
                            process_step_status = '3'
                            created_by = 'Kohli'
                            ) ).

          MODIFY zfstb_processobj FROM TABLE @lt_processobj.
          MODIFY zfstb_processlog FROM TABLE @lt_processlog.

  ENDMETHOD.
ENDCLASS.
