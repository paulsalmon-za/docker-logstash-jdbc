select Id, [Description], ISNULL(DateCreated, DateModified) as date_changed
FROM VEHICLES
WHERE ISNULL(DateCreated, DateModified) > :sql_last_value