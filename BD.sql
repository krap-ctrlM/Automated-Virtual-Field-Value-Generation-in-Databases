-- Создание таблицы с виртуальным полем
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * price_per_unit) VIRTUAL
);

-- Вставка данных
INSERT INTO orders (quantity, price_per_unit) VALUES (10, 5.5), (3, 12.75);

-- Выбор данных с вычисленным полем
SELECT * FROM orders;

-- Хранимая процедура для автоматического расчета скидки
DELIMITER //
CREATE PROCEDURE apply_discount()
BEGIN
    UPDATE orders
    SET total_price = total_price * 0.9
    WHERE total_price > 50;
END //
DELIMITER ;

-- Вызов процедуры
CALL apply_discount();

-- Представление для вычисления среднего значения
CREATE VIEW average_order_value AS
SELECT AVG(total_price) AS avg_value FROM orders;

-- Запрос к представлению
SELECT * FROM average_order_value;
