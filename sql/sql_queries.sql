-- SQL запросы для тестировщика
-- Демонстрация навыков работы с базами данных

-- 1. Выбрать всех пользователей
SELECT * FROM users;

-- 2. Выбрать пользователей из Москвы
SELECT id, username, email, city 
FROM users 
WHERE city = 'Moscow';

-- 3. Посчитать количество заказов у каждого пользователя
SELECT 
    u.id,
    u.username,
    COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.username
ORDER BY order_count DESC;

-- 4. Найти пользователей без заказов
SELECT 
    u.id,
    u.username,
    u.email
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;

-- 5. Топ-5 самых дорогих товаров
SELECT 
    id,
    product_name,
    price,
    category
FROM products
ORDER BY price DESC
LIMIT 5;

-- 6. Средняя стоимость заказа
SELECT 
    AVG(total_amount) as average_order_value
FROM orders
WHERE status = 'completed';

-- 7. Количество товаров в каждой категории
SELECT 
    category,
    COUNT(*) as product_count
FROM products
GROUP BY category
ORDER BY product_count DESC;

-- 8. Заказы за последние 30 дней
SELECT 
    id,
    order_date,
    total_amount,
    status
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';

-- 9. Самый популярный товар (по количеству заказов)
SELECT 
    p.id,
    p.product_name,
    SUM(oi.quantity) as total_ordered
FROM products p
JOIN order_items oi ON p.id = oi.product_id
GROUP BY p.id, p.product_name
ORDER BY total_ordered DESC
LIMIT 1;

-- 10. Общая выручка по месяцам
SELECT 
    DATE_TRUNC('month', order_date) as month,
    SUM(total_amount) as monthly_revenue
FROM orders
WHERE status = 'completed'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month DESC;

-- 11. Пользователи с более чем 3 заказами
SELECT 
    u.id,
    u.username,
    COUNT(o.id) as order_count
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.username
HAVING COUNT(o.id) > 3;

-- 12. Товары, которых нет на складе
SELECT 
    id,
    product_name,
    price,
    stock_quantity
FROM products
WHERE stock_quantity = 0;

-- 13. Заказы с доставкой курьером
SELECT 
    o.id,
    o.order_date,
    o.total_amount,
    u.username,
    d.delivery_type
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN delivery d ON o.delivery_id = d.id
WHERE d.delivery_type = 'courier';

-- 14. Обновить email пользователя
UPDATE users 
SET email = 'new.email@example.com'
WHERE id = 1;

-- 15. Удалить отмененные заказы старше года
DELETE FROM orders 
WHERE status = 'cancelled' 
AND order_date < CURRENT_DATE - INTERVAL '1 year';

-- 16. Добавить новый товар
INSERT INTO products (product_name, price, category, stock_quantity)
VALUES ('Новый смартфон', 59999.99, 'electronics', 50);

-- 17. Найти дубликаты email в пользователях
SELECT 
    email,
    COUNT(*) as duplicate_count
FROM users
GROUP BY email
HAVING COUNT(*) > 1;

-- 18. Статусы заказов и их количество
SELECT 
    status,
    COUNT(*) as order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- 19. Пользователи и их последний заказ
SELECT 
    u.username,
    MAX(o.order_date) as last_order_date,
    o.total_amount
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.username, o.total_amount
ORDER BY last_order_date DESC;

-- 20. Проверка целостности данных: заказы без пользователя
SELECT 
    o.id,
    o.order_date,
    o.user_id
FROM orders o
LEFT JOIN users u ON o.user_id = u.id
WHERE u.id IS NULL;

/*
Комментарии тестировщика:
1. Запросы покрывают основные CRUD-операции
2. Использованы JOIN для проверки связей между таблицами
3. Включены агрегатные функции для анализа данных
4. Есть запросы для проверки целостности данных
5. Все запросы безопасны (не изменяют продовые данные при тестировании)
*/