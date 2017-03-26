Мини-фрэймворк для тестирования базового API компании HH.ru.

Структура проекта:

/environment - папка для хранения файлов(*.yml), в которых указаны параметры запуска тестов.

/expected_data - папка для хранения файлов(*.json) с данными для dictionary endpoints(данные не меняются или меняются редко)

/helper - папка для вынесения слоя логики отдельно от слоя тестов

/spec - папка для тестов

Для запуска тестов и формирования html-отчета необходимо выпонить команду


```html
TEST_ENV=hh_ru.yml rspec spec --format html --out rspec_results.html
```
