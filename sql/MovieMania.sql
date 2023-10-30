-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blockbuster
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blockbuster` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `blockbuster` ;

-- -----------------------------------------------------
-- Table `blockbuster`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`actor` (
  `actor_id` INT NOT NULL,
  `first_name` TEXT NULL DEFAULT NULL,
  `last_name` TEXT NULL DEFAULT NULL,
  `Edad` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`actor_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`category` (
  `category_id` INT NOT NULL,
  `name` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`language` (
  `language_id` INT NOT NULL,
  `name` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`film` (
  `film_id` INT NOT NULL,
  `title` TEXT NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `release_year` SMALLINT NULL DEFAULT NULL,
  `language_id` INT NULL DEFAULT NULL,
  `rental_duration` SMALLINT NULL DEFAULT NULL,
  `rental_rate` FLOAT NULL DEFAULT NULL,
  `length` SMALLINT NULL DEFAULT NULL,
  `replacement_cost` FLOAT NULL DEFAULT NULL,
  `rating` TEXT NULL DEFAULT NULL,
  `behind_the_scenes` TINYINT(1) NULL DEFAULT NULL,
  `commentaries` TINYINT(1) NULL DEFAULT NULL,
  `deleted_scenes` TINYINT(1) NULL DEFAULT NULL,
  `trailers` TINYINT(1) NULL DEFAULT NULL,
  `category_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  INDEX `fk_film_language` (`language_id` ASC) VISIBLE,
  INDEX `fk_film_category` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `blockbuster`.`category` (`category_id`),
  CONSTRAINT `fk_film_language`
    FOREIGN KEY (`language_id`)
    REFERENCES `blockbuster`.`language` (`language_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`actor_film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`actor_film` (
  `actor_id` INT NOT NULL,
  `film_id` INT NOT NULL,
  PRIMARY KEY (`actor_id`, `film_id`),
  INDEX `film_id` (`film_id` ASC) VISIBLE,
  CONSTRAINT `actor_film_ibfk_1`
    FOREIGN KEY (`actor_id`)
    REFERENCES `blockbuster`.`actor` (`actor_id`),
  CONSTRAINT `actor_film_ibfk_2`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`film` (`film_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`customer` (
  `customer_id` INT NOT NULL,
  `nombre` TEXT NULL DEFAULT NULL,
  `apellido` TEXT NULL DEFAULT NULL,
  `direccion` TEXT NULL DEFAULT NULL,
  `correo_electronico` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`inventory` (
  `inventory_id` INT NOT NULL,
  `film_id` INT NULL DEFAULT NULL,
  `store_id` SMALLINT NULL DEFAULT NULL,
  `last_update` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `fk_inventory_film` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_film`
    FOREIGN KEY (`film_id`)
    REFERENCES `blockbuster`.`film` (`film_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`old`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`old` (
  `first_name` TEXT NULL DEFAULT NULL,
  `last_name` TEXT NULL DEFAULT NULL,
  `title` TEXT NULL DEFAULT NULL,
  `release_year` SMALLINT NULL DEFAULT NULL,
  `category_id` INT NULL DEFAULT NULL,
  `old_id` INT NOT NULL,
  PRIMARY KEY (`old_id`),
  INDEX `fk_old_category` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_old_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `blockbuster`.`category` (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`rental` (
  `rental_id` INT NOT NULL,
  `rental_date` TEXT NULL DEFAULT NULL,
  `inventory_id` INT NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `return_date` TEXT NULL DEFAULT NULL,
  `staff_id` SMALLINT NULL DEFAULT NULL,
  `last_update` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `fk_rental_inventory` (`inventory_id` ASC) VISIBLE,
  INDEX `fk_rental_customer` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_rental_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `blockbuster`.`customer` (`customer_id`),
  CONSTRAINT `fk_rental_inventory`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `blockbuster`.`inventory` (`inventory_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `blockbuster`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blockbuster`.`staff` (
  `staff_id` BIGINT NULL DEFAULT NULL,
  `nombre` TEXT NULL DEFAULT NULL,
  `apellido` TEXT NULL DEFAULT NULL,
  `direccion` TEXT NULL DEFAULT NULL,
  `correo_electronico` TEXT NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
