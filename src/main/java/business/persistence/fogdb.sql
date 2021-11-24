-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema fog
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fog
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fog` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `fog` ;

-- -----------------------------------------------------
-- Table `fog`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fog`.`city` (
  `zipcode` VARCHAR(4) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`zipcode`),
  UNIQUE INDEX `zipcode_UNIQUE` (`zipcode` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fog`.`users-admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fog`.`users-admin` (
  `email` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fog`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fog`.`users` (
  `id_user` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `streetname` VARCHAR(45) NOT NULL,
  `housenr` VARCHAR(10) NOT NULL,
  `zipcode` VARCHAR(4) NOT NULL,
  `phonenr` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `id_user_UNIQUE` (`id_user` ASC) VISIBLE,
  INDEX `fk_users_city_idx` (`zipcode` ASC) VISIBLE,
  INDEX `fk_users_users-admin1_idx` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_users_city`
    FOREIGN KEY (`zipcode`)
    REFERENCES `fog`.`city` (`zipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_users-admin1`
    FOREIGN KEY (`email`)
    REFERENCES `fog`.`users-admin` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fog`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fog`.`admin` (
  `id_admin` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_admin`),
  INDEX `fk_admin_users-admin1_idx` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_admin_users-admin1`
    FOREIGN KEY (`email`)
    REFERENCES `fog`.`users-admin` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fog`.`user_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fog`.`user_orders` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `admin_id` INT NOT NULL,
  `totalprice` INT NOT NULL,
  `toltalcost` INT NOT NULL,
  `orderdate` TIMESTAMP NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'request',
  `carpot_length` INT NOT NULL,
  `carport_width` INT NOT NULL,
  `shed` TINYINT NOT NULL,
  `shed_length` INT NULL,
  `shed-width` INT NULL,
  PRIMARY KEY (`id_order`),
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC) VISIBLE,
  INDEX `fk_user_orders_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_orders_admin1_idx` (`admin_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_orders_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `fog`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_orders_admin1`
    FOREIGN KEY (`admin_id`)
    REFERENCES `fog`.`admin` (`id_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fog`.`material`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fog`.`material` (
  `id_material` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `cost` INT NOT NULL,
  `price` INT NOT NULL,
  `length` INT NULL,
  `unit` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_material`),
  UNIQUE INDEX `id_material_UNIQUE` (`id_material` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fog`.`bom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fog`.`bom` (
  `id_bom` INT NOT NULL AUTO_INCREMENT,
  `id_order` INT NOT NULL,
  `id_material` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id_bom`),
  UNIQUE INDEX `id_stykliste_UNIQUE` (`id_bom` ASC) VISIBLE,
  INDEX `fk_bom_user_orders1_idx` (`id_order` ASC) VISIBLE,
  INDEX `fk_bom_material1_idx` (`id_material` ASC) VISIBLE,
  CONSTRAINT `fk_bom_user_orders1`
    FOREIGN KEY (`id_order`)
    REFERENCES `fog`.`user_orders` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bom_material1`
    FOREIGN KEY (`id_material`)
    REFERENCES `fog`.`material` (`id_material`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
