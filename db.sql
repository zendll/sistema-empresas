CREATE TABLE `empresas` (
    `ID` INT AUTO_INCREMENT PRIMARY KEY,
    `Nome` VARCHAR(100) NOT NULL,
    `Dono` VARCHAR(50) NOT NULL,
    `Saldo` INT NOT NULL DEFAULT 0,
    `EntradaX` FLOAT NOT NULL,
    `EntradaY` FLOAT NOT NULL,
    `EntradaZ` FLOAT NOT NULL,
    `Interior` INT NOT NULL,
    `World` INT NOT NULL
);
