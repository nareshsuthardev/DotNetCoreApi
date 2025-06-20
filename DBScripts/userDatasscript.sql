USE [UserData]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 8/12/2023 10:00:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CountryId] [int] NOT NULL,
	[CountryName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 8/12/2023 10:00:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Language]    Script Date: 8/12/2023 10:00:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Language](
	[LanguageId] [int] NOT NULL,
	[LanguageName] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 8/12/2023 10:00:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[roleId] [int] NOT NULL,
	[roleName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[State]    Script Date: 8/12/2023 10:00:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State](
	[SId] [int] NOT NULL,
	[StateName] [nvarchar](50) NULL,
	[CountryId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 8/12/2023 10:00:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[GenderId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[Languages] [nvarchar](50) NOT NULL,
	[dob] [datetime] NULL,
	[roleId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__User__1788CC4C7B76F314] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Country] ([CountryId], [CountryName]) VALUES (1, N'India')
INSERT [dbo].[Country] ([CountryId], [CountryName]) VALUES (2, N'USA')
INSERT [dbo].[Country] ([CountryId], [CountryName]) VALUES (3, N'China')
INSERT [dbo].[Country] ([CountryId], [CountryName]) VALUES (4, N'Russia')
INSERT [dbo].[Country] ([CountryId], [CountryName]) VALUES (5, N'France')
GO
INSERT [dbo].[Gender] ([Id], [Name]) VALUES (1, N'Male')
INSERT [dbo].[Gender] ([Id], [Name]) VALUES (2, N'Female')
INSERT [dbo].[Gender] ([Id], [Name]) VALUES (3, N'Other')
GO
INSERT [dbo].[Language] ([LanguageId], [LanguageName]) VALUES (1, N'Hindi')
INSERT [dbo].[Language] ([LanguageId], [LanguageName]) VALUES (2, N'English')
INSERT [dbo].[Language] ([LanguageId], [LanguageName]) VALUES (3, N'Marathi')
GO
INSERT [dbo].[Role] ([roleId], [roleName]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([roleId], [roleName]) VALUES (2, N'Manager')
INSERT [dbo].[Role] ([roleId], [roleName]) VALUES (3, N'Seller')
INSERT [dbo].[Role] ([roleId], [roleName]) VALUES (4, N'Buyer')
GO
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (1, N'Maharashtra', 1)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (2, N'Rajasthan', 1)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (3, N'UttarPradesh', 1)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (4, N'Bihar', 1)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (5, N'Karnataka', 1)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (6, N'California', 2)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (7, N'Texas', 2)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (8, N'Chuvash Republic', 4)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (9, N'Buryatia', 4)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (10, N'Shanghai', 3)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (11, N'Sichuan', 3)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (12, N'Ingushetia', 4)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (13, N'Qinghai', 3)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (14, N'Yunnan', 3)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (15, N'Kalmykia', 4)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (16, N'Karelia', 4)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (17, N'Zhejiang', 3)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (18, N'Florida ', 2)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (19, N'Alaska', 2)
INSERT [dbo].[State] ([SId], [StateName], [CountryId]) VALUES (20, N'NewYork', 2)
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (2, N'Mark', N'Mark@1234', 1, 2, 19, N'1,3', CAST(N'2023-01-25T00:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (3, N'Kevin', N'Kevin@1234', 2, 4, 12, N'3,2', CAST(N'2023-01-25T00:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (4, N'Doe', N'Doe@12345', 2, 1, 3, N'2,3,1', CAST(N'2023-01-25T00:00:00.000' AS DateTime), 3, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (7, N'Wilson', N'Wilson@1234', 1, 1, 3, N'1,2,3', CAST(N'2023-01-25T00:00:00.000' AS DateTime), 4, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (10, N'John', N'John@1234', 1, 1, 2, N'1,3,2', CAST(N'2023-01-25T00:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (12, N'Karan', N'Karan@1234', 1, 3, 17, N'2', CAST(N'2023-01-25T00:00:00.000' AS DateTime), 2, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (17, N'Johnson', N'Johnson@1234', 1, 1, 4, N'1,2', CAST(N'2023-02-04T00:00:00.000' AS DateTime), 3, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (1012, N'Paul', N'Paul@1234', 1, 2, 18, N'2,3', CAST(N'2023-02-07T00:00:00.000' AS DateTime), 4, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (2012, N'Ortan', N'Ortan@1234', 1, 1, 2, N'1,2', CAST(N'2023-02-15T00:00:00.000' AS DateTime), 1, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (2013, N'Marks', N'Asdf@1233', 1, 1, 3, N'2', CAST(N'2023-02-15T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (2014, N'KevinObrin', N'Asdf@1234', 1, 1, 2, N'2,3', CAST(N'2023-02-15T00:00:00.000' AS DateTime), 3, 0)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (2015, N'Asdf', N'Asdf@1234', 1, 1, 3, N'2', CAST(N'2023-02-15T00:00:00.000' AS DateTime), 4, 1)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (2016, N'Marken', N'Marken@1234', 1, 1, 5, N'2,3', NULL, 1, 1)
INSERT [dbo].[User] ([UserId], [Username], [Password], [GenderId], [CountryId], [StateId], [Languages], [dob], [roleId], [IsDeleted]) VALUES (2017, N'Rock', N'Rock@1234', 2, 2, 7, N'2', NULL, 2, 0)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[State]  WITH CHECK ADD  CONSTRAINT [FK_Country_State_Id] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[State] CHECK CONSTRAINT [FK_Country_State_Id]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([roleId])
REFERENCES [dbo].[Role] ([roleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_UserCountry_countryId] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([CountryId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_UserCountry_countryId]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_UserGender_GenderId] FOREIGN KEY([GenderId])
REFERENCES [dbo].[Gender] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_UserGender_GenderId]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_UserState_StateId] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([SId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_UserState_StateId]
GO
