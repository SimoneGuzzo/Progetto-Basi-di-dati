-- 3. Trigger che impedisce di inserire piu di 50 pezzi per ogni attrezzatura
CREATE OR REPLACE TRIGGER ATTREZ_50
BEFORE INSERT ON ATTREZZATURA
FOR EACH ROW	--per ogni riga deve essere fatto il controllo

DECLARE
TN EXCEPTION;

BEGIN	--prima di aggiungere devo contare quanti mobili ci sono
IF :NEW.QUANTITA>50 THEN--se si verifica questo lanciamo eccezione
	RAISE TN;
END IF;

EXCEPTION
WHEN TN THEN
	RAISE_APPLICATION_ERROR(-20001, 'NON PUOI PIU INSERIRE')
END;