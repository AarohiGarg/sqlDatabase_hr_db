-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hr_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hr_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hr_db` DEFAULT CHARACTER SET utf8 ;
USE `hr_db` ;

-- -----------------------------------------------------
-- Table `hr_db`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr_db`.`regions` (
  `region_id` INT NOT NULL,
  `region_name` VARCHAR(25) NULL,
  PRIMARY KEY (`region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_db`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr_db`.`countries` (
  `country_id` VARCHAR(2) NOT NULL,
  `country_name` VARCHAR(40) NULL,
  `region_id` INT NULL,
  PRIMARY KEY (`country_id`),
  INDEX `fk_countries_regions1_idx` (`region_id` ASC) VISIBLE,
  CONSTRAINT `fk_countries_regions1`
    FOREIGN KEY (`region_id`)
    REFERENCES `hr_db`.`regions` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_db`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr_db`.`locations` (
  `location_id` INT NOT NULL,
  `street_address` VARCHAR(25) NULL,
  `postal_code` VARCHAR(12) NULL,
  `city` VARCHAR(30) NULL,
  `state_province` VARCHAR(12) NULL,
  `country_id` VARCHAR(2) NULL,
  PRIMARY KEY (`location_id`),
  INDEX `fk_locations_countries1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_locations_countries1`
    FOREIGN KEY (`country_id`)
    REFERENCES `hr_db`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_db`.`departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr_db`.`departments` (
  `department_id` INT NOT NULL,
  `department_name` VARCHAR(30) NULL,
  `manager_id` INT NULL,
  `location_id` INT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `fk_departments_locations1_idx` (`location_id` ASC) VISIBLE,
  CONSTRAINT `fk_departments_locations1`
    FOREIGN KEY (`location_id`)
    REFERENCES `hr_db`.`locations` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_db`.`jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr_db`.`jobs` (
  `job_id` VARCHAR(10) NOT NULL,
  `job_title` VARCHAR(35) NULL,
  `min_salary` INT NULL,
  `max_salary` INT NULL,
  PRIMARY KEY (`job_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_db`.`job_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr_db`.`job_history` (
  `employee_id` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NULL,
  `job_id` VARCHAR(10) NULL,
  `department_id` INT NULL,
  PRIMARY KEY (`employee_id`, `start_date`),
  INDEX `fk_job_history_jobs1_idx` (`job_id` ASC) VISIBLE,
  INDEX `fk_job_history_departments1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_job_history_jobs1`
    FOREIGN KEY (`job_id`)
    REFERENCES `hr_db`.`jobs` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_job_history_departments1`
    FOREIGN KEY (`department_id`)
    REFERENCES `hr_db`.`departments` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_db`.`job_grades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr_db`.`job_grades` (
  `grade_level` VARCHAR(2) NOT NULL,
  `lowest_sal` INT NULL,
  `highest_sal` INT NULL,
  PRIMARY KEY (`grade_level`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hr_db`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hr_db`.`employees` (
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(20) NULL,
  `last_name` VARCHAR(25) NULL,
  `email` VARCHAR(25) NULL,
  `phone_number` VARCHAR(20) NULL,
  `hire_data` DATE NULL,
  `job_id` VARCHAR(10) NULL,
  `salary` INT NULL,
  `commission_pct` INT NULL,
  `manager_id` INT NULL,
  `department_id` INT NULL,
  INDEX `fk_employees_jobs1_idx` (`job_id` ASC) VISIBLE,
  INDEX `fk_employees_departments1_idx` (`department_id` ASC) VISIBLE,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `fk_employees_jobs1`
    FOREIGN KEY (`job_id`)
    REFERENCES `hr_db`.`jobs` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_departments1`
    FOREIGN KEY (`department_id`)
    REFERENCES `hr_db`.`departments` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employees_job_history1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `hr_db`.`job_history` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `hr_db`.`regions`
-- -----------------------------------------------------
START TRANSACTION;
USE `hr_db`;
INSERT INTO `hr_db`.`regions` (`region_id`, `region_name`) VALUES (1, 'Europe');
INSERT INTO `hr_db`.`regions` (`region_id`, `region_name`) VALUES (2, 'Americas');
INSERT INTO `hr_db`.`regions` (`region_id`, `region_name`) VALUES (3, 'Asia');
INSERT INTO `hr_db`.`regions` (`region_id`, `region_name`) VALUES (4, 'Middle East and Africa');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hr_db`.`countries`
-- -----------------------------------------------------
START TRANSACTION;
USE `hr_db`;
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('AR', 'Argentina', 2);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('AU', 'Australia', 3);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('BE', 'Belgium', 1);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('BR', 'Brazil', 2);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('CA', 'Canada', 2);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('CH', 'Switzerland', 1);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('CN', 'China', 3);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('DE', 'Germany', 1);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('DK', 'Denmark', 1);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('EG', 'Egypt', 4);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('FR', 'France', 1);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('HK', 'HongKong', 3);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('IL', 'Israel', 4);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('IN', 'India', 3);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('IT', 'Italy', 1);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('JP', 'Japan', 3);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('KW', 'Kuwait', 4);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('MX', 'Mexico', 2);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('NG', 'Nigeria', 4);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('NL', 'Netherlands', 1);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('SG', 'Singapore', 3);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('UK', 'United Kingdom', 1);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('US', 'United States of America', 2);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('ZM', 'Zambia', 4);
INSERT INTO `hr_db`.`countries` (`country_id`, `country_name`, `region_id`) VALUES ('ZW', 'Zimbabwe', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hr_db`.`locations`
-- -----------------------------------------------------
START TRANSACTION;
USE `hr_db`;
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1000, '1297 Via Cola di Rie', '989', 'Roma', '', 'IT');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1100, '93091 Calle della Testa', '10934', 'Venice', '', 'IT');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', '', 'JP');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2000, '40-5-12 Laogianggen', '190518', 'Beijing', '', 'CN');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2300, '198 Clementi North', '540198', 'Singapore', '', 'SG');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2400, '8204 Arthur St', '', 'London', '', 'UK');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2500, 'Magdalen Centre\', \' The Oxford \', \'OX9 9ZB\', \'Oxford\', \'Ox\'),', '', '', '', '');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2600, '9702 Chester Road', '9629850293', 'Stretford', 'Manchester', 'UK');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2800, 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');
INSERT INTO `hr_db`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal\', \'', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `hr_db`.`departments`
-- -----------------------------------------------------
START TRANSACTION;
USE `hr_db`;
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (10, 'Administration', 200, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (20, 'Marketing', 201, 1800);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (30, 'Purchasing', 114, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (40, 'Human Resources', 203, 2400);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (50, 'Shipping', 121, 1500);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (60, 'IT', 103, 1400);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (70, 'Public Relations', 204, 2700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (80, 'Sales', 145, 2500);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (90, 'Executive', 100, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (100, 'Finance', 108, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (110, 'Accounting', 205, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (120, 'Treasury', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (130, 'Corporate Tax', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (140, 'Control And Credit', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (150, 'Shareholder Services', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (160, 'Benefits', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (170, 'Manufacturing', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (180, 'Construction', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (190, 'Contracting', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (200, 'Operations', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (210, 'IT Support', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (220, 'NOC', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (230, 'IT Helpdesk', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (240, 'Government Sales', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (250, 'Retail Sales', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (260, 'Recruiting', 0, 1700);
INSERT INTO `hr_db`.`departments` (`department_id`, `department_name`, `manager_id`, `location_id`) VALUES (270, 'Payroll', 0, 1700);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hr_db`.`jobs`
-- -----------------------------------------------------
START TRANSACTION;
USE `hr_db`;
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('AD_PRES', 'President', 20000, 40000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('AD_VP', 'Administration Vice President', 15000, 30000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('AD_ASST', 'Administration Assistant', 3000, 6000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('FI_MGR', 'Finance Manager', 8200, 16000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('FI_ACCOUNT', 'Accountant', 4200, 9000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('AC_MGR', 'Accounting Manager', 8200, 16000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('SA_MAN', 'Sales Manager', 10000, 20000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('SA_REP', 'Sales Representative', 6000, 12000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('PU_MAN', 'Purchasing Manager', 8000, 15000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('PU_CLERK', 'Purchasing Clerk', 2500, 5500);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('ST_CLERK', 'Stock Clerk', 2000, 5000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('SH_CLERK', 'Shipping Clerk', 2500, 5500);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('IT_PROG', 'Programmer', 4000, 10000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('MK_MAN', 'Marketing Manager', 9000, 15000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('MK_REP', 'Marketing Representative', 4000, 9000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('HR_REP', 'Human Resources Representative', 4000, 9000);
INSERT INTO `hr_db`.`jobs` (`job_id`, `job_title`, `min_salary`, `max_salary`) VALUES ('PR_REP', 'Public Relations Representative', 4500, 10500);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hr_db`.`job_history`
-- -----------------------------------------------------
START TRANSACTION;
USE `hr_db`;
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (102, '13-01-1993', '24-07-1998', 'IT_PROG', 60);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (101, '21-09-1989', '27-10-1993', 'AC_ACCOUNT', 110);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (101, '28-10-1993', '15-03-1997', 'AC_MGR', 110);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (201, '17-02-1996', '19-12-1999', 'MK_REP', 20);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (114, '24-03-1998', '31-12-1999', 'ST_CLERK', 50);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (122, '01-01-1999', '31-12-1999', 'ST_CLERK', 50);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (200, '17-09-1987', '17-06-1993', 'AD_ASST', 90);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (176, '24-03-1998', '31-12-1998', 'SA_REP', 80);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (176, '01-01-1999', '31-12-1999', 'SA_MAN', 80);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (200, '01-07-1994', '31-12-1998', 'AC_ACCOUNT', 90);
INSERT INTO `hr_db`.`job_history` (`employee_id`, `start_date`, `end_date`, `job_id`, `department_id`) VALUES (0, '0000-00-00', '0000-00-00', '', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hr_db`.`employees`
-- -----------------------------------------------------
START TRANSACTION;
USE `hr_db`;
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', '17-06-1987', 'AD_PRES', 24000, 0, 0, 90);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '18-06-1987', 'AD_VP', 17000, 0, 100, 90);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '19-06-1987', 'AD_VP', 17000, 0, 100, 90);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '20-06-1987', 'IT_PROG', 9000, 0, 102, 60);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '21-06-1987', 'IT_PROG', 6000, 0, 103, 60);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '22-06-1987', 'IT_PROG', 4800, 0, 103, 60);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '23-06-1987', 'IT_PROG', 4800, 0, 103, 60);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '24-06-1987', 'IT_PROG', 4200, 0, 103, 60);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '25-06-1987', 'FI_MGR', 12000, 0, 101, 100);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '26-06-1987', 'FI_ACCOUNT', 9000, 0, 108, 100);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (110, 'John', 'Chen', 'JCHEN', '515.124.4269', '27-06-1987', 'FI_ACCOUNT', 8200, 0, 108, 100);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '28-06-1987', 'FI_ACCOUNT', 7700, 0, 108, 100);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', '29-06-1987', 'FI_ACCOUNT', 7800, 0, 108, 100);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', '30-06-1987', 'FI_ACCOUNT', 6900, 0, 108, 100);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '01-07-1987', 'PU_MAN', 11000, 0, 100, 30);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '02-07-1987', 'PU_CLERK', 3100, 0, 114, 30);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '03-07-1987', 'PU_CLERK', 2900, 0, 114, 30);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', '04-07-1987', 'PU_CLERK', 2800, 0, 114, 30);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', '05-07-1987', 'PU_CLERK', 2600, 0, 114, 30);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', '06-07-1987', 'PU_CLERK', 2500, 0, 114, 30);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', '07-07-1987', 'ST_MAN', 8000, 0, 100, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', '08-07-1987', 'ST_MAN', 8200, 0, 100, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', '09-07-1987', 'ST_MAN', 7900, 0, 100, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', '10-07-1987', 'ST_MAN', 6500, 0, 100, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', '11-07-1987', 'ST_MAN', 5800, 0, 100, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', '12-07-1987', 'ST_CLERK', 3200, 0, 120, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', '13-07-1987', 'ST_CLERK', 2700, 0, 120, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (127, 'James', 'Landry', 'JLANDRY', '650.124.1334', '14-07-1987', 'ST_CLERK', 2400, 0, 120, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', '15-07-1987', 'ST_CLERK', 2200, 0, 120, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', '16-07-1987', 'ST_CLERK', 3300, 0, 121, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', '17-07-1987', 'ST_CLERK', 2800, 0, 121, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234', '18-07-1987', 'ST_CLERK', 2500, 0, 121, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234', '19-07-1987', 'ST_CLERK', 2100, 0, 121, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', '20-07-1987', 'ST_CLERK', 3300, 0, 122, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', '21-07-1987', 'ST_CLERK', 2900, 0, 122, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (135, 'Ki', 'Gee', 'KGEE', '650.127.1734', '22-07-1987', 'ST_CLERK', 2400, 0, 122, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', '23-07-1987', 'ST_CLERK', 2200, 0, 122, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', '24-07-1987', 'ST_CLERK', 3600, 0, 123, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', '25-07-1987', 'ST_CLERK', 3200, 0, 123, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (139, 'John', 'Seo', 'JSEO', '650.121.2019', '26-07-1987', 'ST_CLERK', 2700, 0, 123, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', '27-07-1987', 'ST_CLERK', 2500, 0, 123, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', '28-07-1987', 'ST_CLERK', 3500, 0, 124, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', '29-07-1987', 'ST_CLERK', 3100, 0, 124, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', '30-07-1987', 'ST_CLERK', 2600, 0, 124, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', '31-07-1987', 'ST_CLERK', 2500, 0, 124, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', '01-08-1987', 'SA_MAN', 14000, 0.4, 100, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', '02-08-1987', 'SA_MAN', 13500, 0.3, 100, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', '03-08-1987', 'SA_MAN', 12000, 0.3, 100, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', '04-08-1987', 'SA_MAN', 11000, 0.3, 100, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '05-08-1987', 'SA_MAN', 10500, 0.2, 100, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', '06-08-1987', 'SA_REP', 10000, 0.3, 145, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', '07-08-1987', 'SA_REP', 9500, 0.25, 145, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', '08-08-1987', 'SA_REP', 9000, 0.25, 145, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', '09-08-1987', 'SA_REP', 8000, 0.2, 145, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', '10-08-1987', 'SA_REP', 7500, 0.2, 145, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', '11-08-1987', 'SA_REP', 7000, 0.15, 145, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (156, 'Janette', 'King', 'JKING', '011.44.1345.429268', '12-08-1987', 'SA_REP', 10000, 0.35, 146, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', '13-08-1987', 'SA_REP', 9500, 0.35, 146, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', '14-08-1987', 'SA_REP', 9000, 0.35, 146, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', '15-08-1987', 'SA_REP', 8000, 0.3, 146, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', '16-08-1987', 'SA_REP', 7500, 0.3, 146, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', '17-08-1987', 'SA_REP', 7000, 0.25, 146, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', '18-08-1987', 'SA_REP', 10500, 0.25, 147, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', '19-08-1987', 'SA_REP', 9500, 0.15, 147, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (164, 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', '20-08-1987', 'SA_REP', 7200, 0.1, 147, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (165, 'David', 'Lee', 'DLEE', '011.44.1346.529268', '21-08-1987', 'SA_REP', 6800, 0.1, 147, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', '22-08-1987', 'SA_REP', 6400, 0.1, 147, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', '23-08-1987', 'SA_REP', 6200, 0.1, 147, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', '24-08-1987', 'SA_REP', 11500, 0.25, 148, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (169, 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', '25-08-1987', 'SA_REP', 10000, 0.2, 148, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', '26-08-1987', 'SA_REP', 9600, 0.2, 148, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (171, 'William', 'Smith', 'WSMITH', '011.44.1343.629268', '27-08-1987', 'SA_REP', 7400, 0.15, 148, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', '28-08-1987', 'SA_REP', 7300, 0.15, 148, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', '29-08-1987', 'SA_REP', 6100, 0.1, 148, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', '30-08-1987', 'SA_REP', 11000, 0.3, 149, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', '31-08-1987', 'SA_REP', 8800, 0.25, 149, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', '01-09-1987', 'SA_REP', 8600, 0.2, 149, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', '02-09-1987', 'SA_REP', 8400, 0.2, 149, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', '03-09-1987', 'SA_REP', 7000, 0.15, 149, 0);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', '04-09-1987', 'SA_REP', 6200, 0.1, 149, 80);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (180, 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', '05-09-1987', 'SH_CLERK', 3200, 0, 120, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (181, 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', '06-09-1987', 'SH_CLERK', 3100, 0, 120, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (182, 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', '07-09-1987', 'SH_CLERK', 2500, 0, 120, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (183, 'Girard', 'Geoni', 'GGEONI', '650.507.9879', '08-09-1987', 'SH_CLERK', 2800, 0, 120, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (184, 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', '09-09-1987', 'SH_CLERK', 4200, 0, 121, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (185, 'Alexis', 'Bull', 'ABULL', '650.509.2876', '10-09-1987', 'SH_CLERK', 4100, 0, 121, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (186, 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', '11-09-1987', 'SH_CLERK', 3400, 0, 121, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (187, 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', '12-09-1987', 'SH_CLERK', 3000, 0, 121, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (188, 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', '13-09-1987', 'SH_CLERK', 3800, 0, 122, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (189, 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', '14-09-1987', 'SH_CLERK', 3600, 0, 122, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (190, 'Timothy', 'Gates', 'TGATES', '650.505.3876', '15-09-1987', 'SH_CLERK', 2900, 0, 122, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (191, 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', '16-09-1987', 'SH_CLERK', 2500, 0, 122, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', '17-09-1987', 'SH_CLERK', 4000, 0, 123, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (193, 'Britney', 'Everett', 'BEVERETT', '650.501.2876', '18-09-1987', 'SH_CLERK', 3900, 0, 123, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (194, 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', '19-09-1987', 'SH_CLERK', 3200, 0, 123, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (195, 'Vance', 'Jones', 'VJONES', '650.501.4876', '20-09-1987', 'SH_CLERK', 2800, 0, 123, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (196, 'Alana', 'Walsh', 'AWALSH', '650.507.9811', '21-09-1987', 'SH_CLERK', 3100, 0, 124, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (197, 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', '22-09-1987', 'SH_CLERK', 3000, 0, 124, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', '23-09-1987', 'SH_CLERK', 2600, 0, 124, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', '24-09-1987', 'SH_CLERK', 2600, 0, 124, 50);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '25-09-1987', 'AD_ASST', 4400, 0, 101, 10);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '26-09-1987', 'MK_MAN', 13000, 0, 100, 20);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', '27-09-1987', 'MK_REP', 6000, 0, 201, 20);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', '28-09-1987', 'HR_REP', 6500, 0, 101, 40);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', '29-09-1987', 'PR_REP', 10000, 0, 101, 70);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', '30-09-1987', 'AC_MGR', 12000, 0, 101, 110);
INSERT INTO `hr_db`.`employees` (`employee_id`, `first_name`, `last_name`, `email`, `phone_number`, `hire_data`, `job_id`, `salary`, `commission_pct`, `manager_id`, `department_id`) VALUES (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', '01-10-1987', 'AC_ACCOUNT', 8300, 0, 205, 110);

COMMIT;

