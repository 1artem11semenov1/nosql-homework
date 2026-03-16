-- Решение заданий по ClickHouse

-- 1. Создание таблицы
CREATE TABLE IF NOT EXISTS server_logs
(
  timestamp DateTime('Europe/Moscow'),
  user_id String,
  endpoint String,
  response_time_ms UInt32,
  status_code UInt16
)
ENGINE = MergeTree()
PRIMARY KEY (timestamp, endpoint)
ORDER BY (timestamp, endpoint);

-- 2. Загрузка данных из CSV
-- Подсказка: можно использовать clickhouse-client с параметром --query
-- Пример команды (выполняется в терминале):
-- cat server_logs.csv | clickhouse-client --query="INSERT INTO server_logs FORMAT CSVWithNames"


-- 3. Запрос: Топ-5 самых медленных endpoint'ов (по среднему времени ответа)
SELECT endpoint
FROM server_logs
GROUP BY endpoint
ORDER BY avg(response_time_ms) desc
LIMIT 5;

-- 4. Запрос: Количество запросов по часам за весь период в логах
SELECT
  toHour(timestamp) AS hour,
  count(*) AS requests_count
FROM server_logs
GROUP BY hour;

-- 5. Запрос: Процент ошибок (status_code >= 400) для каждого endpoint'а
SELECT
  endpoint,
  floor((countIf(status_code >= 400) * 100) / count(*)) AS err_percent
FROM server_logs
GROUP BY endpoint;
