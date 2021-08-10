-- 8. Trigger che corregge l'importo della busta paga all'inserimento tenendo conto del regime orario che supera le 8 ore e il prestigio del venditore
CREATE OR REPLACE TRIGGER STIPENDIO
BEFORE INSERT ON BUSTA_PAGA
FOR EACH ROW	--per ogni riga deve essere fatto il controllo

DECLARE
ORE NUMBER;
AUMENTO NUMBER;

BEGIN
SELECT REGIME_ORARIO INTO ORE FROM DIPENDENTE WHERE #TESSERA=:NEW.TESSERA;
IF ORE>8 THEN--se si verifica questo lanciamo eccezione
	:NEW.IMPORTO:=:NEW.IMPORTO + 100;
END IF;

SELECT IMPORTO INTO AUMENTO FROM VENDITORE NATURAL JOIN PRESTIGIO WHERE #TESSERA=:NEW.TESSERA;
 :NEW.IMPORTO:=:NEW.IMPORTO+AUMENTO;

END;