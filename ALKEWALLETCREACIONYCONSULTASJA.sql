-- Crear la base de datos AlkeWallet
CREATE DATABASE IF NOT EXISTS AlkeWallet;
USE AlkeWallet;

-- Crear tabla, para ingresar información de usuarios
CREATE TABLE `User` (
    `user_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `balance` BIGINT NOT NULL DEFAULT 0 
) ENGINE=InnoDB; -- Utiliza motor de almacenamiento InnoDB, para cumplir con principios ACID

-- Crear tabla Currency con su información de monedas
CREATE TABLE `Currency` (
    `currency_id` INT AUTO_INCREMENT PRIMARY KEY,
    `currency_name` VARCHAR(50) NOT NULL,
    `currency_symbol` VARCHAR(10) NOT NULL
) ENGINE=InnoDB;

-- Crear tabla Transaction
CREATE TABLE `Transaction` (
    `transaction_id` INT AUTO_INCREMENT PRIMARY KEY,
    `sender_user_id` INT NOT NULL,
    `receiver_user_id` INT NOT NULL,
    `amount` BIGINT NOT NULL,
    `transaction_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`sender_user_id`) REFERENCES `User`(`user_id`), -- clave foránea a que referencia a quien envia dinero
    FOREIGN KEY (`receiver_user_id`) REFERENCES `User`(`user_id`) -- clave foránea que referencia a quien recepciona dinero
) ENGINE=InnoDB; 

-- DATOS PARA USER

INSERT INTO User (name, email, password, balance) VALUES
('Javiera Acevedo', 'javiera@ejemplo.com', 's3cur3P@ssw0rd1!', 150000),
('Joaquin Soto', 'joaquin@ejemplo.com', 's3cur3P@ssw0rd2!', 90000),
('Juan Pablo Munoz', 'jp@ejemplo.com', 's3cur3P@ssw0rd3!', 45000),
('Nany Cabezas', 'nany@ejemplo.com', 's3cur3P@ssw0rd4!', 250000),
('Roberto Seguel', 'roberto@ejemplo.com', 's3cur3P@ssw0rd5!', 380000);

-- DATOS PARA TRANSACTION

INSERT INTO Transaction (sender_user_id, receiver_user_id, amount, transaction_date) VALUES
(1, 2, 20000, '2024-01-10'),
(2, 3, 15000, '2024-02-15'),
(3, 4, 10000, '2024-03-20'),
(4, 5, 50000, '2024-01-25'),
(5, 1, 30000, '2024-02-28'),
(1, 3, 45000, '2024-03-05'),
(2, 4, 25000, '2024-01-15'),
(3, 5, 15000, '2024-02-10'),
(4, 1, 35000, '2024-03-15'),
(5, 2, 40000, '2024-02-20');

-- DATOS PARA CURRENCY

INSERT INTO Currency (currency_name, currency_symbol) VALUES
('Peso Chileno', 'CLP'),
('Dólar Estadounidense', 'USD'),
('Euro', 'EUR'),
('Bitcoin', 'BTC');

-- -- Consulta para obtener el nombre de la moneda elegida por un usuario específico, en este caso user_id =1

SELECT * FROM AlkeWallet.transaction;
SELECT c.currency_name, u.name from USER as u
INNER JOIN transaction as t
on t.sender_user_id = u.user_id
INNER JOIN Currency as c
ON c.currency_id = c.currency_id
WHERE u.user_id = 1


-- --  Consulta para obtener todas las transacciones registradas:
SELECT * FROM Transaction;

-- -- Consulta para obtener todas las transacciones realizadas por un usuario específico, en este caso user_id 1
SELECT * FROM Transaction
WHERE sender_user_id = 1 OR receiver_user_id = 1;

-- --  Sentencia DML para modificar el campo correo electrónico de un usuario específico, en este caso user_id=1
UPDATE User
SET email = 'nuevo_email_javiera@gmail.com'
WHERE user_id = 1;

-- -- Sentencia para eliminar los datos de una transacción, en este caso transaction_id=1
DELETE FROM transaction
WHERE transaction_id = 1;



