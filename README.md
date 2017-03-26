Мини-фрэймворк для тестирования базового API компании HH.ru.

Структура проекта:

/environment - папка для хранения файлов(*.yml), в которых указаны параметры запуска тестов.

/expected_data - папка для хранения файлов(*.json) с данными для dictionary endpoints(данные не меняются или меняются редко)

/helper - папка для вынесения слоя логики отдельно от слоя тестов

/spec - папка для тестов

Для запуска тестов и формирования rspec html-отчета необходимо выпонить команду


```html
TEST_ENV=hh_ru.yml rspec spec --format html --out reports/rspec-report/rspec_results.html

```
TEST_ENV - переменная для указания файла с параметрами запуска тестов. Пример файла:

```html
host: 'https://api.hh.ru'
```

Данные для allure отчета находятся в папке /allure-results. 
Пример html allure отчета - в папке reports/allure-report. 
Пример html rspec отчета - в папке reports/rspec-report. 
