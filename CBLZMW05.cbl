       IDENTIFICATION DIVISION.
       PROGRAM-ID. CBLX0008.
      ******************************************************************
      * Author: Marcelo Wzorek Filho
      * Date: 18/01/2024
      * Purpose: Programa feito para ordenar um arquivo com base em um CNPJ e gerar um relatorio
      * Updates:
      * 180124 - Marcelo - Create Program
      ******************************************************************
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT LISTA ASSIGN TO
           'C:\VOLVO_ESTAGIO\IDE_COBOL\Exercício05\Devedores.txt'
           FILE STATUS IS AS-STATUS-E.

       SELECT RELATORIO ASSIGN TO
           'C:\VOLVO_ESTAGIO\IDE_COBOL\Exercício05\Relatorio.txt'
           FILE STATUS IS AS-STATUS-S.

       SELECT ARQ-SORT ASSIGN TO
           'C:\VOLVO_ESTAGIO\IDE_COBOL\Exercício05Arqsort.txt'
           FILE STATUS IS AS-STATUS-SD.

       DATA DIVISION.
       FILE SECTION.

       FD LISTA RECORDING MODE IS F BLOCK CONTAINS 0 RECORDS.
       01 WK-LISTA-ARQ                    PIC X(33).
       01 FILLER REDEFINES WK-LISTA-ARQ.
          05 ARQ-CNPJ  PIC 9(14).
          05 ARQ-SIT   PIC 9(02).
          05 ARQ-VALOR PIC 9(13)V99.
          05 ARQ-FIM   PIC X(02).

       FD RELATORIO RECORDING MODE IS F.
       01 FL-RELATORIO-ARQ.
           02 RELATORIO-CNPJ  PIC X(14).
           02 RELATORIO-SPAC01 PIC X(06).
           02 RELATORIO-SIT   PIC X(02).
           02 RELATORIO-SPAC02 PIC X(18).
           02 RELATORIO-VALOR PIC ZZZZZZZZZZZ99V99.

       SD ARQ-SORT RECORDING MODE IS F BLOCK CONTAINS 0 RECORDS.
       01 WK-ARQ-SORT                    PIC X(33).
       01 FILLER REDEFINES WK-ARQ-SORT.
          05 ARQ-S-CNPJ  PIC 9(14).
          05 ARQ-S-SIT   PIC 9(02).
          05 ARQ-S-VALOR PIC 9(13)V99.
          05 ARQ-S-FIM   PIC X(02).

       WORKING-STORAGE SECTION.
       01 AS-STATUS-E  PIC 9(02) VALUE ZEROS.
       01 AS-STATUS-S  PIC 9(02) VALUE ZEROS.
       01 AS-STATUS-SD PIC 9(02) VALUE ZEROS.
       01 WK-FIM       PIC X(01) VALUE SPACES.

       01 WK-CABEC01  PIC X(55) VALUE ALL '='.

       01 WK-CABEC02.
           02 WK-CABEC02-TITU PIC X(32) VALUE 'Meu relatório ordenado'.
           02 WK-CABEC02-DATA PIC XXXXXXXXXX.
           02 WK-CABEC02-SPAC PIC X(05).
           02 WK-CABEC02-HORA PIC XXXXXXXX.

       01 WK-CABEC03.
           02 WK-CABEC03-CNPJ PIC X(20) VALUE 'CNPJ'.
           02 WK-CABEC03-SIT  PIC X(20) VALUE 'SITUACAO'.
           02 WK-CABEC03-VALO PIC X(15) VALUE 'VALOR'.

       01 WK-DATA-SYS.
           02 WK-YEAR-SYS  PIC 9(04) VALUE ZEROS.
           02 WK-MONTH-SYS PIC 9(02) VALUE ZEROS.
           02 WK-DAY-SYS   PIC 9(02) VALUE ZEROS.

       01 WK-HORA-SYS.
           02 WK-HOUR-SYS   PIC 9(02) VALUE ZEROS.
           02 WK-MINUTE-SYS PIC 9(02) VALUE ZEROS.
           02 WK-SECOND-SYS PIC 9(02) VALUE ZEROS.

       PROCEDURE DIVISION.
           PERFORM 1000-INICIALIZAR.
           PERFORM 3000-FINALIZAR.
      *-----------------------------------------------------------------
      *     INCIALIZACAO DO PROGRAMA
      *-----------------------------------------------------------------
       1000-INICIALIZAR SECTION.
           PERFORM 1100-INICIALIZAR-DATA-HORA

           OPEN INPUT LISTA.
           IF AS-STATUS-E NOT EQUAL ZEROS
               DISPLAY 'DEU ERRO NA ABERTURA ' AS-STATUS-E
           END-IF

           OPEN OUTPUT RELATORIO
           IF AS-STATUS-S NOT EQUAL 0
               DISPLAY 'ERRO DE ABERTURA DE ARQUIVO ' AS-STATUS-S
           END-IF.

           PERFORM 1200-INICIALIZAR-CABECALHO

           SORT ARQ-SORT
               ASCENDING KEY ARQ-S-CNPJ
               INPUT PROCEDURE 2000-PROCESSAR
               OUTPUT PROCEDURE 2100-IMPRIMIR-SORT
           .
       1000-INICIALIZAR-EXIT.
           EXIT.
      *-----------------------------------------------------------------
      *     INCIALIZACAO DATA E HORA
      *-----------------------------------------------------------------
       1100-INICIALIZAR-DATA-HORA SECTION.
           ACCEPT WK-DATA-SYS FROM DATE YYYYMMDD

           MOVE WK-DAY-SYS TO WK-CABEC02-DATA (1:2)
           MOVE WK-MONTH-SYS TO WK-CABEC02-DATA (4:2)
           MOVE WK-YEAR-SYS TO WK-CABEC02-DATA (7:4)
           MOVE '/' TO WK-CABEC02-DATA (3:1)
                       WK-CABEC02-DATA (6:1)

           ACCEPT WK-HORA-SYS FROM TIME.

           MOVE WK-HOUR-SYS TO WK-CABEC02-HORA (1:2)
           MOVE WK-MINUTE-SYS TO WK-CABEC02-HORA (4:2)
           MOVE WK-SECOND-SYS TO WK-CABEC02-HORA (7:2)
           MOVE ':' TO WK-CABEC02-HORA (3:1)
                       WK-CABEC02-HORA (6:1)
       .
       1100-INICIALIZAR-DATA-HORA-EXIT.
           EXIT.
      *-----------------------------------------------------------------
      *     INCIALIZACAO CABECALHO
      *-----------------------------------------------------------------
       1200-INICIALIZAR-CABECALHO SECTION.
           MOVE WK-CABEC01 TO FL-RELATORIO-ARQ
           WRITE FL-RELATORIO-ARQ.

           MOVE WK-CABEC02 TO FL-RELATORIO-ARQ
           WRITE FL-RELATORIO-ARQ AFTER ADVANCING 1 LINE.

           MOVE WK-CABEC01 TO FL-RELATORIO-ARQ
           WRITE FL-RELATORIO-ARQ AFTER ADVANCING 1 LINE.

           MOVE WK-CABEC03 TO FL-RELATORIO-ARQ
           WRITE FL-RELATORIO-ARQ AFTER ADVANCING 1 LINE.

       1200-INICIALIZAR-CABECALHO-EXIT.
           EXIT.
      *-----------------------------------------------------------------
      *     PROCESSAMENTO
      *-----------------------------------------------------------------
       2000-PROCESSAR SECTION.
           READ LISTA AT END
                GO TO 2000-PROCESSAR-EXIT.

           MOVE ARQ-CNPJ  TO ARQ-S-CNPJ
           MOVE ARQ-SIT   TO ARQ-S-SIT
           MOVE ARQ-VALOR TO ARQ-S-VALOR

           RELEASE WK-ARQ-SORT
           GO TO 2000-PROCESSAR
           .
       2000-PROCESSAR-EXIT.
           EXIT.
      *-----------------------------------------------------------------
      *     IMPRIMIR SORT
      *-----------------------------------------------------------------
       2100-IMPRIMIR-SORT SECTION.
           RETURN ARQ-SORT AT END MOVE 'F' TO WK-FIM.

           IF WK-FIM NOT EQUAL 'F'
               MOVE ARQ-S-CNPJ  TO RELATORIO-CNPJ
               MOVE SPACES      TO RELATORIO-SPAC01
               MOVE ARQ-S-SIT   TO RELATORIO-SIT
               MOVE SPACES      TO RELATORIO-SPAC02
               MOVE ARQ-S-VALOR TO RELATORIO-VALOR

               WRITE FL-RELATORIO-ARQ AFTER ADVANCING 1 LINE
               GO TO 2100-IMPRIMIR-SORT
           END-IF
           .
       2100-IMPRIMIR-SORT-EXIT.
           EXIT.
      *-----------------------------------------------------------------
      *     FINALIZAR PROGRAMA
      *-----------------------------------------------------------------
       3000-FINALIZAR SECTION.
            CLOSE LISTA.
            IF AS-STATUS-E NOT EQUAL ZEROS
               DISPLAY 'DEU ERRO NO FECHAR ' AS-STATUS-E
           END-IF

           CLOSE RELATORIO
           IF AS-STATUS-S NOT EQUAL 0
               DISPLAY 'ERRO AO FECHAR O ARQUIVO ' AS-STATUS-S
           END-IF.

           DISPLAY 'Processo Concluido!'
           STOP RUN.
       3000-FINALIZAR-EXIT.
           EXIT.

       END PROGRAM CBLX0008.
