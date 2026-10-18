USE [Invoice_Assessment_1_Test]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 17-10-2026 16:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](5) NOT NULL,
	[Name] [varchar](25) NOT NULL,
	[Description] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[IsDeleted] [bit] NULL,
	[CreatedBy] [varchar](100) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](100) NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Delete]    Script Date: 17-10-2026 16:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Category_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Category_Delete] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_Category_Delete]
(
@Id INT
)
AS 
BEGIN

UPDATE Category
SET
IsActive=0,
IsDeleted=1

WHERE Id=@Id AND ISNULL(IsDeleted, 0) = 0;
SELECT CAST(
        CASE WHEN @@ROWCOUNT > 0 THEN 1 ELSE 0 END
        AS BIT
    ) AS Success;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_GetAll]    Script Date: 17-10-2026 16:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Category_GetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Category_GetAll] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_Category_GetAll]
AS 
BEGIN

SELECT Id,Code,Name,Description,IsActive,IsDeleted,CreatedBy,CreatedDate,UpdatedBy,UpdatedDate
FROM Category
WHERE ISNULL(IsDeleted, 0) = 0;


END
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_GetById]    Script Date: 17-10-2026 16:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Category_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Category_GetById] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_Category_GetById]
(
@Id INT
)
AS
BEGIN

SELECT Id,Code,Name,Description,IsActive,IsDeleted,CreatedBy,CreatedDate,UpdatedBy,UpdatedDate
FROM Category
WHERE Id=@Id AND ISNULL(IsDeleted, 0) = 0;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Insert]    Script Date: 17-10-2026 16:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Category_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Category_Insert] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_Category_Insert]
(
@Code VARCHAR(5),
@Name VARCHAR(25),
@Description VARCHAR(100),
@IsActive BIT,
@IsDeleted BIT
)
AS
BEGIN

INSERT INTO Category
(
Code,
Name,
Description,
IsActive,
IsDeleted,
CreatedBy,
CreatedDate
)
VALUES
(
@Code,
@Name,
@Description,
@IsActive,
@IsDeleted,
SYSTEM_USER,
GETDATE()
)
 SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Category_Update]    Script Date: 17-10-2026 16:27:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_Category_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_Category_Update] AS' 
END
GO
ALTER PROCEDURE [dbo].[sp_Category_Update]
(
@Id INT,
@Code VARCHAR(5),
@Name VARCHAR(25),
@Description VARCHAR(100),
@IsActive BIT,
@IsDeleted BIT
)
AS
BEGIN

Update Category
SET
Code=@Code,
Name=@Name,
Description=@Description,
IsActive=@IsActive,
IsDeleted=@IsDeleted,
UpdatedBy=SYSTEM_USER,
UpdatedDate=GETDATE()
WHERE Id=@Id

END;
GO
