--create new user--
CREATE USER 'new_user'@'12.12.12.12' IDENTIFIED BY "gD3SWW8rgJN_mESPuK4ubGCK8J";
GRANT SELECT PRIVILEGES on *.* to 'user'@'12.12.12.12';
flush privileges;

--select table/column sizes--
SELECT table_name AS “Table Name”,
       ROUND(((data_length + index_length) / 1024 / 1024 / 1024), 2) AS “Table Size (GB)”
FROM information_schema.tables
WHERE table_schema = ‘dbname’
ORDER BY (data_length + index_length) DESC;

--select db largest 10 tables--
SELECT table_name AS `Table`, 
       round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB` 
FROM information_schema.TABLES 
WHERE table_schema = 'db_name' 
ORDER BY `Size in MB` DESC 
LIMIT 10;


--mysqldump/export--
mysqldump -h db_hostname -u admin -p db_schema db_table --set-gtid-purged=OFF --compress --quick --triggers --routines --lock-tables=false --single-transaction > /opt/db/schema.sql

--import into db--
pv backup.sql | mysql -u username -p database_name
--or--
mysql -u username -p database_name < schema.sql

--these can be configured on my.cnf
--for binlog policy--
SHOW VARIABLES LIKE 'binlog_expire_logs_seconds';
SET GLOBAL binlog_expire_logs_seconds = 604800; -- 7 days in seconds
FLUSH BINARY LOGS;

--binlog size--
SHOW VARIABLES LIKE 'max_binlog_size';
SET GLOBAL max_binlog_size = 1073741824; --1GB
