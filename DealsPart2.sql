#Vin Rella
#11/4/2017
#The purpose of this script is to learn SQL through writing code, debugging errors, as well as combining multiple sets of data.

USE deals;
SELECT *
FROM Companies
WHERE CompanyName like "%Inc";

#Select companies sorted by CompanyName
SELECT *
FROM Companies
ORDER BY CompanyID;

#Select Deal Parts with dollar values
SELECT DealName, PartNumber, Dollarvalue
FROM Deals,DealParts
WHERE Deals.DealID = DealParts.DealID;

#Select Deal Parts with dollar values using a join
SELECT DealName, PartNumber, DollarValue
FROM Deals join DealParts on (Deals.DealID=DealParts.DealID);

#Show each company involved in each deal
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
    JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;

#Create a view that matches companies to deal
DROP VIEW IF EXISTS `CompanyDeals`;
CREATE View CompanyDeals AS
SELECT DealName, RoleCode, CompanyName
FROM Companies
	JOIN Players ON (Companies.COmpanyID = PLayers.CompanyID)
    JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;

#Create a view named "DealValues" that lists the DealID, total dollar value and the number of parts for each deal
DROP VIEW IF EXISTS `DealValues`;
CREATE VIEW DealValues AS
SELECT DEALS.DealID, SUM(DollarValue) AS TotDollarValue, COUNT(PartNumber) AS NumParts
FROM DEALS JOIN DEALPARTS ON (DEALS.DealID = DEALPARTS.DealID)
GROUP BY DEALS.DealID
ORDER BY DEALS.DealID;

#Create view named DealSummary that lists the DealID, DealName, number of players, total dollar valyue, and nymber of parts
DROP VIEW IF EXISTS `DealSummary`;
CREATE VIEW DealSummary AS
SELECT Deals.DealID, DealName, COUNT(PlayerID) AS NumPlayers, TotDollarValue, NumParts
FROM DEALS JOIN DealValues ON (DEALS.DealID = Dealvalues.DealID)
			JOIN Players ON (DEALS.DealID = Players.DealID)
GROUP BY Deals.DealID;

#CREATE a view called DealsByType that lists TypeCOde, number of deals, and total value of deals for wach deal type
DROP VIEW IF EXISTS `DealsByType`;
CREATE VIEW DealsByType AS 
SELECT DISTINCT DealTypes.TypeCode, COUNT(Deals.DealID) AS NumDeals, SUM(DealParts.DollarValue) AS TotDollarValue
FROM DealTypes
	LEFT JOIN Deals ON (DealTypes.DealID = Deals.DealID)
    JOIN DealParts ON (DealParts.DealID = Deals.DealID)
GROUP BY DealTypes.Typecode;

#Create view called DealPlayers that lists CompanyID, Name, and Role Code for each deal. Sort the players by the RoleSortOrder
DROP VIEW IF EXISTS `DealPlayers`;
CREATE VIEW DealPlayers As
SELECT DealID, CompanyID, CompanyName, RoleCode
FROM Players 
	JOIN Deals USING (DealID)
    JOIN COMPANIES USING (CompanyID)
    JOIN ROLECODES USING (RoleCode)
ORDER By RoleSortOrder;

#Create view called DealsByFirm that list FirmID, Name, and total value of deals for each firm
SELECT FirmID, `Name`AS FirmName, COUNT(PLAYERS.DealID) AS NumDeals, SUM(TotDollarValue) AS TotValue
FROM Firms 
	JOIN PLAYERSUPPORTS USING (FirmID)
	JOIN PLAYERS USING (PlayerID)
	JOIN DealValues USING (DealID)
GROUP BY FirmID, `Name`;