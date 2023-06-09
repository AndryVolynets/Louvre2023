use LouvreDatabase

GO
CREATE PROCEDURE ADMIN_GetTableColumns
    @tableName NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
		@@Servername AS Server ,
        DB_NAME() AS DBName ,
        C.COLUMN_NAME,
        CASE 
            WHEN C.COLUMN_NAME IN (
                SELECT COLUMN_NAME
                FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                WHERE TABLE_NAME = @tableName AND CONSTRAINT_NAME LIKE 'PK%' -- Проверка на первичный ключ
            ) THEN 'PrimaryKey'
            WHEN C.COLUMN_NAME IN (
                SELECT COLUMN_NAME
                FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                WHERE TABLE_NAME = @tableName AND CONSTRAINT_NAME LIKE 'FK%' -- Проверка на внешний ключ
            ) THEN 'ForeignKey'
            ELSE 'RegularColumn'
        END AS ColumnType,
        T.TABLE_SCHEMA,
        T.TABLE_TYPE,
        C.IS_NULLABLE,
        C.DATA_TYPE,
		C.ORDINAL_POSITION
    FROM INFORMATION_SCHEMA.COLUMNS AS C
    JOIN INFORMATION_SCHEMA.TABLES AS T
        ON C.TABLE_NAME = T.TABLE_NAME
    WHERE C.TABLE_NAME = @tableName
    ORDER BY C.ORDINAL_POSITION;
END;

