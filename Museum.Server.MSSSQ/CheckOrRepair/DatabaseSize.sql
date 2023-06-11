
use LouvreDatabase

SELECT
    SUM(CAST(size / 128.0 AS DECIMAL(17,2))) AS [������ � MB]
FROM sys.database_files

-- ������ ������ ������� ����� � ��

SELECT 
    name            AS [���������� ��� �����],     
    physical_name   AS [���� � ��� ����� � ��],
    state_desc      AS [��������� �����],
    
    CAST(size / 128.0 AS DECIMAL(17,2))
                    AS [������ � MB]
    
FROM sys.database_files
