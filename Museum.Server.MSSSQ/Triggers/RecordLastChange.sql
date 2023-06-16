-- �������� ������� ��� ������ ��������� ���������
CREATE TABLE LastChanges (
    TableName NVARCHAR(128),
    ChangeType NVARCHAR(50),
    Description NVARCHAR(MAX),
    LastModified DATETIME
);

GO
-- �������� �������� ��� ������ ��������� ��������� �� ������������ �������
CREATE TRIGGER RecordLastChange_ApplicationRole
ON ApplicationRole -- �������� �� ��� ������ �������
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- ����������� ���� ���������
    DECLARE @ChangeType NVARCHAR(50);
    SET @ChangeType = CASE 
        WHEN EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) THEN 'UPDATE'
        WHEN EXISTS (SELECT * FROM inserted) THEN 'INSERT'
        WHEN EXISTS (SELECT * FROM deleted) THEN 'DELETE'
    END;
    
    -- ����������� �������� ���������
    DECLARE @Description NVARCHAR(MAX);
    SET @Description = CASE
        WHEN @ChangeType = 'UPDATE' THEN 'Updated record(s) in YourTableName' -- �������� �� ��� ������ �������
        WHEN @ChangeType = 'INSERT' THEN 'Inserted record(s) into YourTableName' -- �������� �� ��� ������ �������
        WHEN @ChangeType = 'DELETE' THEN 'Deleted record(s) from YourTableName' -- �������� �� ��� ������ �������
    END;
    
    -- ������ ���������� ��������� � ������� LastChanges
    INSERT INTO LastChanges (TableName, ChangeType, Description, LastModified)
    VALUES ('ApplicationRole', @ChangeType, @Description, GETDATE()); -- �������� �� ��� ������ �������
END