USE [LouvreDatabase]
GO
/****** Object:  UserDefinedFunction [dbo].[To_AD_BC_Date]    Script Date: 13.05.2023 18:05:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION To_AD_BC_Date (@date DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT
        CASE 
            WHEN YEAR(@date) < 0 THEN CONCAT(ABS(YEAR(@date)), ' BC')
            ELSE CONCAT(YEAR(@date), ' AD')
        END AS formatted_date
);
