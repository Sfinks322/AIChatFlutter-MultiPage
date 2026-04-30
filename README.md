# 🤖 AIChatFlutter — Многостраничное ИИ-чат приложение

[![Flutter](https://img.shields.io/badge/Flutter-3.41.4-blue)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.11.1-blue)](https://dart.dev)

Мультиплатформенное приложение для общения с искусственным интеллектом с расширенной аналитикой использования токенов и расходов.

---

## 📱 Возможности

### 🏠 Главная страница
- Создание и управление чатами
- Удаление диалогов свайпом
- Быстрый доступ к истории переписки

### ⚙️ Настройки провайдера
- Выбор между **OpenRouter.ai** и **VseGPT.ru**
- Ввод и сохранение API ключа
- Настройка Base URL, максимального числа токенов и температуры

### 📊 Статистика токенов
- Общее количество использованных токенов
- Суммарные расходы в долларах
- Детальная разбивка по моделям ИИ

### 📈 График расходов
- Визуализация расходов по дням (bar chart)
- Выбор периода: 7, 30 или 90 дней
- Итоговая сумма за выбранный период

---

## 🔌 Поддержка API

| Провайдер | Валюта | Особенности |
|-----------|--------|-------------|
| **OpenRouter.ai** | Доллары | Доступ к 100+ моделям |
| **VseGPT.ru** | Рубли | Оплата в рублях, для РФ |

---

## 🛠 Технологии

| Технология | Назначение |
|------------|------------|
| Flutter | Кроссплатформенный UI |
| Provider | Управление состоянием |
| fl_chart | Графики и диаграммы |
| SharedPreferences | Хранение настроек |
| SQLite | Локальная база данных |

---

## 🚀 Быстрый старт

git clone https://github.com/Sfinks322/AIChatFlutter-MultiPage.git
cd AIChatFlutter-MultiPage
flutter pub get
cp .env.example .env
flutter run -d chrome

---

## 📸 Скриншоты

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

---

## 👤 Автор

**Sfinks322** — [GitHub](https://github.com/Sfinks322)

*Последнее обновление: апрель 2026*
