-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Toll_APP_Database
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Toll_APP_Database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Toll_APP_Database` DEFAULT CHARACTER SET utf8 ;
USE `Toll_APP_Database` ;

-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`Territory_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`Territory_Table` (
  `TerritoryID` INT NOT NULL AUTO_INCREMENT,
  `Territory` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`TerritoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`Route_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`Route_Table` (
  `RouteID` INT NOT NULL AUTO_INCREMENT,
  `LocID` INT NOT NULL,
  `Radius` INT NOT NULL,
  PRIMARY KEY (`RouteID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`Location_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`Location_Table` (
  `LocID` INT NOT NULL AUTO_INCREMENT,
  `Lat` VARCHAR(45) NOT NULL,
  `Long` VARCHAR(45) NOT NULL,
  `State` CHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `RouteID` INT NOT NULL,
  PRIMARY KEY (`LocID`),
  INDEX `RouteID_idx` (`RouteID` ASC),
  CONSTRAINT `RouteID`
    FOREIGN KEY (`RouteID`)
    REFERENCES `Toll_APP_Database`.`Route_Table` (`RouteID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`Country_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`Country_Table` (
  `CountryID` INT NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `TerritoryID` INT NOT NULL,
  `LocID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`CountryID`),
  INDEX `LocID_idx` (`LocID` ASC),
  CONSTRAINT `TerritoryID`
    FOREIGN KEY (`LocID`)
    REFERENCES `Toll_APP_Database`.`Territory_Table` (`TerritoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `LocID`
    FOREIGN KEY (`LocID`)
    REFERENCES `Toll_APP_Database`.`Location_Table` (`LocID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`City_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`City_Table` (
  `CityID` INT NOT NULL AUTO_INCREMENT,
  `City` VARCHAR(45) NOT NULL,
  `State` CHAR(45) NOT NULL,
  `CountryID` INT NOT NULL,
  PRIMARY KEY (`CityID`),
  INDEX `CountryID_idx` (`CountryID` ASC),
  CONSTRAINT `CountryID`
    FOREIGN KEY (`CountryID`)
    REFERENCES `Toll_APP_Database`.`Country_Table` (`CountryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`Customer_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`Customer_Table` (
  `Cust_ID` INT NOT NULL AUTO_INCREMENT,
  `Cust_Name` VARCHAR(50) NOT NULL,
  `Cust_FirstName` VARCHAR(50) NOT NULL,
  `Cust_LastName` VARCHAR(50) NOT NULL,
  `Phone` CHAR(10) NOT NULL,
  `Address_1` VARCHAR(150) NOT NULL,
  `Address_2` VARCHAR(150) NOT NULL,
  `PostalCode` CHAR(10) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `CityID` INT NULL,
  PRIMARY KEY (`Cust_ID`),
  INDEX `CityID_idx` (`CityID` ASC),
  CONSTRAINT `CityID`
    FOREIGN KEY (`CityID`)
    REFERENCES `Toll_APP_Database`.`City_Table` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`Vehicle_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`Vehicle_Table` (
  `Cust_ID` INT NOT NULL AUTO_INCREMENT,
  `City` VARCHAR(45) NOT NULL,
  `VehiclePlate` VARCHAR(45) NOT NULL,
  `LicenseNum` VARCHAR(45) NOT NULL,
  `CityID` INT NOT NULL,
  PRIMARY KEY (`CityID`),
  CONSTRAINT `fk_Vehicle_Table_CityID`
    FOREIGN KEY (`Cust_ID`)
    REFERENCES `Toll_APP_Database`.`Customer_Table` (`Cust_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`Date_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`Date_Table` (
  `DateID` INT NOT NULL,
  `Month` INT NOT NULL,
  `Day` INT NOT NULL,
  `Year` INT NOT NULL,
  `Cust_ID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`DateID`),
  INDEX `Cust_ID_idx` (`Cust_ID` ASC),
  CONSTRAINT `Cust_ID`
    FOREIGN KEY (`Cust_ID`)
    REFERENCES `Toll_APP_Database`.`Customer_Table` (`Cust_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`Payment_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`Payment_Table` (
  `Cust_ID` INT NOT NULL AUTO_INCREMENT,
  `CardNum` VARCHAR(45) NOT NULL,
  `Cust_Name` VARCHAR(45) NOT NULL,
  `Payment_Date` DATETIME NOT NULL,
  `DateID` INT NOT NULL,
  PRIMARY KEY (`Cust_ID`),
  INDEX `DateID_idx` (`DateID` ASC),
  CONSTRAINT `DateID`
    FOREIGN KEY (`DateID`)
    REFERENCES `Toll_APP_Database`.`Date_Table` (`DateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Toll_APP_Database`.`Agreement_Table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Toll_APP_Database`.`Agreement_Table` (
  `AgreementID` INT NOT NULL AUTO_INCREMENT,
  `AgrmtAcptd` CHAR(45) NOT NULL,
  `AgreementDeclined` CHAR(45) NOT NULL,
  `CityID` INT NOT NULL,
  PRIMARY KEY (`AgreementID`),
  INDEX `CityID_idx` (`CityID` ASC),
  CONSTRAINT `fk_Agreement_Table_CityID`
    FOREIGN KEY (`CityID`)
    REFERENCES `Toll_APP_Database`.`City_Table` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
