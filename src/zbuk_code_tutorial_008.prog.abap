*&---------------------------------------------------------------------*
*& Report  SAPHTML_DEMO1                                               *
*&---------------------------------------------------------------------*
REPORT  zbuk_code_tutorial_008.

DATA: html_control TYPE REF TO cl_gui_html_viewer,
      my_container TYPE REF TO cl_gui_custom_container,
      fcode LIKE sy-ucomm,
      myevent_tab TYPE cntl_simple_events,
      myevent TYPE cntl_simple_event,
      edurl(2048),
      alignment TYPE i.

*****************************************************
*              CLASS cl_myevent_handler             *
*****************************************************
CLASS cl_myevent_handler DEFINITION.

  PUBLIC SECTION.
    METHODS: on_navigate_complete
               FOR EVENT navigate_complete OF cl_gui_html_viewer
               IMPORTING url.
ENDCLASS.

DATA: evt_receiver TYPE REF TO cl_myevent_handler.

SET SCREEN 100.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'TESTHTM1'.
  SET TITLEBAR '001'.

  IF my_container IS INITIAL.

    CREATE OBJECT my_container
        EXPORTING
            container_name = 'HTML'
        EXCEPTIONS
            others = 1.
    CASE sy-subrc.
      WHEN 0.
*
      WHEN OTHERS.
        RAISE cntl_error.
    ENDCASE.
  ENDIF.

  IF html_control IS INITIAL.
    CREATE OBJECT html_control
         EXPORTING
              parent    = my_container.
    IF sy-subrc NE 0.
      RAISE cntl_error.
    ENDIF.

* register event

*************************************************************
* DON'T USE the NAVIGATE_COMPLETE event in application logic
*************************************************************
    myevent-eventid = html_control->m_id_navigate_complete.
    myevent-appl_event = 'X'.
    APPEND myevent TO myevent_tab.
    CALL METHOD html_control->set_registered_events
        EXPORTING
           events = myevent_tab.

    CREATE OBJECT evt_receiver.

    SET HANDLER evt_receiver->on_navigate_complete
                FOR html_control.

    PERFORM load_home_page.
  ENDIF.
ENDMODULE.                             " STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE fcode.
    WHEN 'BACK'.
      IF NOT html_control IS INITIAL.
        CALL METHOD html_control->free.
        FREE html_control.
      ENDIF.
      IF NOT my_container IS INITIAL.
        CALL METHOD my_container->free
          EXCEPTIONS
            OTHERS = 1.
        IF sy-subrc <> 0.
*         MESSAGE E002 WITH F_RETURN.
        ENDIF.
        FREE my_container.
      ENDIF.

      LEAVE PROGRAM.

    WHEN 'HHOM'.                       " show the home page
      CALL METHOD html_control->go_home.

      CALL METHOD html_control->get_current_url
           IMPORTING
                url  = edurl.

    WHEN 'HBAK'.
      CALL METHOD html_control->go_back.

      CALL METHOD html_control->get_current_url
           IMPORTING
                url  = edurl.

    WHEN 'HFWD'.
      CALL METHOD html_control->go_forward.

      CALL METHOD html_control->get_current_url
           IMPORTING
                url  = edurl.

    WHEN 'HRFR'.
      CALL METHOD html_control->do_refresh.

      CALL METHOD html_control->get_current_url
           IMPORTING
                url  = edurl.

    WHEN 'HNAV'.
      IF NOT edurl IS INITIAL.
        CALL METHOD html_control->show_url
             EXPORTING
                  url = edurl
             EXCEPTIONS
                  cnht_error_parameter = 1
                  OTHERS = 2.
        IF sy-subrc GE 2.
          RAISE cntl_error.
        ENDIF.
      ENDIF.

    WHEN OTHERS.
      CALL METHOD cl_gui_cfw=>dispatch.

  ENDCASE.
  CLEAR fcode.
ENDMODULE.                             " USER_COMMAND_0100  INPUT

* Homepage form
FORM load_home_page.
  DATA: doc_url(80).

  CALL METHOD html_control->load_html_document
       EXPORTING
            document_id  = 'HTMLCNTL_CNHTTST1_START'
       IMPORTING
            assigned_url = doc_url
       EXCEPTIONS
            OTHERS       = 1.

  IF sy-subrc EQ 0.
    CALL METHOD html_control->show_url
         EXPORTING
              url       = doc_url.
  ENDIF.
ENDFORM.                               " LOAD_HOME_PAGE

****************************************************
*    cl_myevent_handler implementation             *
****************************************************
CLASS cl_myevent_handler IMPLEMENTATION.

*************************************************************
* DON'T USE the NAVIGATE_COMPLETE event in application logic
*************************************************************
  METHOD on_navigate_complete.
    edurl = url.
  ENDMETHOD.

ENDCLASS.
