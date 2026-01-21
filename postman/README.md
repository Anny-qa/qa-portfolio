# API тестирование: JSONPlaceholder

## Описание проекта
Тестирование REST API публичного сервиса JSONPlaceholder (тестовое API для разработчиков).

## Цель тестирования
1. Проверить работу всех CRUD-операций
2. Проверить валидацию входных данных
3. Проверить коды ответов и структуру JSON
4. Проверить производительность API

## Тестируемые эндпоинты

### Посты (Posts)
- GET /posts - получить все посты
- GET /posts/1 - получить пост с ID=1
- POST /posts - создать новый пост
- PUT /posts/1 - обновить пост с ID=1
- PATCH /posts/1 - частично обновить пост
- DELETE /posts/1 - удалить пост с ID=1

### Комментарии (Comments)
- GET /comments - все комментарии
- GET /comments?postId=1 - комментарии к посту 1
- GET /posts/1/comments - комментарии к посту 1 (альтернативный путь)

### Пользователи (Users)
- GET /users - все пользователи
- GET /users/1 - пользователь с ID=1

## Коллекция Postman
Файл collection.json содержит:
- 15+ запросов ко всем эндпоинтам
- Переменные окружения (environment variables)
- Автоматические проверки (tests)
- Pre-request scripts для подготовки данных

## Проверки (Tests/Assertions)
Для каждого запроса настроены проверки:

### Статус коды
```javascript
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

Время ответа
pm.test("Response time is less than 500ms", function () {
    pm.expect(pm.response.responseTime).to.be.below(500);
});

Структура JSON

pm.test("Response has correct JSON structure", function () {
    var jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('id');
    pm.expect(jsonData).to.have.property('title');
    pm.expect(jsonData).to.have.property('body');
    pm.expect(jsonData).to.have.property('userId');
});

Заголовки

pm.test("Content-Type is present", function () {
    pm.response.to.have.header("Content-Type");
});

pm.test("Content-Type is application/json", function () {
    pm.expect(pm.response.headers.get("Content-Type")).to.include("application/json");
});

Переменные окружения

Создан файл environment.json с переменными:

· baseUrl: https://jsonplaceholder.typicode.com
· postId: 1 (для тестирования конкретного поста)
· userId: 1 (для тестирования конкретного пользователя)

Запуск коллекции

Способ 1: Ручной запуск

1. Импортируйте collection.json в Postman
2. Импортируйте environment.json (если нужно)
3. Выберите окружение "JSONPlaceholder"
4. Запустите коллекцию (Run Collection)

Способ 2: Через Newman (CLI)
# Установка Newman
npm install -g newman

# Запуск коллекции
newman run collection.json -e environment.json

# Запуск с отчетом
newman run collection.json -e environment.json -r cli,html

Отчеты о тестировании

Успешные проверки:

· Все GET-запросы возвращают статус 200
· POST-запросы создают новые ресурсы (возвращают 201)
· PUT/PATCH-запросы обновляют данные
· DELETE-запросы удаляют ресурсы
· JSON-схема соответствует документации

Найденные "баги" (ожидаемые для тестового API):

1. DELETE /posts/1 возвращает 200, но не удаляет ресурс (тестовое API)
2. Изменения при POST/PUT не сохраняются (фиктивное API)
3. Нет реальной валидации данных

Использованные техники тестирования API

1. Позитивное тестирование: валидные запросы
2. Негативное тестирование: невалидные данные, несуществующие ID
3. Тестирование граничных значений: минимальные/максимальные ID
4. Тестирование производительности: время ответа
5. Тестирование безопасности: проверка заголовков CORS

Заключение

Коллекция демонстрирует навыки:

· Работы с Postman
· Написания автоматических проверок
· Тестирования REST API
· Документирования процесса тестирования

---

Коллекция создана для демонстрации навыков API-тестирования
