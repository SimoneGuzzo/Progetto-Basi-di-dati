-- 7. Trigger che impedisce di inserire più di una volta lo stesso numero di ufficio dei venditori
CREATE OR REPLACE TRIGGER UFFICIO
BEFORE INSERT ON VENDITORE
FOR EACH ROW	--per ogni riga deve essere fatto il controllo

DECLARE
CONTA NUMBER;
UF EXCEPTION;

BEGIN
SELECT COUNT(*) INTO CONTA
FROM VENDITORE
WHERE #UFFICIO=:NEW.UFFICIO;
IF CONTA>1 THEN--se si verifica questo lanciamo eccezione
	RAISE UF;
END IF;

EXCEPTION
WHEN UF THEN
	RAISE_APPLICATION_ERROR(-20001, 'IMPOSSIBILE INSERIRE STESSO NUMERO DI UFFICIO')
END;