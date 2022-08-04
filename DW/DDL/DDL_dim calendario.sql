USE [DW]
GO

/****** Object:  Table [dim].[calendario]    Script Date: 01/08/2022 21:46:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dim].[calendario](
	[dt_data] [date] NULL,
	[dt_dia] [int] NULL,
	[nm_semana] [nvarchar](30) NULL,
	[nr_semana] [int] NULL,
	[nr_semana_iso] [int] NULL,
	[nr_dia_semana] [int] NULL,
	[nr_mes] [varchar](2) NULL,
	[nm_mes] [nvarchar](30) NULL,
	[nr_quarter] [int] NULL,
	[nr_ano] [int] NULL,
	[dt_primeiro_dia_mes] [date] NULL,
	[dt_ultimo_dia_mes] [date] NULL,
	[nr_dia_ano] [int] NULL,
	[fl_feriado] [varchar](1) NOT NULL
) ON [PRIMARY]
GO


