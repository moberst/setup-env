## Drop all connections to a database

TARGET_DB=$1

echo 'SELECT pg_terminate_backend(pg_stat_activity.pid)
	FROM pg_stat_activity
	WHERE pg_stat_activity.datname = "$TARGET_DB"
  	AND pid <> pg_backend_pid();' | psql 


