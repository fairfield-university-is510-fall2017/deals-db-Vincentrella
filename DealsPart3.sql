USE deals;
ALTER TABLE DealTypes
	ADD FOREIGN KEY (TypeCode)
    REFERENCES TypeCodes (TypeCode);
    
ALTER TABLE DealTypes
	ADD FOREIGN KEY (DealID)
    REFERENCES Deals (DealID);
    
ALTER TABLE DealParts
	ADD FOREIGN KEY (DealID)
    REFERENCES Deals (DealID);

ALTER TABLE PlayerSupports
	ADD FOREIGN KEY (FirmID)
    REFERENCES Firms (FIrmID);
    
ALTER TABLE PlayerSupports
	ADD FOREIGN KEY (PlayerID)
    REFERENCES Player (PlayerID);
    
ALTER TABLE PlayerSupports
	ADD FOREIGN KEY (SupportCodeID)
    REFERENCES SupportCodes(SupportCodeID);
    
ALTER TABLE Players
	ADD FOREIGN KEY (CompanyID)
    REFERENCES Companies (CompanyID);

ALTER TABLE Players
	ADD FOREIGN KEY (RoleCode)
    REFERENCES RoleCodes (RoleCode);
    