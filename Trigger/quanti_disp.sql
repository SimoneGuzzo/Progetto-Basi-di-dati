--9 Trigger che controlla se la quantità dei mobili inserita nel contratto è disponibile
CREATE OR REPLACE TRIGGER QUANT_DISP
BEFORE INSERT ON CONTRATTO_MOBILE
FOR EACH ROW	--per ogni riga deve essere fatto il controllo

DECLARE
TN EXCEPTION;
QT NUMBER;

BEGIN	--prima di aggiungere devo contare se la quantità è disponibile

SELECT QUANTITA_M INTO QT FROM MOBILE WHERE COD_BARRA_M=:NEW.COD_BARRA_M;
IF :NEW.QUANTITA_AQUISTATA>QT THEN --se si verifica questo lanciamo eccezione
	RAISE TN;
END IF;

EXCEPTION
WHEN TN THEN
	RAISE_APPLICATION_ERROR(-20003, 'NON CI SONO ABBASTANZA MOBILI')
END;