USE LouvreDatabase;
-- �������� ������� ������ � ������ ��� ����������
USE LouvreDatabase;
CREATE LOGIN ModeratorLogin WITH PASSWORD = '12345678';
CREATE USER ModeratorUser FOR LOGIN ModeratorLogin;

-- �������� ������� ������ � ������ ��� ��������������
USE LouvreDatabase;
CREATE LOGIN AdminLogin WITH PASSWORD = '12345678';
CREATE USER AdminUser FOR LOGIN AdminLogin;

-- �������� ������� ������ � ������ ��� ���������
USE LouvreDatabase;
CREATE LOGIN OwnerLogin WITH PASSWORD = '12345678';
CREATE USER OwnerUser FOR LOGIN OwnerLogin;

--�������������� ��������������� ���� ������� ������ ����:
USE LouvreDatabase;
GRANT SELECT ON SCHEMA::dbo TO ModeratorUser;
-- �������������� ���� ������� ��������������
USE LouvreDatabase;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO AdminUser;
-- �������������� ���� ������� ���������
USE LouvreDatabase;
GRANT CONTROL, ALTER, SELECT, INSERT ON SCHEMA::dbo TO OwnerUser;

-- �������� ������� ������� ������� � �������
SELECT name FROM sys.sql_logins;

-- �������� ���� ������� ��� ����������
SELECT permission_name, state_desc FROM sys.database_permissions WHERE grantee_principal_id = USER_ID('ModeratorUser');

-- �������� ���� ������� ��� ��������������
SELECT permission_name, state_desc FROM sys.database_permissions WHERE grantee_principal_id = USER_ID('AdminUser');

-- �������� ���� ������� ��� ���������
SELECT permission_name, state_desc FROM sys.database_permissions WHERE grantee_principal_id = USER_ID('OwnerUser');

