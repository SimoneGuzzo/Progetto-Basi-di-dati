-- 2. Trigger che impedisce di inserire piu di 50 pezzi per ogni mobili
CREATE OR REPLACE TRIGGER MOBILI_50
BEFORE INSERT ON MOBILE
FOR EACH ROW	--per ogni riga deve essere fatto il controllo

DECLARE
TN EXCEPTION;

BEGIN	--prima di aggiungere devo contare quanti mobili ci sono
IF :NEW.QUANTITA_M>50 THEN--se si verifica questo lanciamo eccezione
	RAISE TN;
END IF;

EXCEPTION
WHEN TN THEN
	RAISE_APPLICATION_ERROR(-20001, 'NON PUOI PIU INSERIRE')
END;