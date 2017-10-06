-- MySQL Script generated by MySQL Workbench
-- Fri Oct  6 17:21:06 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema productivity_appdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `` DEFAULT CHARACTER SET utf8 ;
USE `` ;

-- -----------------------------------------------------
-- Table `productivity_appdb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productivity_appdb`.`users` (
  `user_name` VARCHAR(15) NOT NULL,
  `user_pass` VARCHAR(255) NOT NULL,
  `user_first_name` VARCHAR(15) NULL,
  `user_last_name` VARCHAR(15) NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `user_dateofbirth` DATE NOT NULL,
  `user_registered_date` DATE NOT NULL,
  `user_photo_link` VARCHAR(45) NULL,
  `user_city` VARCHAR(16) NULL,
  `user_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productivity_appdb`.`user_task_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productivity_appdb`.`user_task_list` (
  `common_tasks_id` INT NOT NULL,
  `task1` VARCHAR(45) NULL,
  `task2` VARCHAR(45) NULL,
  `task3` VARCHAR(45) NULL,
  `task4` VARCHAR(45) NULL,
  `task5` VARCHAR(45) NULL,
  `task6` VARCHAR(45) NULL,
  `users_user_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`common_tasks_id`),
  INDEX `fk_predefined_user_task_list_users1_idx` (`users_user_id` ASC),
  CONSTRAINT `fk_predefined_user_task_list_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `productivity_appdb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productivity_appdb`.`user_custom_task_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productivity_appdb`.`user_custom_task_list` (
  `idCustomerUserTags` INT NOT NULL,
  `user_name` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idCustomerUserTags`, `user_name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productivity_appdb`.`open_weather_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productivity_appdb`.`open_weather_data` (
  `open_weather_data_id` VARCHAR(45) NOT NULL,
  `pressure` VARCHAR(45) NULL,
  `humidity` VARCHAR(45) NULL,
  `temp_min` VARCHAR(45) NULL,
  `temp_max` VARCHAR(45) NULL,
  `date` DATETIME NULL,
  `usercity` VARCHAR(45) NULL,
  `users_user_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`open_weather_data_id`),
  INDEX `fk_open_weather_data_users1_idx` (`users_user_id` ASC),
  CONSTRAINT `fk_open_weather_data_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `productivity_appdb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productivity_appdb`.`UserRegionCityLinkingTable`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productivity_appdb`.`UserRegionCityLinkingTable` (
  `idUserRegionCityLinkingTable` INT NULL,
  `WeatherData_idWeatherData` VARCHAR(45) NOT NULL,
  `Usernfo_userClientKey` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`WeatherData_idWeatherData`, `Usernfo_userClientKey`),
  CONSTRAINT `fk_UserRegionCityLinkingTable_WeatherData1`
    FOREIGN KEY (`WeatherData_idWeatherData`)
    REFERENCES `productivity_appdb`.`open_weather_data` (`open_weather_data_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productivity_appdb`.`user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productivity_appdb`.`user_roles` (
  `user_name` VARCHAR(15) NOT NULL,
  `role_name` VARCHAR(15) NOT NULL,
  `users_user_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_name`, `role_name`, `users_user_id`),
  INDEX `fk_user_roles_users1_idx` (`users_user_id` ASC),
  CONSTRAINT `fk_user_roles_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `productivity_appdb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `productivity_appdb`.`task_completion_times`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productivity_appdb`.`task_completion_times` (
  `task_time_id`  NOT NULL,
  `task_time_start`  NULL,
  `task_time_stop` VARCHAR(45) NULL,
  `users_user_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`task_time_id`),
  INDEX `fk_task_completion_times_users1_idx` (`users_user_id` ASC),
  CONSTRAINT `fk_task_completion_times_users1`
    FOREIGN KEY (`users_user_id`)
    REFERENCES `productivity_appdb`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `productivity_appdb`.`timestamps_1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productivity_appdb`.`timestamps_1` (
  `create_time`  NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`  NULL);


-- -----------------------------------------------------
-- Table `productivity_appdb`.`user_task_list_has_task_completion_times`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productivity_appdb`.`user_task_list_has_task_completion_times` (
  `user_task_list_common_tasks_id` INT NOT NULL,
  `task_completion_times_task_time_id`  NOT NULL,
  PRIMARY KEY (`user_task_list_common_tasks_id`, `task_completion_times_task_time_id`),
  INDEX `fk_user_task_list_has_task_completion_times_task_completion_idx` (`task_completion_times_task_time_id` ASC),
  INDEX `fk_user_task_list_has_task_completion_times_user_task_list1_idx` (`user_task_list_common_tasks_id` ASC),
  CONSTRAINT `fk_user_task_list_has_task_completion_times_user_task_list1`
    FOREIGN KEY (`user_task_list_common_tasks_id`)
    REFERENCES `productivity_appdb`.`user_task_list` (`common_tasks_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_task_list_has_task_completion_times_task_completion_t1`
    FOREIGN KEY (`task_completion_times_task_time_id`)
    REFERENCES `productivity_appdb`.`task_completion_times` (`task_time_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
