# AIChatFlutter - Многостраничное ИИ-чат приложение

Мультиплатформенное приложение для общения с искусственным интеллектом с расширенной аналитикой использования.

## Возможности

### 4 страницы приложения

| Страница | Описание |
|----------|----------|
| Главная | Список чатов, создание/удаление диалогов |
| Настройки | Выбор провайдера (OpenRouter/VseGPT), ввод API ключей |
| Статистика | Анализ использования токенов по моделям |
| График расходов | Визуализация расходов по дням |

### Поддержка API

- **OpenRouter.ai** - доступ к 100+ языковым моделям
- **VseGPT.ru** - оплата в рублях для пользователей из РФ

### Аналитика

- Подсчёт токенов для каждого сообщения
- Отслеживание стоимости запросов
- Статистика использования по моделям
- График расходов по дням

### Технологии

- **Flutter** - кроссплатформенная разработка
- **Provider** - управление состоянием
- **fl_chart** - визуализация данных
- **SharedPreferences** - хранение настроек
- **SQLite** - локальная база данных

## Быстрый старт

`ash
git clone https://github.com/Sfinks322/AIChatFlutter-MultiPage.git
cd AIChatFlutter-MultiPage
flutter pub get
cp .env.example .env
flutter run -d chrome
``n
## Скриншоты

### Главная страница
![Главная](https://raw.githubusercontent.com/Sfinks322/AIChatFlutter-MultiPage/main/screenshots/home.png)

### Чат с ИИ
![Чат](https://raw.githubusercontent.com/Sfinks322/AIChatFlutter-MultiPage/main/screenshots/chat.png)

### Настройки провайдера
![Настройки](https://raw.githubusercontent.com/Sfinks322/AIChatFlutter-MultiPage/main/screenshots/settings.png)

### Статистика токенов
![Статистика](https://raw.githubusercontent.com/Sfinks322/AIChatFlutter-MultiPage/main/screenshots/stats.png)

### График расходов
![График расходов](https://raw.githubusercontent.com/Sfinks322/AIChatFlutter-MultiPage/main/screenshots/charttoken.png)

### Статистика в чате
![Статистика в чате](https://raw.githubusercontent.com/Sfinks322/AIChatFlutter-MultiPage/main/screenshots/statsinchat.png)

## Структура проекта

`	ext
lib/
+-- api/            # Клиенты API
+-- models/         # Модели данных
+-- providers/      # Управление состоянием
+-- screens/        # Экраны приложения
+-- services/       # Сервисы (БД, аналитика)
+-- main.dart       # Точка входа
``n
## Автор

**Sfinks322** - [GitHub](https://github.com/Sfinks322)
