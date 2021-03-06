USE [sa365]
GO
/****** Object:  StoredProcedure [dbo].[InsertAccountMovementRecord]    Script Date: 08/01/2014 14:10:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAccountMovementRecord]
(
	@AccID int,
	@Outstanding real,
	@CurrentCat int,
	@PreviousCat int,
	@branch nchar(10),
	@ct int,
	@aging datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_account_movement
                         (datAccountID, datOutstandingAmount, datCurrentCat, datPreviousCat, datBranch, datCreditTeam, datAgingDate)
VALUES        (@AccID,@Outstanding,@CurrentCat,@PreviousCat,@branch,@ct,@aging)
GO
/****** Object:  StoredProcedure [dbo].[GetRptCreditInformation]    Script Date: 08/01/2014 14:10:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptCreditInformation]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datCreditor, datDescription, datCreditValue, datMonthlyObligation, datOutstanding, datIssueDate, datExpiryDate
FROM            tbl_credit_information
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateDaysOver]    Script Date: 08/01/2014 14:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateDaysOver]
(
	@DaysOver int,
	@finRptBalance_Daily decimal(20, 2),
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datDaysOver = @DaysOver, datFinRptBalance_Daily = @finRptBalance_Daily
WHERE        (datID = @AccID)
GO
/****** Object:  UserDefinedFunction [dbo].[getExpectedAmount]    Script Date: 08/01/2014 14:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getExpectedAmount]
	(
	@AppID int,
	@EndDate datetime,
	@outstanding decimal(20,2),
	@date nvarchar(10)
	)
RETURNS decimal(20,2)/* datatype */
AS
	BEGIN
	DECLARE @return decimal(20,2)

	if(@EndDate <= GETDATE())
	BEGIN

		set @return=@outstanding	
	
	END
	else
	BEGIN 

		SELECT  @return =datMonthlyPayment
		FROM tbl_pplan_details
		WHERE (datApplicationID = @AppID) AND ( datMonth LIKE Cast(@date as datetime))

	END

	RETURN @return

	END
GO
/****** Object:  StoredProcedure [dbo].[GetRptInitiator]    Script Date: 08/01/2014 14:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptInitiator]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        datFullname, datPosition, datMobileNumber, datTelephoneNumber, datEmailAddress, datFaxNumber, datPhysicalAddress, status
FROM            tbl_contact_person
WHERE        (datApplicationID = @AppID) AND (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[newClient]    Script Date: 08/01/2014 14:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[newClient]
	
	(
	@clientnumber varchar(50),
	@clientType int,
	@title int,
	@fname varchar(150),
	@mname varchar(150),
	@sname varchar(150),
	@fullname varchar(300),
	@hometel varchar(20),
	@mobileno varchar(20),
	@emailAddress varchar(150),
	@res varchar(255),
	@return int output
	)
	
AS
	/* SET NOCOUNT ON */

	INSERT INTO tbl_client
                      (datClientNumber,datClientType,datTitle, datFirstName, datMiddleName, datSurname, datClientName, datHomeTelephoneNumber, datMobileNumber1, datEmailAddress, 
                      datCurrentResidentialAddress, status, modifiedDate)
VALUES     (@clientnumber,@clientType, @title,@fname,@mname,@sname,@fullname,@hometel,@mobileno,@emailAddress,@res, 1, GETDATE())
	
 SET @Return = SCOPE_IDENTITY()
RETURN
GO
/****** Object:  UserDefinedFunction [dbo].[getAmtCollection]    Script Date: 08/01/2014 14:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAmtCollection]
	(
	@AccID int,
	@date nvarchar(10)
	)
RETURNS decimal(20,2)/* datatype */

AS
	BEGIN
	DECLARE @return decimal(20,2)
	
	SELECT @return = tbl_pplan_details.datMonthlyPayment 
    FROM tbl_historic_accounts 
				INNER JOIN tbl_pplan_details ON (tbl_historic_accounts.datApplicationID = tbl_pplan_details.datApplicationID AND 
				tbl_pplan_details.datMonth BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME)))
				WHERE (datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND datAccountID = @AccID

	if(@return is null)
	BEGIN
	 set @return=0
	END 

	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetWeekExpected]    Script Date: 08/01/2014 14:14:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[GetWeekExpected]
(
 @week int,
 @AccID int,
 @date nvarchar(10)
 

)
returns decimal(20,2)

as 

BEGIN

declare @return decimal(20,2)
declare @month int

set @month = datepart(m,Cast(@date as datetime))

SELECT @return = datCreditAmount FROM tbl_financial_transactions AS lt 
WHERE (datediff(week, dateadd(week, datediff(week, 0, dateadd(month, datediff(month, 0, lt.modifiedDate), 0)), 0), lt.modifiedDate - 1) + 1= @week 
and datepart(m,lt.modifiedDate) =@month) AND (lt.datAccountID=@AccID) AND (datGLAccount = 1)

if(@return is null)
set @return =0

return @return
END
GO
/****** Object:  StoredProcedure [dbo].[newCoporate]    Script Date: 08/01/2014 14:11:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[newCoporate]
	
	(
	@clientid int,
	@company varchar(250),
	@address varchar(255),
	@telno varchar(20)
	)
	
AS
	/* SET NOCOUNT ON */
INSERT INTO tbl_corporate_info
                         (datClientID, datCompanyName, datPhysicalAddress, datTelephoneNumber1, status)
VALUES        (@clientid,@company,@address,@telno, 1)
	
RETURN
GO
/****** Object:  StoredProcedure [dbo].[GetRptEmploymentDetails]    Script Date: 08/01/2014 14:10:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptEmploymentDetails]
(
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datCompanyName, datPhysicalAddress, datPosition, datStaffID, datDateOfEmployment, datTelephoneNumber, datFaxNumber, datMonthlyIncome, datOtherIncome, 
                         datMonthlyExpenditure, datDisposalbleIncome, datInstituteID
FROM            tbl_employment_details
WHERE        (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[getClients]    Script Date: 08/01/2014 14:09:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getClients]

AS
	/* SET NOCOUNT ON */
	
	SELECT        datClientNumber, datTitle, datClientName, datEmailAddress, datID
	FROM            tbl_client
	RETURN
GO
/****** Object:  UserDefinedFunction [dbo].[getPrevHistoricAcCat]    Script Date: 08/01/2014 14:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getPrevHistoricAcCat]
	(
	@ID int = NULL,
	@date datetime
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT      @return=datCategory
	FROM     tbl_historic_accounts
	WHERE        (datID = @ID) AND ( datAgingDate= dateadd(day,datediff(day,1,@date),0))
	
	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getIDType]    Script Date: 08/01/2014 14:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getIDType]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT      @return=datDescription
	FROM            opt_identification_types
	WHERE        (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetRptAsset]    Script Date: 08/01/2014 14:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptAsset]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        opt_asset_types.datDescription AS assetType, tbl_assets.datDescription, tbl_assets.datValue
FROM            tbl_assets INNER JOIN
                         opt_asset_types ON tbl_assets.datAssetTypeID = opt_asset_types.datID
WHERE        (tbl_assets.datApplicationID = @AppID) AND (tbl_assets.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Portfolio_Rpt]    Script Date: 08/01/2014 14:12:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Portfolio_Rpt]
	
	@date nvarchar(10),
	@BranchID int,
	@CMID int,
    @category int
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT     ha.datID, ha.datAccountID, ha.datAccountNumber, ha.datClientFullname, ha.datInitialAmount, ha.datIssuedate, ha.datEndDate, 
                      dbo.getCategories(ha.datCategory) AS datCategory, dbo.getAccountStatus(ha.datAccountStatus) AS AccountStatus, 
				dbo.getExpectedAmount(ha.datApplicationID, ha.datEndDate, ha.datOutstandingAmount, '''+@date+''') AS ExpectedAmt, 
				dbo.GetWeekExpected(1, ha.datAccountID, '''+@date+''') AS Week1, 
				dbo.GetWeekExpected(2, ha.datAccountID, '''+@date+''') AS Week2, 
				dbo.GetWeekExpected(3, ha.datAccountID, '''+@date+''') AS Week3, 
				dbo.GetWeekExpected(4, ha.datAccountID, '''+@date+''') AS Week4, 
                dbo.GetWeekExpected(5, ha.datAccountID, '''+@date+''') AS Week5, 
				dbo.GetWeekExpected(1, ha.datAccountID, '''+@date+''') 
			  + dbo.GetWeekExpected(1, ha.datAccountID, '''+@date+''') 
              + dbo.GetWeekExpected(1, ha.datAccountID, '''+@date+''') 
			  + dbo.GetWeekExpected(1, ha.datAccountID, '''+@date+''') 
			  + dbo.GetWeekExpected(1, ha.datAccountID, '''+@date+''') AS TotalWeek, ha.datOutstandingAmount
FROM         tbl_historic_accounts AS ha INNER JOIN
                      sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON ha.datTeamID = br.datID INNER JOIN
                      opt_categories ON ha.datCategory = opt_categories.datID
WHERE     (ha.datAgingDate BETWEEN CAST('''+@date+''' AS DATETIME) AND DATEADD(DAY, 1, CAST('''+@date+''' AS DATETIME)))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END
--if(@Type != 0 )
--BEGIN
--
--set @query =  @query + ' AND  ha.datPerformance =' + cast(@Type as nvarchar(10)) 
--END

if(@category != 0 )
BEGIN

set @query =  @query + ' AND  ha.datCategory =' + cast(@category as nvarchar(10)) 
END
BEGIN
 
set @query = @query + ' ORDER BY ha.datClientFullname '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[GetRptNextOfKin]    Script Date: 08/01/2014 14:10:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptNextOfKin]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datFullName, datMobileNumber, datHomeTelephoneNumber, datOfficeTelephoneNumber, datEmailAddress, datPercentageShare, datAddress
FROM            tbl_next_of_kin
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetDailyInterest]    Script Date: 08/01/2014 14:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetDailyInterest]
(
	@Interest decimal(20, 2),
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datDailyInterest = @Interest, datFlag = 0
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptNoOfEmployee]    Script Date: 08/01/2014 14:10:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptNoOfEmployee]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datManagement, datSkilled, datUnskilled, datCasual, datTotal
FROM            tbl_noofemployees
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptPaymentPlan]    Script Date: 08/01/2014 14:10:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptPaymentPlan]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datMonth, datBalanceBF, datInterest1, datMonthlyPayment, datPrincipalComponent, 
                         CASE WHEN datOutstanding = NULL THEN 0.0 
							  WHEN datOutstanding > 0.00 THEN datOutstanding 
						 END AS amtOutstanding
FROM            tbl_pplan_details
WHERE        (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetMonthlyInterest]    Script Date: 08/01/2014 14:13:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetMonthlyInterest]
(
	@interest decimal(20, 2),
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datBulletInterest = @interest, datFlag = 1
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetFinRptBalanceMonthly]    Script Date: 08/01/2014 14:13:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetFinRptBalanceMonthly]
(
	@finRptBalanceMnthly decimal(20, 2),
	@AmtOut decimal(20, 2),
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datFinRptBalance_Monthly = @finRptBalanceMnthly, datOutstandingAmount = @AmtOut
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[GetListItems]    Script Date: 08/01/2014 14:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetListItems]
AS
	SET NOCOUNT ON;
SELECT        datID, datOrder, datDescription, datHeader, datView, datCount, datSubHeader
FROM            opt_list_items
GO
/****** Object:  StoredProcedure [dbo].[getLoanApplications]    Script Date: 08/01/2014 14:10:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getLoanApplications]
(
	@AppID varchar(20)
)
AS
	SET NOCOUNT ON;
SELECT datNewClient, datApplicationNumber, datClientID, datNatureOfBusiness, datTypeOfBusiness, datNumberOfYears, datAveMonthlyIncome, datApplicationDate, datLoanType, datLoanAmount, datDisburseAmount, datPaymentPlanAmount, datTotalPayment, datTotalInterest, datFees, datDuration, datPurpose, datInterestRate, datFirstPaymentDate, datFrequency, datInterestRateType, datPaneltyType, datHearAboutUs, datTeamID, datAlert, datMoveTime, datCreditTeamID, datCreditOfficerID, datPreviousUserID, datApplicationStatus, datReinstateID, datRefreshedID, status, modifiedDate, userID, datID FROM tbl_loan_application WHERE (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetAccountFrozen]    Script Date: 08/01/2014 14:13:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetAccountFrozen]
(
	@date datetime,
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE tbl_loan_accounts SET datPerformance = 2, datAccountStatus = 2,  datFrozenDate = @date  WHERE datID = @AccID
GO
/****** Object:  StoredProcedure [dbo].[InsertListItem]    Script Date: 08/01/2014 14:11:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertListItem]
(
	@order int,
	@description varchar(50),
	@header int,
	@view int,
	@count int,
	@subheader int
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_list_items
                         (datOrder, datDescription, datHeader, datView, datCount, datSubHeader)
VALUES        (@order,@description,@header,@view,@count,@subheader)
GO
/****** Object:  StoredProcedure [dbo].[GetRptFinancial]    Script Date: 08/01/2014 14:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptFinancial]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datMonth, datYear, datSales, datCostOfSales, datGrossOfProfit, datAdminCost, datNetProfit
FROM            tbl_financials
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[getLoanApps]    Script Date: 08/01/2014 14:10:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getLoanApps]
(
	@branchID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_client.datClientNumber, tbl_client.datClientName, tbl_loan_application.datLoanType, tbl_loan_application.datLoanAmount, 
                         tbl_loan_application.datApplicationNumber
FROM            tbl_loan_application INNER JOIN
                         tbl_client ON tbl_loan_application.datID = tbl_client.datID
WHERE        (tbl_loan_application.datTeamID = @branchID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateListItem]    Script Date: 08/01/2014 14:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateListItem]
(
	@order int,
	@description varchar(50),
	@header int,
	@view int,
	@count int,
	@subheader int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_list_items
SET                datOrder = @order, datDescription = @description, datHeader = @header, datView = @view, datCount = @count, datSubHeader = @subheader
GO
/****** Object:  StoredProcedure [dbo].[GetRptBankers]    Script Date: 08/01/2014 14:10:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptBankers]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datBank, datAccountName, datBranch, datAccountType, datAccountNo
FROM            tblBankers
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetCreditTeam]    Script Date: 08/01/2014 14:09:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCreditTeam]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datTeamID, status
FROM            sys_credit_teams
GO
/****** Object:  StoredProcedure [dbo].[GetRptAuditors]    Script Date: 08/01/2014 14:10:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptAuditors]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_auditors.datAuditorName, tbl_auditors.datAddress, opt_aors.datDescription AS aors
FROM            tbl_auditors INNER JOIN
                         opt_aors ON tbl_auditors.datAORS = opt_aors.datID
WHERE        (tbl_auditors.datApplicationID = @AppID) AND (tbl_auditors.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetCreditTeamByBranch]    Script Date: 08/01/2014 14:09:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCreditTeamByBranch]
(
	@BranchID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datTeamID, status
FROM            sys_credit_teams
WHERE        (datTeamID = @BranchID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptSupportingDocuments]    Script Date: 08/01/2014 14:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptSupportingDocuments]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datFileName, datDescription, modifiedDate
FROM            tbl_supporting_documents
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertNewApplication]    Script Date: 08/01/2014 14:11:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertNewApplication]
(
	@clientID int,
	@clientName varchar(250),
	@loanType int,
	@branchID int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_loan_application
                         (datClientID, datClientName, datLoanType, datTeamID, datPreviousUserID, status, datMoveTime, datApplicationStatus)
VALUES        (@clientID,@clientName,@loanType,@branchID,@userID, 1, GETDATE(), 2)
GO
/****** Object:  StoredProcedure [dbo].[GetCreditTeamDetail]    Script Date: 08/01/2014 14:09:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCreditTeamDetail]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datTeamID, status
FROM            sys_credit_teams
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptIncomeExpense]    Script Date: 08/01/2014 14:10:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptIncomeExpense]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datBusinessSurplus, datIncome, datOtherIncome, datRent, datFood, datEducation, datStaff, datTransport, datHealth, datClothing, datEntertainment, datCharity, 
                         datPayments, datOthers, datUnexpected
FROM            tbl_incomeexpense
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[Update_IntialInterview]    Script Date: 08/01/2014 14:12:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_IntialInterview]
(
	@AppID int,
	@newclient int,
	@loanType int,
	@natureofBusiness varchar(100),
	@typeOfBusiness varchar(255),
	@noOfYears int,
	@aveMonthlyIncome decimal(20, 2),
	@appNumber varchar(20),
	@loanAmount decimal(20, 2),
	@disburseAmt decimal(20, 2),
	@paymentplan decimal(20, 2),
	@clientName varchar(250),
	@duration int,
	@purpose int,
	@interestrate decimal(20, 2),
	@firstpaymentDate datetime,
	@frequency int,
	@interestRateType int,
	@hearaboutus varchar(255)
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_application
SET                datNewClient = @newclient, datLoanType = @loanType, datNatureOfBusiness = @natureofBusiness, datTypeOfBusiness = @typeOfBusiness, 
                         datNumberOfYears = @noOfYears, datAveMonthlyIncome = @aveMonthlyIncome, datApplicationNumber = @appNumber, datLoanAmount = @loanAmount, 
                         datDisburseAmount = @disburseAmt, datPaymentPlanAmount = @paymentplan, datClientName = @clientName, datDuration = @duration, datPurpose = @purpose, 
                         datInterestRate = @interestrate, datApplicationDate = GETDATE(), datFirstPaymentDate = @firstpaymentDate, datFrequency = @frequency, 
                         datInterestRateType = @interestRateType, datHearAboutUs = @hearaboutus
WHERE datID=@AppID
GO
/****** Object:  StoredProcedure [dbo].[GetAllLoanRepayments]    Script Date: 08/01/2014 14:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllLoanRepayments]
AS
	SET NOCOUNT ON;
SELECT datID, datReceiptNumber, datPaymentDate, datAccountID, datAccountNumber, datClientNumber, datIssueDate, datInterestRate, datCash, datBank, datTotalAmount, datTotalFees, datLoanType, datPurpose, datBranch FROM tbl_loan_repayments
GO
/****** Object:  StoredProcedure [dbo].[InsertCreditTeam]    Script Date: 08/01/2014 14:10:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCreditTeam]
(
	@descripiton varchar(100),
	@branchID int,
	@status int
)
AS
	SET NOCOUNT OFF;
INSERT INTO sys_credit_teams
                         (datDescription, datTeamID, status)
VALUES        (@descripiton,@branchID,@status)
GO
/****** Object:  StoredProcedure [dbo].[GetInterestDate]    Script Date: 08/01/2014 14:09:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInterestDate]
(
	@month varchar(50),
	@AccID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datAccountID, datApplicationID, datMonth
FROM            tbl_interest_dates
WHERE        (datMonth = @month) AND (datAccountID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[InsertCollateral]    Script Date: 08/01/2014 14:10:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCollateral]
(
	@clientID int,
	@AppID int,
	@CollateralType int,
	@Description varchar(255),
	@location varchar(255),
	@value decimal(18, 2),
	@surety int,
	@contactperson varchar(50),
	@cpTel varchar(50),
	@address varchar(50),
	@confirma int,
	@picture image =null
)
AS
	SET NOCOUNT ON;
INSERT INTO tbl_collaterals
                         (datClientID, datApplicationID, datCollateralTypeID, datDescription, datLocation, datValue, datSurety, datContactPerson, datContactPersonTelephoneNumber, 
                         datPhysicalAddress, datConfirmed, datPicture, status, modifiedDate)
VALUES        (@clientID,@AppID,@CollateralType,@Description,@location,@value,@surety,@contactperson,@cpTel,@address,@confirma,@picture, 1, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[InsertLoanRepayment]    Script Date: 08/01/2014 14:11:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertLoanRepayment]
(
	@receiptno varchar(50),
	@paymentdate datetime,
	@AccID int,
	@AccNo varchar(50),
	@clientNo varchar(100),
	@issuedate datetime,
	@interestrate decimal(20, 2),
	@cash decimal(20, 2),
	@bank decimal(20, 2),
	@totalAmt decimal(20, 2),
	@totalfees decimal(20, 2),
	@loantype int,
	@purpose int,
	@branch int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_loan_repayments(datReceiptNumber, datPaymentDate, datAccountID, datAccountNumber, datClientNumber, datIssueDate, datInterestRate, datCash, datBank, datTotalAmount, datTotalFees, datLoanType, datPurpose, datBranch, userID) VALUES (@receiptno, @paymentdate, @AccID, @AccNo, @clientNo, @issuedate, @interestrate, @cash, @bank, @totalAmt, @totalfees, @loantype, @purpose, @branch, @userID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateCreditTeam]    Script Date: 08/01/2014 14:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCreditTeam]
(
	@description varchar(100),
	@branchid int,
	@status int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       sys_credit_teams
SET                datDescription = @description, datTeamID = @branchid, status = @status
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertReligionDetails]    Script Date: 08/01/2014 14:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertReligionDetails]
(
	@AppID int,
	@ClientID int,
	@religion int,
	@placeOfWorship varchar(25),
	@Leader varchar(100),
	@tel varchar(25),
	@address varchar(255)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_religions
                         (datApplicationID, datClientID, datReligionID, datPlaceOfWorship, datLeader, datTelephoneNumber, datPhysicalAddress)
VALUES        (@AppID,@ClientID,@religion,@placeOfWorship,@Leader,@tel,@address)
GO
/****** Object:  StoredProcedure [dbo].[GetListItem]    Script Date: 08/01/2014 14:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetListItem]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datOrder, datDescription, datHeader, datView, datCount, datSubHeader
FROM            opt_list_items
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateNewAmtOutstanding]    Script Date: 08/01/2014 14:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateNewAmtOutstanding]
(
	@amtDeductable decimal(20, 2),
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE tbl_loan_accounts SET datOutstandingAmount = (datOutstandingAmount - @amtDeductable), datFinRptBalance_Monthly = (datFinRptBalance_Monthly - @amtDeductable), datFinRptBalance_Daily = (datFinRptBalance_Daily - @amtDeductable) WHERE (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateReligionDetails]    Script Date: 08/01/2014 14:13:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateReligionDetails]
(
	@relID int,
	@placeOfWorship varchar(25),
	@leader varchar(100),
	@tel varchar(25),
	@address varchar(255),
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_religions
SET                datReligionID = @relID, datPlaceOfWorship = @placeOfWorship, datLeader = @leader, datTelephoneNumber = @tel, datPhysicalAddress = @address
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[updateCollateral]    Script Date: 08/01/2014 14:12:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateCollateral]
(
	@typeID int,
	@description varchar(255),
	@location varchar(255),
	@value decimal(18, 2),
	@surety int,
	@contactPerson varchar(50),
	@cpTel varchar(50),
	@address varchar(50),
	@confirm int,
	@picture image,
	@CollateralID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_collaterals
SET                datCollateralTypeID = @typeID, datDescription = @description, datLocation = @location, datValue = @value, datSurety = @surety, 
                         datContactPerson = @contactPerson, datContactPersonTelephoneNumber = @cpTel, datPhysicalAddress = @address, datConfirmed = @confirm, 
                         datPicture = @picture, status = 1, modifiedDate = GETDATE()
WHERE        (datID = @CollateralID)
GO
/****** Object:  StoredProcedure [dbo].[GetCreditInformation]    Script Date: 08/01/2014 14:09:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCreditInformation]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT         datID,datClientID,datApplicationID, datCreditor, datDescription, datCreditValue, datMonthlyObligation, datOutstanding, datIssueDate, datExpiryDate
FROM            tbl_credit_information
WHERE        (datApplicationID = @AppID) AND (datClientID=@clientID)
GO
/****** Object:  StoredProcedure [dbo].[GetTempAccTransactions]    Script Date: 08/01/2014 14:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTempAccTransactions]
(
	@AccID int
)
AS
	SET NOCOUNT ON;
SELECT datDescription, datPaymentMethod, datAccountID, datDebit, datCredit, datTotal, datIndex, datLoanAccountID FROM tempTransaction WHERE (datLoanAccountID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[InsertSpouse]    Script Date: 08/01/2014 14:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertSpouse]
(
	@AppID int,
	@ClientID int,
	@fullname varchar(100),
	@tel varchar(25),
	@IDType int,
	@IDNo varchar(100),
	@noDependent int,
	@dateMarried datetime,
	@employer varchar(250),
	@empTel varchar(25),
	@empAddress varchar(255),
	@industry varchar(100),
	@employeenumber varchar(50),
	@poion varchar(100),
	@contactperson varchar(100),
	@monthlyincome decimal(20, 2)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_spouse
                         (datApplicationID, datClientID, datFullName, datTelephoneNumber, datIdentificationType, datIdentificationNumber, datNumberOfDependents, datDateMarried, 
                         datEmployerName, datEmployerTelephone, datEmployerAddress, datIndustryType, datEmployeeNumber, datPosition, datContactPerson, datMonthlyIncome)
VALUES        (@AppID,@ClientID,@fullname,@tel,@IDType,@IDNo,@noDependent,@dateMarried,@employer,@empTel,@empAddress,@industry,@employeenumber,@poion,@contactperson,@monthlyincome)
GO
/****** Object:  StoredProcedure [dbo].[InsertCreditInformation]    Script Date: 08/01/2014 14:10:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCreditInformation]
(
	@clientID int,
	@applicationID int,
	@creditor varchar(255),
	@description varchar(255),
	@creditvalue decimal(18, 2),
	@monthlyObligation decimal(18, 2),
	@outstanding decimal(18, 2),
	@issueDate datetime,
	@expiryDate datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_credit_information
                         (datClientID, datApplicationID, datCreditor, datDescription, datCreditValue, datMonthlyObligation, datOutstanding, datIssueDate, datExpiryDate, status, modifiedDate)
VALUES        (@clientID,@applicationID,@creditor,@description,@creditvalue,@monthlyObligation,@outstanding,@issueDate,@expiryDate, 1, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[DeleteTempTransByAppID]    Script Date: 08/01/2014 14:09:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteTempTransByAppID]
(
	@ApplD int
)
AS
	SET NOCOUNT OFF;
DELETE FROM tempTransaction WHERE (datApplicationID = @ApplD)
GO
/****** Object:  StoredProcedure [dbo].[UpdateSpouse]    Script Date: 08/01/2014 14:13:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSpouse]
(
	@fullname varchar(100),
	@tel varchar(25),
	@IDType int,
	@ID varchar(100),
	@noDependents int,
	@datemarried datetime,
	@employer varchar(250),
	@empTel varchar(25),
	@empAddress varchar(255),
	@industry varchar(100),
	@empNo varchar(50),
	@position varchar(100),
	@contactperson varchar(100),
	@monthly decimal(20, 2),
	@datID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_spouse
SET                datFullName = @fullname, datTelephoneNumber = @tel, datIdentificationType = @IDType, datIdentificationNumber = @ID, 
                         datNumberOfDependents = @noDependents, datDateMarried = @datemarried, datEmployerName = @employer, datEmployerTelephone = @empTel, 
                         datEmployerAddress = @empAddress, datIndustryType = @industry, datEmployeeNumber = @empNo, datPosition = @position, datContactPerson = @contactperson,
                          datMonthlyIncome = @monthly
WHERE        (datID = @datID)
GO
/****** Object:  StoredProcedure [dbo].[updateCreditInformation]    Script Date: 08/01/2014 14:12:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateCreditInformation]
(
	@creditor varchar(255),
	@description varchar(255),
	@creditvalue decimal(18, 2),
	@monthlyObligation decimal(18, 2),
	@outstanding decimal(18, 2),
	@issueDate datetime,
	@expiryDate datetime,
	@status int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_credit_information
SET            datCreditor = @creditor, datDescription = @description, datCreditValue = @creditvalue, 
                         datMonthlyObligation = @monthlyObligation, datOutstanding = @outstanding, datIssueDate = @issueDate, datExpiryDate = @expiryDate, status = @status, 
                         modifiedDate = GETDATE()
WHERE datID=@ID
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetPerformanceCat]    Script Date: 08/01/2014 14:13:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetPerformanceCat]
(
	@performing int,
	@category int,
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datPerformance = @performing, datCategory = @category
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanAppType]    Script Date: 08/01/2014 14:10:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanAppType]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT     datLoanType
FROM         tbl_loan_application
WHERE     (datID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanReport]    Script Date: 08/01/2014 14:10:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanReport]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datDescription, datID
FROM            tbl_reports
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[getClientProfile]    Script Date: 08/01/2014 14:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getClientProfile]
(
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT     datClientNumber,datClientType, datTitle, datFirstName, datMiddleName, datSurname, datClientName, datIDType1, datIDType2, datIDType3, datIDValue1, datIDValue2, datIDValue3, 
                      datNationality, datRegion, datMaritalStatus, datGender, datDateOfBirth, datHomeTelephoneNumber, datOfficeTelephoneNumber, datMobileNumber1, 
                      datMobileNumber2, datFaxNumber, datEmailAddress, datResidentialStatus, datCurrentResidentialAddress, datPreviousResidentialAddress, datPostalAddress, 
                      datNearestLandMark, datSpouse, datNoChildren
FROM         tbl_client
WHERE     (datID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertLoanReport]    Script Date: 08/01/2014 14:11:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertLoanReport]
(
	@Description text,
	@ClientID int,
	@AppID int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_reports
                         (datDescription, datClientID, datApplicationID, status, userID)
VALUES        (@Description,@ClientID,@AppID, 1,@userID)
GO
/****** Object:  StoredProcedure [dbo].[GetIntiator]    Script Date: 08/01/2014 14:09:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIntiator]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT       datID, datClientID, datFullname, datPosition, datMobileNumber, datTelephoneNumber, datEmailAddress, datApplicationID, datFaxNumber, datPhysicalAddress
FROM            tbl_contact_person
WHERE        (datClientID = @clientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateCloseAccount]    Script Date: 08/01/2014 14:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCloseAccount]
(
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datAccountStatus = 3, datClosedDate = GETDATE()
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLoanReport]    Script Date: 08/01/2014 14:12:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLoanReport]
(
	@Description text,
	@ClientID int,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_reports
SET                datDescription = @Description
WHERE        (datClientID = @ClientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertInitiator]    Script Date: 08/01/2014 14:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInitiator]
(
	@AppID int,
	@ClientID int,
	@fullname varchar(100),
	@position varchar(50),
	@mobileno varchar(20),
	@telno varchar(20),
	@email varchar(255),
	@fax varchar(20),
	@address varchar(255)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_contact_person
                         (datApplicationID, datClientID, datFullname, datPosition, datMobileNumber, datTelephoneNumber, datEmailAddress, datFaxNumber, datPhysicalAddress, status, 
                         modifiedDate)
VALUES        (@AppID,@ClientID,@fullname,@position,@mobileno,@telno,@email,@fax,@address, 1, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[GetTransactionDetails]    Script Date: 08/01/2014 14:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTransactionDetails]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datDescription, datPaymentMethod, datAccountID, datDebit, datCredit, datTotal, datIndex, datApplicationID
FROM            tempTransaction
WHERE        (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptLoanReport]    Script Date: 08/01/2014 14:10:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptLoanReport]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datDescription, datID
FROM            tbl_reports
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[Dashboard_PBD]    Script Date: 08/01/2014 14:09:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dashboard_PBD]
	
	@date nvarchar(10),
	@BranchID int,
	@CMID int,
   ---@Type int,
    @category int
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT dbo.getCategories(ha.datCategory) as datCategory,dbo.getProvision(ha.datCategory, Sum(ha.datOutstandingAmount)) AS provision
FROM         tbl_historic_accounts AS ha INNER JOIN
                      sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON ha.datTeamID = br.datID
WHERE     (ha.datOutstandingAmount > 0) AND (ha.datAgingDate BETWEEN CAST('''+@date+''' AS DATETIME) AND DATEADD(DAY, 1, CAST('''+@date+''' AS DATETIME)))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END
--if(@Type != 0 )
--BEGIN
--
--set @query =  @query + ' AND  ha.datPerformance =' + cast(@Type as nvarchar(10)) 
--END

if(@category != 0 )
BEGIN

set @query =  @query + ' AND  ha.datCategory =' + cast(@category as nvarchar(10)) 
END
BEGIN
 
set @query = @query + ' GROUP BY ha.datCategory '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateInitiator]    Script Date: 08/01/2014 14:12:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateInitiator]
(
	@ID int,
	@fullname varchar(100),
	@position varchar(50),
	@mobileno varchar(20),
	@telno varchar(20),
	@email varchar(120),
	@address varchar(255),
	@fax varchar(20)
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_contact_person
SET          datFullname = @fullname, datPosition = @position, datMobileNumber = @mobileno, 
                         datTelephoneNumber = @telno, datEmailAddress = @email, datFaxNumber = @fax, datPhysicalAddress = @address, status = 1, modifiedDate = GETDATE()
WHERE datID=@ID
GO
/****** Object:  StoredProcedure [dbo].[InsertTransactionDetails]    Script Date: 08/01/2014 14:11:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTransactionDetails]
(
	@AppID int,
	@index int,
	@description varchar(350),
	@paymentmethod int,
	@accountid int,
	@debit decimal(20, 2),
	@credit decimal(20, 2),
	@total decimal(20, 2)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tempTransaction
                      (datApplicationID, datIndex, datDescription, datPaymentMethod, datAccountID, datDebit, datCredit, datTotal, datLoanAccountID)
VALUES     (@AppID,@index,@description,@paymentmethod,@accountid,@debit,@credit,@total, NULL)
GO
/****** Object:  StoredProcedure [dbo].[GetSpouse]    Script Date: 08/01/2014 14:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSpouse]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_spouse.datID, tbl_spouse.datFullName, tbl_spouse.datTelephoneNumber, opt_identification_types.datDescription AS idtype, tbl_spouse.datIdentificationNumber, 
                      tbl_spouse.datNumberOfDependents, tbl_spouse.datDateMarried, tbl_spouse.datEmployerName, tbl_spouse.datEmployerTelephone, 
                      tbl_spouse.datEmployerAddress, tbl_spouse.datIndustryType, tbl_spouse.datEmployeeNumber, tbl_spouse.datPosition, tbl_spouse.datContactPerson, 
                      tbl_spouse.datMonthlyIncome
FROM         tbl_spouse INNER JOIN
                      opt_identification_types ON tbl_spouse.datIdentificationType = opt_identification_types.datID
WHERE     (tbl_spouse.datApplicationID = @AppID) AND (tbl_spouse.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[DeleteTransactionDetails]    Script Date: 08/01/2014 14:09:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteTransactionDetails]
(
	@index int,
	@AppID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM tempTransaction
WHERE        (datIndex = @index) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[getBankers]    Script Date: 08/01/2014 14:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getBankers]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT datID,datClientID, datApplicationID, datBank, datAccountName, datBranch, datAccountType, datAccountNo FROM tblBankers WHERE (datClientID = @clientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetLastIndex]    Script Date: 08/01/2014 14:09:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLastIndex]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        MAX(datIndex) AS Expr1
FROM            tempTransaction
WHERE        (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetRiskReport]    Script Date: 08/01/2014 14:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRiskReport]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            tbl_riskreports
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertBanker]    Script Date: 08/01/2014 14:10:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBanker]
(
	@clientID int,
	@AppID int,
	@bank varchar(100),
	@AccName varchar(50),
	@branch varchar(100),
	@AccType varchar(100),
	@AccNo varchar(100),
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tblBankers(datClientID, datApplicationID, datBank, datAccountName, datBranch, datAccountType, datAccountNo, status, modifiedDate, userID) VALUES (@clientID, @AppID, @bank, @AccName, @branch, @AccType, @AccNo, 1, GETDATE(), @userID)
GO
/****** Object:  StoredProcedure [dbo].[Dashboard_Disbursement]    Script Date: 08/01/2014 14:09:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dashboard_Disbursement]
	
	@FromDT nvarchar(10),
	@ToDT nvarchar(10),
	@BranchID int,
	@CMID int
    
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT    SUM(ld.datTotalAmount) AS DisbursedAmt,  DATEPART (m,ld.datIssueDate) AS mnth
FROM         tbl_loan_disbursements AS ld INNER JOIN
                      sys_credit_teams AS ct ON ld.datCreditTeam = ct.datID INNER JOIN
                      tbl_teams AS br ON ld.datBranch = br.datID
WHERE     (ld.datIssueDate BETWEEN CAST('''+@FromDT+''' AS DATETIME) AND CAST('''+@ToDT+''' AS DATETIME))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END


BEGIN
 
set @query = @query + ' GROUP  BY DATEPART (m,ld.datIssueDate)'
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[GetTransTotalAmount]    Script Date: 08/01/2014 14:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTransTotalAmount]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        SUM(datTotal) AS Expr1
FROM            tempTransaction
WHERE        (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertIncomeExpenditure]    Script Date: 08/01/2014 14:11:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertIncomeExpenditure]
(
	@AppID int,
	@ClientID int,
	@bSurplus decimal(20, 2),
	@Income decimal(20, 2),
	@OtherIncome decimal(20, 2),
	@Rent decimal(20, 2),
	@Food decimal(20, 2),
	@Education decimal(20, 2),
	@staff decimal(20, 2),
	@Transport decimal(20, 2),
	@Health decimal(20, 2),
	@Clothing decimal(20, 2),
	@Entertainment decimal(20, 2),
	@charity decimal(20, 2),
	@payments decimal(20, 2),
	@others decimal(20, 2),
	@unexpected int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_incomeexpense
                         (datApplicationID, datClientID, datBusinessSurplus, datIncome, datOtherIncome, datRent, datFood, datEducation, datStaff, datTransport, datHealth, datClothing, 
                         datEntertainment, datCharity, datPayments, datOthers, datUnexpected)
VALUES        (@AppID,@ClientID,@bSurplus,@Income,@OtherIncome,@Rent,@Food,@Education,@staff,@Transport,@Health,@Clothing,@Entertainment,@charity,@payments,@others,@unexpected)
GO
/****** Object:  StoredProcedure [dbo].[UpdateBankers]    Script Date: 08/01/2014 14:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBankers]
(
	@bank varchar(100),
	@AccName varchar(50),
	@branch varchar(100),
	@AccType varchar(100),
	@AccNo varchar(100),
	@userID int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE tblBankers SET datBank = @bank, datAccountName = @AccName, datBranch = @branch, datAccountType = @AccType, datAccountNo = @AccNo, userID = @userID, modifiedDate = GETDATE() WHERE (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertRiskReport]    Script Date: 08/01/2014 14:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertRiskReport]
(
	@description text,
	@clientID int,
	@AppID int,
	@userid int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_riskreports
                         (datDescription, datClientID, datApplicationID, status, userID)
VALUES        (@description,@clientID,@AppID, 1,@userid)
GO
/****** Object:  StoredProcedure [dbo].[getLoanApplicationsByAppNumber]    Script Date: 08/01/2014 14:10:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getLoanApplicationsByAppNumber]
(
	@AppID varchar(20)
)
AS
	SET NOCOUNT ON;
SELECT datNewClient, datApplicationNumber, datClientID, datNatureOfBusiness, datTypeOfBusiness, datNumberOfYears, datAveMonthlyIncome, datApplicationDate, datLoanType, datLoanAmount, datDisburseAmount, datPaymentPlanAmount, datTotalPayment, datTotalInterest, datFees, datDuration, datPurpose, datInterestRate, datFirstPaymentDate, datFrequency, datInterestRateType, datPaneltyType, datHearAboutUs, datTeamID, datAlert, datMoveTime, datCreditTeamID, datCreditOfficerID, datPreviousUserID, datApplicationStatus, datReinstateID, datRefreshedID, status, modifiedDate, userID, datID FROM tbl_loan_application WHERE (datApplicationNumber= @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLoanAmountComponents]    Script Date: 08/01/2014 14:12:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLoanAmountComponents]
(
	@disburse decimal(20, 2),
	@pplan decimal(20, 2),
	@fees decimal(20, 2),
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_application
SET                datDisburseAmount = @disburse, datPaymentPlanAmount = @pplan, datFees = @fees
WHERE        (datID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[DeleteInitiator]    Script Date: 08/01/2014 14:09:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteInitiator]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM tbl_contact_person
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAppStatus]    Script Date: 08/01/2014 14:12:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAppStatus]
(
	@status int,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE    tbl_loan_application
SET              datApplicationStatus = @status, datReinstateID = @status
WHERE     (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[Dashboard_Loan_Categories]    Script Date: 08/01/2014 14:09:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dashboard_Loan_Categories]
	
	@date nvarchar(10),
	@BranchID int,
	@CMID int
    
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT     cat.datDescription AS Categories, SUM(ha.datOutstandingAmount) AS amount
FROM         opt_categories AS cat INNER JOIN
                      tbl_historic_accounts AS ha ON cat.datID = ha.datCategory
WHERE     (ha.datAgingDate BETWEEN CAST('''+@date+''' AS DATETIME) AND DATEADD(DAY, 1, CAST('''+@date+''' AS DATETIME)))
GROUP BY cat.datDescription'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END


BEGIN
 
set @query = @query + ' ORDER BY cat.datDescription'
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[GetLoanAccount1]    Script Date: 08/01/2014 14:10:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanAccount1]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datAccountNumber, datApplicationID, datClientID, datID, datTeamID, datStartDate, datEndDate, datInterestRate, datInterestRateType, datFrequency, datDuration, 
                         datPurpose, datInitialAmount, datFees, datBulletInterest, datFinRptBalance_Monthly, datCategory, datOutstandingAmount, datClientFullName, datIssueDate
FROM            tbl_loan_accounts
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetLegalReport]    Script Date: 08/01/2014 14:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLegalReport]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datDescription, datID
FROM            tbl_legalreports
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetClientName]    Script Date: 08/01/2014 14:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetClientName]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT datClientName FROM tbl_client WHERE (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Dashboard_Interest_Income]    Script Date: 08/01/2014 14:09:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dashboard_Interest_Income]
	
	@FromDT nvarchar(10),
	@ToDT nvarchar(10),
	@BranchID int,
	@CMID int,
    @Type int,
    @category int
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT   SUM(ha.datBulletInterest) AS InterestIncome,DATEPART(m, ha.datAgingDate) as month
FROM         tbl_historic_accounts AS ha INNER JOIN
                      sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON ha.datTeamID = br.datID
WHERE     (ha.datAgingDate BETWEEN '''+@FromDT+''' AND '''+@ToDT+''') AND (ha.datFlag = 1)'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END
if(@Type != 0 )
BEGIN

set @query =  @query + ' AND  ha.datPerformance =' + cast(@Type as nvarchar(10)) 
END

if(@category != 0 )
BEGIN

set @query =  @query + ' AND  ha.datCategory =' + cast(@category as nvarchar(10)) 
END
BEGIN
 
set @query = @query + ' GROUP BY DATEPART(m, ha.datAgingDate) '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateRiskReport]    Script Date: 08/01/2014 14:13:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateRiskReport]
(
	@description text,
	@userid int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_riskreports
SET                datDescription = @description, status = 1, userID = @userid
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetInterestDates]    Script Date: 08/01/2014 14:09:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInterestDates]
(
	@AccID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datAccountID, datApplicationID, datMonth
FROM            tbl_interest_dates
WHERE        (datAccountID = @AccID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertLegalReport]    Script Date: 08/01/2014 14:11:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertLegalReport]
(
	@Description text,
	@ClientID int,
	@AppID int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_legalreports
                         (datDescription, datClientID, datApplicationID, status, modifiedDate, userID)
VALUES        (@Description,@ClientID,@AppID, 1, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[InsertInterestDate]    Script Date: 08/01/2014 14:11:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInterestDate]
(
	@AccID int,
	@AppID int,
	@month varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_interest_dates
                         (datAccountID, datApplicationID, datMonth)
VALUES        (@AccID,@AppID,@month)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLegalReport]    Script Date: 08/01/2014 14:12:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLegalReport]
(
	@Description text,
	@userID int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_legalreports
SET                datDescription = @Description, status = 1, modifiedDate = GETDATE(), userID = @userID
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdatePDC1]    Script Date: 08/01/2014 14:13:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePDC1]
(
	@bank varchar(100),
	@date datetime,
	@cheque varchar(100),
	@amount decimal(20, 2),
	@cleared int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_pdc
SET                datBank = @bank, datDate = @date, datCheque = @cheque, datAmount = @amount, datCleared = @cleared, status = 1, modifiedDate = GETDATE()
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptRiskReport]    Script Date: 08/01/2014 14:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptRiskReport]
(
	@ClientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datDescription, datID
FROM            tbl_riskreports
WHERE        (datClientID = @ClientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetListItemByHeader]    Script Date: 08/01/2014 14:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetListItemByHeader]
(
	@headerID int
)
AS
	SET NOCOUNT ON;
SELECT datID, datOrder, datDescription, datHeader, datView, datCount, datSubHeader FROM opt_list_items WHERE (datHeader = @headerID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptLegalReports]    Script Date: 08/01/2014 14:10:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptLegalReports]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            tbl_legalreports
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[getCurrentStage]    Script Date: 08/01/2014 14:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCurrentStage]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datStage, datNextStageID, datDescription
FROM            opt_application_status
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetCheckListItems]    Script Date: 08/01/2014 14:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCheckListItems]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datQuestion, datAnswer, datComment
FROM            tbl_checklist
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLoanParameters]    Script Date: 08/01/2014 14:12:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLoanParameters]
(
	@loanAmt decimal(20, 2),
	@DisburseAmt decimal(20, 2),
	@ppAmt decimal(20, 2),
	@totalPayment decimal(20, 2),
	@firstPaymentDate datetime,
	@IntRateType int,
	@duration int,
    @frequency int,
	@ClientID int,
    @interestrate decimal(20, 2),
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE    tbl_loan_application
SET        datLoanAmount = @loanAmt, datDisburseAmount = @DisburseAmt, datPaymentPlanAmount = @ppAmt, datTotalPayment = @totalPayment,
                       datFirstPaymentDate = @firstPaymentDate, datDuration = @duration, datFrequency = @frequency, datInterestRateType = @IntRateType, 
                      datInterestRate = @interestrate
WHERE     (datClientID = @ClientID) AND (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[getNextStageID]    Script Date: 08/01/2014 14:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getNextStageID]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datNextStageID
FROM            opt_application_status
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateClearedCheque]    Script Date: 08/01/2014 14:12:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateClearedCheque]
(
	@cleared int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_pdc
SET                datCleared = @cleared
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertCheckListItems]    Script Date: 08/01/2014 14:10:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCheckListItems]
(
	@ClientID int,
	@AppID int,
	@question int,
	@answer int,
	@comment varchar(255)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_checklist
                         (datClientID, datApplicationID, datQuestion, datAnswer, datComment, status)
VALUES        (@ClientID,@AppID,@question,@answer,@comment, 1)
GO
/****** Object:  StoredProcedure [dbo].[GetComments]    Script Date: 08/01/2014 14:09:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetComments]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datRole, datStage, datDescription
FROM            tbl_comments
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[getNextOfKins]    Script Date: 08/01/2014 14:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getNextOfKins]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT     datID, datFullName, datMobileNumber, datHomeTelephoneNumber, datOfficeTelephoneNumber, datEmailAddress, datPercentageShare, datAddress, 
                      datRelationship
FROM         tbl_next_of_kin
WHERE     (datClientID = @clientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[Report_ScheduledPayments]    Script Date: 08/01/2014 14:12:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_ScheduledPayments]
(
	@startDate nvarchar(50),
	@endDate nvarchar(50),
	@BranchID int,
	@CMID int
)
AS
	DECLARE @query nvarchar(4000);

BEGIN

 SET @query='SELECT DISTINCT 
                      la.datID AS acc_id, cl.datID AS cl_id, cl.datClientName AS cl_name, la.datAccountNumber AS AcNo, la.datOutstandingAmount AS out_st, pp.datMonthlyPayment AS amount, 
                      pp.datMonth AS theDate
FROM         tbl_client AS cl INNER JOIN
                      tbl_loan_accounts AS la ON la.datClientID = cl.datID INNER JOIN
                      tbl_pplan_details AS pp ON pp.datApplicationID = la.datApplicationID INNER JOIN
                      tbl_teams AS br ON la.datTeamID = br.datID INNER JOIN
                      sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID
WHERE     (pp.datMonth BETWEEN CAST('''+@startDate+''' as datetime) AND CAST('''+@endDate+''' as datetime)) AND (la.datOutstandingAmount > ''0.00'') AND (pp.datMonthlyPayment > 0)'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END
BEGIN
 
set @query = @query + ' ORDER BY theDate '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[DeleteCheckListItem]    Script Date: 08/01/2014 14:09:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCheckListItem]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM tbl_checklist
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertNextOfKin]    Script Date: 08/01/2014 14:11:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertNextOfKin]
(
	@clientID int,
	@applicationID int,
	@fullname varchar(250),
	@mobileNumber varchar(20),
	@hometelephone varchar(20),
	@officetelephone varchar(20),
	@emailAddress varchar(150),
	@percentageShare decimal(3, 0),
	@address varchar(450),
	@userID int,
	@relationship varchar(120)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_next_of_kin
                      (datClientID, datApplicationID, datFullName, datMobileNumber, datHomeTelephoneNumber, datOfficeTelephoneNumber, datEmailAddress, datPercentageShare, 
                      datAddress, status, userID, datRelationship)
VALUES     (@clientID,@applicationID,@fullname,@mobileNumber,@hometelephone,@officetelephone,@emailAddress,@percentageShare,@address, 1,@userID,@relationship)
GO
/****** Object:  StoredProcedure [dbo].[GetAlertMessage]    Script Date: 08/01/2014 14:09:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlertMessage]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datAlert
FROM            tbl_loan_application
WHERE        (datID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAppReinstate]    Script Date: 08/01/2014 14:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAppReinstate]
(
	@ReinstateID int,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_application
SET                datApplicationStatus = @ReinstateID, datReinstateID = @ReinstateID
WHERE        (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertComment]    Script Date: 08/01/2014 14:10:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertComment]
(
	@role varchar(50),
	@stage varchar(50),
	@description text,
	@clientID int,
	@AppID int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_comments
                         (datRole, datStage, datDescription, datClientID, datApplicationID, status, modifiedDate, userID)
VALUES        (@role,@stage,@description,@clientID,@AppID, 1, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[InsertAsset]    Script Date: 08/01/2014 14:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAsset]
(
	@clientID int,
	@AppID int,
	@assetTypeID int,
	@description varchar(255),
	@value real,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_assets
                      (datClientID, datApplicationID, datAssetTypeID, datDescription, datValue, status, modifiedDate, userID)
VALUES     (@clientID,@AppID,@assetTypeID,@description,@value, 1, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateComment]    Script Date: 08/01/2014 14:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateComment]
(
	@description text,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_comments
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAsset]    Script Date: 08/01/2014 14:12:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAsset]
(
	@typeID int,
	@description varchar(255),
	@AppID int,
	@clientID int,
	@value real,
	@status int,
	@userID int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_assets
SET                datAssetTypeID = @typeID, datDescription = @description, datApplicationID = @AppID, datClientID = @clientID, datValue = @value, status = @status, modifiedDate = GETDATE(), userID = @userID
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[saveAlert]    Script Date: 08/01/2014 14:12:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[saveAlert]
(
	@alert text,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE tbl_loan_application SET datAlert = @alert WHERE (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetAuditors]    Script Date: 08/01/2014 14:09:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAuditors]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_auditors.datID, tbl_auditors.datAuditorName, tbl_auditors.datAddress, tbl_auditors.datAORS, opt_aors.datDescription
FROM         tbl_auditors INNER JOIN
                      opt_aors ON tbl_auditors.datAORS = opt_aors.datID
WHERE     (tbl_auditors.datClientID = @clientID) AND (tbl_auditors.datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertAuditor]    Script Date: 08/01/2014 14:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAuditor]
(
	@clientID int,
	@AppID int,
	@auditorName varchar(100),
	@address text,
	@AORS int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_auditors
                         (datClientID, datApplicationID, datAuditorName, datAddress, datAORS, status, modifiedDate, userID)
VALUES        (@clientID,@AppID,@auditorName,@address,@AORS, 1, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[getSupportingDocuments]    Script Date: 08/01/2014 14:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getSupportingDocuments]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT       datID,datFileName, datDescription, datFilePath, modifiedDate
FROM            tbl_supporting_documents
WHERE        (datClientID = @clientID) AND (datApplicationID = @AppID)
GO
/****** Object:  UserDefinedFunction [dbo].[getOptCreditTeam]    Script Date: 08/01/2014 14:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptCreditTeam]
	(
	@ID int
	)
RETURNS nvarchar(50)/* datatype */

AS
	BEGIN
	DECLARE @return nvarchar(50)
	
SELECT   @return=datDescription
FROM         sys_credit_teams
WHERE     (datID = @ID)

	if(@return is null)
	BEGIN
	 set @return=null
	END 

	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetAlertLogs]    Script Date: 08/01/2014 14:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlertLogs]
(
	@startDate datetime,
	@endDate datetime
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDatestamp, datPostedBy, datPostedDate, datRemovedBy, datRemovedDate, datApplicationID, datStage
FROM            tbl_Alert_Log
WHERE        (datDatestamp BETWEEN @startDate AND @endDate)
GO
/****** Object:  StoredProcedure [dbo].[InsertAlertLog]    Script Date: 08/01/2014 14:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAlertLog]
(
	@postedBy int,
	@postedDate datetime,
	@AppID int,
	@stage varchar(150)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_Alert_Log
                         (datDatestamp, datPostedBy, datPostedDate, datApplicationID, datStage)
VALUES        (GETDATE(),@postedBy,@postedDate,@AppID,@stage)
GO
/****** Object:  StoredProcedure [dbo].[InsertSupportingDocuments]    Script Date: 08/01/2014 14:11:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertSupportingDocuments]
(
	@clientID int,
	@ApplicationID int,
	@filename varchar(250),
	@description varchar(255),
	@filepath varchar(250),
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_supporting_documents
                         (datClientID, datApplicationID, datFileName, datDescription, datFilePath, status, userID)
VALUES        (@clientID,@ApplicationID,@filename,@description,@filepath, 1,@userID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateSupportingDocument]    Script Date: 08/01/2014 14:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSupportingDocument]
(

	@filename varchar(250),
	@description varchar(255),
	@filepath varchar(250),
	@userID int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_supporting_documents
SET          datFileName = @filename, datDescription = @description, datFilePath = @filepath, status = 1, userID = @userID
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[getApplicationStatus]    Script Date: 08/01/2014 14:09:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getApplicationStatus]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datApplicationStatus
FROM            tbl_loan_application
WHERE        (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[Dashboard_Disbursement1]    Script Date: 08/01/2014 14:09:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dashboard_Disbursement1]
	
	@FromDT nvarchar(10),
	@ToDT nvarchar(10),
	@BranchID int,
	@CMID int
    
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT    SUM(ld.datTotalAmount) AS DisbursedAmt,  ld.datIssueDate
FROM         tbl_loan_disbursements AS ld INNER JOIN
                      sys_credit_teams AS ct ON ld.datCreditTeam = ct.datID INNER JOIN
                      tbl_teams AS br ON ld.datBranch = br.datID
WHERE     (ld.datIssueDate BETWEEN CAST('''+@FromDT+''' AS DATETIME) AND CAST('''+@ToDT+''' AS DATETIME))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END


BEGIN
 
set @query = @query + ' GROUP  BY ld.datIssueDate'
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateApplicationRejection]    Script Date: 08/01/2014 14:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateApplicationRejection]
(
	@AppStatus int,
	@ReinstateID int,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_application
SET                datApplicationStatus = @AppStatus, datReinstateID = @ReinstateID
WHERE        (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertOwner]    Script Date: 08/01/2014 14:11:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertOwner]
(
	@clientID int,
	@AppID int,
	@fullName varchar(100),
	@birthdate datetime,
	@age varchar(5),
	@nationality varchar(50),
	@residence varchar(100),
	@education varchar(100),
	@apptDate varchar(20),
	@shord int,
	@percentage varchar(20),
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_ownership
                         (datClientID, datApplicationID, datFullName, datDateOfBirth, datAge, datNationality, datResidence, datEducation, datAppointment, datSHORD, datPercentage, status, 
                         userID)
VALUES        (@clientID,@AppID,@fullName,@birthdate,@age,@nationality,@residence,@education,@apptDate,@shord,@percentage, 1,@userID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateOwner]    Script Date: 08/01/2014 14:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOwner]
(
	@clientID int,
	@AppID int,
	@fullname varchar(100),
	@birthdate datetime,
	@age varchar(5),
	@nationality varchar(50),
	@res varchar(100),
	@education varchar(100),
	@apptDate varchar(20),
	@shord int,
	@percentage varchar(20),
	@userid int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_ownership
SET                datClientID = @clientID, datApplicationID = @AppID, datFullName = @fullname, datDateOfBirth = @birthdate, datAge = @age, datNationality = @nationality, 
                         datResidence = @res, datEducation = @education, datAppointment = @apptDate, datSHORD = @shord, datPercentage = @percentage, status = 1, 
                         userID = @userid
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetAORS]    Script Date: 08/01/2014 14:09:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAORS]
AS
	SET NOCOUNT ON;
SELECT        datDescription, datID
FROM            opt_aors
GO
/****** Object:  StoredProcedure [dbo].[getPreApprovalReport]    Script Date: 08/01/2014 14:10:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getPreApprovalReport]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datClientID, datApplicationID, status, modifiedDate, userID
FROM            tbl_pre_approval_reports
WHERE        (datApplicationID = @AppID) AND (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertPreApprovalReport]    Script Date: 08/01/2014 14:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPreApprovalReport]
(
	@report text,
	@clientID int,
	@AppID int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_pre_approval_reports
                         (datDescription, datClientID, datApplicationID, status, userID)
VALUES        (@report,@clientID,@AppID, 1,@userID)
GO
/****** Object:  StoredProcedure [dbo].[GetIdentifications]    Script Date: 08/01/2014 14:09:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIdentifications]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_identification_types
GO
/****** Object:  StoredProcedure [dbo].[UpdatePreApprovalReport]    Script Date: 08/01/2014 14:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePreApprovalReport]
(
	@report text,
	@clientID int,
	@AppID int,
	@status int,
	@userID int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_pre_approval_reports
SET                datDescription = @report, datClientID = @clientID, datApplicationID = @AppID, status = @status, userID = @userID
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[getClientID]    Script Date: 08/01/2014 14:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getClientID]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datClientID
FROM            tbl_loan_application
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetPDC]    Script Date: 08/01/2014 14:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPDC]
(
	@ClientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datBank, datDate, datCheque, datAmount, datCleared, status
FROM            tbl_pdc
WHERE        (datClientID = @ClientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertLoanFee]    Script Date: 08/01/2014 14:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertLoanFee]
(
	@clientID int,
	@AppID int,
	@feeTypeID int,
	@Paymentmode int,
	@percentage decimal(20, 2),
	@amount decimal(20, 2)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_fees
                         (datClientID, datApplicationID, datFeeTypeID, datFeePaymentID, datPercentage, datAmount)
VALUES        (@clientID,@AppID,@feeTypeID,@Paymentmode,@percentage,@amount)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanAmount]    Script Date: 08/01/2014 14:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanAmount]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        datLoanAmount
FROM            tbl_loan_application
WHERE        (datID = @AppID) AND (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertPDC]    Script Date: 08/01/2014 14:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPDC]
(
	@ClientID int,
	@AppID int,
	@Bank varchar(100),
	@datestamp datetime,
	@cheque varchar(100),
	@amount decimal(20, 2),
	@cleared int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_pdc
                         (datClientID, datApplicationID, datBank, datDate, datCheque, datAmount, datCleared, status, userID, modifiedDate)
VALUES        (@ClientID,@AppID,@Bank,@datestamp,@cheque,@amount,@cleared, 1,@userID, GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[UpdatePDC]    Script Date: 08/01/2014 14:13:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePDC]
(
	@bank varchar(100),
	@datestamp datetime,
	@cheque varchar(100),
	@amout decimal(20, 2),
	@cleared int,
	@userID int,
	@ClientID int,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_pdc
SET                datBank = @bank, datDate = @datestamp, datCheque = @cheque, datAmount = @amout, datCleared = @cleared, status = 1, modifiedDate = GETDATE(), 
                         userID = @userID
WHERE        (datClientID = @ClientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetPDCDetails]    Script Date: 08/01/2014 14:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPDCDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datBank, datDate, datCheque, datAmount, datCleared
FROM            tbl_pdc
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[getCoporateInformation]    Script Date: 08/01/2014 14:09:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getCoporateInformation]
(
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datCompanyName, datCommencementDate, datYearsInBusiness, datIndustryType, datSector, datPhysicalAddress, datTelephoneNumber1, 
                         datTelephoneNumber2, datFaxNumber, datNatureOfBusiness, datPremissesStatus, datIsRegistered, datRegistrationDate, datRegistrationNumber, datVATNumber, 
                         datTIN, datWebsite
FROM            tbl_corporate_info
WHERE        (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertCoporateInformation]    Script Date: 08/01/2014 14:10:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCoporateInformation]
(
	@AppID int,
	@clientID int,
	@company varchar(250),
	@commencementDate datetime,
	@yrsinBusiness int,
	@industryTypeID int,
	@sector int,
	@physicalAddress varchar(255),
	@tel1 varchar(20),
	@tel2 varchar(20),
	@fax varchar(20),
	@natureofBusiness varchar(255),
	@premisesStatus varchar(4),
	@isRegistered int,
	@regDate datetime,
	@regNo varchar(50),
	@vatNo varchar(50),
	@tinNo varchar(50),
	@website varchar(100),
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_corporate_info
                         (datApplicationID, datClientID, datCompanyName, datCommencementDate, datYearsInBusiness, datIndustryType, datSector, datPhysicalAddress, 
                         datTelephoneNumber1, datTelephoneNumber2, datFaxNumber, datNatureOfBusiness, datPremissesStatus, datIsRegistered, datRegistrationDate, 
                         datRegistrationNumber, datVATNumber, datTIN, datWebsite, status, modifiedDate, userID)
VALUES        (@AppID,@clientID,@company,@commencementDate,@yrsinBusiness,@industryTypeID,@sector,@physicalAddress,@tel1,@tel2,@fax,@natureofBusiness,@premisesStatus,@isRegistered,@regDate,@regNo,@vatNo,@tinNo,@website,
                          1, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateCoporateInformation]    Script Date: 08/01/2014 14:12:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCoporateInformation]
(
	@company nchar(10),
	@commencementDate datetime,
	@yrsInBusiness int,
	@industryTypeID int,
	@sector int,
	@physicalAddress varchar(255),
	@tel1 varchar(20),
	@tel2 varchar(20),
	@fax varchar(20),
	@natureofBusiness varchar(255),
	@premisesStatus varchar(4),
	@IsRegistered int,
	@regDate datetime,
	@regNo varchar(50),
	@vatNo varchar(50),
	@tinNo varchar(50),
	@website varchar(100),
	@clientID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_corporate_info
SET                datCompanyName = @company, datCommencementDate = @commencementDate, datYearsInBusiness = @yrsInBusiness, datIndustryType = @industryTypeID, 
                         datSector = @sector, datPhysicalAddress = @physicalAddress, datTelephoneNumber1 = @tel1, datTelephoneNumber2 = @tel2, datFaxNumber = @fax, 
                         datNatureOfBusiness = @natureofBusiness, datPremissesStatus = @premisesStatus, datIsRegistered = @IsRegistered, datRegistrationDate = @regDate, 
                         datRegistrationNumber = @regNo, datVATNumber = @vatNo, datTIN = @tinNo, datWebsite = @website
WHERE        (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[getAssets]    Script Date: 08/01/2014 14:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAssets]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_assets.datID, tbl_assets.datAssetTypeID, tbl_assets.datDescription, tbl_assets.datValue, opt_asset_types.datDescription AS Asset
FROM         tbl_assets INNER JOIN
                      opt_asset_types ON tbl_assets.datAssetTypeID = opt_asset_types.datID
WHERE     (tbl_assets.datClientID = @clientID) AND (tbl_assets.datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertGuarantor]    Script Date: 08/01/2014 14:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertGuarantor]
(
	@clientID int,
	@ApplicationID int,
	@gorr int,
	@fullname varchar(250),
	@relationship varchar(50),
	@noyrs int,
	@nationalID int,
	@birthdat datetime,
	@mobile varchar(20),
	@telno varchar(20),
	@officeno varchar(20),
	@email varchar(50),
	@residentialaddress varchar(255),
	@officeaddress varchar(255),
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_guarantor
                         (datClientID, datApplicationID, datGORR, datFullName, datRelationship, datNumberOfYears, datNationalityID, datDateOfBirth, datMobileNumber, 
                         datHomeTelephoneNumber, datOfficeTelephoneNUmber, datEmailAddress, datResidentialAddress, datOfficeAddress, status, modifiedDate, userID)
VALUES        (@clientID,@ApplicationID,@gorr,@fullname,@relationship,@noyrs,@nationalID,@birthdat,@mobile,@telno,@officeno,@email,@residentialaddress,@officeaddress,
                          1, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[getEmploymentDetails]    Script Date: 08/01/2014 14:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getEmploymentDetails]
(
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datClientID, datInstituteID, datCompanyName, datPhysicalAddress, datPosition, datStaffID, datDateOfEmployment, datTelephoneNumber, datFaxNumber, datMonthlyIncome, datOtherIncome, 
                         datMonthlyExpenditure, datDisposalbleIncome, status, modifiedDate, userID
FROM            tbl_employment_details
WHERE        (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertEmploymentDetails]    Script Date: 08/01/2014 14:11:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertEmploymentDetails]
(
	@clientID int,
	@instituteID int,
	@companyName varchar(100),
	@physicalAddress varchar(255),
	@position varchar(50),
	@staffID varchar(20),
	@EmploymentDate datetime,
	@telephoneNumber varchar(20),
	@fax varchar(20),
	@monthlyIncome decimal(20, 2),
	@otherIncome decimal(20, 2),
	@monthlyExpenditure decimal(20, 2),
	@disposalIncome decimal(20, 0),
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_employment_details
                         (datClientID, datInstituteID, datCompanyName, datPhysicalAddress, datPosition, datStaffID, datDateOfEmployment, datTelephoneNumber, datFaxNumber, datMonthlyIncome, datOtherIncome, 
                         datMonthlyExpenditure, datDisposalbleIncome, status, modifiedDate, userID)
VALUES        (@clientID,@instituteID,@companyName,@physicalAddress,@position,@staffID,@EmploymentDate,@telephoneNumber,@fax,@monthlyIncome,@otherIncome,@monthlyExpenditure,@disposalIncome, 1, 
                         GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptLoanApplication]    Script Date: 08/01/2014 14:10:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptLoanApplication]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datClientNumber, datTitle, datFirstName, datMiddleName, datSurname, datClientName, datIDType2, datIDType1, datIDType3, datIDValue1, datIDValue2, 
                         datIDValue3, datNationality, datRegion, datMaritalStatus, datGender, datDateOfBirth, datHomeTelephoneNumber, datOfficeTelephoneNumber, datMobileNumber1, 
                         datMobileNumber2, datFaxNumber, datEmailAddress, datResidentialStatus, datCurrentResidentialAddress, datPreviousResidentialAddress, datPostalAddress, 
                         datNearestLandMark, status, modifiedDate, userID
FROM            tbl_client
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmploymentDetails]    Script Date: 08/01/2014 14:12:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEmploymentDetails]
(
	@instituteID int,
	@companyName varchar(100),
	@physicalAddress varchar(255),
	@position varchar(50),
	@staffID varchar(20),
	@EmploymentDate datetime,
	@telephoneNumber varchar(20),
	@fax varchar(20),
	@monthlyIncome decimal(20, 2),
	@otherincome decimal(20, 2),
	@monthlyExpenditure decimal(20, 2),
	@disposableIncome decimal(20, 0),
	@status int,
	@userID int,
	@clientID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_employment_details
SET                datInstituteID = @instituteID, datCompanyName = @companyName, datPhysicalAddress = @physicalAddress, datPosition = @position, datStaffID = @staffID, datDateOfEmployment = @EmploymentDate, 
                         datTelephoneNumber = @telephoneNumber, datFaxNumber = @fax, datMonthlyIncome = @monthlyIncome, datOtherIncome = @otherincome, datMonthlyExpenditure = @monthlyExpenditure, 
                         datDisposalbleIncome = @disposableIncome, status = @status, modifiedDate = GETDATE(), userID = @userID
WHERE        (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptClientName]    Script Date: 08/01/2014 14:10:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptClientName]
(
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datClientName
FROM            tbl_client
WHERE        (datID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateClient]    Script Date: 08/01/2014 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateClient]
(
	@clientNo varchar(50),
	@title int,
	@fname varchar(50),
	@mname varchar(150),
	@sname varchar(150),
	@clientname varchar(250),
	@idtype1 varchar(50),
	@idtype2 varchar(50),
	@idtype3 varchar(50),
	@idvalue1 varchar(50),
	@idvalue2 varchar(50),
	@idvalue3 varchar(50),
	@nationality int,
	@region int,
	@mstatus int,
	@spouse varchar(250),
    @NoChildren int,
	@gender int,
	@birthdate datetime,
	@tel varchar(20),
	@officetel varchar(20),
	@mobitelno varchar(180),
	@mobitelno2 varchar(180),
	@fax varchar(180),
	@email varchar(180),
	@resStatus int,
	@currentResStatus varchar(255),
	@previousResStatus varchar(255),
	@pAddress varchar(255),
	@nearestLandMark varchar(255),
	@userID int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE    tbl_client
SET              datClientNumber = @clientNo, datTitle = @title, datFirstName = @fname, datMiddleName = @mname, datSurname = @sname, datClientName = @clientname, 
                      datIDType1 = @idtype1, datIDType2 = @idtype2, datIDType3 = @idtype3, datIDValue1 = @idvalue1, datIDValue2 = @idvalue2, datIDValue3 = @idvalue3, 
                      datNationality = @nationality, datRegion = @region, datMaritalStatus = @mstatus, datGender = @gender, datDateOfBirth = @birthdate, 
                      datHomeTelephoneNumber = @tel, datOfficeTelephoneNumber = @officetel, datMobileNumber1 = @mobitelno, datMobileNumber2 = @mobitelno2, 
                      datFaxNumber = @fax, datEmailAddress = @email, datResidentialStatus = @resStatus, datCurrentResidentialAddress = @currentResStatus, 
                      datPreviousResidentialAddress = @previousResStatus, datPostalAddress = @pAddress, datNearestLandMark = @nearestLandMark, status = 1, 
                      modifiedDate = GETDATE(), userID = @userID, datSpouse = @spouse, datNoChildren = @NoChildren
WHERE     (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetSpecificComments]    Script Date: 08/01/2014 14:10:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSpecificComments]
(
	@AppID int,
	@ClientID int,
	@stage varchar(50)
)
AS
	SET NOCOUNT ON;
SELECT     datID, datRole, datStage, datDescription
FROM         tbl_comments
WHERE     (datApplicationID = @AppID) AND (datClientID = @ClientID) AND (datStage = @stage)
GO
/****** Object:  StoredProcedure [dbo].[GetAppCounts]    Script Date: 08/01/2014 14:09:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAppCounts]
AS
	SET NOCOUNT ON;
SELECT        COUNT(datID) AS AppCounts
FROM            tbl_loan_application
GO
/****** Object:  StoredProcedure [dbo].[GetAllDuePostDatedCheques]    Script Date: 08/01/2014 14:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllDuePostDatedCheques]
(
	@startDate datetime,
	@endDate datetime,
	@branch int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_pdc.datID, tbl_pdc.datBank, tbl_pdc.datDate, tbl_pdc.datCheque, tbl_pdc.datAmount, tbl_pdc.datCleared, tbl_pdc.status, tbl_loan_application.datTeamID, 
                         tbl_pdc.datApplicationID, tbl_pdc.datClientID, tbl_loan_application.datClientName
FROM            tbl_pdc INNER JOIN
                         tbl_loan_application ON tbl_pdc.datApplicationID = tbl_loan_application.datID
WHERE        (tbl_pdc.datDate BETWEEN @startDate AND @endDate) AND (tbl_loan_application.datTeamID = @branch)
ORDER BY  tbl_pdc.datDate
GO
/****** Object:  StoredProcedure [dbo].[GetApplicationTrail]    Script Date: 08/01/2014 14:09:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetApplicationTrail]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datApplicationID, datFromUser, datToUser, datDate, datStage, datDuration, datTime
FROM            tbl_loan_history
WHERE        (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertAppTrail]    Script Date: 08/01/2014 14:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAppTrail]
(
	@AppID int,
	@FromUser int,
	@ToUser int,
	@DateStamp datetime,
	@stage int,
	@duration varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_loan_history
                         (datApplicationID, datFromUser, datToUser, datDate, datStage, datDuration)
VALUES        (@AppID,@FromUser,@ToUser,@DateStamp,@stage,@duration)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAppTrail]    Script Date: 08/01/2014 14:12:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAppTrail]
(
	@FromUser int,
	@ToUser int,
	@datDate datetime,
	@stage int,
	@duration varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_history
SET                datFromUser = @FromUser, datToUser = @ToUser, datDate = @datDate, datStage = @stage, datDuration = @duration
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetAreas]    Script Date: 08/01/2014 14:09:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAreas]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_area
GO
/****** Object:  StoredProcedure [dbo].[UpdateAppStageStatus]    Script Date: 08/01/2014 14:12:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAppStageStatus]
(
	@AppStatus int,
	@ReInstatedID int,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_application
SET                datApplicationStatus = @AppStatus, datReinstateID = @ReInstatedID
WHERE        (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetPreviousUsersID]    Script Date: 08/01/2014 14:10:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPreviousUsersID]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datPreviousUserID
FROM            tbl_loan_application
WHERE        (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetClientCount]    Script Date: 08/01/2014 14:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetClientCount]
AS
	SET NOCOUNT ON;
SELECT        COUNT(datID) AS ClientCount
FROM            tbl_client
GO
/****** Object:  StoredProcedure [dbo].[SetNewUserAndTime]    Script Date: 08/01/2014 14:12:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetNewUserAndTime]
(
	@newUserID int,
	@newMoveTime datetime,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_application
SET                datPreviousUserID = @newUserID, datMoveTime = @newMoveTime
WHERE datID=@AppID
GO
/****** Object:  StoredProcedure [dbo].[GetNoOfEmployees]    Script Date: 08/01/2014 14:10:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNoOfEmployees]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datClientID, datApplicationID, datManagement, datSkilled, datUnskilled, datCasual, datTotal
FROM            tbl_noofemployees
WHERE        (datApplicationID = @AppID) AND (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertNoOfEmployees]    Script Date: 08/01/2014 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertNoOfEmployees]
(
	@clientID int,
	@AppID int,
	@management int,
	@skilled int,
	@unskilled int,
	@casual int,
	@total int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_noofemployees
                         (datClientID, datApplicationID, datManagement, datSkilled, datUnskilled, datCasual, datTotal, status, userID)
VALUES        (@clientID,@AppID,@management,@skilled,@unskilled,@casual,@total, 1,@userID)
GO
/****** Object:  UserDefinedFunction [dbo].[udf_Num_ToWords]    Script Date: 08/01/2014 14:14:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[udf_Num_ToWords] (

@Number Numeric (38, 0) -- Input number with as many as 18 digits

) RETURNS VARCHAR(8000)
AS BEGIN

DECLARE @inputNumber VARCHAR(38)
DECLARE @NumbersTable TABLE (number CHAR(2), word VARCHAR(10))
DECLARE @outputString VARCHAR(8000)
DECLARE @length INT ,@counter INT, @loops INT, @position INT
DECLARE @chunk CHAR(3) -- for chunks of 3 numbers
DECLARE @tensones CHAR(2),@hundreds CHAR(1), @tens CHAR(1), @ones CHAR(1)

IF @Number = 0 Return 'Zero'

-- initialize the variables
SELECT @inputNumber = CONVERT(varchar(38), @Number)
, @outputString = ''
, @counter = 1
SELECT @length = LEN(@inputNumber)
, @position = LEN(@inputNumber) - 2
, @loops = LEN(@inputNumber)/3

-- make sure there is an extra loop added for the remaining numbers
IF LEN(@inputNumber) % 3 <> 0 SET @loops = @loops + 1

-- insert data for the numbers and words
INSERT INTO @NumbersTable SELECT '00', ''
UNION ALL SELECT '01', 'one' UNION ALL SELECT '02', 'two'
UNION ALL SELECT '03', 'three' UNION ALL SELECT '04', 'four'
UNION ALL SELECT '05', 'five' UNION ALL SELECT '06', 'six'
UNION ALL SELECT '07', 'seven' UNION ALL SELECT '08', 'eight'
UNION ALL SELECT '09', 'nine' UNION ALL SELECT '10', 'ten'
UNION ALL SELECT '11', 'eleven' UNION ALL SELECT '12', 'twelve'
UNION ALL SELECT '13', 'thirteen' UNION ALL SELECT '14', 'fourteen'
UNION ALL SELECT '15', 'fifteen' UNION ALL SELECT '16', 'sixteen'
UNION ALL SELECT '17', 'seventeen' UNION ALL SELECT '18', 'eighteen'
UNION ALL SELECT '19', 'nineteen' UNION ALL SELECT '20', 'twenty'
UNION ALL SELECT '30', 'thirty' UNION ALL SELECT '40', 'forty'
UNION ALL SELECT '50', 'fifty' UNION ALL SELECT '60', 'sixty'
UNION ALL SELECT '70', 'seventy' UNION ALL SELECT '80', 'eighty'
UNION ALL SELECT '90', 'ninety'

WHILE @counter <= @loops BEGIN

-- get chunks of 3 numbers at a time, padded with leading zeros
SET @chunk = RIGHT('000' + SUBSTRING(@inputNumber, @position, 3), 3)

IF @chunk <> '000' BEGIN
SELECT @tensones = SUBSTRING(@chunk, 2, 2)
, @hundreds = SUBSTRING(@chunk, 1, 1)
, @tens = SUBSTRING(@chunk, 2, 1)
, @ones = SUBSTRING(@chunk, 3, 1)

-- If twenty or less, use the word directly from @NumbersTable
IF CONVERT(INT, @tensones) <= 20 OR @Ones='0' BEGIN
SET @outputString = (SELECT word
FROM @NumbersTable
WHERE @tensones = number)
+ CASE @counter WHEN 1 THEN '' -- No name
WHEN 2 THEN ' thousand ' WHEN 3 THEN ' million '
WHEN 4 THEN ' billion ' WHEN 5 THEN ' trillion '
WHEN 6 THEN ' quadrillion ' WHEN 7 THEN ' quintillion '
WHEN 8 THEN ' sextillion ' WHEN 9 THEN ' septillion '
WHEN 10 THEN ' octillion ' WHEN 11 THEN ' nonillion '
WHEN 12 THEN ' decillion ' WHEN 13 THEN ' undecillion '
ELSE '' END
+ @outputString
END
ELSE BEGIN -- break down the ones and the tens separately

SET @outputString = ' '
+ (SELECT word
FROM @NumbersTable
WHERE @tens + '0' = number)
+ '-'
+ (SELECT word
FROM @NumbersTable
WHERE '0'+ @ones = number)
+ CASE @counter WHEN 1 THEN '' -- No name
WHEN 2 THEN ' thousand ' WHEN 3 THEN ' million '
WHEN 4 THEN ' billion ' WHEN 5 THEN ' trillion '
WHEN 6 THEN ' quadrillion ' WHEN 7 THEN ' quintillion '
WHEN 8 THEN ' sextillion ' WHEN 9 THEN ' septillion '
WHEN 10 THEN ' octillion ' WHEN 11 THEN ' nonillion '
WHEN 12 THEN ' decillion ' WHEN 13 THEN ' undecillion '
ELSE '' END
+ @outputString
END

-- now get the hundreds
IF @hundreds <> '0' BEGIN
SET @outputString = (SELECT word
FROM @NumbersTable
WHERE '0' + @hundreds = number)
+ ' hundred '
+ @outputString
END
END

SELECT @counter = @counter + 1
, @position = @position - 3

END

-- Remove any double spaces
SET @outputString = LTRIM(RTRIM(REPLACE(@outputString, ' ', ' ')))
SET @outputstring = UPPER(LEFT(@outputstring, 1)) + SUBSTRING(@outputstring, 2, 8000)


RETURN @outputString -- return the result
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateNoOfEmployees]    Script Date: 08/01/2014 14:13:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateNoOfEmployees]
(
	@management int,
	@skilled int,
	@unskilled int,
	@casual int,
	@total int,
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_noofemployees
SET                datManagement = @management, datSkilled = @skilled, datUnskilled = @unskilled, datCasual = @casual, datTotal = @total
WHERE        (datClientID = @clientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetClientIDFromAcc]    Script Date: 08/01/2014 14:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetClientIDFromAcc]
(
	@AccID int
)
AS
	SET NOCOUNT ON;
SELECT datClientID FROM tbl_loan_accounts WHERE (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[InsertFinancials]    Script Date: 08/01/2014 14:11:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFinancials]
(
	@clientID int,
	@AppID int,
	@month varchar(50),
	@year varchar(50),
	@sales varchar(50),
	@costofsales varchar(100),
	@grossprofit varchar(100),
	@admincost varchar(100),
	@netprofit varchar(100),
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_financials
                         (datClientID, datApplicationID, datMonth, datYear, datSales, datCostOfSales, datGrossOfProfit, datAdminCost, datNetProfit, status, modifiedDate, userID)
VALUES        (@clientID,@AppID,@month,@year,@sales,@costofsales,@grossprofit,@admincost,@netprofit, '1', GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[getFinancials]    Script Date: 08/01/2014 14:09:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getFinancials]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datMonth, datYear, datSales, datCostOfSales, datGrossOfProfit, datAdminCost, datNetProfit
FROM            tbl_financials
WHERE        (datApplicationID = @AppID) AND (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateFinancials]    Script Date: 08/01/2014 14:12:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFinancials]
(
	@month varchar(50),
	@year varchar(50),
	@sales varchar(50),
	@costofsales varchar(100),
	@grossprofit varchar(100),
	@admin varchar(100),
	@netprofit varchar(100),
	@userID int,
	@ID int
	
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_financials
SET                datMonth = @month, datYear = @year, datSales = @sales, datCostOfSales = @costofsales, datGrossOfProfit = @grossprofit, datAdminCost = @admin, 
                         datNetProfit = @netprofit, userID = @userID, modifiedDate = GETDATE()
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertAccountComment]    Script Date: 08/01/2014 14:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAccountComment]
(
	@Description text,
	@AccID int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_account_comments(datDescription, datAccountID, status, modifiedDate, usersID) VALUES (@Description, @AccID, 1, GETDATE(), @userID)
GO
/****** Object:  UserDefinedFunction [dbo].[getNumWords]    Script Date: 08/01/2014 14:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getNumWords]
	(
	@num decimal(20,2) 
	)
RETURNS varchar(max)
AS
	BEGIN
	DECLARE @return varchar(max);
	DECLARE @decimal decimal(20,0);
	DECLARE @word varchar(max);
	
	
	if(Floor(@num)<>CEILING(@num))
	BEGIN
			set  @decimal=PARSENAME(@num,1)
		   SET @word = dbo.fn_spellNumber(@num,'UK',0) +' Ghana cedis '+ dbo.fn_spellNumber(@decimal,'UK',0) + ' Ghana pessewas'
	END
    else
	BEGIN
		--set  @decimal=PARSENAME(@num,1)
		   SET @word = dbo.fn_spellNumber(@num,'UK',0) +' Ghana cedis'
    END
     
	SET @return =@word
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[AssignCreditTeam]    Script Date: 08/01/2014 14:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AssignCreditTeam]
(
	@ctID int,
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_application
SET                datCreditTeamID = @ctID
WHERE        (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateClientName]    Script Date: 08/01/2014 14:12:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateClientName]
(
	@clientName varchar(250),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_application
SET                datClientName = @clientName
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Financial_Aging]    Script Date: 08/01/2014 14:11:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Financial_Aging]
	
	@date nvarchar(10),
	@BranchID int,
	@CMID int,
    @Type int,
    @category int
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT DISTINCT 
                      ha.datID, ha.datAccountID, ha.datClientFullname, ha.datAccountNumber, ha.datEndDate, ha.datCategory, ha.datEnt1, ha.datEnt2, ha.datEnt3, ha.datEnt4, ha.datEnt5, 
                      ha.datEnt6, ha.datPerformance, ha.modifiedDate, ha.datDaysOver, br.datDescription AS branch, ha.datAgingDate, perf.datDescription AS performance,ha.datIssuedate
FROM         tbl_historic_accounts AS ha INNER JOIN
                      tbl_teams AS br ON ha.datTeamID = br.datID INNER JOIN
                      sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
                      opt_performance AS perf ON ha.datPerformance = perf.datID
WHERE     (ha.datAgingDate BETWEEN CAST('''+@date+''' AS DATETIME) AND DATEADD(DAY, 1, CAST('''+@date+''' AS DATETIME)))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END
if(@Type != 0 )
BEGIN

set @query =  @query + ' AND  ha.datPerformance =' + cast(@Type as nvarchar(10)) 
END

if(@category != 0 )
BEGIN

set @query =  @query + ' AND  ha.datLoanType =' + cast(@category as nvarchar(10)) 
END
BEGIN
 
set @query = @query + ' ORDER BY ha.datClientFullname '
END
print @query
Exec (@query)

END
GO
/****** Object:  UserDefinedFunction [dbo].[getTerm]    Script Date: 08/01/2014 14:14:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getTerm]
	(
	@term int
	)
RETURNS decimal(20,2)
AS
	BEGIN
	DECLARE @return decimal(20,2);
	
	
	if(@term = 1)
	BEGIN
			set  @return=91
	END
    else if(@term = 2)
	BEGIN
		set  @return=182
    END
	else if(@term =3)
	BEGIN 
		set @return = 365
	END
     
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetEnterpriseDetails]    Script Date: 08/01/2014 14:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEnterpriseDetails]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datApplicationID, datClientID, datEnterpriseName, datTelephoneNumber, datFaxNumber, datPhysicalAddress, datActivity, datRegistrationDate, datRegistrationNumber, datPremises, datOccupancy, 
                         datSector
FROM            tbl_enterprises
WHERE        (datClientID = @clientID) AND (datApplicationID = @AppID)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_spellNumber]    Script Date: 08/01/2014 14:13:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[fn_spellNumber](@SpellNumber BIGINT,@SpellType VARCHAR(10) = 'US',@AddComma     BIT = 1) 
RETURNS VARCHAR(MAX) 
BEGIN 
 
/* 
Parameters 
 
@SpellNumber - The number to be spelled. 
               Supports till 19 digits and accepts the range of BIG INT. 
@SpellType     - US - For US Numbering system (in designation of Million,Billion,Trillion) 
               UK - For UK Numbering system (in designation of Lakhs,Crores) 
@AddComma     - To add comma seperator to the output or not.  
 
*/ 
 
 
    DECLARE @Res VARCHAR(MAX) 
    DECLARE @TmpRes VARCHAR(MAX) 
    DECLARE @CurrentNumber int 
    DECLARE @PrevNumber int 
    DECLARE @Comma        VARCHAR(1) 
    DECLARE @Loopvar int 
    DECLARE @VarSpellNumber VARCHAR(50) 
 
    IF @SpellNumber < 0 
        SELECT @SpellNumber = @SpellNumber * -1 
 
    SELECT @VarSpellNumber = @SpellNumber 
 
    SELECT @Loopvar = 1 
    SELECT @Res = '' 
 
    SELECT @Comma = CASE @AddComma 
                    WHEN 1 THEN ',' 
                    ELSE '' 
                    END 
 
 
    WHILE LTRIM(RTRIM(@VarSpellNumber)) <> '' 
    BEGIN 
     
        SELECT @CurrentNumber = NULL 
        SELECT @PrevNumber    = NULL 
        SELECT @TmpRes          = '' 
     
 
        SELECT @CurrentNumber = SUBSTRING(@VarSpellNumber,LEN(@VarSpellNumber),1) 
     
        IF LEN(@VarSpellNumber) > 1  
            SELECT @PrevNumber = SUBSTRING(@VarSpellNumber,LEN(@VarSpellNumber)-1,1) 
     
        IF (@Loopvar = 2 AND @SpellType = 'UK') OR (@Loopvar%2=0  AND @SpellType ='US') 
            SELECT @PrevNumber = NULL 
 
 
        IF @PrevNumber IS NULL OR @PrevNumber <> 1  
        BEGIN 
            SELECT @TmpRes = CASE @CurrentNumber 
                          WHEN 1 THEN 'One' 
                          WHEN 2 THEN 'Two' 
                          WHEN 3 THEN 'Three' 
                          WHEN 4 THEN 'Four' 
                          WHEN 5 THEN 'Five' 
                          WHEN 6 THEN 'Six' 
                          WHEN 7 THEN 'Seven' 
                          WHEN 8 THEN 'Eight' 
                          WHEN 9 THEN 'Nine' 
                          WHEN 0 THEN '' 
                          END  
        END 
     
        IF @PrevNumber = 1 
        BEGIN 
            SELECT @TmpRes = CASE CONVERT(INT,CONVERT(VARCHAR(1),@PrevNumber) + CONVERT(VARCHAR(1),@CurrentNumber)) 
                            WHEN 10 THEN 'Ten' 
                            WHEN 11 THEN 'Eleven' 
                            WHEN 12 THEN 'Twelve' 
                            WHEN 13 THEN 'Thirteen' 
                            WHEN 14 THEN 'Fourteen' 
                            WHEN 15 THEN 'Fiveteen' 
                            WHEN 16 THEN 'Sixteen' 
                            WHEN 17 THEN 'Seventeen' 
                            WHEN 18 THEN 'Eighteen' 
                            WHEN 19 THEN 'Nineteen' 
                            END  
 
        END 
 
        IF @PrevNumber > 1 
        BEGIN 
            SELECT @TmpRes = CASE @PrevNumber 
                            WHEN 2 THEN 'Twenty' 
                            WHEN 3 THEN 'Thirty' 
                            WHEN 4 THEN 'Fourty' 
                            WHEN 5 THEN 'Fifty' 
                            WHEN 6 THEN 'Sixty' 
                            WHEN 7 THEN 'Seventy' 
                            WHEN 8 THEN 'Eighty' 
                            WHEN 9 THEN 'Ninety' 
                            WHEN 0 THEN '' 
                            END  + ' ' + @TmpRes 
        END 
     
        SELECT @TmpRes = LTRIM(RTRIM(@TmpRes)) 
 
        IF  @SpellType ='UK' AND (@TmpRes <> '' OR ( @Loopvar = 5 AND CONVERT(INT,@VarSpellNumber)>0)) 
        BEGIN 
            SELECT @TmpRes =  @TmpRes + ' ' 
                               + CASE @Loopvar  
                                 WHEN 2 THEN 'Hundred'  
                                 WHEN 3 THEN 'Thousand' + @Comma 
                                 WHEN 4 THEN 'Lakh' + @Comma 
                                 WHEN 5 THEN 'Crore' + @Comma 
                                 ELSE '' 
                                 END  
     
        END 
 
 
 
        IF  @SpellType ='US' AND (@TmpRes <> '' OR ( @Loopvar%2 = 1 AND CONVERT(INT,SUBSTRING(@VarSpellNumber,LEN(@VarSpellNumber)-2,1))>0)) 
        BEGIN 
            SELECT @TmpRes =  @TmpRes + ' ' 
                               + CASE @Loopvar  
                                 WHEN 2 THEN 'Hundred' 
                                 WHEN 3 THEN 'Thousand' + @Comma 
                                 WHEN 4 THEN 'Hundred' 
                                 WHEN 5 THEN 'Million' + @Comma 
                                 WHEN 6 THEN 'Hundred'  
                                 WHEN 7 THEN 'Billion' + @Comma 
                                 WHEN 8 THEN 'Hundred' 
                                 WHEN 9 THEN 'Trillion' + @Comma 
                                 WHEN 10 THEN 'Hundred' 
                                 WHEN 11 THEN 'Quadrillion' + @Comma 
                                 WHEN 12 THEN 'Hundred' 
                                 WHEN 13 THEN 'Quintillion' + @Comma 
                                 ELSE '' 
                                 END  
        END 
 
        IF @Loopvar = 1 AND LEN(@VarSpellNumber) > 2  
            IF CONVERT(INT,SUBSTRING(CONVERT(VARCHAR(50),@SpellNumber),LEN(@VarSpellNumber)-1,2)) > 0 
                SELECT @TmpRes = 'And ' + @TmpRes 
 
        IF @TmpRes <> '' 
            SELECT  @Res = @TmpRes + ' ' + @Res 
     
        IF (@Loopvar = 2  AND @SpellType = 'UK')  or (@Loopvar%2=0  AND @SpellType ='US') 
            SELECT @VarSpellNumber = SUBSTRING(@VarSpellNumber,1,LEN(@VarSpellNumber)-1) 
        ELSE IF LEN(@VarSpellNumber) = 1 
            SELECT @VarSpellNumber = SUBSTRING(@VarSpellNumber,1,LEN(@VarSpellNumber)-1) 
        ELSE 
            SELECT @VarSpellNumber = SUBSTRING(@VarSpellNumber,1,LEN(@VarSpellNumber)-2) 
 
         
        SELECT @Loopvar = @Loopvar + 1 
     
        IF @Loopvar = 6 AND @SpellType ='UK' 
            SELECT @Loopvar = 2 
     
    END 
 
    SELECT @Res = LTRIM(RTRIM(@RES)) 
 
 
    RETURN (@Res) 
 
END
GO
/****** Object:  StoredProcedure [dbo].[InsertEnterpriseDetails]    Script Date: 08/01/2014 14:11:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertEnterpriseDetails]
(
	@AppID int,
	@clientID int,
	@EntName varchar(250),
	@telno varchar(25),
	@faxno varchar(25),
	@address varchar(255),
	@activity varchar(100),
	@regDate datetime,
	@regNo varchar(100),
	@premises int,
	@occupancy datetime,
	@sector int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_enterprises
                         (datApplicationID, datClientID, datEnterpriseName, datTelephoneNumber, datFaxNumber, datPhysicalAddress, datActivity, datRegistrationDate, datRegistrationNumber, datPremises, datOccupancy, datSector)
VALUES        (@AppID,@clientID,@EntName,@telno,@faxno,@address,@activity,@regDate,@regNo,@premises,@occupancy,@sector)
GO
/****** Object:  StoredProcedure [dbo].[AccountTransfer]    Script Date: 08/01/2014 14:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AccountTransfer]
(
	@branch int,
	@creditTeam int,
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datTeamID = @branch, datCreditTeamID = @creditTeam
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateEnterpriseDetails]    Script Date: 08/01/2014 14:12:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateEnterpriseDetails]
(
	@EntName varchar(250),
	@telno varchar(25),
	@faxno varchar(25),
	@address varchar(255),
	@activity varchar(100),
	@regNo datetime,
	@regDate varchar(100),
	@premises int,
	@occupancy datetime,
	@sector int,
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_enterprises
SET                datEnterpriseName = @EntName, datTelephoneNumber = @telno, datFaxNumber = @faxno, datPhysicalAddress = @address, datActivity = @activity, datRegistrationDate = @regNo, 
                         datRegistrationNumber = @regDate, datPremises = @premises, datOccupancy = @occupancy, datSector = @sector
WHERE        (datApplicationID = @AppID) AND (datClientID = @clientID)
GO
/****** Object:  UserDefinedFunction [dbo].[checkCategories]    Script Date: 08/01/2014 14:13:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[checkCategories]
	(
	@current decimal(20,2) =NULL,
	@supposed decimal(20,2) =NULL	
	)
RETURNS decimal(20,2)
AS
	BEGIN
	DECLARE @return decimal(20,2);
	DECLARE @supposed_ decimal(20,2);
	
	SET @supposed_ = @supposed
	
	if(@current<1)
	BEGIN
			set  @return=0
	END
    else
	BEGIN
		set  @return=@supposed_
    END
     
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetFrozenAccount]    Script Date: 08/01/2014 14:09:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFrozenAccount]
(
	@AccID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datAccountID, datAccountNumber, datTeamID, datPurpose, datOutstandingAmount, datCategory, datFrozenDate, datUnFrozenDate, datCreditTeamID, 
                         datClientFullName, datLoanType, datAgingDate
FROM            tbl_frozen_accounts
WHERE        (datAccountID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[GetIncomeExpense]    Script Date: 08/01/2014 14:09:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIncomeExpense]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datBusinessSurplus, datIncome, datOtherIncome, datRent, datFood, datEducation, datStaff, datTransport, datHealth, datClothing, datEntertainment, datCharity, 
                         datPayments, datOthers, datUnexpected
FROM            tbl_incomeexpense
WHERE        (datClientID = @clientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Portfolio_Aging]    Script Date: 08/01/2014 14:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Portfolio_Aging]
	
	@date nvarchar(10),
	@BranchID int,
	@CMID int,
    @Type int,
    @category int
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT DISTINCT 
                      ha.datID, ha.datAccountID, ha.datClientFullname, ha.datAccountNumber, ha.datEndDate, ha.datCategory,ha.datOutstandingAmount,
				      dbo.checkCategories(ha.datEnt1,ha.datOutstandingAmount)as datEnt1,
					  dbo.checkCategories(ha.datEnt2,ha.datOutstandingAmount)as datEnt2, 
					  dbo.checkCategories(ha.datEnt3,ha.datOutstandingAmount)as datEnt3,
					  dbo.checkCategories(ha.datEnt4,ha.datOutstandingAmount)as datEnt4,
					  dbo.checkCategories(ha.datEnt5,ha.datOutstandingAmount)as datEnt5,
					  dbo.checkCategories(ha.datEnt6,ha.datOutstandingAmount)as datEnt6,
					  ha.datPerformance, ha.modifiedDate, ha.datDaysOver, br.datDescription AS branch, ha.datAgingDate, perf.datDescription AS performance, ha.datIssuedate
FROM         tbl_historic_accounts AS ha INNER JOIN
                      tbl_teams AS br ON ha.datTeamID = br.datID INNER JOIN
                      sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
                      opt_performance AS perf ON ha.datPerformance = perf.datID
WHERE     (ha.datAgingDate BETWEEN CAST('''+@date+''' AS DATETIME) AND DATEADD(DAY, 1, CAST('''+@date+''' AS DATETIME)))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END
if(@Type != 0 )
BEGIN

set @query =  @query + ' AND  ha.datPerformance =' + cast(@Type as nvarchar(10)) 
END

if(@category != 0 )
BEGIN

set @query =  @query + ' AND  ha.datCategory =' + cast(@category as nvarchar(10)) 
END
BEGIN
 
set @query = @query + ' ORDER BY ha.datClientFullname '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[InsertFrozenAccount]    Script Date: 08/01/2014 14:11:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFrozenAccount]
(
	@AccID int,
	@AccNo varchar(50),
	@branch int,
	@purpose int,
	@outstanding decimal(18, 0),
	@category int,
	@frozendate datetime,
	@ct int,
	@clientname varchar(255),
	@aging datetime,
	@loantype int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_frozen_accounts
                         (datAccountID, datAccountNumber, datTeamID, datPurpose, datOutstandingAmount, datCategory, datFrozenDate, datCreditTeamID, datClientFullName, datAgingDate, 
                         datLoanType)
VALUES        (@AccID,@AccNo,@branch,@purpose,@outstanding,@category,@frozendate,@ct,@clientname,@aging,@loantype)
GO
/****** Object:  StoredProcedure [dbo].[Report_Client_Movement]    Script Date: 08/01/2014 14:11:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Client_Movement]
	
	@FromDT nvarchar(10),
	@ToDT nvarchar(10),
	@BranchID int,
	@CMID int
    
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT     am.datID, am.datAccountID,la.datAccountNumber, am.datOutstandingAmount, dbo.getCategories(am.datPreviousCat) AS PreviousCat, dbo.getCategories(am.datCurrentCat) AS CurrentCat, am.datBranch, am.datCreditTeam,
                      dbo.getPAIDAMT(am.datAccountID,'''+@ToDT+''') as paidamt ,am.datAgingDate, am.modifiedDate, la.datClientFullName, la.datIssueDate, br.datDescription, ct.datDescription AS creditTeam,la.datOutstandingAmount as AmtOutstanding,la.datEndDate
FROM         tbl_account_movement AS am INNER JOIN
                      tbl_loan_accounts AS la ON am.datAccountID = la.datID INNER JOIN
                      tbl_teams AS br ON la.datTeamID = br.datID INNER JOIN
                      sys_credit_teams AS ct ON am.datCreditTeam = ct.datID
WHERE     (am.datAgingDate BETWEEN CAST('''+@FromDT+''' AS DATETIME) AND CAST('''+@ToDT+''' AS DATETIME)) AND (am.datPreviousCat >= 1) AND (am.datOutstandingAmount > 0)'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END


BEGIN
 
set @query = @query + ' ORDER BY la.datClientFullname '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetFrozenAccount]    Script Date: 08/01/2014 14:13:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetFrozenAccount]
(
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datFrozenDate = GETDATE(), datAccountStatus = 2
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateIncomeExpense]    Script Date: 08/01/2014 14:12:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateIncomeExpense]
(
	@bSurplus decimal(20, 2),
	@Income decimal(20, 2),
	@OtherIncome decimal(20, 2),
	@Rent decimal(20, 2),
	@Food decimal(20, 2),
	@Education decimal(20, 2),
	@Staff decimal(20, 2),
	@Transport decimal(20, 2),
	@Health decimal(20, 2),
	@Clothing decimal(20, 2),
	@Entertainment decimal(20, 2),
	@charity decimal(20, 2),
	@payments decimal(20, 2),
	@others decimal(20, 2),
	@unexpected int,
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_incomeexpense
SET                datBusinessSurplus = @bSurplus, datIncome = @Income, datOtherIncome = @OtherIncome, datRent = @Rent, datFood = @Food, datEducation = @Education, 
                         datStaff = @Staff, datTransport = @Transport, datHealth = @Health, datClothing = @Clothing, datEntertainment = @Entertainment, datCharity = @charity, 
                         datPayments = @payments, datOthers = @others, datUnexpected = @unexpected
WHERE        (datApplicationID = @AppID) AND (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertUnfrozenAccount]    Script Date: 08/01/2014 14:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUnfrozenAccount]
(
	@AccID int,
	@AccNo varchar(50),
	@branch int,
	@purpose int,
	@Outstanding decimal(18, 0),
	@category int,
	@unfrozen datetime,
	@ct int,
	@clientname varchar(255),
	@aging datetime,
	@loantype int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_frozen_accounts
                         (datAccountID, datAccountNumber, datTeamID, datPurpose, datOutstandingAmount, datCategory, datUnFrozenDate, datCreditTeamID, datClientFullName, 
                         datAgingDate, datLoanType)
VALUES        (@AccID,@AccNo,@branch,@purpose,@Outstanding,@category,@unfrozen,@ct,@clientname,@aging,@loantype)
GO
/****** Object:  UserDefinedFunction [dbo].[getPAIDAMT]    Script Date: 08/01/2014 14:14:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getPAIDAMT]
	(
	@AccID int,
	@date datetime
	)
RETURNS varchar(300)/* datatype */
AS
	BEGIN
	DECLARE @return VARCHAR(300)
	
 SELECT  @return =SUM(datCreditAmount) 
 FROM tbl_financial_transactions 
 WHERE (datAccountID = @AccID AND datGLAccount = 1) 
				AND (modifiedDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME)))
	RETURN @return
	
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetUnfrozenAccount]    Script Date: 08/01/2014 14:13:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetUnfrozenAccount]
(
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datUnFrozenDate = GETDATE(), datAccountStatus = 1, datFrozenDate = NULL
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[InsertInvAccount]    Script Date: 08/01/2014 14:11:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInvAccount]
(
	@datInvestmentName varchar(250),
	@datApplicationNumber varchar(50),
	@datClientID int,
	@datInvestmentType int,
	@datTerms int,
	@datInvestmentAmount decimal(20, 2),
	@datInterestRatePerAnnum decimal(4, 2),
	@datFrequency int,
	@datModeOfRepayment int,
	@datAdvise text,
	@datValueDate datetime,
	@Principal decimal(20, 2),
	@datTeamID int,
	@branchManager int,
	@datCreditTeamID int,
	@datAreaManagerID int,
	@RollOverID int,
	@datAccountStatus int,
	@InvAppID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_investment_accounts
                         (datInvestmentName, datApplicationNumber, datClientID, datInvestmentType, datTerms, datInvestmentAmount, datInterestRatePerAnnum, datFrequencyOfInterestPayment, datModeOfRepayment, datAdvise, 
                         datValueDate, datPrincipal, datTeamID, datBranchManagerID, datCreditTeamID, datAreaManagerID, datRollOverID, datAccountStatus, datID)
VALUES        (@datInvestmentName,@datApplicationNumber,@datClientID,@datInvestmentType,@datTerms,@datInvestmentAmount,@datInterestRatePerAnnum,@datFrequency,@datModeOfRepayment,@datAdvise,@datValueDate,@Principal,@datTeamID,@branchManager,@datCreditTeamID,@datAreaManagerID,@RollOverID,@datAccountStatus,@InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Disbursement]    Script Date: 08/01/2014 14:11:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Disbursement]
	
	@FromDT nvarchar(10),
	@ToDT nvarchar(10),
	@BranchID int,
	@CMID int
    
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT     ld.datID, ld.datAccountID, ld.datAccountNumber, ld.datClientFullName, ld.datIssueDate, ld.datExpiryDate, ld.datInterestRate, ld.datCash, ld.datBank, ld.datTotalAmount, ld.datTotalFee, 
                      ld.datLoanType, ld.datPurpose, ld.userID, ct.datDescription AS CreditTeam, br.datDescription AS Branch
FROM         tbl_loan_disbursements AS ld INNER JOIN
                      sys_credit_teams AS ct ON ld.datCreditTeam = ct.datID INNER JOIN
                      tbl_teams AS br ON ld.datBranch = br.datID
WHERE     (ld.datIssueDate BETWEEN CAST('''+@FromDT+''' AS DATETIME) AND CAST('''+@ToDT+''' AS DATETIME))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END


BEGIN
 
set @query = @query + ' ORDER BY ld.datIssueDate'
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[GetSchedulePayments]    Script Date: 08/01/2014 14:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSchedulePayments]
(
	@startDate datetime,
	@endDate datetime
)
AS
	SET NOCOUNT ON;
SELECT DISTINCT 
                         tbl_loan_accounts.datID AS acc_id, tbl_client.datID AS cl_id, tbl_client.datClientName AS cl_name,tbl_loan_accounts.datAccountNumber as AcNo, tbl_loan_accounts.datOutstandingAmount AS out_st, 
                         tbl_pplan_details.datMonthlyPayment AS amount, tbl_pplan_details.datMonth AS theDate
FROM            tbl_client INNER JOIN
                         tbl_loan_accounts ON tbl_loan_accounts.datClientID = tbl_client.datID INNER JOIN
                         tbl_pplan_details ON tbl_pplan_details.datApplicationID = tbl_loan_accounts.datApplicationID
WHERE        (tbl_pplan_details.datMonth BETWEEN @startDate AND @endDate) AND (tbl_loan_accounts.datOutstandingAmount > '0.00') AND (tbl_pplan_details.datMonthlyPayment>0)
ORDER BY theDate
GO
/****** Object:  UserDefinedFunction [dbo].[getAccountStatus]    Script Date: 08/01/2014 14:13:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAccountStatus]
	(
	@AccStatus int
	)
RETURNS varchar(300)/* datatype */
AS
	BEGIN
	DECLARE @return VARCHAR(300)
	
SELECT   @return=datDescription
FROM         opt_account_status
WHERE     (datID = @AccStatus)
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetUnlockApp]    Script Date: 08/01/2014 14:13:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetUnlockApp]
(
	@AppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_application
SET                userID = 0
WHERE        (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetInterestCalc]    Script Date: 08/01/2014 14:09:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInterestCalc]
(
	@InvAccID varchar(50),
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datApplicationID, datDateAction, datPrincipal, datIntRate, datDay, datTerm, datAccrued, datDayInt, status, modifiedDate
FROM            tbl_invest_calc
WHERE        (datAccountNumber = @InvAccID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetBankerDetails]    Script Date: 08/01/2014 14:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBankerDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datBank, datAccountName, datBranch, datAccountType, datAccountNo
FROM            tblBankers
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Frozen_Balance]    Script Date: 08/01/2014 14:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Report_Frozen_Balance]
	
	@FromDT nvarchar(10),
	@ToDT nvarchar(10),
	@BranchID int,
	@CMID int
    
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT     fa.datID, fa.datAccountID, fa.datAccountNumber, fa.datTeamID,dbo.getOptLoanPurpose(fa.datPurpose) as datPurpose, fa.datOutstandingAmount,dbo.getCategories(fa.datCategory) as datCategory, fa.datFrozenDate, fa.datUnFrozenDate, fa.datClientFullName, dbo.getOptLoanType(fa.datLoanType) as datLoanType, 
                      fa.datAgingDate, ct.datDescription AS datCreditTeam, br.datDescription AS branch
FROM         tbl_frozen_accounts AS fa INNER JOIN
                      sys_credit_teams AS ct ON fa.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON fa.datTeamID = br.datID
WHERE     (fa.datAgingDate BETWEEN CAST('''+@FromDT+''' AS DATETIME) AND CAST('''+@ToDT+''' AS DATETIME))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END


BEGIN
 
set @query = @query + ' ORDER BY fa.datClientFullName'
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[InsertNewRefreshApp]    Script Date: 08/01/2014 14:11:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertNewRefreshApp]
(
	@clientID int,
	@clientName varchar(250),
	@loantype int,
	@AppNo varchar(20),
	@loanAmt decimal(20, 2),
	@disburseAmt decimal(20, 2),
	@pplanAmt decimal(20, 2),
	@duration int,
	@status int,
	@intRate decimal(20, 2),
	@appDate datetime,
	@firstpaymentDate datetime,
	@frequency int,
	@intrateType int,
	@refreshedID int,
	@ct int,
	@branch int,
	@returnAppID int output
)
AS
	SET NOCOUNT ON;
INSERT INTO tbl_loan_application
                         (datClientID, datClientName, datLoanType, datApplicationNumber, datLoanAmount, datDisburseAmount, datPaymentPlanAmount, datDuration, datApplicationStatus, 
                         datInterestRate, datApplicationDate, datFirstPaymentDate, datFrequency, datInterestRateType, datRefreshedID, datCreditTeamID, datTeamID)
VALUES        (@clientID,@clientName,@loantype,@AppNo,@loanAmt,@disburseAmt,@pplanAmt,@duration,@status,@intRate,@appDate,@firstpaymentDate,@frequency,@intrateType,@refreshedID,@ct,@branch)

set @returnAppID = SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[GetCreditInformationDetail]    Script Date: 08/01/2014 14:09:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCreditInformationDetail]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT         datID,datClientID,datApplicationID, datCreditor, datDescription, datCreditValue, datMonthlyObligation, datOutstanding, datIssueDate, datExpiryDate
FROM            tbl_credit_information
WHERE        (datID=@ID)
GO
/****** Object:  StoredProcedure [dbo].[GetAssetDetails]    Script Date: 08/01/2014 14:09:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAssetDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datAssetTypeID, datDescription, datValue
FROM            tbl_assets
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAccountStatus]    Script Date: 08/01/2014 14:12:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAccountStatus]
(
	@status int,
	@InvAccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_investment_accounts
SET                datActiveAccountStatus = @status
WHERE        (datID = @InvAccID)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanFeeDetails]    Script Date: 08/01/2014 14:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanFeeDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datFeeTypeID, datFeePaymentID, datPercentage, datAmount
FROM            tbl_fees
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetPaymentVoucher]    Script Date: 08/01/2014 14:10:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPaymentVoucher]
(
	@ClientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datReference, datAmount, datFeePaymentID
FROM            tbl_payment_vouchers
WHERE        (datClientID = @ClientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLoanFees]    Script Date: 08/01/2014 14:12:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLoanFees]
(
	@feetypeID int,
	@paymentmethodID int,
	@percentage decimal(20, 2),
	@amount decimal(20, 2),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_fees
SET                datFeeTypeID = @feetypeID, datFeePaymentID = @paymentmethodID, datPercentage = @percentage, datAmount = @amount
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertPaymentVoucher]    Script Date: 08/01/2014 14:11:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPaymentVoucher]
(
	@ClientID int,
	@AppID int,
	@description varchar(100),
	@reference varchar(20),
	@amount decimal(20, 2),
	@feepayment int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_payment_vouchers
                         (datClientID, datApplicationID, datDescription, datReference, datAmount, datFeePaymentID, userID)
VALUES        (@ClientID,@AppID,@description,@reference,@amount,@feepayment,@userID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAuditors]    Script Date: 08/01/2014 14:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAuditors]
(
	@Auditors varchar(100),
	@address text,
	@AORS int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_auditors
SET                datAuditorName = @Auditors, datAddress = @address, datAORS = @AORS
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Loan_Expiry]    Script Date: 08/01/2014 14:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Report_Loan_Expiry]
	
	@FromDT nvarchar(10),
	@ToDT nvarchar(10),
	@BranchID int,
	@CMID int
    
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT     la.datID, la.datAccountNumber, la.datStartDate, la.datEndDate, la.datDuration, la.datInitialAmount, la.datOutstandingAmount, la.datClientFullName, dbo.getOptPerformance(la.datPerformance)as datPerformance, 
                      ct.datDescription AS datCreditTeam, br.datDescription AS datTeam, la.datInterestRate
FROM         tbl_loan_accounts AS la INNER JOIN
                      sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON la.datTeamID = br.datID
WHERE     (la.datEndDate BETWEEN CAST('''+@FromDT+''' AS DATETIME) AND CAST('''+@ToDT+''' AS DATETIME))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END


BEGIN
 
set @query = @query + ' ORDER BY la.datEndDate'
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[UpdatePaymentVoucher]    Script Date: 08/01/2014 14:13:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePaymentVoucher]
(
	@description varchar(100),
	@reference varchar(20),
	@amount decimal(20, 2),
	@feepayment int,
	@userID int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_payment_vouchers
SET                datDescription = @description, datReference = @reference, datAmount = @amount, datFeePaymentID = @feepayment, userID = @userID
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAccountStatus1]    Script Date: 08/01/2014 14:12:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAccountStatus1]
(
	@status int,
	@InvAccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_investment_accounts
SET                datAccountStatus = @status
WHERE        (datID = @InvAccID)
GO
/****** Object:  StoredProcedure [dbo].[GetAuditorsDetails]    Script Date: 08/01/2014 14:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAuditorsDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datAuditorName, datAddress, datAORS, datClientID, datApplicationID
FROM            tbl_auditors
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Credit_Balance]    Script Date: 08/01/2014 14:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Credit_Balance]
	
--	@FromDT nvarchar(10),
--	@ToDT nvarchar(10),
	@category int,
	@BranchID int,
	@CMID int
    
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT    la.datID, la.datAccountNumber, la.datClientFullName, la.datIssueDate,la.datEndDate, br.datDescription, ct.datDescription AS creditTeam, la.datOutstandingAmount AS AmtOutstanding, 
                     dbo.getCategories(la.datCategory) as datCategory,dbo.getAccountStatus(la.datAccountStatus) as status,la.datInitialAmount
FROM         tbl_loan_accounts AS la INNER JOIN
                      tbl_teams AS br ON la.datTeamID = br.datID INNER JOIN
                      sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID
WHERE datOutstandingAmount < 0'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END


if(@category != 0 )
BEGIN
set @query =  @query + ' AND  la.datCategory =' + cast(@category as nvarchar(10)) 
END

BEGIN
 
set @query = @query + ' ORDER BY la.datClientFullname '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[GetGuarantorDetails]    Script Date: 08/01/2014 14:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetGuarantorDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datGORR, datFullName, datRelationship, datNumberOfYears, datNationalityID, datDateOfBirth, datMobileNumber, datHomeTelephoneNumber, 
                         datOfficeTelephoneNUmber, datEmailAddress, datResidentialAddress, datOfficeAddress
FROM            tbl_guarantor
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Largest_Exposure]    Script Date: 08/01/2014 14:12:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Largest_Exposure]
	
--	@FromDT nvarchar(10),
--	@ToDT nvarchar(10),
	@category int,
	@BranchID int,
	@CMID int,
	@top int =NULL,
    @Type int
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
print @top;

if(@top != 0)
BEGIN
SET @query ='SELECT DISTINCT  TOP '+ cast(@top as nvarchar(10)) +'    la.datID, la.datAccountNumber, la.datClientFullName, la.datIssueDate, la.datEndDate, br.datDescription, ct.datDescription AS creditTeam, 
                      la.datOutstandingAmount AS AmtOutstanding, dbo.getCategories(la.datCategory) AS datCategory, dbo.getAccountStatus(la.datAccountStatus) AS status, la.datFinRptBalance_Monthly,
                      la.datInitialAmount,dbo.getOptLoanType(la.datLoanType) as datLoanType
FROM         tbl_loan_accounts AS la INNER JOIN
                      tbl_teams AS br ON la.datTeamID = br.datID INNER JOIN
                      sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID
WHERE     (la.datOutstandingAmount > 0)'
END
ELSE
BEGIN
SET @query ='SELECT DISTINCT   la.datID, la.datAccountNumber, la.datClientFullName, la.datIssueDate, la.datEndDate, br.datDescription, ct.datDescription AS creditTeam, 
                      la.datOutstandingAmount AS AmtOutstanding, dbo.getCategories(la.datCategory) AS datCategory, dbo.getAccountStatus(la.datAccountStatus) AS status, la.datFinRptBalance_Monthly,
                      la.datInitialAmount,dbo.getOptLoanType(la.datLoanType) as datLoanType
FROM         tbl_loan_accounts AS la INNER JOIN
                      tbl_teams AS br ON la.datTeamID = br.datID INNER JOIN
                      sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID
WHERE     (la.datOutstandingAmount > 0)'
END

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END


if(@category != 0 )
BEGIN
set @query =  @query + ' AND  la.datCategory =' + cast(@category as nvarchar(10)) 
END

if(@Type != 0 )
BEGIN

set @query =  @query + ' AND  la.datPerformance =' + cast(@Type as nvarchar(10)) 
END

BEGIN
 
set @query = @query + ' ORDER BY la.datFinRptBalance_Monthly DESC'
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[GetTotalAmount]    Script Date: 08/01/2014 14:10:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTotalAmount]
(
	@ClientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        SUM(datAmount) AS TotalAmount
FROM            tbl_payment_vouchers
WHERE        (datClientID = @ClientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdatePenaltyHistory]    Script Date: 08/01/2014 14:13:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePenaltyHistory]
(
	@datAmount decimal(20, 2),
	@datID int,
	@InvAccID int
)
AS
	SET NOCOUNT OFF;
UPDATE tbl_historic_accounts2 SET datPaymentStatus = 2, datPenalty = @datAmount WHERE (datID = @datID) AND (datAccountID = @InvAccID)
GO
/****** Object:  StoredProcedure [dbo].[GetCollateralDetails]    Script Date: 08/01/2014 14:09:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCollateralDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datCollateralTypeID, datDescription, datLocation, datValue, datSurety, datContactPerson, datContactPersonTelephoneNumber, datPhysicalAddress, datConfirmed, 
                         datPicture
FROM            tbl_collaterals
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetFinalVoucher]    Script Date: 08/01/2014 14:09:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFinalVoucher]
(
	@ClientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datVoucherName, datVoucherDate, datVoucherTotalAmount, datAmountInWords, datPreparedBy, datApprovedBy, datPreparedDate, datApproveDate, userID, 
                         modifiedDate
FROM            tbl_final_voucher
WHERE        (datClientID = @ClientID) AND (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetFinancialDetails]    Script Date: 08/01/2014 14:09:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFinancialDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datMonth, datYear, datSales, datCostOfSales, datGrossOfProfit, datAdminCost, datNetProfit
FROM            tbl_financials
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertFinalVoucher]    Script Date: 08/01/2014 14:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFinalVoucher]
(
	@ClientID int,
	@AppID int,
	@VoucherName varchar(20),
	@VoucherDate datetime,
	@VoucherTotalAmount decimal(20, 2),
	@AmtInWords varchar(200),
	@preparedby int,
	@preparedDate datetime,
	@userID int,
	@modifiedDate datetime
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_final_voucher
                         (datClientID, datApplicationID, datVoucherName, datVoucherDate, datVoucherTotalAmount, datAmountInWords, datPreparedBy, datPreparedDate, 
                          userID, modifiedDate)
VALUES        (@ClientID,@AppID,@VoucherName,@VoucherDate,@VoucherTotalAmount,@AmtInWords,@preparedby,@preparedDate,@userID,@modifiedDate)
GO
/****** Object:  StoredProcedure [dbo].[GetIntiatorDetails]    Script Date: 08/01/2014 14:09:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIntiatorDetails]
(

	@ID int
)
AS
	SET NOCOUNT ON;
SELECT     datClientID, datFullname, datPosition, datMobileNumber, datTelephoneNumber, datEmailAddress, datApplicationID, datFaxNumber, datPhysicalAddress
FROM       tbl_contact_person
WHERE   (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateFinalVoucher]    Script Date: 08/01/2014 14:12:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFinalVoucher]
(
	@voucherName varchar(20),
	@voucherDate datetime,
	@totalAmt decimal(20, 2),
	@AmtWords varchar(200),
	@preparedBy int,
	@preparedDate datetime,
	@userID int,
	@modifiedDate datetime,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_final_voucher
SET                datVoucherName = @voucherName, datVoucherDate = @voucherDate, datVoucherTotalAmount = @totalAmt, datAmountInWords = @AmtWords, 
                         datPreparedBy = @preparedBy,  datPreparedDate = @preparedDate, userID = @userID, 
                         modifiedDate = @modifiedDate
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetNextOfKin]    Script Date: 08/01/2014 14:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNextOfKin]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT     datFullName, datMobileNumber, datHomeTelephoneNumber, datOfficeTelephoneNumber, datEmailAddress, datPercentageShare, datAddress, datRelationship
FROM         tbl_next_of_kin
WHERE     (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Portfolio_Interest_Income]    Script Date: 08/01/2014 14:12:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Portfolio_Interest_Income]
	
	@FromDT nvarchar(10),
	@ToDT nvarchar(10),
	@BranchID int,
	@CMID int,
    @Type int,
    @category int
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT     ha.datAccountNumber AS ACC, ha.datClientFullname AS CLN, ha.datFinRptBalance_Monthly, ha.datBulletInterest, ha.datAgingDate
FROM         tbl_historic_accounts AS ha INNER JOIN
                      sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON ha.datTeamID = br.datID
WHERE     (ha.datAgingDate BETWEEN '''+@FromDT+''' AND '''+@ToDT+''') AND (ha.datFlag = 1)'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END
if(@Type != 0 )
BEGIN

set @query =  @query + ' AND  ha.datPerformance =' + cast(@Type as nvarchar(10)) 
END

if(@category != 0 )
BEGIN

set @query =  @query + ' AND  ha.datCategory =' + cast(@category as nvarchar(10)) 
END
BEGIN
 
set @query = @query + ' ORDER BY ha.datClientFullname '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateFinalVoucher1]    Script Date: 08/01/2014 14:12:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFinalVoucher1]
(
	@voucherName varchar(20),
	@voucherDate datetime,
	@totalAmt decimal(20, 2),
	@AmtWords varchar(200),
	@approvedBy int,
	@approvedDate datetime,
	@userID int,
	@modifiedDate datetime,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_final_voucher
SET                datVoucherName = @voucherName, datVoucherDate = @voucherDate, datVoucherTotalAmount = @totalAmt, datAmountInWords = @AmtWords, 
                          datApprovedBy = @approvedBy, datApproveDate = @approvedDate, userID = @userID, 
                         modifiedDate = @modifiedDate
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanAppBranch]    Script Date: 08/01/2014 14:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanAppBranch]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datTeamID
FROM            tbl_loan_application
WHERE        (datID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[getSupportingDocumentsDetails]    Script Date: 08/01/2014 14:10:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getSupportingDocumentsDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datFileName, datDescription, datFilePath, modifiedDate
FROM            tbl_supporting_documents
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Provision_Bad_Debt]    Script Date: 08/01/2014 14:12:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Provision_Bad_Debt]
	
	@date nvarchar(10),
	@BranchID int,
	@CMID int,
   ---@Type int,
    @category int
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT DISTINCT 
                      ha.datID,ha.datClientFullname, ha.datAccountNumber, ha.datIssuedate, ha.datEndDate,dbo.getCategories(ha.datCategory) as datCategory,dbo.getAccountStatus(ha.datAccountStatus) as datAccountStatus, ha.datInitialAmount, ha.datOutstandingAmount, 
                      dbo.getProvision(ha.datCategory, ha.datOutstandingAmount) AS provision, dbo.getProvisionFactor(ha.datCategory) as provisionfactor
FROM         tbl_historic_accounts AS ha INNER JOIN
                      sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON ha.datTeamID = br.datID
WHERE     (ha.datOutstandingAmount > 0) AND (ha.datAgingDate BETWEEN CAST('''+@date+''' AS DATETIME) AND DATEADD(DAY, 1, CAST('''+@date+''' AS DATETIME)))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END
--if(@Type != 0 )
--BEGIN
--
--set @query =  @query + ' AND  ha.datPerformance =' + cast(@Type as nvarchar(10)) 
--END

if(@category != 0 )
BEGIN

set @query =  @query + ' AND  ha.datCategory =' + cast(@category as nvarchar(10)) 
END
BEGIN
 
set @query = @query + ' ORDER BY ha.datClientFullname '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[GetAccountRefreshmentRecord]    Script Date: 08/01/2014 14:09:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAccountRefreshmentRecord]
(
	@AccID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datOldAppID, datOldAccountID, datNewAppID, datNewAccountID, datstartDate, datendDate, userID
FROM            tbl_account_refreshment_record
WHERE        (datOldAccountID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[GetFinancialTransactions]    Script Date: 08/01/2014 14:09:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFinancialTransactions]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datGLAccount, datAccountID, datDescription, datBatchNo, datPaymentMode, datBranch, datCreditAmount, datDebitAmount, datCreditAccID, datDebitAccID, 
                         datWeekNo, modifiedDate
FROM            tbl_financial_transactions
WHERE        (datApplicationID = @AppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[getOwnersDetails]    Script Date: 08/01/2014 14:10:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getOwnersDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datFullName, datDateOfBirth, datAge, datNationality, datResidence, datEducation, datAppointment, datSHORD, datPercentage
FROM            tbl_ownership
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertFinancialTransaction]    Script Date: 08/01/2014 14:11:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFinancialTransaction]
(
	@AppID int,
	@ClientID int,
	@GLAccount int,
	@AccountID int,
	@Description varchar(100),
	@BatchNo varchar(20),
	@paymentMethod int,
	@branch int,
	@creditAmt decimal(20, 2),
	@debitAmt decimal(20, 2),
	@CreditAccID int,
	@DebitAccID int,
	@weekNo int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_financial_transactions
                         (datApplicationID, datClientID, datGLAccount, datAccountID, datDescription, datBatchNo, datPaymentMode, datBranch, datCreditAmount, datDebitAmount, 
                         datCreditAccID, datDebitAccID, datWeekNo, modifiedDate, userID)
VALUES        (@AppID,@ClientID,@GLAccount,@AccountID,@Description,@BatchNo,@paymentMethod,@branch,@creditAmt,@debitAmt,@CreditAccID,@DebitAccID,@weekNo, 
                         GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[InsertPaymentPlan]    Script Date: 08/01/2014 14:11:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPaymentPlan]
(
	@datMonth datetime,
	@datBalanceBF decimal(20, 2),
	@datInterest1 decimal(20, 2),
	@datMonthlyPayment decimal(20, 2),
	@datInterest2 decimal(20, 2),
	@datPrincipalComponent decimal(20, 2),
	@datOutstanding decimal(20, 2),
	@applicationID int,
	@monthindex int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_pplan_details
                      (datMonth, datBalanceBF, datInterest1, datMonthlyPayment, datInterest2, datPrincipalComponent, datOutstanding, datApplicationID, datMonthIndex)
VALUES     (@datMonth,@datBalanceBF,@datInterest1,@datMonthlyPayment,@datInterest2,@datPrincipalComponent,@datOutstanding,@applicationID,@monthindex)
GO
/****** Object:  StoredProcedure [dbo].[UpdateGuarantor]    Script Date: 08/01/2014 14:12:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateGuarantor]
(
	@GORR int,
	@fullname varchar(250),
	@relationship varchar(50),
	@noOfYrs int,
	@nationality int,
	@birthdate datetime,
	@mobile varchar(20),
	@hometel varchar(20),
	@officetel varchar(20),
	@email varchar(50),
	@resAddreds varchar(255),
	@officeAddress varchar(255),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_guarantor
SET                datGORR = @GORR, datFullName = @fullname, datRelationship = @relationship, datNumberOfYears = @noOfYrs, datNationalityID = @nationality, 
                         datDateOfBirth = @birthdate, datMobileNumber = @mobile, datHomeTelephoneNumber = @hometel, datOfficeTelephoneNUmber = @officetel, 
                         datEmailAddress = @email, datResidentialAddress = @resAddreds, datOfficeAddress = @officeAddress
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateNextOfKin]    Script Date: 08/01/2014 14:13:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateNextOfKin]
(
	@fullname varchar(250),
	@mobileno varchar(20),
	@hometel varchar(20),
	@officetel varchar(20),
	@email varchar(150),
	@percentage decimal(3, 0),
	@address varchar(255),
	@ID int,
	@relationship varchar(150)
)
AS
	SET NOCOUNT OFF;
UPDATE    tbl_next_of_kin
SET              datFullName = @fullname, datMobileNumber = @mobileno, datHomeTelephoneNumber = @hometel, datOfficeTelephoneNumber = @officetel, 
                      datEmailAddress = @email, datPercentageShare = @percentage, datAddress = @address, datRelationship = @relationship
WHERE     (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanAccount]    Script Date: 08/01/2014 14:10:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanAccount]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT     datID, datAccountNumber, datClientID, datTeamID, datStartDate, datEndDate, datInterestRate, datInterestRateType, datFrequency, datDuration, datPurpose, 
                      datInitialAmount, datOutstandingAmount, datFees, datDailyInterest, datBulletInterest, datFlag, datFinRptBalance_Daily, datFinRptBalance_Monthly, datCategory, 
                      datFrozenDate, datUnFrozenDate, datDaysOver, datIntrestOnNextWorkingDays, datDateOfLastInterest, datCreditTeamID, datClientFullName, datLoanType, datEnt1, 
                      datEnt2, datEnt3, datEnt4, datEnt5, datEnt6, datPerformance, datClosedDate, datAccountStatus, datAgingDate, datRefreshedID, datIssueDate, datApplicationID
FROM         tbl_loan_accounts
WHERE     (datID = @ID)
GO
/****** Object:  Table [dbo].[tbl_historic_accounts2]    Script Date: 08/01/2014 14:13:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbl_historic_accounts2](
	[datID] [int] IDENTITY(1,1) NOT NULL,
	[datAccountID] [int] NULL,
	[datInvestmentName] [varchar](450) NULL,
	[datApplicationNumber] [varchar](450) NULL,
	[datClientID] [int] NULL,
	[datInvestmentType] [int] NULL,
	[datTerms] [int] NULL,
	[datInvestmentAmount] [decimal](20, 2) NULL,
	[datInterestRatePerAnnum] [decimal](20, 2) NULL,
	[datFrequencyOfInterestPayment] [int] NOT NULL,
	[datModeOfRepayment] [int] NULL,
	[datAdvise] [varchar](500) NULL,
	[datValueDate] [datetime] NULL,
	[datDaysOver] [int] NULL,
	[datAlert] [varchar](1000) NULL,
	[datMatured] [decimal](20, 2) NULL,
	[datPenalty] [decimal](20, 2) NULL,
	[datIntAccrued] [decimal](20, 2) NULL,
	[datPrincipal] [decimal](20, 2) NULL,
	[datTeamID] [int] NULL,
	[datBranchManagerID] [int] NULL,
	[datCreditTeamID] [int] NULL,
	[datAreaManagerID] [int] NULL,
	[datRollOverID] [int] NULL,
	[datAccountStatus] [int] NULL,
	[datPaymentStatus] [int] NULL,
	[datActiveAccountStatus] [int] NULL,
	[datRollOverAmt] [decimal](20, 2) NULL,
	[datDisinvestAmt] [decimal](20, 2) NULL,
	[status] [int] NULL,
	[recUpdate] [datetime] NULL,
	[recUser] [int] NULL,
	[flag1] [int] NULL,
	[flag2] [int] NULL,
	[flag3] [int] NULL,
	[flag4] [int] NULL,
	[flag5] [int] NULL,
	[flag6] [int] NULL,
	[dat30] [decimal](20, 2) NULL,
	[dat60] [decimal](20, 2) NULL,
	[dat91] [decimal](20, 2) NULL,
	[dat121] [decimal](20, 2) NULL,
	[dat151] [decimal](20, 2) NULL,
	[dat182] [decimal](20, 2) NULL,
	[dat212] [decimal](20, 2) NULL,
	[dat242] [decimal](20, 2) NULL,
	[dat273] [decimal](20, 2) NULL,
	[dat303] [decimal](20, 2) NULL,
	[dat333] [decimal](20, 2) NULL,
	[dat364] [decimal](20, 2) NULL,
	[datAgingDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_historic_accounts2] PRIMARY KEY CLUSTERED 
(
	[datID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Delete_PaymentPlan]    Script Date: 08/01/2014 14:09:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_PaymentPlan]
(
	@ID int
)
AS
	SET NOCOUNT ON;
DELETE FROM tbl_pplan_details
WHERE        (datApplicationID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Loan_Repayment]    Script Date: 08/01/2014 14:12:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Loan_Repayment]
	
	@FromDT nvarchar(10),
	@ToDT nvarchar(10),
	@BranchID int,
	@CMID int
--    @Type int,
--    @category int
AS
DECLARE @query nvarchar(4000);


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


SET @query ='SELECT     lp.datID, lp.datReceiptNumber, lp.datPaymentDate, lp.datAccountID, lp.datAccountNumber, lp.datClientNumber, lp.datIssueDate, lp.datInterestRate, lp.datCash, 
                      lp.datBank, lp.datTotalAmount, lp.datTotalFees, dbo.getOptLoanType(lp.datLoanType) as datLoanType, lp.datPurpose, lp.datBranch, lp.userID,la.datClientFullname
FROM         tbl_loan_repayments AS lp INNER JOIN
                      tbl_loan_accounts AS la ON lp.datAccountID = la.datID INNER JOIN
                      sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON la.datTeamID = br.datID
WHERE     (lp.datPaymentDate BETWEEN CAST('''+@FromDT+''' AS DATETIME) AND CAST('''+@ToDT+''' AS DATETIME))'

if(@CMID != 0)
BEGIN  
 
set @query =  @query + ' AND ct.datID =' + cast(@CMID as nvarchar(10)) 

END   
if(@BranchID != 0 )
BEGIN

set @query =  @query + ' AND  br.datID=' + cast(@BranchID as nvarchar(10)) 
END
--if(@Type != 0 )
--BEGIN
--
--set @query =  @query + ' AND  ha.datPerformance =' + cast(@Type as nvarchar(10)) 
--END
--
--if(@category != 0 )
--BEGIN
--
--set @query =  @query + ' AND  ha.datCategory =' + cast(@category as nvarchar(10)) 
--END
BEGIN
 
set @query = @query + ' ORDER BY la.datClientFullname '
END
print @query
Exec (@query)

END
GO
/****** Object:  StoredProcedure [dbo].[InsertAccountRefreshment]    Script Date: 08/01/2014 14:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAccountRefreshment]
(
	@AccID int,
	@OldAppID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_account_refreshment_record
                         (datOldAccountID, datstartDate, datOldAppID)
VALUES        (@AccID, GETDATE(),@OldAppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateNewAppID]    Script Date: 08/01/2014 14:13:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateNewAppID]
(
	@datNewAppID int,
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_account_refreshment_record
SET                datNewAppID = @datNewAppID
WHERE        (datOldAccountID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateNewAccountID]    Script Date: 08/01/2014 14:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateNewAccountID]
(
	@NewAccountID int,
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_account_refreshment_record
SET                datNewAccountID = @NewAccountID, datendDate = GETDATE()
WHERE        (datOldAccountID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[InsertLoanAccount]    Script Date: 08/01/2014 14:11:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertLoanAccount]
(
	@AccountNo varchar(50),
	@fees decimal(20, 2),
	@ClientID int,
	@AppID int,
	@branchID int,
	@startdate datetime,
	@enddate datetime,
	@interestrate decimal(4, 2),
	@duration int,
	@frequency int,
	@initialAmt decimal(20, 2),
	@outstandingAmt decimal(20, 2),
	@FinRptBalance decimal(20, 2),
	@userID int,
	@Ent1 decimal(20, 2),
	@agingDate datetime,
	@issueDate datetime,
	@purpose int,
	@bulletInterest decimal(20, 2),
	@refreshedID int,
	@creditTeamID int,
    @clientName varchar(400),
    @loanType int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_loan_accounts
                      (datAccountNumber, datFees, datClientID, datApplicationID, datTeamID, datStartDate, datEndDate, datInterestRate, datDuration, datFrequency, datInitialAmount, 
                      datOutstandingAmount, datFinRptBalance_Daily, datFinRptBalance_Monthly, userID, datEnt1, datAgingDate, datCategory, datIssueDate, datPurpose, datBulletInterest, 
                      datRefreshedID, datAccountStatus, datCreditTeamID, datClientFullName, datLoanType)
VALUES     (@AccountNo,@fees,@ClientID,@AppID,@branchID,@startdate,@enddate,@interestrate,@duration,@frequency,@initialAmt,@outstandingAmt,@FinRptBalance,@FinRptBalance,@userID,@Ent1,@agingDate,
                       1,@issueDate,@purpose,@bulletInterest,@refreshedID, 1,@creditTeamID,@clientName,@loanType)
GO
/****** Object:  StoredProcedure [dbo].[GetAllAccountRefreshByPeriod]    Script Date: 08/01/2014 14:09:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllAccountRefreshByPeriod]
(
	@start datetime,
	@end datetime
)
AS
	SET NOCOUNT ON;
SELECT        datID, datOldAccountID, datOldAppID, datNewAppID, datNewAccountID, datstartDate, datendDate, userID
FROM            tbl_account_refreshment_record
WHERE        (datstartDate BETWEEN @start AND @end)
GO
/****** Object:  StoredProcedure [dbo].[GetDisburseLoan]    Script Date: 08/01/2014 14:09:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDisburseLoan]
AS
	SET NOCOUNT ON;
SELECT datID, datAccountID, datAccountNumber, datClientFullName, datIssueDate, datExpiryDate, datInterestRate, datCash, datBank, datTotalAmount, datTotalFee, datLoanType, datPurpose, datBranch, datCreditTeam, userID FROM tbl_loan_disbursements
GO
/****** Object:  StoredProcedure [dbo].[GetLoanApplicationNo]    Script Date: 08/01/2014 14:10:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanApplicationNo]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datApplicationNumber
FROM            tbl_loan_application
WHERE        (datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[getPaymentPlan]    Script Date: 08/01/2014 14:10:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getPaymentPlan]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT     datMonth, datBalanceBF, datInterest1, datMonthlyPayment, datInterest2, datPrincipalComponent, datOutstanding, datApplicationID, datMonthIndex
FROM         tbl_pplan_details
WHERE     (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetAccountClosed]    Script Date: 08/01/2014 14:13:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetAccountClosed]
(
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datOutstandingAmount = 0, datAccountStatus = 3, datClosedDate = GETDATE()
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[GetFrozenAccountsPeriod]    Script Date: 08/01/2014 14:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFrozenAccountsPeriod]
(
	@start datetime,
	@end datetime
)
AS
	SET NOCOUNT ON;
SELECT        datID, datAccountID, datAccountNumber, datTeamID, datPurpose, datOutstandingAmount, datCategory, datFrozenDate, datUnFrozenDate, datCreditTeamID, 
                         datClientFullName, datLoanType, datAgingDate
FROM            tbl_frozen_accounts
WHERE        (datFrozenDate BETWEEN @start AND @end)
GO
/****** Object:  StoredProcedure [dbo].[InsertDisburseLoan]    Script Date: 08/01/2014 14:11:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertDisburseLoan]
(
	@accountID int,
	@accountNo varchar(50),
	@clientName varchar(250),
	@issuedate datetime,
	@expirydate datetime,
	@interestrate decimal(20, 2),
	@cash decimal(20, 2),
	@bank decimal(20, 2),
	@totalAmt decimal(20, 2),
	@totalFee decimal(20, 2),
	@LoanType int,
	@purpose int,
	@branch int,
	@creditteam int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_loan_disbursements(datAccountID, datAccountNumber, datClientFullName, datIssueDate, datExpiryDate, datInterestRate, datCash, datBank, datTotalAmount, datTotalFee, datLoanType, datPurpose, datBranch, datCreditTeam, userID) VALUES (@accountID, @accountNo, @clientName, @issuedate, @expirydate, @interestrate, @cash, @bank, @totalAmt, @totalFee, @LoanType, @purpose, @branch, @creditteam, @userID)
GO
/****** Object:  StoredProcedure [dbo].[GetPreliminaryReport]    Script Date: 08/01/2014 14:10:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPreliminaryReport]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        datDescription
FROM            tbl_pre_approval_reports
WHERE        (datApplicationID = @AppID) AND (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[AccountMovement]    Script Date: 08/01/2014 14:09:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AccountMovement]
(
	@start datetime,
	@end datetime
)
AS
	SET NOCOUNT ON;
SELECT        datID, datAccountID, datOutstandingAmount, datPreviousCat, datCurrentCat, datBranch, datCreditTeam, datAgingDate, modifiedDate
FROM            tbl_account_movement
WHERE        (modifiedDate BETWEEN @start AND @end)
GO
/****** Object:  StoredProcedure [dbo].[GetNotificationCount]    Script Date: 08/01/2014 14:10:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetNotificationCount]

@BranchID int,
@UserID int,
@ctID int = null
AS

declare @client int
declare @loanApplication int
declare @loanaccount int
declare @initialAssessment int
declare @preapproval int
declare @appraisal int
declare @legal int
declare @risk int
declare @approvalI int
declare @approvalII int
declare @approvalIII int
declare @approvalIV int
declare @approvalV int
declare @approvedloans int
declare @disbursementI int
declare @disbursementII int
declare @disbursementIII int
declare @ctReview int
declare @cmReview int
declare @ceoReview int
declare @cooReview int
declare @scheduledPayment int
declare @invapplications int
declare @initInterview int
declare @receipts int
declare @certification int
declare @InvApproved int
declare @IntMaturity int
declare @InvMaturity int
declare @InvAccounts int
declare @InvDisbI int
declare @InvDisbII int
declare @InvDisbIII int


SELECT   @client=COUNT(datID) 
FROM         tbl_client

SELECT  @loanApplication = COUNT(datID) 
FROM         tbl_loan_application
WHERE     (status = 1)  AND (datApplicationStatus<16) AND (datTeamID=@BranchID)

SELECT   @loanaccount = COUNT(datID)
FROM         tbl_loan_accounts

SELECT @initialAssessment= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 2


SELECT @preapproval= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 3

SELECT @appraisal= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 4 AND tbl_loan_application.datCreditTeamID=@ctID
	
SELECT @risk= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 5

SELECT @legal= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 6

SELECT @approvalI= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 7

SELECT @approvalII= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 8

SELECT @approvalIII= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 9

SELECT @approvalIV= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 10

SELECT @approvalV= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 11

SELECT @approvedloans = COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 12

SELECT @disbursementI = COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 13

SELECT @disbursementII = COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 14

SELECT @disbursementIII = COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 15

SELECT @ctReview= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 0

SELECT @cmReview= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 0


SELECT @ceoReview= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 0

SELECT @cooReview= COUNT(*) 
FROM tbl_loan_application INNER JOIN opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID 
WHERE (datTeamID =@BranchID AND tbl_loan_application.datApplicationStatus = 0)

SELECT @scheduledPayment =   Count(DISTINCT tbl_loan_accounts.datOutstandingAmount)
FROM            tbl_client INNER JOIN
                         tbl_loan_accounts ON tbl_loan_accounts.datClientID = tbl_client.datID INNER JOIN
                         tbl_pplan_details ON tbl_pplan_details.datApplicationID = tbl_loan_accounts.datApplicationID
WHERE        (tbl_pplan_details.datMonth BETWEEN GETDATE() AND DATEADD(day, 7, GETDATE())) AND (tbl_loan_accounts.datOutstandingAmount > '0.00')

SELECT  @invapplications =  COUNT(datID)
FROM         tbl_investment_application
WHERE     (datTeamID = @BranchID) AND (datApplicationStatus <5)

SELECT   @initInterview = COUNT(datID) 
FROM         tbl_investment_application
WHERE     (datTeamID = @branchID) AND (datApplicationStatus = 1)

SELECT   @receipts = COUNT(datID) 
FROM         tbl_investment_application
WHERE     (datTeamID = @branchID) AND (datApplicationStatus = 2)

SELECT   @certification = COUNT(datID) 
FROM         tbl_investment_application
WHERE     (datTeamID = @branchID) AND (datApplicationStatus = 3)

SELECT   @InvApproved = COUNT(datID) 
FROM         tbl_investment_application
WHERE     (datTeamID = @branchID) AND (datApplicationStatus = 4)

SELECT  @IntMaturity =Count(datID)
FROM tbl_investment_accounts 
WHERE (datDaysOver >= 30) AND (datTeamID = @BranchID)

SELECT @InvMaturity = COUNT(tbl_investment_accounts.datID)
FROM tbl_inv_pay_sched INNER JOIN tbl_investment_accounts
					   ON tbl_investment_accounts.datID=tbl_inv_pay_sched.datAccountID
WHERE tbl_inv_pay_sched.datDate <= GETDATE() AND tbl_inv_pay_sched.datStatus = 100

SELECT   @InvAccounts = COUNT(datID) 
FROM         tbl_investment_accounts
WHERE     (datTeamID = @BranchID) AND (datAccountStatus <> 0)


SELECT @InvDisbI = Count(*) 
FROM tbl_investment_accounts 
WHERE datActiveAccountStatus = 5 OR datPaymentStatus  = 5

select @client as client,
@loanApplication as loanApplication ,
@loanaccount as loanaccount, 
@initialassessment as intialassessment,
@preapproval as preapproval,
@appraisal as appraisal,
@risk as risk,
@legal as legal,
@approvalI as approvalI,
@approvalII as approvalII,
@approvalIII as approvalIII,
@approvalIV as approvalIV,
@approvalV as approvalV,
@approvedloans as approvedloans,
@disbursementI as disbursementI,
@disbursementII as disbursementII,
@disbursementIII as disbursementIII, 
@ctReview as ctreview,
@cmReview as cmreview,
@ceoReview as ceoreview,
@cooReview as cooreview,
@scheduledPayment as scheduledPayment,
@invapplications AS invapplications,
@initInterview as initInterview,
@receipts as receipts,
@certification as certification,
@InvApproved as InvApproved,
@IntMaturity as IntMaturity,
@InvMaturity as InvMaturity,
@InvAccounts as InvAccounts,
@InvDisbI as InvDisbI,
@InvDisbII as InvDisbII,
@InvDisbIII as InvDisbIII

--declare @TotalMinutes int
--
--select @TotalMinutes = datediff( minute, dateadd( day, datediff( day, 0, getdate() ), 0 ), getdate( ))
--
--declare @Hours int, @Minutes int
--
--select @Hours = @TotalMinutes / 60, @Minutes = @TotalMinutes % 60
--
--select @TotalMinutes, @Hours, @Minutes
GO
/****** Object:  StoredProcedure [dbo].[UpdateCategorizationOfAmount]    Script Date: 08/01/2014 14:12:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCategorizationOfAmount]
(
	@ent1 decimal(20, 2),
	@ent2 decimal(20, 2),
	@ent3 decimal(20, 2),
	@ent4 decimal(20, 2),
	@ent5 decimal(20, 2),
	@ent6 decimal(20, 2),
	@ent7 decimal(20, 2),
	@category int,
	@date datetime,
	@AccID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_loan_accounts
SET                datEnt1 = @ent1, datEnt2 = @ent2, datEnt3 = @ent3, datEnt4 = @ent4, datEnt5 = @ent5, datEnt6 = @ent6, datEnt7 = @ent7, datCategory = @category, datAgingDate = @date
WHERE        (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[GetSchSpecificLoanAccount]    Script Date: 08/01/2014 14:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSchSpecificLoanAccount]
(
	@AccID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datAccountNumber, datApplicationID, datClientID, datTeamID, datStartDate, datEndDate, datInterestRate, datInterestRateType, datFrequency, datDuration, 
                         datPurpose, datInitialAmount, datOutstandingAmount, datFees, datDailyInterest, datBulletInterest, datFlag, datFinRptBalance_Daily, datFinRptBalance_Monthly, 
                         datCategory, datFrozenDate, datUnFrozenDate, datDaysOver, datIntrestOnNextWorkingDays, datDateOfLastInterest, datCreditTeamID, datClientFullName, 
                         datLoanType, datEnt1, datEnt2, datEnt3, datEnt4, datEnt5, datEnt6, datEnt7, datPerformance, datClosedDate, datAccountStatus, datAgingDate, datRefreshedID, datIssueDate, 
                         modifiedDate, userID
FROM            tbl_loan_accounts
WHERE        (datOutstandingAmount > 0) AND (datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[GetSchLoanAccount]    Script Date: 08/01/2014 14:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSchLoanAccount]
AS
	SET NOCOUNT ON;
SELECT        datID, datAccountNumber, datApplicationID, datClientID, datTeamID, datStartDate, datEndDate, datInterestRate, datInterestRateType, datFrequency, datDuration, 
                         datPurpose, datInitialAmount, datOutstandingAmount, datFees, datDailyInterest, datBulletInterest, datFlag, datFinRptBalance_Daily, datFinRptBalance_Monthly, 
                         datCategory, datFrozenDate, datUnFrozenDate, datDaysOver, datIntrestOnNextWorkingDays, datDateOfLastInterest, datCreditTeamID, datClientFullName, 
                         datLoanType, datEnt1, datEnt2, datEnt3, datEnt4, datEnt5, datEnt6, datEnt7, datPerformance, datClosedDate, datAccountStatus, datAgingDate, datRefreshedID, datIssueDate, 
                         modifiedDate, userID
FROM            tbl_loan_accounts
WHERE        (datOutstandingAmount > 0)
GO
/****** Object:  UserDefinedFunction [dbo].[getExpectedAmountByCAT]    Script Date: 08/01/2014 14:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getExpectedAmountByCAT]
	(

	@date nvarchar(10),
	@catID int,
    @BranchID int,
	@CMID int
	)
RETURNS decimal(20,2)/* datatype */
AS
	BEGIN
	DECLARE @return decimal(20,2)

	if((@branchid =0) AND ((@CMID =0)))
	BEGIN 
			SELECT   @return=  Sum(pp.datMonthlyPayment)
			FROM         tbl_pplan_details AS pp INNER JOIN
								  tbl_loan_accounts AS la ON pp.datApplicationID = la.datApplicationID INNER JOIN
								  sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID INNER JOIN
								  tbl_teams AS br ON la.datTeamID = br.datID
			WHERE     (pp.datMonth LIKE CAST(@date AS datetime)) AND (la.datcategory=@catID)
	END
	else if((@branchid !=0) AND ((@CMID =0)))
	BEGIN
			SELECT   @return=  Sum(pp.datMonthlyPayment)
			FROM         tbl_pplan_details AS pp INNER JOIN
								  tbl_loan_accounts AS la ON pp.datApplicationID = la.datApplicationID INNER JOIN
								  sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID INNER JOIN
								  tbl_teams AS br ON la.datTeamID = br.datID
			WHERE     (pp.datMonth LIKE CAST(@date AS datetime)) AND (la.datcategory=@catID) AND (br.datID=@branchID)
	END
	else if((@BranchID=0) AND (@CMID !=0))
	BEGIN
		    SELECT     @return=Sum(pp.datMonthlyPayment)
			FROM         tbl_pplan_details AS pp INNER JOIN
								  tbl_loan_accounts AS la ON pp.datApplicationID = la.datApplicationID INNER JOIN
								  sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID INNER JOIN
								  tbl_teams AS br ON la.datTeamID = br.datID
			WHERE     (pp.datMonth LIKE CAST(@date AS datetime)) AND (la.datcategory=@catID) AND (ct.datID=@CMID)
	END
	if((@BranchID !=0 )AND( @CMID !=0))
	BEGIN

		SELECT    @return= Sum(pp.datMonthlyPayment)
		FROM         tbl_pplan_details AS pp INNER JOIN
							  tbl_loan_accounts AS la ON pp.datApplicationID = la.datApplicationID INNER JOIN
							  sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON la.datTeamID = br.datID
		WHERE     (pp.datMonth LIKE CAST(@date AS datetime)) AND (la.datcategory=@catID) AND ( ct.datID=@CMID AND br.datID=@branchID )
	END
	else
	BEGIN
		SELECT   @return=Sum(pp.datMonthlyPayment)
		FROM         tbl_pplan_details AS pp INNER JOIN
							  tbl_loan_accounts AS la ON pp.datApplicationID = la.datApplicationID INNER JOIN
							  sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON la.datTeamID = br.datID
		WHERE     (pp.datMonth LIKE CAST(@date AS datetime)) AND (la.datcategory=@catID)
	END
	if(@return is null)
	BEGIN
		set @return=0
	END

	RETURN @return

	END
GO
/****** Object:  UserDefinedFunction [dbo].[GetWeekByCat]    Script Date: 08/01/2014 14:14:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[GetWeekByCat]
(
	
 @week int,
 @date nvarchar(10),
 @catID int,
 @BranchID int,
 @CMID int
)
returns decimal(20,2)

as 

BEGIN

declare @return decimal(20,2)
declare @month int

set @month = datepart(m,Cast(@date as datetime))
	

if((@branchid =0) AND ((@CMID =0)))
	BEGIN 
			SELECT   @return = SUM(lt.datCreditAmount) 
			FROM     tbl_financial_transactions AS lt INNER JOIN
					 tbl_teams AS br ON lt.datBranch = br.datID INNER JOIN
					 tbl_loan_accounts AS la ON lt.datApplicationID = la.datApplicationID INNER JOIN
					 sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID
			WHERE     (datediff(week, dateadd(week, datediff(week, 0, dateadd(month, datediff(month, 0, lt.modifiedDate), 0)), 0), lt.modifiedDate - 1) + 1= @week) AND (DATEPART(m, lt.modifiedDate) = @month) AND (la.datCategory=@catID) AND (lt.datGLAccount = 1)
	END
	else if((@branchid !=0) AND ((@CMID =0)))
	BEGIN
			SELECT   @return = SUM(lt.datCreditAmount) 
			FROM     tbl_financial_transactions AS lt INNER JOIN
					 tbl_teams AS br ON lt.datBranch = br.datID INNER JOIN
					 tbl_loan_accounts AS la ON lt.datApplicationID = la.datApplicationID INNER JOIN
					 sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID
			WHERE     (datediff(week, dateadd(week, datediff(week, 0, dateadd(month, datediff(month, 0, lt.modifiedDate), 0)), 0), lt.modifiedDate - 1) + 1=  @week) AND (DATEPART(m, lt.modifiedDate) = @month)AND (la.datCategory=@catID) AND (lt.datGLAccount = 1) AND (br.datID=@branchID)
	END
	else if((@BranchID=0) AND (@CMID !=0))
	BEGIN
		    SELECT   @return = SUM(lt.datCreditAmount) 
			FROM     tbl_financial_transactions AS lt INNER JOIN
					 tbl_teams AS br ON lt.datBranch = br.datID INNER JOIN
					 tbl_loan_accounts AS la ON lt.datApplicationID = la.datApplicationID INNER JOIN
					 sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID
			WHERE     (datediff(week, dateadd(week, datediff(week, 0, dateadd(month, datediff(month, 0, lt.modifiedDate), 0)), 0), lt.modifiedDate - 1) + 1=  @week) AND (DATEPART(m, lt.modifiedDate) = @month) AND (la.datCategory=@catID) AND (lt.datGLAccount = 1) AND (ct.datID=@CMID)
	END
	if((@BranchID !=0 )AND( @CMID !=0))
	BEGIN

		SELECT   @return = SUM(lt.datCreditAmount) 
		FROM     tbl_financial_transactions AS lt INNER JOIN
					 tbl_teams AS br ON lt.datBranch = br.datID INNER JOIN
					 tbl_loan_accounts AS la ON lt.datApplicationID = la.datApplicationID INNER JOIN
					 sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID
		WHERE     (datediff(week, dateadd(week, datediff(week, 0, dateadd(month, datediff(month, 0, lt.modifiedDate), 0)), 0), lt.modifiedDate - 1) + 1=  @week) AND (DATEPART(m, lt.modifiedDate) = @month)AND (la.datCategory=@catID) AND (lt.datGLAccount = 1) AND ( ct.datID=@CMID AND br.datID=@branchID )
	END
	else
	BEGIN
		SELECT  @return = SUM(lt.datCreditAmount) 
		FROM         tbl_financial_transactions AS lt INNER JOIN
                      tbl_loan_accounts AS la ON lt.datApplicationID = la.datApplicationID 		
        WHERE     (datediff(week, dateadd(week, datediff(week, 0, dateadd(month, datediff(month, 0, lt.modifiedDate), 0)), 0), lt.modifiedDate - 1) + 1  = @week) AND (DATEPART(m, lt.modifiedDate) = @month)AND (la.datCategory=@catID) AND (lt.datGLAccount = 1)
	END


if(@return is null)
set @return =0

return @return
END
GO
/****** Object:  UserDefinedFunction [dbo].[getOutstandingByCAT]    Script Date: 08/01/2014 14:13:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOutstandingByCAT]
	(
	@catID int,
	@date nvarchar(50),
	@CMID int=null,
	@BranchID int=null
	)
RETURNS int/* datatype */
AS
	BEGIN
	DECLARE @return int
	DECLARE @query nvarchar(4000)
--SELECT  @return = COUNT(datID) 
--FROM         tbl_historic_accounts AS ha
--WHERE     (datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (datCategory = @catID) AND (datOutstandingAmount > 0)

if((@branchid =0) AND ((@CMID =0)))
	BEGIN 
			
			SELECT   @return = SUM(ha.datOutstandingAmount) 
FROM         tbl_historic_accounts AS ha INNER JOIN
                      sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON ha.datTeamID = br.datID
WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
                      (ha.datOutstandingAmount > 0)	
	END
	else if((@branchid !=0) AND ((@CMID =0)))
	BEGIN
			SELECT  @return =    SUM(ha.datOutstandingAmount) 
			FROM       tbl_historic_accounts AS ha INNER JOIN
								  sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
								  tbl_teams AS br ON ha.datTeamID = br.datID
			WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
                      (ha.datOutstandingAmount > 0) AND (br.datID=@branchID)
	END
	else if((@BranchID=0) AND (@CMID !=0))
	BEGIN
		SELECT    @return = SUM(ha.datOutstandingAmount) 
		FROM         tbl_historic_accounts AS ha INNER JOIN
							  sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON ha.datTeamID = br.datID
		WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
							  (ha.datOutstandingAmount > 0) AND (ct.datID=@CMID)
	END
	if((@BranchID !=0 )AND( @CMID !=0))
	BEGIN

		SELECT  @return =  SUM(ha.datOutstandingAmount) 
		FROM         tbl_historic_accounts AS ha INNER JOIN
							  sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON ha.datTeamID = br.datID
		WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
							  (ha.datOutstandingAmount > 0) AND ( ct.datID=@CMID AND br.datID=@branchID )
	END
	else
	BEGIN
		SELECT  @return =   SUM(ha.datOutstandingAmount) 
		FROM         tbl_historic_accounts AS ha 
		WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
							  (ha.datOutstandingAmount > 0)
	END


if(@return is null)
set @return =0

return @return
END
GO
/****** Object:  StoredProcedure [dbo].[Dashboard_Loan_Amount]    Script Date: 08/01/2014 14:09:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dashboard_Loan_Amount]
(
	@startDate datetime,
	@endDate datetime
)
AS
	SET NOCOUNT ON;
SELECT        SUM(lt.datCreditAmount) AS AmtReceived, DATEDIFF(week, DATEADD(week, DATEDIFF(week, 0, DATEADD(month, DATEDIFF(month, 0, lt.modifiedDate), 0)), 0), lt.modifiedDate - 1) + 1 AS NoWeek
FROM            tbl_financial_transactions AS lt INNER JOIN
                         tbl_teams AS br ON lt.datBranch = br.datID INNER JOIN
                         tbl_loan_accounts AS la ON lt.datApplicationID = la.datApplicationID INNER JOIN
                         sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID
WHERE        (lt.modifiedDate BETWEEN CAST(@startDate AS datetime) AND CAST(@endDate AS datetime)) AND (lt.datGLAccount = 1)
GROUP BY DATEDIFF(week, DATEADD(week, DATEDIFF(week, 0, DATEADD(month, DATEDIFF(month, 0, lt.modifiedDate), 0)), 0), lt.modifiedDate - 1) + 1
GO
/****** Object:  StoredProcedure [dbo].[GetCreditTeamMembers]    Script Date: 08/01/2014 14:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCreditTeamMembers]
(
	@ctID int
)
AS
	SET NOCOUNT ON;
SELECT     sys_users.datTitle, sys_users.datSurname, sys_users.datFirstnames, sys_credit_teams.datDescription AS creditteam, tbl_ct_members.datID, tbl_ct_members.datCreditTeamID, 
                      tbl_ct_members.datSysUserID, tbl_teams.datID AS branchID
FROM         tbl_ct_members INNER JOIN
                      sys_users ON tbl_ct_members.datSysUserID = sys_users.datID INNER JOIN
                      sys_credit_teams ON tbl_ct_members.datCreditTeamID = sys_credit_teams.datID INNER JOIN
                      tbl_teams ON sys_users.datTeam = tbl_teams.datID
WHERE     (sys_credit_teams.datID = @ctID)
GO
/****** Object:  UserDefinedFunction [dbo].[getOptBranch]    Script Date: 08/01/2014 14:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptBranch]
	(
	@ID int
	)
RETURNS varchar(300)/* datatype */
AS
	BEGIN
	DECLARE @return VARCHAR(300)
	
SELECT    @return = datDescription
FROM         tbl_teams
WHERE     (datID = @ID)

	RETURN @return
	
END
GO
/****** Object:  StoredProcedure [dbo].[Dashboard_Expected_Amount]    Script Date: 08/01/2014 14:09:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Dashboard_Expected_Amount]
(
	@startDate datetime,
	@endDate datetime
)
AS
	SET NOCOUNT ON;
SELECT        SUM(pp.datMonthlyPayment) AS ExpectedAmt, DATEDIFF(week, DATEADD(week, DATEDIFF(week, 0, DATEADD(month, DATEDIFF(month, 0, pp.datMonth), 0)), 0), pp.datMonth - 1) + 1 AS NoWeek
FROM            tbl_pplan_details AS pp INNER JOIN
                         tbl_loan_accounts AS la ON pp.datApplicationID = la.datApplicationID INNER JOIN
                         sys_credit_teams AS ct ON la.datCreditTeamID = ct.datID INNER JOIN
                         tbl_teams AS br ON la.datTeamID = br.datID
WHERE        (pp.datMonth BETWEEN CAST(@startDate AS datetime) AND CAST(@endDate AS datetime))
GROUP BY DATEDIFF(week, DATEADD(week, DATEDIFF(week, 0, DATEADD(month, DATEDIFF(month, 0, pp.datMonth), 0)), 0), pp.datMonth - 1) + 1
GO
/****** Object:  UserDefinedFunction [dbo].[getNoClientByCAT]    Script Date: 08/01/2014 14:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getNoClientByCAT]
	(
	@catID int,
	@date nvarchar(10),
	@branchID int =NULL,
	@CMID int = NULL	
	)
RETURNS int
AS
	BEGIN
	DECLARE @return int;
	


	if((@branchid =0) AND ((@CMID =0)))
	BEGIN 
			SELECT    @return = COUNT(*) 
			FROM         tbl_historic_accounts INNER JOIN
								  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID INNER JOIN
								  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID
			WHERE     (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND 
                      (tbl_historic_accounts.datCategory = @catID) AND (tbl_historic_accounts.datOutstandingAmount > 0)
	END
	else if((@branchid !=0) AND ((@CMID =0)))
	BEGIN
			SELECT    @return = COUNT(*) 
			FROM         tbl_historic_accounts INNER JOIN
								  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID INNER JOIN
								  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID
			WHERE     (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND 
                      (tbl_historic_accounts.datCategory = @catID) AND (tbl_historic_accounts.datOutstandingAmount > 0) AND (br.datID=@branchID)
	END
	else if((@BranchID=0) AND (@CMID !=0))
	BEGIN
		SELECT    @return = COUNT(*) 
			FROM         tbl_historic_accounts INNER JOIN
								  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID INNER JOIN
								  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID
			WHERE     (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND 
                      (tbl_historic_accounts.datCategory = @catID) AND (tbl_historic_accounts.datOutstandingAmount > 0) AND (ct.datID=@CMID)
	END
	if((@BranchID !=0 )AND( @CMID !=0))
	BEGIN

		SELECT    @return = COUNT(*) 
			FROM         tbl_historic_accounts INNER JOIN
								  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID INNER JOIN
								  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID
			WHERE     (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND 
                      (tbl_historic_accounts.datCategory = @catID) AND (tbl_historic_accounts.datOutstandingAmount > 0) AND ( ct.datID=@CMID AND br.datID=@branchID )
	END
	else
	BEGIN
		SELECT @return = COUNT(*)  
			FROM tbl_historic_accounts 
			WHERE (tbl_historic_accounts.datCategory = @catID) AND (tbl_historic_accounts.datOutstandingAmount > 0)  AND (datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) 
	END
	
	
	
   
     
	
	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getLoanAmountByCAT]    Script Date: 08/01/2014 14:13:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getLoanAmountByCAT]
	(
	@catID int,
	@date nvarchar(50),
	@CMID int=null,
	@BranchID int=null
	)
RETURNS int/* datatype */
AS
	BEGIN
	DECLARE @return int
	DECLARE @query nvarchar(4000)
--SELECT  @return = COUNT(datID) 
--FROM         tbl_historic_accounts AS ha
--WHERE     (datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (datCategory = @catID) AND (datOutstandingAmount > 0)

if((@branchid =0) AND ((@CMID =0)))
	BEGIN 
			
			SELECT   @return = SUM(ha.datInitialAmount) 
FROM         tbl_historic_accounts AS ha INNER JOIN
                      sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
                      tbl_teams AS br ON ha.datTeamID = br.datID
WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
                      (ha.datOutstandingAmount > 0)	
	END
	else if((@branchid !=0) AND ((@CMID =0)))
	BEGIN
			SELECT  @return =    SUM(ha.datInitialAmount) 
			FROM       tbl_historic_accounts AS ha INNER JOIN
								  sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
								  tbl_teams AS br ON ha.datTeamID = br.datID
			WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
                      (ha.datOutstandingAmount > 0) AND (br.datID=@branchID)
	END
	else if((@BranchID=0) AND (@CMID !=0))
	BEGIN
		SELECT    @return = SUM(ha.datInitialAmount) 
		FROM         tbl_historic_accounts AS ha INNER JOIN
							  sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON ha.datTeamID = br.datID
		WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
							  (ha.datOutstandingAmount > 0) AND (ct.datID=@CMID)
	END
	if((@BranchID !=0 )AND( @CMID !=0))
	BEGIN

		SELECT  @return =  SUM(ha.datInitialAmount) 
		FROM         tbl_historic_accounts AS ha INNER JOIN
							  sys_credit_teams AS ct ON ha.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON ha.datTeamID = br.datID
		WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
							  (ha.datOutstandingAmount > 0) AND ( ct.datID=@CMID AND br.datID=@branchID )
	END
	else
	BEGIN
		SELECT  @return =   SUM(ha.datInitialAmount) 
		FROM         tbl_historic_accounts AS ha 
		WHERE     (ha.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND (ha.datCategory = @catID) AND 
							  (ha.datOutstandingAmount > 0)
	END


if(@return is null)
set @return =0

return @return
END
GO
/****** Object:  StoredProcedure [dbo].[InsertBranch]    Script Date: 08/01/2014 14:10:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBranch]
(
	@description varchar(50),
	@location int,
	@address varchar(255),
	@telephone varchar(20)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_teams
                         (datDescription, datLocation,datAddress, datTelephone)
VALUES        (@description,@location,@address,@telephone)
GO
/****** Object:  StoredProcedure [dbo].[UpdateBranch]    Script Date: 08/01/2014 14:12:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBranch]
(
	@description varchar(50),
	@location int,
	@address varchar(255),
	@telephone varchar(20),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_teams
SET                datDescription = @description, datLocation = @location, datAddress = @address, datTelephone = @telephone
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetBranchDetails]    Script Date: 08/01/2014 14:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBranchDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datLocation, datBranchManagerID, datFrontDeskID, datCreditTeamID, datAreaManagerID, datAddress, datTelephone, status
FROM            tbl_teams
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetBranch]    Script Date: 08/01/2014 14:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBranch]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datLocation, datBranchManagerID, datFrontDeskID, datCreditTeamID, datAreaManagerID, datAddress, datTelephone
FROM            tbl_teams
GO
/****** Object:  StoredProcedure [dbo].[GetBranches]    Script Date: 08/01/2014 14:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBranches]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datLocation, datBranchManagerID, datFrontDeskID, datCreditTeamID, datAreaManagerID, datAddress, datTelephone
FROM            tbl_teams
GO
/****** Object:  StoredProcedure [dbo].[GetClientReportDetails]    Script Date: 08/01/2014 14:09:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetClientReportDetails]
(
	@AccID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_loan_accounts.datAccountNumber, tbl_loan_accounts.datClientFullName, opt_loan_types.datDescription AS loantype, tbl_loan_accounts.datInitialAmount, 
                         tbl_loan_accounts.datDuration, tbl_loan_accounts.datInterestRate, tbl_loan_accounts.datStartDate, tbl_loan_accounts.datEndDate, tbl_client.datClientNumber
FROM            tbl_loan_accounts INNER JOIN
                         opt_loan_types ON tbl_loan_accounts.datLoanType = opt_loan_types.datID INNER JOIN
                         tbl_teams ON tbl_loan_accounts.datTeamID = tbl_teams.datID INNER JOIN
                         tbl_client ON tbl_loan_accounts.datTeamID = tbl_client.datID
WHERE        (tbl_loan_accounts.datID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[InsertBeneficiaries]    Script Date: 08/01/2014 14:10:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertBeneficiaries]
(
	@title int,
	@firstname varchar(50),
	@middlename varchar(50),
	@surname varchar(50),
	@birthdate datetime,
	@occupation varchar(50),
	@idtype int,
	@idvalue varchar(50),
	@pshare real,
	@telnoRes varchar(20),
	@telnoOff varchar(20),
	@mobile varchar(50),
	@email varchar(180),
	@pAddress nchar(10),
	@ResAddress nchar(10),
	@clientID int,
	@InvAppID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_beneficiary
                         (datTitle, datFirstname, datMiddleName, datSurname, datDateOfBirth, datOccupation, datIDType, datIDValue, datPercentageShare, datTelephoneRes, datTelephoneOff, datMobileNumber, datEmailAddress, 
                         datPostalAddress, datResidentialAddress, datClientID, datApplicationID, status)
VALUES        (@title,@firstname,@middlename,@surname,@birthdate,@occupation,@idtype,@idvalue,@pshare,@telnoRes,@telnoOff,@mobile,@email,@pAddress,@ResAddress,@clientID,@InvAppID, 1)
GO
/****** Object:  StoredProcedure [dbo].[GetBeneficiaries]    Script Date: 08/01/2014 14:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBeneficiaries]
(
	@InvAppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT     datID, datTitle, datFirstname, datMiddleName, datSurname, datPercentageShare, datMobileNumber, datEmailAddress, datDateOfBirth, datIDType, datIDValue, datOccupation, datTelephoneRes, 
                      datTelephoneOff, datPostalAddress, datResidentialAddress, datApplicationID, datClientID, status, modifiedDate, userID
FROM         tbl_beneficiary
WHERE     (datApplicationID = @InvAppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateBeneficiaries]    Script Date: 08/01/2014 14:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateBeneficiaries]
(
	@title int,
	@firstname varchar(50),
	@middlename varchar(50),
	@surname varchar(50),
	@birthdate datetime,
	@occupation varchar(50),
	@idValue varchar(50),
	@idType int,
	@pshare real,
	@telnoRes varchar(20),
	@telnoOff varchar(20),
	@mobile varchar(50),
	@email varchar(180),
	@pAddress nchar(10),
	@resAddress nchar(10),
	@datID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_beneficiary
SET                datTitle = @title, datFirstname = @firstname, datMiddleName = @middlename, datSurname = @surname, datDateOfBirth = @birthdate, datOccupation = @occupation, datIDValue = @idValue, 
                         datIDType = @idType, datPercentageShare = @pshare, datTelephoneRes = @telnoRes, datTelephoneOff = @telnoOff, datMobileNumber = @mobile, datEmailAddress = @email, datPostalAddress = @pAddress, 
                         datResidentialAddress = @resAddress
WHERE        (datID = @datID)
GO
/****** Object:  StoredProcedure [dbo].[GetAccountMovementInfo]    Script Date: 08/01/2014 14:09:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAccountMovementInfo]
(
	@date datetime
)
AS
	SET NOCOUNT ON;
SELECT        datCategory, datTeamID, datCreditTeamID, datOutstandingAmount, datAccountID AS ACC, dbo.getPrevHistoricAcCat(1, @date) AS CAT2
FROM            tbl_historic_accounts
WHERE        (datAgingDate = @date)
GO
/****** Object:  StoredProcedure [dbo].[GetRptPersonalInformation]    Script Date: 08/01/2014 14:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptPersonalInformation]
(
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_client.datID, tbl_client.datClientNumber, tbl_client.datFirstName, opt_titles.datDescription AS title, tbl_client.datMiddleName, tbl_client.datSurname, 
                      tbl_client.datClientName, tbl_client.datIDValue1, tbl_client.datIDValue2, tbl_client.datIDValue3, opt_genders.datDescription AS gender, tbl_client.datDateOfBirth, 
                      tbl_client.datHomeTelephoneNumber, tbl_client.datOfficeTelephoneNumber, tbl_client.datMobileNumber1, tbl_client.datMobileNumber2, tbl_client.datFaxNumber, 
                      tbl_client.datEmailAddress, tbl_client.datCurrentResidentialAddress, tbl_client.datPreviousResidentialAddress, tbl_client.datPostalAddress, 
                      tbl_client.datNearestLandMark, opt_marital_statuses.datDescription AS maritalstatus, opt_region.datDescription AS region, 
                      opt_nationalities.datDescription AS nationality, opt_residential_statuses.datDescription AS residentialstatus,dbo.getIDType(datIDType2) as datIDType2, dbo.getIDType(datIDType1) as datIDType1, dbo.getIDType(datIDType3) as  datIDType3
FROM         tbl_client INNER JOIN
                      opt_genders ON tbl_client.datGender = opt_genders.datID INNER JOIN
                      opt_titles ON tbl_client.datTitle = opt_titles.datID INNER JOIN
                      opt_marital_statuses ON tbl_client.datMaritalStatus = opt_marital_statuses.datID INNER JOIN
                      opt_region ON tbl_client.datRegion = opt_region.datID INNER JOIN
                      opt_nationalities ON tbl_client.datNationality = opt_nationalities.datID INNER JOIN
                      opt_residential_statuses ON tbl_client.datResidentialStatus = opt_residential_statuses.datID
WHERE     (tbl_client.datID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptClientProfile]    Script Date: 08/01/2014 14:10:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptClientProfile]
(
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datClientNumber, datTitle, datFirstName, datMiddleName, datSurname, datClientName,dbo.getIDType(datIDType2) as datIDType2, dbo.getIDType(datIDType1) as datIDType1, dbo.getIDType(datIDType3) as  datIDType3, datIDValue1, datIDValue2, 
                         datIDValue3, datNationality, datRegion, datMaritalStatus, datGender, datDateOfBirth, datHomeTelephoneNumber, datOfficeTelephoneNumber, datMobileNumber1, 
                         datMobileNumber2, datFaxNumber, datEmailAddress, datResidentialStatus, datCurrentResidentialAddress, datPreviousResidentialAddress, datPostalAddress, 
                         datNearestLandMark, status, modifiedDate, userID
FROM            tbl_client
WHERE        (datID = 2)
GO
/****** Object:  StoredProcedure [dbo].[GetAdvise]    Script Date: 08/01/2014 14:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAdvise]
(
	@InvAppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT     datID, datStage, datDescription, userID, modifiedDate
FROM         tbl_comments_invest
WHERE     (datApplicationID = @InvAppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetInvComments]    Script Date: 08/01/2014 14:09:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvComments]
(
	@ClientID int,
	@InvAppID int
)
AS
	SET NOCOUNT ON;
SELECT        datStage, datDescription, status
FROM            tbl_comments_invest
WHERE        (datClientID = @ClientID) AND (datApplicationID = @InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertInvComments]    Script Date: 08/01/2014 14:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInvComments]
(
	@datstage varchar(50),
	@datDescription text,
	@datClientID int,
	@datApplicationID int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_comments_invest
                         (datStage, datDescription, datClientID, datApplicationID, status, modifiedDate, userID)
VALUES        (@datstage,@datDescription,@datClientID,@datApplicationID, 1, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[InsertAdvise]    Script Date: 08/01/2014 14:10:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAdvise]
(
	@stage varchar(50),
	@ClientID int,
	@InvAppID int,
	@description text,
	@userid int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_comments_invest
                         (datStage, datClientID, datApplicationID, datDescription, modifiedDate, status, userID)
VALUES        (@stage,@ClientID,@InvAppID,@description, GETDATE(), 1,@userid)
GO
/****** Object:  StoredProcedure [dbo].[UpdateCron]    Script Date: 08/01/2014 14:12:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCron]
(
	@tag varchar(150),
	@startdate datetime,
	@enddate datetime,
	@triggertime datetime,
	@OnetimeActive bit,
	@OnetimeDate datetime,
	@dailyInterval decimal(18,0),
	@itemEnabled bit,
	@ID int
)
AS
	SET NOCOUNT OFF;

UPDATE    tbl_cron
SET              datTag = @tag, datStartDate = @startDate, datEndDate = @endDate, datTriggerTime = @triggerTime, datTriggerSettingsOneTimeOnlyActive = @oneTimeActive, 
                      datTriggerSettingsOneTimeOnlyDate = @oneTimeDate, datTriggerSettingsDailyInterval = @dailyInterval, datTriggerSettingsItemEnabled = @itemEnabled
WHERE     (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetCronList]    Script Date: 08/01/2014 14:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCronList]
AS
	SET NOCOUNT ON;
SELECT     datID, datTag, datStartDate, datEndDate, datTriggerTime, datTriggerSettingsDailyInterval, datTriggerSettingsItemEnabled, datTriggerSettingsOneTimeOnlyActive, 
                      datTriggerSettingsOneTimeOnlyDate
FROM         tbl_cron
WHERE     (datTriggerSettingsItemEnabled = 'True')
GO
/****** Object:  StoredProcedure [dbo].[InsertCron]    Script Date: 08/01/2014 14:10:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCron]
(
	@tag varchar(150),
	@startdate datetime,
	@enddate datetime,
	@triggertime datetime,
	@OnetimeActive bit,
	@OnetimeDate datetime,
	@dailyInterval decimal(18,0),
	@itemEnabled bit
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_cron
                      (datTag, datStartDate, datEndDate, datTriggerTime, datTriggerSettingsOneTimeOnlyActive, datTriggerSettingsOneTimeOnlyDate, datTriggerSettingsDailyInterval, datTriggerSettingsItemEnabled)
VALUES     (@tag,@startdate,@enddate,@triggertime,@OnetimeActive,@OnetimeDate,@dailyInterval,@itemEnabled)
GO
/****** Object:  StoredProcedure [dbo].[getQuestions]    Script Date: 08/01/2014 14:10:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getQuestions]
(
	@Enable int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_checklistquestions
WHERE        (datEnable = @Enable)
GO
/****** Object:  StoredProcedure [dbo].[InsertConstituentInvestors]    Script Date: 08/01/2014 14:10:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertConstituentInvestors]
(
	@title int,
	@firstname varchar(50),
	@middlename varchar(50),
	@surname varchar(50),
	@idType1 int,
	@idType2 int,
	@idType3 int,
	@idValue1 varchar(50),
	@idValue2 varchar(50),
	@idValue3 varchar(50),
	@nationality int,
	@region int,
	@maritalstatus int,
	@gender int,
	@birthdate datetime,
	@hometel varchar(20),
	@officetel varchar(20),
	@mobile varchar(20),
	@mobile2 varchar(20),
	@fax varchar(20),
	@email varchar(20),
	@resStatus int,
	@currentResAddress varchar(255),
	@postalAddress varchar(255),
	@nearestLandmark varchar(255),
	@clientID int,
	@InvAppID int,
	@pshare int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_constituent_investor
                         (datTitle, datFirstName, datMiddleName, datSurname, datIDType1, datIDType2, datIDType3, datIDValue1, datIDValue2, datIDValue3, datNationality, datRegion, datMaritalStatus, datGender, datDateOfBirth, 
                         datHomeTelephoneNumber, datOfficeTelephoneNumber, datMobileNumber1, datMobileNumber2, datFaxNumber, datEmailAddress, datResidentialStatus, datCurrentResidentialAddress, datPostalAddress, 
                         datNearestLandMark, datClientID, datApplicationID, datPercentageShare)
VALUES        (@title,@firstname,@middlename,@surname,@idType1,@idType2,@idType3,@idValue1,@idValue2,@idValue3,@nationality,@region,@maritalstatus,@gender,@birthdate,@hometel,@officetel,@mobile,@mobile2,@fax,@email,@resStatus,@currentResAddress,@postalAddress,@nearestLandmark,@clientID,@InvAppID,@pshare)
GO
/****** Object:  StoredProcedure [dbo].[GetConstituentInvestors]    Script Date: 08/01/2014 14:09:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetConstituentInvestors]
(
	@ClientID int,
	@InvAppID int
)
AS
	SET NOCOUNT ON;
SELECT        datTitle, datFirstName, datMiddleName, datSurname, datIDType1, datIDType2, datIDType3, datIDValue1, datIDValue2, datIDValue3, datNationality, datRegion, datMaritalStatus, datGender, datDateOfBirth, 
                         datHomeTelephoneNumber, datOfficeTelephoneNumber, datMobileNumber1, datMobileNumber2, datFaxNumber, datEmailAddress, datResidentialStatus, datCurrentResidentialAddress, datPostalAddress, 
                         datNearestLandMark, datPercentageShare
FROM            tbl_constituent_investor
WHERE        (datClientID = @ClientID) AND (datApplicationID = @InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertOptCollateral]    Script Date: 08/01/2014 14:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertOptCollateral]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_collateral_types
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[UpdateCollaterall]    Script Date: 08/01/2014 14:12:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCollaterall]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_collateral_types
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetOptCollateral]    Script Date: 08/01/2014 14:10:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOptCollateral]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_collateral_types
GO
/****** Object:  StoredProcedure [dbo].[GetOptColateralDetails]    Script Date: 08/01/2014 14:10:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOptColateralDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_collateral_types
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetCollateral]    Script Date: 08/01/2014 14:09:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCollateral]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_collaterals.datCollateralTypeID, tbl_collaterals.datDescription, tbl_collaterals.datLocation, tbl_collaterals.datValue, tbl_collaterals.datSurety, 
                      tbl_collaterals.datContactPerson, tbl_collaterals.datContactPersonTelephoneNumber, tbl_collaterals.datPhysicalAddress, tbl_collaterals.datConfirmed, 
                      tbl_collaterals.datPicture, tbl_collaterals.status, tbl_collaterals.modifiedDate, tbl_collaterals.datID, tbl_collaterals.datClientID, 
                      opt_collateral_types.datDescription AS CollateralType
FROM         tbl_collaterals INNER JOIN
                      opt_collateral_types ON tbl_collaterals.datCollateralTypeID = opt_collateral_types.datID
WHERE     (tbl_collaterals.datApplicationID = @AppID) AND (tbl_collaterals.datClientID = @clientID)
GO
/****** Object:  UserDefinedFunction [dbo].[getCategories]    Script Date: 08/01/2014 14:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getCategories]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT   @return = datDescription
FROM         opt_categories
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getCatMaxDays]    Script Date: 08/01/2014 14:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getCatMaxDays]
	(
	@catID int
	)
RETURNS int
AS
	BEGIN
	DECLARE @return int;
	
SELECT    @return= datMaxDays
FROM         opt_categories
WHERE datID=@catID
	
	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getProvision]    Script Date: 08/01/2014 14:14:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getProvision]
	(
	@catID int,
	@Amt decimal(20,2)
	)
RETURNS decimal(20,2)
AS
	BEGIN
	DECLARE @return decimal(20,2)
	

	SELECT   @return= (@Amt *  (datProvisionFactor/100))
	FROM         opt_categories
	WHERE     (datID = @catID)


	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getCatMinDays]    Script Date: 08/01/2014 14:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getCatMinDays]
	(
	@catID int
	)
RETURNS int
AS
	BEGIN
	DECLARE @return int;
	
SELECT     @return=  datMinDays
FROM         opt_categories
WHERE     (datID = @catID)
	
	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getProvisionFactor]    Script Date: 08/01/2014 14:14:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getProvisionFactor]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT   @return = datProvisionFactor
FROM         opt_categories
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetLoanCategoriesDetails]    Script Date: 08/01/2014 14:10:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanCategoriesDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datDescription, datMinDays, datMaxDays, datPerformance, datProvisionFactor
FROM            opt_categories
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanCategories]    Script Date: 08/01/2014 14:10:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanCategories]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datMinDays, datMaxDays, datPerformance, datProvisionFactor
FROM            opt_categories
GO
/****** Object:  StoredProcedure [dbo].[InsertLoanCategories]    Script Date: 08/01/2014 14:11:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertLoanCategories]
(
	@description varchar(50),
	@datMinDays int,
	@datMaxDays int,
	@performance varchar(50),
	@provisionfactor decimal(20, 2)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_categories
                         (datDescription, datMinDays, datMaxDays, datPerformance, datProvisionFactor)
VALUES        (@description,@datMinDays,@datMaxDays,@performance,@provisionfactor)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLoanCategories]    Script Date: 08/01/2014 14:12:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLoanCategories]
(
	@description varchar(50),
	@datMinDays int,
	@datMaxDays int,
	@Performance varchar(50),
	@provisionfactor decimal(20, 2),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_categories
SET                datDescription = @description, datMinDays = @datMinDays, datMaxDays = @datMaxDays, datPerformance = @Performance, 
                         datProvisionFactor = @provisionfactor
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[DeleteCTMember]    Script Date: 08/01/2014 14:09:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteCTMember]
(
	@ctMemberID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM tbl_ct_members WHERE (datID = @ctMemberID)
GO
/****** Object:  StoredProcedure [dbo].[InsertCreditTeamMember]    Script Date: 08/01/2014 14:10:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCreditTeamMember]
(
	@ct int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_ct_members(datCreditTeamID, datSysUserID) VALUES (@ct, @userID)
GO
/****** Object:  StoredProcedure [dbo].[GetAccessMenuTypes]    Script Date: 08/01/2014 14:09:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAccessMenuTypes]
AS
	SET NOCOUNT ON;
SELECT DISTINCT datType
FROM            opt_access_codes
GO
/****** Object:  StoredProcedure [dbo].[GetAccessCodes]    Script Date: 08/01/2014 14:09:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAccessCodes]
(
	@type varchar(250)
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datControlName, datType
FROM            opt_access_codes
WHERE        (datType = @type)
GO
/****** Object:  StoredProcedure [dbo].[GetEveryAccessCode]    Script Date: 08/01/2014 14:09:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEveryAccessCode]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datControlName, datType
FROM            opt_access_codes
GO
/****** Object:  StoredProcedure [dbo].[GetAllMenuItems]    Script Date: 08/01/2014 14:09:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllMenuItems]
AS
	SET NOCOUNT ON;
SELECT     datID, datDescription, datControlName, datType, datControlType
FROM         opt_access_codes
GO
/****** Object:  StoredProcedure [dbo].[GetMenuItems]    Script Date: 08/01/2014 14:10:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMenuItems]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        sys_access_codes.datID, sys_access_codes.datUserID, sys_access_codes.datCode, sys_access_codes.datestamp, sys_access_codes.datAssignedBy, 
                         opt_access_codes.datControlName, opt_access_codes.datDescription, opt_access_codes.datType, opt_access_codes.datID AS optAccessID
FROM            sys_access_codes INNER JOIN
                         opt_access_codes ON sys_access_codes.datCode = opt_access_codes.datID
WHERE        (sys_access_codes.datUserID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptEnterprise]    Script Date: 08/01/2014 14:10:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptEnterprise]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_enterprises.datEnterpriseName, tbl_enterprises.datTelephoneNumber, tbl_enterprises.datFaxNumber, tbl_enterprises.datPhysicalAddress, 
                         tbl_enterprises.datActivity, tbl_enterprises.datRegistrationDate, tbl_enterprises.datRegistrationNumber, opt_residential_statuses.datDescription AS premises, 
                         tbl_enterprises.datOccupancy, opt_enterprise_sectors.datDescription AS sector
FROM            tbl_enterprises INNER JOIN
                         opt_residential_statuses ON tbl_enterprises.datPremises = opt_residential_statuses.datID INNER JOIN
                         opt_enterprise_sectors ON tbl_enterprises.datSector = opt_enterprise_sectors.datID
WHERE        (tbl_enterprises.datApplicationID = @AppID) AND (tbl_enterprises.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptFees]    Script Date: 08/01/2014 14:10:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptFees]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        opt_fee_types.datDescription AS Fee, tbl_fees.datAmount, tbl_fees.datPercentage, opt_fee_payment_modes.datDescription AS paymentmode
FROM            tbl_fees INNER JOIN
                         opt_fee_types ON tbl_fees.datFeeTypeID = opt_fee_types.datID INNER JOIN
                         opt_fee_payment_modes ON tbl_fees.datFeePaymentID = opt_fee_payment_modes.datID
WHERE        (tbl_fees.datApplicationID = @AppID) AND (tbl_fees.datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertFeePayment]    Script Date: 08/01/2014 14:11:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFeePayment]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_fee_payment_modes
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[GetFeePayment]    Script Date: 08/01/2014 14:09:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFeePayment]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_fee_payment_modes
GO
/****** Object:  StoredProcedure [dbo].[UpdateFeePayment]    Script Date: 08/01/2014 14:12:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFeePayment]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_fee_payment_modes
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[getLoanFees]    Script Date: 08/01/2014 14:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getLoanFees]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_fees.datID, tbl_fees.datClientID, tbl_fees.datApplicationID, opt_fee_types.datDescription AS feetype, opt_fee_payment_modes.datDescription AS paymentmode, 
                      tbl_fees.datPercentage, tbl_fees.datAmount, tbl_fees.datFeeTypeID, tbl_fees.datFeePaymentID
FROM         tbl_fees INNER JOIN
                      opt_fee_payment_modes ON tbl_fees.datFeePaymentID = opt_fee_payment_modes.datID INNER JOIN
                      opt_fee_types ON tbl_fees.datFeeTypeID = opt_fee_types.datID
WHERE     (tbl_fees.datApplicationID = @AppID) AND (tbl_fees.datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[GetFeePaymentDetails]    Script Date: 08/01/2014 14:09:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFeePaymentDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_fee_payment_modes
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetPaymentVoucher1]    Script Date: 08/01/2014 14:10:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPaymentVoucher1]
(
	@ClientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_payment_vouchers.datID, tbl_payment_vouchers.datDescription, tbl_payment_vouchers.datReference, tbl_payment_vouchers.datAmount, 
                      tbl_payment_vouchers.datFeePaymentID, opt_fee_payment_modes.datDescription AS feepayment
FROM         tbl_payment_vouchers INNER JOIN
                      opt_fee_payment_modes ON tbl_payment_vouchers.datFeePaymentID = opt_fee_payment_modes.datID
WHERE     (tbl_payment_vouchers.datClientID = @ClientID) AND (tbl_payment_vouchers.datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[GetPaymentVoucherDetail]    Script Date: 08/01/2014 14:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPaymentVoucherDetail]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_payment_vouchers.datID, tbl_payment_vouchers.datDescription, tbl_payment_vouchers.datReference, tbl_payment_vouchers.datAmount, 
                         opt_fee_payment_modes.datDescription AS feepayment
FROM            tbl_payment_vouchers INNER JOIN
                         opt_fee_payment_modes ON tbl_payment_vouchers.datFeePaymentID = opt_fee_payment_modes.datID
WHERE        (tbl_payment_vouchers.datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertRollOverApplication]    Script Date: 08/01/2014 14:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertRollOverApplication]
(
	@ClientID int,
	@ClientName varchar(255),
	@datInvestmentAmount decimal(20, 2),
	@datInvestmentType int,
	@datTeamID int,
	@RollOverID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_investment_application
                         (datClientID, datClientName, datInvestmentAmount, datInvestmentType, datTeamID, status, datApplicationStatus, datRollOverID)
VALUES        (@ClientID,@ClientName,@datInvestmentAmount,@datInvestmentType,@datTeamID, 1, 10,@RollOverID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateInvestmentApp]    Script Date: 08/01/2014 14:12:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateInvestmentApp]
(
	@InvestmentName varchar(250),
	@clientname varchar(255),
	@AppNo varchar(20),
	@additionalAmt decimal(20, 2),
	@term int,
	@InvAmt decimal(20, 2),
	@type int,
	@IntRatePerAnnum decimal(20, 2),
	@freqIntPayment int,
	@modepayment int,
	@fund varchar(255),
	@verified int,
	@InvAppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_investment_application
SET                datInvestmentName = @InvestmentName, datClientName = @clientname, datApplicationNumber = @AppNo, datAdditionalAmt = @additionalAmt, datTerms = @term, datInvestmentAmount = @InvAmt, 
                         datInvestmentType = @type, datInterestRatePerAnnum = @IntRatePerAnnum, datFrequencyOfInterestPayment = @freqIntPayment, datModeOfRepayment = @modepayment, datFunds = @fund, 
                         datVerified = @verified
WHERE        (datID = @InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[DeleteInvAlert]    Script Date: 08/01/2014 14:09:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteInvAlert]
(
	@InvAppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_investment_application
SET                datAlert = NULL
WHERE        (datID = @InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertInvestmentApplication]    Script Date: 08/01/2014 14:11:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInvestmentApplication]
(
	@ClientID int,
	@clientname varchar(255),
	@type int,
	@branchID int
)
AS
	SET NOCOUNT ON;
INSERT INTO tbl_investment_application(datClientID, datClientName, datInvestmentType, datAdvise, modifiedDate, datTeamID, datApplicationStatus) VALUES (@ClientID, @clientname, @type, 'Empty', GETDATE(), @branchID, 1)
GO
/****** Object:  StoredProcedure [dbo].[SaveInvAlert]    Script Date: 08/01/2014 14:12:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SaveInvAlert]
(
	@alert text,
	@InvAppID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_investment_application
SET                datAlert = @alert
WHERE        (datID = @InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[GetAlert]    Script Date: 08/01/2014 14:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlert]
(
	@InvAppID int
)
AS
	SET NOCOUNT ON;
SELECT        datAlert
FROM            tbl_investment_application
WHERE        (datID = @InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[GetInvestmentApp]    Script Date: 08/01/2014 14:09:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvestmentApp]
(
	@InvID int
)
AS
	SET NOCOUNT ON;
SELECT datInvestmentName, datApplicationNumber, datClientID, datClientName, datInvestmentType, datTerms, datInvestmentAmount, datAdditionalAmt, datInterestRatePerAnnum, datFrequencyOfInterestPayment, datModeOfRepayment, datFunds, datVerified, datAdvise, datValueDate, datAlert, datTeamID, datBranchManagerID, datCreditTeamID, datAreaManagerID, datRollOverID, datApplicationStatus, status, modifiedDate, userID FROM tbl_investment_application WHERE (datID = @InvID)
GO
/****** Object:  StoredProcedure [dbo].[GetFeeTypeID]    Script Date: 08/01/2014 14:09:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFeeTypeID]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_fee_types
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetFeeType]    Script Date: 08/01/2014 14:09:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFeeType]
AS
	SET NOCOUNT ON;
SELECT        datDescription, datID
FROM            opt_fee_types
GO
/****** Object:  StoredProcedure [dbo].[InsertFeeType]    Script Date: 08/01/2014 14:11:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFeeType]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_fee_types
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[GetFinanceAccTypes]    Script Date: 08/01/2014 14:09:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFinanceAccTypes]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_finance_acc_types
GO
/****** Object:  StoredProcedure [dbo].[InsertFinanceAccTypes]    Script Date: 08/01/2014 14:11:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertFinanceAccTypes]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_finance_acc_types
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[GetFinanceAccTypesDetails]    Script Date: 08/01/2014 14:09:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFinanceAccTypesDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_finance_acc_types
WHERE        (datID = @ID)
GO
/****** Object:  UserDefinedFunction [dbo].[getOptFinCategories]    Script Date: 08/01/2014 14:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptFinCategories]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT  @return = datDescription
FROM         opt_finance_acc_types
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[UpdateFinanceAccountType]    Script Date: 08/01/2014 14:12:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFinanceAccountType]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_finance_acc_types
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  UserDefinedFunction [dbo].[getOptInvType]    Script Date: 08/01/2014 14:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptInvType]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT  @return = datDescription
FROM         opt_investment_types
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[DeleteAccessRights]    Script Date: 08/01/2014 14:09:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAccessRights]
(
	@userID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM sys_access_codes
WHERE        (datUserID = @userID)
GO
/****** Object:  StoredProcedure [dbo].[InsertQuery]    Script Date: 08/01/2014 14:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertQuery]
(
	@userID int,
	@code int,
	@assignedBy int
)
AS
	SET NOCOUNT OFF;
INSERT INTO sys_access_codes
                         (datUserID, datCode, datestamp, datAssignedBy)
VALUES        (@userID,@code, GETDATE(),@assignedBy)
GO
/****** Object:  StoredProcedure [dbo].[GetAllAccessRights]    Script Date: 08/01/2014 14:09:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllAccessRights]
(
	@userID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datUserID, datCode, datestamp, datAssignedBy
FROM            sys_access_codes
WHERE        (datUserID = @userID)
GO
/****** Object:  StoredProcedure [dbo].[InsertUserAccessRight]    Script Date: 08/01/2014 14:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUserAccessRight]
(
	@userID int,
	@code int
)
AS
	SET NOCOUNT OFF;
INSERT INTO sys_access_codes
                         (datUserID, datCode, datestamp)
VALUES        (@userID,@code, GETDATE())
GO
/****** Object:  UserDefinedFunction [dbo].[getOptInvFrequency]    Script Date: 08/01/2014 14:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptInvFrequency]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	SELECT  @return = datDescription
FROM         opt_frequencies_investments
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getOptGender]    Script Date: 08/01/2014 14:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptGender]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	SELECT   @return =datDescription
FROM         opt_genders
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetInvBankers]    Script Date: 08/01/2014 14:09:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvBankers]
(
	@InvAppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datClientID, datApplicationID, datApplicationID1, datBank, datAccountName, datBranch, datAccountType, datAccountNo, status
FROM            tblBankers
WHERE        (datApplicationID1 = @InvAppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertInvBankers]    Script Date: 08/01/2014 14:11:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInvBankers]
(
	@clientID int,
	@InvAppID int,
	@bank varchar(100),
	@AcName varchar(50),
	@branch varchar(100),
	@acctype varchar(100),
	@accno varchar(100),
	@status int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tblBankers
                         (datClientID, datApplicationID1, datBank, datAccountName, datBranch, datAccountType, datAccountNo, status, modifiedDate, userID)
VALUES        (@clientID,@InvAppID,@bank,@AcName,@branch,@acctype,@accno,@status, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateInvBankers]    Script Date: 08/01/2014 14:12:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateInvBankers]
(
	@bank varchar(100),
	@AccName varchar(50),
	@branch varchar(100),
	@AccType varchar(100),
	@AccNo varchar(100),
	@status int,
	@userID int,
	@datID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tblBankers
SET                datBank = @bank, datAccountName = @AccName, datBranch = @branch, datAccountType = @AccType, datAccountNo = @AccNo, status = @status, userID = @userID, modifiedDate = GETDATE()
WHERE        (datID = @datID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptGuarantor]    Script Date: 08/01/2014 14:10:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptGuarantor]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_guarantor.datFullName, opt_gorr.datDescription AS gorr, tbl_guarantor.datRelationship, tbl_guarantor.datNumberOfYears, 
                         opt_nationalities.datDescription AS nationality, tbl_guarantor.datDateOfBirth, tbl_guarantor.datMobileNumber, tbl_guarantor.datHomeTelephoneNumber, 
                         tbl_guarantor.datOfficeTelephoneNUmber, tbl_guarantor.datEmailAddress, tbl_guarantor.datResidentialAddress, tbl_guarantor.datOfficeAddress
FROM            tbl_guarantor INNER JOIN
                         opt_gorr ON tbl_guarantor.datGORR = opt_gorr.datID INNER JOIN
                         opt_nationalities ON tbl_guarantor.datNationalityID = opt_nationalities.datID
WHERE        (tbl_guarantor.datApplicationID = @AppID) AND (tbl_guarantor.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[getGuarantor]    Script Date: 08/01/2014 14:09:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getGuarantor]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_guarantor.datID, tbl_guarantor.datClientID, tbl_guarantor.datApplicationID, tbl_guarantor.datGORR, tbl_guarantor.datFullName, tbl_guarantor.datRelationship, 
                      tbl_guarantor.datNumberOfYears, tbl_guarantor.datNationalityID, tbl_guarantor.datDateOfBirth, tbl_guarantor.datMobileNumber, 
                      tbl_guarantor.datHomeTelephoneNumber, tbl_guarantor.datOfficeTelephoneNUmber, tbl_guarantor.datEmailAddress, tbl_guarantor.datResidentialAddress, 
                      tbl_guarantor.datOfficeAddress, tbl_guarantor.status, tbl_guarantor.modifiedDate, tbl_guarantor.userID, opt_gorr.datDescription AS gorr
FROM         tbl_guarantor INNER JOIN
                      opt_gorr ON tbl_guarantor.datGORR = opt_gorr.datID
WHERE     (tbl_guarantor.datClientID = @clientID) AND (tbl_guarantor.datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateInvSupportingDocs]    Script Date: 08/01/2014 14:12:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateInvSupportingDocs]
(
	@filename varchar(250),
	@description varchar(255),
	@filepath varchar(250),
	@userID int,
	@datID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_supporting_documents
SET                datFileName = @filename, datDescription = @description, datFilePath = @filepath, modifiedDate = GETDATE(), userID = @userID
WHERE        (datID = @datID)
GO
/****** Object:  StoredProcedure [dbo].[InsertInvSupportingDocs]    Script Date: 08/01/2014 14:11:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInvSupportingDocs]
(
	@ClientID int,
	@InvAppID int,
	@filename varchar(250),
	@description varchar(255),
	@filepath varchar(250),
	@status int,
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_supporting_documents
                         (datClientID, datApplicationID1, datFileName, datDescription, datFilePath, status, modifiedDate, userID)
VALUES        (@ClientID,@InvAppID,@filename,@description,@filepath,@status, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[GetInvSupportingDocs]    Script Date: 08/01/2014 14:09:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvSupportingDocs]
(
	@ClientID int,
	@InvAppID int
)
AS
	SET NOCOUNT ON;
SELECT        datFileName, datDescription, datFilePath, datID
FROM            tbl_supporting_documents
WHERE        (datClientID = @ClientID) AND (datApplicationID1 = @InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[InsertInterestRateDetails]    Script Date: 08/01/2014 14:11:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInterestRateDetails]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_interest_rate_types
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[UpdateInterestRateTypes]    Script Date: 08/01/2014 14:12:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateInterestRateTypes]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_interest_rate_types
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetInterestRateTypesDetails]    Script Date: 08/01/2014 14:09:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInterestRateTypesDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_interest_rate_types
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetInterestRateTypes]    Script Date: 08/01/2014 14:09:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInterestRateTypes]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_interest_rate_types
GO
/****** Object:  StoredProcedure [dbo].[loanDetails]    Script Date: 08/01/2014 14:11:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[loanDetails]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_loan_application.datLoanAmount, tbl_loan_application.datDuration, tbl_loan_application.datInterestRate, tbl_loan_application.datInterestRateType, 
                      opt_interest_rate_types.datDescription AS interestratetype, opt_loan_types.datDescription AS loantype, tbl_loan_application.datFirstPaymentDate
FROM         tbl_loan_application INNER JOIN
                      opt_loan_types ON tbl_loan_application.datLoanType = opt_loan_types.datID INNER JOIN
                      opt_interest_rate_types ON tbl_loan_application.datInterestRateType = opt_interest_rate_types.datID
WHERE     (tbl_loan_application.datID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateRoles]    Script Date: 08/01/2014 14:13:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateRoles]
(
	@description varchar(250),
	@approval decimal(20, 2),
	@session int,
	@email varchar(120),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_levels
SET                datDescription = @description, datApprovalLimit = @approval, datSessionDuration = @session, datEmailAddress = @email
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertRole]    Script Date: 08/01/2014 14:11:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertRole]
(
	@description varchar(250),
	@approvalLimit decimal(20, 2),
	@session int,
	@emailAddress varchar(120)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_levels
                         (datDescription, datApprovalLimit, datSessionDuration, datEmailAddress)
VALUES        (@description,@approvalLimit,@session,@emailAddress)
GO
/****** Object:  StoredProcedure [dbo].[GetRolesDetail]    Script Date: 08/01/2014 14:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRolesDetail]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datApprovalLimit, datSessionDuration, datEmailAddress
FROM            opt_levels
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetRoles]    Script Date: 08/01/2014 14:10:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRoles]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datApprovalLimit, datSessionDuration, datEmailAddress
FROM            opt_levels
GO
/****** Object:  StoredProcedure [dbo].[InsertApprovalLimits]    Script Date: 08/01/2014 14:10:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertApprovalLimits]
(
	@description varchar(250),
	@approvalLimit decimal(20, 2),
	@sessionduration int,
	@emailAddress varchar(120)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_levels
                         (datDescription, datApprovalLimit, datSessionDuration, datEmailAddress)
VALUES        (@description,@approvalLimit,@sessionduration,@emailAddress)
GO
/****** Object:  StoredProcedure [dbo].[GetApprovalLimit]    Script Date: 08/01/2014 14:09:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetApprovalLimit]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datApprovalLimit
FROM            opt_levels
WHERE        (datID = @ID)
GO
/****** Object:  UserDefinedFunction [dbo].[getOptLevel]    Script Date: 08/01/2014 14:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptLevel]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT  @return= datDescription
	FROM         opt_levels
	WHERE datID= @ID
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetApprovalLevel]    Script Date: 08/01/2014 14:09:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetApprovalLevel]
(
	@description varchar(250)
)
AS
	SET NOCOUNT ON;
SELECT        datDescription, datApprovalLimit, datSessionDuration, datEmailAddress, datID
FROM            opt_levels
WHERE        (datDescription = @description)
GO
/****** Object:  StoredProcedure [dbo].[UpdateApprovalLevel]    Script Date: 08/01/2014 14:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateApprovalLevel]
(
	@description varchar(250),
	@approvalLimit decimal(20, 2),
	@sessionduration int,
	@emailaddress varchar(120),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_levels
SET                datDescription = @description, datApprovalLimit = @approvalLimit, datSessionDuration = @sessionduration, datEmailAddress = @emailaddress
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetIndustry]    Script Date: 08/01/2014 14:09:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIndustry]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_industry
GO
/****** Object:  StoredProcedure [dbo].[UpdateIndustry]    Script Date: 08/01/2014 14:12:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateIndustry]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_industry
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertIndustry]    Script Date: 08/01/2014 14:11:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertIndustry]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_industry
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[GetIndustryDetails]    Script Date: 08/01/2014 14:09:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIndustryDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_industry
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAORS]    Script Date: 08/01/2014 14:12:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAORS]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_aors
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertAORS]    Script Date: 08/01/2014 14:10:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAORS]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_aors
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[GetInvContactPerson]    Script Date: 08/01/2014 14:09:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvContactPerson]
(
	@InvAppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datFullname, datMobileNumber, datTelephoneNumber, datEmailAddress, datFaxNumber, datPhysicalAddress, datID
FROM            tbl_contact_person
WHERE        (datApplicationID1 = @InvAppID) AND (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertContactPerson]    Script Date: 08/01/2014 14:10:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertContactPerson]
(
	@datClientID int,
	@fullname varchar(100),
	@mobileno varchar(20),
	@telno varchar(20),
	@email varchar(255),
	@physicalAddress varchar(255),
	@fax varchar(20),
	@InvAppID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_contact_person
                         (datClientID, datFullname, datMobileNumber, datTelephoneNumber, datEmailAddress, datPhysicalAddress, datFaxNumber, datApplicationID1)
VALUES        (@datClientID,@fullname,@mobileno,@telno,@email,@physicalAddress,@fax,@InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateIdentification]    Script Date: 08/01/2014 14:12:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateIdentification]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_identification_types
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertIdentification]    Script Date: 08/01/2014 14:11:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertIdentification]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_identification_types
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[GetIdentificationDetails]    Script Date: 08/01/2014 14:09:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIdentificationDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_identification_types
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertInvNextOfKin]    Script Date: 08/01/2014 14:11:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInvNextOfKin]
(
	@fullname varchar(250),
	@clientID int,
	@InvAppID int,
	@mobile varchar(20),
	@hometel varchar(20),
	@officetel varchar(20),
	@email varchar(150),
	@address varchar(255),
	@pshare decimal(3, 0),
	@userID int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_next_of_kin
                         (datFullName, datClientID, datApplicationID1, datMobileNumber, datHomeTelephoneNumber, datOfficeTelephoneNumber, datEmailAddress, datAddress, datPercentageShare, status, modifiedDate, userID)
VALUES        (@fullname,@clientID,@InvAppID,@mobile,@hometel,@officetel,@email,@address,@pshare, 1, GETDATE(),@userID)
GO
/****** Object:  StoredProcedure [dbo].[getInvNextOfKins]    Script Date: 08/01/2014 14:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getInvNextOfKins]
(
	@clientID int,
	@InvAppID int
)
AS
	SET NOCOUNT ON;
SELECT     datID, datFullName, datMobileNumber, datHomeTelephoneNumber, datOfficeTelephoneNumber, datEmailAddress, datPercentageShare, datAddress, 
                      datRelationship
FROM         tbl_next_of_kin
WHERE     (datClientID = @clientID) AND (datApplicationID1 = @InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[GetInvNextOfKin]    Script Date: 08/01/2014 14:09:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvNextOfKin]
(
	@InvAppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT        datFullName, datRelationship, datMobileNumber, datHomeTelephoneNumber, datOfficeTelephoneNumber, datEmailAddress, datPercentageShare, datAddress, status, modifiedDate, userID
FROM            tbl_next_of_kin
WHERE        (datApplicationID1 = @InvAppID) AND (datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateInvNextOfKin]    Script Date: 08/01/2014 14:12:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateInvNextOfKin]
(
	@fullname varchar(250),
	@mobile varchar(20),
	@hometel varchar(20),
	@officetel varchar(20),
	@email varchar(150),
	@pshare decimal(3, 0),
	@address varchar(255),
	@userID int,
	@datID int
)
AS
	SET NOCOUNT OFF;
UPDATE tbl_next_of_kin SET datFullName = @fullname, datMobileNumber = @mobile, datHomeTelephoneNumber = @hometel, datOfficeTelephoneNumber = @officetel, datEmailAddress = @email, datPercentageShare = @pshare, datAddress = @address, status = 1, modifiedDate = GETDATE(), userID = @userID WHERE (datID = @datID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateListHeaders]    Script Date: 08/01/2014 14:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateListHeaders]
(
	@order int,
	@description varchar(50),
	@view int,
	@stage int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_list_headers
SET                datOrder = @order, datDescription = @description, datView = @view, datStage = @stage
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertListHeaders]    Script Date: 08/01/2014 14:11:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertListHeaders]
(
	@order int,
	@description varchar(50),
	@view int,
	@stage int
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_list_headers
                         (datOrder, datDescription, datView, datStage)
VALUES        (@order,@description,@view,@stage)
GO
/****** Object:  StoredProcedure [dbo].[GetListHeadersStage]    Script Date: 08/01/2014 14:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetListHeadersStage]
(
	@stage int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datOrder, datDescription, datView, datStage
FROM            opt_list_headers
WHERE        (datStage = @stage)
GO
/****** Object:  StoredProcedure [dbo].[GetListHeaders]    Script Date: 08/01/2014 14:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetListHeaders]
AS
	SET NOCOUNT ON;
SELECT        datID, datOrder, datDescription, datView, datStage
FROM            opt_list_headers
GO
/****** Object:  StoredProcedure [dbo].[GetCheckListChild]    Script Date: 08/01/2014 14:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCheckListChild]
	@ID int
AS
	SET NOCOUNT ON;
SELECT        datID, datOrder, datDescription, datView, datCount, datStage, datParentID, datType
FROM            opt_checklist_Items
WHERE        (datParentID=@ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateQuery]    Script Date: 08/01/2014 14:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateQuery]
(
	@order int,
	@description varchar(350),
	@view int,
	@count int,
	@stage int,
	@parentid int,
	@typeid varchar(150)
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_checklist_Items
SET                datOrder = @order, datDescription = @description, datView = @view, datCount = @count, datStage = @stage, datParentID = @parentid, datType = @typeid
GO
/****** Object:  StoredProcedure [dbo].[InsertCheckListItem]    Script Date: 08/01/2014 14:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertCheckListItem]
(
	@order int,
	@description varchar(350),
	@view int,
	@count int,
	@stage int,
	@parentid int,
	@type varchar(150)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_checklist_Items
                         (datOrder, datDescription, datView, datCount, datStage, datParentID, datType)
VALUES        (@order,@description,@view,@count,@stage,@parentid,@type)
GO
/****** Object:  StoredProcedure [dbo].[UpdateCheckListItem]    Script Date: 08/01/2014 14:12:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCheckListItem]
(
	@order int,
	@description varchar(350),
	@view int,
	@count int,
	@stage int,
	@parentid int,
	@typeid varchar(150),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_checklist_Items
SET                datOrder = @order, datDescription = @description, datView = @view, datCount = @count, datStage = @stage, datParentID = @parentid, datType = @typeid
WHERE datID=@ID
GO
/****** Object:  StoredProcedure [dbo].[GetAllCheckListItem]    Script Date: 08/01/2014 14:09:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllCheckListItem]
AS
	SET NOCOUNT ON;
SELECT        datID, datOrder, datDescription, datView, datCount, datStage, datParentID, datType
FROM            opt_checklist_Items
GO
/****** Object:  StoredProcedure [dbo].[GetCheckListSubHeaders]    Script Date: 08/01/2014 14:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCheckListSubHeaders]
AS
	SET NOCOUNT ON;
SELECT        datID, datOrder, datDescription, datView, datCount, datStage, datParentID, datType
FROM            opt_checklist_Items
WHERE        (datType = 'subheaders')
GO
/****** Object:  StoredProcedure [dbo].[GetCheckListHeaders]    Script Date: 08/01/2014 14:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCheckListHeaders]
AS
	SET NOCOUNT ON;
SELECT        datID, datOrder, datDescription, datView, datCount, datStage, datParentID, datType
FROM            opt_checklist_Items
WHERE        (datType = 'header')
GO
/****** Object:  StoredProcedure [dbo].[GetSetupDetails]    Script Date: 08/01/2014 14:10:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSetupDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datCompanyname, datAddresss, datEmail, datTelephoneNumber, datLocation, datWebsite, datestamp,logo
FROM            tblSetupDetails
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptSetupDetails]    Script Date: 08/01/2014 14:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptSetupDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datCompanyname, datAddresss, datEmail, datTelephoneNumber, datLocation, datWebsite, datestamp
FROM            tblSetupDetails
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertSetupDetails]    Script Date: 08/01/2014 14:11:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertSetupDetails]
(
	@company varchar(180),
	@address varchar(250),
	@email varchar(180),
	@telephone varchar(20),
	@location varchar(150),
	@website varchar(130),
	@image image
)
AS
	SET NOCOUNT OFF;
INSERT INTO tblSetupDetails
                      (datCompanyname, datAddresss, datEmail, datTelephoneNumber, datLocation, datWebsite, datestamp, logo)
VALUES     (@company,@address,@email,@telephone,@location,@website, GETDATE(),@image)
GO
/****** Object:  StoredProcedure [dbo].[UpdateSetupDetails]    Script Date: 08/01/2014 14:13:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSetupDetails]
(
	@company varchar(180),
	@address varchar(250),
	@email varchar(180),
	@telephone varchar(20),
	@location varchar(150),
	@website varchar(130),
	@image image,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE    tblSetupDetails
SET              datCompanyname = @company, datAddresss = @address, datEmail = @email, datTelephoneNumber = @telephone, datLocation = @location, datWebsite = @website, datestamp = GETDATE(), 
                      logo = @image
WHERE     (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLoanPurpose]    Script Date: 08/01/2014 14:12:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLoanPurpose]
(
	@description varchar(100),
	@view int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_loan_purpose
SET                datDescription = @description, datView = @view
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertLoanPurpose]    Script Date: 08/01/2014 14:11:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertLoanPurpose]
(
	@description varchar(100),
	@view int
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_loan_purpose
                         (datDescription, datView)
VALUES        (@description,@view)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanPurposeDetails]    Script Date: 08/01/2014 14:10:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanPurposeDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datView
FROM            opt_loan_purpose
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanPurpose]    Script Date: 08/01/2014 14:10:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanPurpose]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription, datView
FROM            opt_loan_purpose
GO
/****** Object:  UserDefinedFunction [dbo].[getOptLoanPurpose]    Script Date: 08/01/2014 14:13:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptLoanPurpose]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT   @return = datDescription
FROM         opt_loan_purpose
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetInvTempTransactions1]    Script Date: 08/01/2014 14:09:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvTempTransactions1]
(
	@InvAppID int
)
AS
	SET NOCOUNT ON;
SELECT     tempTransaction.datDescription, tempTransaction.datPaymentMethod, tempTransaction.datAccountID, tempTransaction.datDebit, tempTransaction.datCredit, 
                      tempTransaction.datTotal, tempTransaction.datIndex, tempTransaction.datApplicationID, opt_payment_modes.datDescription AS paymentmethod, 
                      sys_ledgers.datDescription AS AccountName
FROM         tempTransaction INNER JOIN
                      opt_payment_modes ON tempTransaction.datPaymentMethod = opt_payment_modes.datID INNER JOIN
                      sys_ledgers ON tempTransaction.datAccountID = sys_ledgers.datID
WHERE     (tempTransaction.datApplicationID1 = @InvAppID)
ORDER BY tempTransaction.datIndex  ASC
GO
/****** Object:  StoredProcedure [dbo].[GetInvTempTransactions]    Script Date: 08/01/2014 14:09:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvTempTransactions]
(
	@InvAppID int
)
AS
	SET NOCOUNT ON;
SELECT        datDescription, datPaymentMethod, datAccountID, datDebit, datCredit, datTotal, datIndex, datApplicationID
FROM            tempTransaction
WHERE        (datApplicationID1 = @InvAppID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLoanType]    Script Date: 08/01/2014 14:12:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLoanType]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_loan_types
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertLoanTypes]    Script Date: 08/01/2014 14:11:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertLoanTypes]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_loan_types
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[GetLoanTypes]    Script Date: 08/01/2014 14:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanTypes]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_loan_types
GO
/****** Object:  StoredProcedure [dbo].[GetLoanType]    Script Date: 08/01/2014 14:10:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLoanType]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_loan_types
WHERE        (datID = @ID)
GO
/****** Object:  UserDefinedFunction [dbo].[getOptLoanType]    Script Date: 08/01/2014 14:13:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptLoanType]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT   @return = datDescription
FROM         opt_loan_types
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[UpdateInvScheduleStatus]    Script Date: 08/01/2014 14:12:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateInvScheduleStatus]
(
	@status int,
	@datID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_inv_pay_sched
SET                datStatus = @status
WHERE        (datID = @datID)
GO
/****** Object:  StoredProcedure [dbo].[GetInvSchedule]    Script Date: 08/01/2014 14:09:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvSchedule]
(
	@InvAccID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datAccountID, datDate, datDays, datAmount, datIntAccrued, datPenalty, datRollOver, datStatus, datDatePaid, datBatchNo, status, modifiedDate, userID
FROM            tbl_inv_pay_sched
WHERE        (datAccountID = @InvAccID)
GO
/****** Object:  StoredProcedure [dbo].[InsertPaymentSch]    Script Date: 08/01/2014 14:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPaymentSch]
(
	@InvAccID int,
	@date datetime,
	@days int,
	@amount decimal(20, 2),
	@rollover decimal(20, 2),
	@status int
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_inv_pay_sched
                         (datAccountID, datDate, datDays, datAmount, datRollOver, datStatus)
VALUES        (@InvAccID,@date,@days,@amount,@rollover,@status)
GO
/****** Object:  StoredProcedure [dbo].[DeleteInvAccID]    Script Date: 08/01/2014 14:09:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteInvAccID]
(
	@InvAccID int
)
AS
	SET NOCOUNT OFF;
DELETE FROM tbl_inv_pay_sched WHERE datAccountID=@InvAccID
GO
/****** Object:  UserDefinedFunction [dbo].[getOptNationality]    Script Date: 08/01/2014 14:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptNationality]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	SELECT  @return=datDescription
FROM         opt_nationalities
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[UpdateNationality]    Script Date: 08/01/2014 14:12:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateNationality]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_nationalities
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetNationality]    Script Date: 08/01/2014 14:10:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNationality]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_nationalities
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetNationalities]    Script Date: 08/01/2014 14:10:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNationalities]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_nationalities
GO
/****** Object:  StoredProcedure [dbo].[InsertNationality]    Script Date: 08/01/2014 14:11:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertNationality]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_nationalities
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[InsertMaritalStatus]    Script Date: 08/01/2014 14:11:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertMaritalStatus]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_marital_statuses
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[UpdateMaritalStatus]    Script Date: 08/01/2014 14:12:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateMaritalStatus]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_marital_statuses
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetMaritalStatus]    Script Date: 08/01/2014 14:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMaritalStatus]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_marital_statuses
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetMaritalStatuses]    Script Date: 08/01/2014 14:10:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMaritalStatuses]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_marital_statuses
GO
/****** Object:  UserDefinedFunction [dbo].[getOptMaritalStatus]    Script Date: 08/01/2014 14:13:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptMaritalStatus]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT    @return = datDescription
FROM         opt_marital_statuses
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getOptModeOfPayment]    Script Date: 08/01/2014 14:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptModeOfPayment]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	SELECT   @return = datDescription
FROM         opt_payment_modes
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetRptPaymentVoucherDetails]    Script Date: 08/01/2014 14:10:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptPaymentVoucherDetails]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_payment_vouchers.datID, tbl_payment_vouchers.datClientID, tbl_payment_vouchers.datApplicationID, tbl_payment_vouchers.datDescription, 
                         tbl_payment_vouchers.datReference, tbl_payment_vouchers.datAmount, opt_payment_modes.datDescription AS paymentmode
FROM            tbl_payment_vouchers INNER JOIN
                         opt_payment_modes ON tbl_payment_vouchers.datFeePaymentID = opt_payment_modes.datID
WHERE        (tbl_payment_vouchers.datApplicationID = @AppID) AND (tbl_payment_vouchers.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetTransactionDetailsAcc1]    Script Date: 08/01/2014 14:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTransactionDetailsAcc1]
(
	@AccID int
)
AS
	SET NOCOUNT ON;
SELECT     tempTransaction.datDescription, tempTransaction.datPaymentMethod, tempTransaction.datAccountID, tempTransaction.datDebit, tempTransaction.datCredit, 
                      tempTransaction.datTotal, tempTransaction.datIndex, tempTransaction.datApplicationID, opt_payment_modes.datDescription AS paymentmethod, 
                      sys_ledgers.datDescription AS AccountName
FROM         tempTransaction INNER JOIN
                      opt_payment_modes ON tempTransaction.datPaymentMethod = opt_payment_modes.datID INNER JOIN
                      sys_ledgers ON tempTransaction.datAccountID = sys_ledgers.datID
WHERE     (tempTransaction.datLoanAccountID = @AccID)
ORDER BY tempTransaction.datIndex  ASC
GO
/****** Object:  StoredProcedure [dbo].[GetTransactionDetails1]    Script Date: 08/01/2014 14:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTransactionDetails1]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT     tempTransaction.datDescription, tempTransaction.datPaymentMethod, tempTransaction.datAccountID, tempTransaction.datDebit, tempTransaction.datCredit, 
                      tempTransaction.datTotal, tempTransaction.datIndex, tempTransaction.datApplicationID, opt_payment_modes.datDescription AS paymentmethod, 
                      sys_ledgers.datDescription AS AccountName
FROM         tempTransaction INNER JOIN
                      opt_payment_modes ON tempTransaction.datPaymentMethod = opt_payment_modes.datID INNER JOIN
                      sys_ledgers ON tempTransaction.datAccountID = sys_ledgers.datID
WHERE     (tempTransaction.datApplicationID = @AppID)
ORDER BY tempTransaction.datIndex  ASC
GO
/****** Object:  UserDefinedFunction [dbo].[getOptRStatus]    Script Date: 08/01/2014 14:13:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptRStatus]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	SELECT  @return = datDescription
FROM         opt_residential_statuses
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getOptPerformance]    Script Date: 08/01/2014 14:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptPerformance]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT   @return = datDescription
FROM         opt_performance
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[InsertArea]    Script Date: 08/01/2014 14:10:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertArea]
(
	@area varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_area
                         (datDescription)
VALUES        (@area)
GO
/****** Object:  StoredProcedure [dbo].[UpdateArea]    Script Date: 08/01/2014 14:12:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateArea]
(
	@area varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_area
SET                datDescription = @area
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetArea]    Script Date: 08/01/2014 14:09:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetArea]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT       datID, datDescription
FROM            opt_area
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdatePremisesStatus]    Script Date: 08/01/2014 14:13:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePremisesStatus]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_premises_statuses
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetPremisesStatusDetails]    Script Date: 08/01/2014 14:10:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPremisesStatusDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_premises_statuses
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertPremisesStatus]    Script Date: 08/01/2014 14:11:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPremisesStatus]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_premises_statuses
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[GetPremisesStatus]    Script Date: 08/01/2014 14:10:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPremisesStatus]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_premises_statuses
GO
/****** Object:  UserDefinedFunction [dbo].[getStage]    Script Date: 08/01/2014 14:14:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getStage]
	(
	@stageID int
	)
RETURNS varchar(300)/* datatype */
AS
	BEGIN
	DECLARE @return VARCHAR(300)
	
SELECT  @return = datStage
FROM    opt_application_status
WHERE     (datID = @stageID)
	RETURN @return
	
END
GO
/****** Object:  UserDefinedFunction [dbo].[getOptProduct]    Script Date: 08/01/2014 14:13:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptProduct]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT    @return = datDescription
FROM         opt_products
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetAssetTypes]    Script Date: 08/01/2014 14:09:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAssetTypes]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_asset_types
GO
/****** Object:  StoredProcedure [dbo].[InsertAssetType]    Script Date: 08/01/2014 14:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertAssetType]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_asset_types
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[GetAssetType]    Script Date: 08/01/2014 14:09:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAssetType]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT       datID, datDescription
FROM            opt_asset_types
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateAssetType]    Script Date: 08/01/2014 14:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAssetType]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_asset_types
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  UserDefinedFunction [dbo].[getOptRegion1]    Script Date: 08/01/2014 14:13:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptRegion1]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	SELECT  @return=datDescription
FROM         opt_region
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetOptRegionDetails]    Script Date: 08/01/2014 14:10:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOptRegionDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_region
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetOptRegion]    Script Date: 08/01/2014 14:10:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOptRegion]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_region
GO
/****** Object:  StoredProcedure [dbo].[InsertRegion]    Script Date: 08/01/2014 14:11:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertRegion]
(
	@description varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_region
                         (datDescription)
VALUES        (@description)
GO
/****** Object:  StoredProcedure [dbo].[UpdateRegion]    Script Date: 08/01/2014 14:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateRegion]
(
	@description varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_region
SET                datDescription = @description
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[getReligion]    Script Date: 08/01/2014 14:10:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getReligion]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_religions.datPlaceOfWorship, tbl_religions.datReligionID, [opt-religion].datDescription AS religion, tbl_religions.datLeader, tbl_religions.datTelephoneNumber, 
                         tbl_religions.datPhysicalAddress, tbl_religions.datID
FROM            tbl_religions INNER JOIN
                         [opt-religion] ON tbl_religions.datReligionID = [opt-religion].datID
WHERE        (tbl_religions.datApplicationID = @AppID) AND (tbl_religions.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetLegders]    Script Date: 08/01/2014 14:09:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLegders]
AS
	SET NOCOUNT ON;
SELECT     datID, datDescription, datLedgerCode, datCategory, datInterest, datProduct, datFee, datVisible, datClientStatement
FROM         sys_ledgers
GO
/****** Object:  StoredProcedure [dbo].[GetLedger]    Script Date: 08/01/2014 14:09:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLedger]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT     datID, datDescription, datLedgerCode, datCategory, datInterest, datProduct, datFee, datVisible, datClientStatement
FROM         sys_ledgers
WHERE     (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[UpdateLedger]    Script Date: 08/01/2014 14:12:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateLedger]
(
	@description varchar(100),
	@ledgercode varchar(50),
	@category int,
	@interest int,
	@product int,
	@fee int,
	@visibility int,
	@clientstatement int,
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE    sys_ledgers
SET              datDescription = @description, datLedgerCode = @ledgercode, datCategory = @category, datInterest = @interest, datProduct = @product, datFee = @fee, datVisible = @visibility, 
                      datClientStatement = @clientstatement
WHERE     (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertLedgers]    Script Date: 08/01/2014 14:11:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertLedgers]
(
	@description varchar(100),
	@ledgercode varchar(50),
	@category int,
	@interest int,
	@product int,
	@fee int,
	@visible int,
	@clientstatement int
)
AS
	SET NOCOUNT OFF;
INSERT INTO sys_ledgers
                      (datDescription, datLedgerCode, datCategory, datInterest, datProduct, datFee, datVisible, datClientStatement)
VALUES     (@description,@ledgercode,@category,@interest,@product,@fee,@visible,@clientstatement)
GO
/****** Object:  StoredProcedure [dbo].[GetClientStatement]    Script Date: 08/01/2014 14:09:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetClientStatement]
(
	@AccountID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_financial_transactions.datID AS ft_datID, tbl_financial_transactions.modifiedDate AS ft_datemodified, 
                         tbl_financial_transactions.datDescription AS ft_datDescription, tbl_financial_transactions.datCreditAccID AS ft_datCreditAccID, 
                         tbl_financial_transactions.datDebitAccID AS ft_datDebitAccID, tbl_financial_transactions.datCreditAccID AS ft_datCreditAccID, 
                         tbl_financial_transactions.datDebitAccID AS ft_datDebitAccID, tbl_financial_transactions.datCreditAmount AS ft_datCreditAmount, 
                         tbl_financial_transactions.datDebitAmount AS ft_datDebitAmount,
						 (tbl_financial_transactions.datCreditAmount-tbl_financial_transactions.datDebitAmount) As sumUp
FROM            tbl_financial_transactions INNER JOIN
                         sys_ledgers ON tbl_financial_transactions.datGLAccount = sys_ledgers.datID
WHERE        (sys_ledgers.datClientStatement = 1 OR
                         sys_ledgers.datClientStatement = 6) AND (tbl_financial_transactions.datAccountID = @AccountID)
ORDER BY ft_datID
GO
/****** Object:  StoredProcedure [dbo].[UpdateGetNextOfKinBeneficiary]    Script Date: 08/01/2014 14:12:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateGetNextOfKinBeneficiary]
(
	@fullname varchar(250),
	@mobile varchar(20),
	@hometel varchar(20),
	@officetel varchar(20),
	@pshare decimal(3, 0),
	@email varchar(50),
	@address varchar(255),
	@status int,
	@userID int,
	@datID int
)
AS
	SET NOCOUNT OFF;
UPDATE       tbl_next_of_kin_inv
SET                datFullName = @fullname, datMobileNumber = @mobile, datHomeTelephoneNumber = @hometel, datOfficeTelephoneNumber = @officetel, datPercentageShare = @pshare, datEmailAddress = @email, 
                         datAddress = @address, status = @status, userID = @userID
WHERE        (datID = @datID)
GO
/****** Object:  StoredProcedure [dbo].[GetNextOfKinBeneficiary]    Script Date: 08/01/2014 14:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetNextOfKinBeneficiary]
(
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datFullName, datMobileNumber, datHomeTelephoneNumber, datOfficeTelephoneNumber, datEmailAddress, datPercentageShare, datAddress
FROM            tbl_next_of_kin_inv
WHERE        (datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[InsertGetNextOfKinBeneficiary]    Script Date: 08/01/2014 14:11:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertGetNextOfKinBeneficiary]
(
	@fullname varchar(250),
	@clientID int,
	@mobile varchar(20),
	@hometel varchar(20),
	@officetel varchar(20),
	@email varchar(50),
	@address varchar(255),
	@pshare decimal(3, 0),
	@userID int
)
AS
	SET NOCOUNT ON;
INSERT INTO tbl_next_of_kin_inv
                         (datFullName, datClientID, datMobileNumber, datHomeTelephoneNumber, datOfficeTelephoneNumber, datEmailAddress, datAddress, datPercentageShare, status, userID)
VALUES        (@fullname,@clientID,@mobile,@hometel,@officetel,@email,@address,@pshare, 1,@userID)
GO
/****** Object:  StoredProcedure [dbo].[InsertRepaymentThreshold]    Script Date: 08/01/2014 14:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertRepaymentThreshold]
(
	@description varchar(50),
	@min decimal(20,2),
	@max decimal(20,2)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_repayment_threshold
                      (datDescription, datMin, datMax)
VALUES     (@description,@min,@max)
GO
/****** Object:  StoredProcedure [dbo].[GetOptRepaymentThreshold]    Script Date: 08/01/2014 14:10:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOptRepaymentThreshold]
AS
	SET NOCOUNT ON;
SELECT     datID, datDescription, datMin, datMax
FROM         opt_repayment_threshold
GO
/****** Object:  StoredProcedure [dbo].[UpdateRepaymentThreshold]    Script Date: 08/01/2014 14:13:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateRepaymentThreshold]
(
	@description varchar(50),
	@min decimal(20,2),
	@max decimal(20,2),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE    opt_repayment_threshold
SET              datDescription = @description, datMin = @min, datMax = @max
WHERE     (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetRepaymentThresholdDetails]    Script Date: 08/01/2014 14:10:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRepaymentThresholdDetails]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT     datID, datDescription, datMin, datMax
FROM         opt_repayment_threshold
WHERE     (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetRptOwnership]    Script Date: 08/01/2014 14:10:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptOwnership]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_ownership.datFullName, tbl_ownership.datDateOfBirth, tbl_ownership.datAge, tbl_ownership.datNationality, tbl_ownership.datResidence, 
                         tbl_ownership.datEducation, tbl_ownership.datAppointment, tbl_ownership.datPercentage, opt_shord.datDescription AS shord
FROM            tbl_ownership INNER JOIN
                         opt_shord ON tbl_ownership.datSHORD = opt_shord.datID
WHERE        (tbl_ownership.datApplicationID = @AppID) AND (tbl_ownership.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[getOwners]    Script Date: 08/01/2014 14:10:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getOwners]
(
	@clientID int,
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_ownership.datID, tbl_ownership.datFullName, tbl_ownership.datDateOfBirth, tbl_ownership.datAge, tbl_ownership.datNationality, tbl_ownership.datResidence, 
                      tbl_ownership.datEducation, tbl_ownership.datAppointment, tbl_ownership.datSHORD, tbl_ownership.datPercentage, opt_shord.datDescription
FROM         tbl_ownership INNER JOIN
                      opt_shord ON tbl_ownership.datSHORD = opt_shord.datID
WHERE     (tbl_ownership.datClientID = @clientID) AND (tbl_ownership.datApplicationID = @AppID)
GO
/****** Object:  UserDefinedFunction [dbo].[getOptTerms]    Script Date: 08/01/2014 14:13:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptTerms]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT   @return =  datDescription
FROM         opt_terms
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[InsertInvCalc]    Script Date: 08/01/2014 14:11:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertInvCalc]
(
	@InvAccID varchar(50),
	@datClientID int,
	@datApplicationID varchar(20),
	@datDateAction text,
	@datPrincipal decimal(20, 2),
	@datIntRate decimal(4, 2),
	@datDay int,
	@datTerm int,
	@datAccrued decimal(20, 2),
	@datDayInt decimal(20, 2)
)
AS
	SET NOCOUNT OFF;
INSERT INTO tbl_invest_calc
                         (datAccountNumber, datClientID, datApplicationID, datDateAction, datPrincipal, datIntRate, datDay, datTerm, datAccrued, datDayInt, status)
VALUES        (@InvAccID,@datClientID,@datApplicationID,@datDateAction,@datPrincipal,@datIntRate,@datDay,@datTerm,@datAccrued,@datDayInt, 1)
GO
/****** Object:  StoredProcedure [dbo].[UpdateTitle]    Script Date: 08/01/2014 14:13:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateTitle]
(
	@title varchar(50),
	@ID int
)
AS
	SET NOCOUNT OFF;
UPDATE       opt_titles
SET                datDescription = @title
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[GetTitle]    Script Date: 08/01/2014 14:10:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTitle]
(
	@ID int
)
AS
	SET NOCOUNT ON;
SELECT        datID,datDescription
FROM            opt_titles
WHERE        (datID = @ID)
GO
/****** Object:  StoredProcedure [dbo].[InsertTitle]    Script Date: 08/01/2014 14:11:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertTitle]
(
	@title varchar(50)
)
AS
	SET NOCOUNT OFF;
INSERT INTO opt_titles
                         (datDescription)
VALUES        (@title)
GO
/****** Object:  UserDefinedFunction [dbo].[getUser]    Script Date: 08/01/2014 14:14:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getUser]
	(
	@userID int
	)
RETURNS varchar(300)/* datatype */
AS
	BEGIN
	DECLARE @return VARCHAR(300)
	
	SELECT   @return =   opt_titles.datDescription + ' ' + sys_users.datFirstnames + ' ' + sys_users.datSurname
FROM         sys_users INNER JOIN
                      opt_titles ON sys_users.datTitle = opt_titles.datID
WHERE     (sys_users.datID = @userID)
	RETURN @return
	END
GO
/****** Object:  UserDefinedFunction [dbo].[getOptTitle]    Script Date: 08/01/2014 14:13:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getOptTitle]
	(
	@ID int = NULL
	)
RETURNS varchar(120)
AS
	BEGIN
	DECLARE @return VARCHAR(120)
	
	SELECT   @return = datDescription
FROM         opt_titles
WHERE     (datID = @ID)
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetTitles]    Script Date: 08/01/2014 14:10:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTitles]
AS
	SET NOCOUNT ON;
SELECT        datID, datDescription
FROM            opt_titles
GO
/****** Object:  UserDefinedFunction [dbo].[getYesNO]    Script Date: 08/01/2014 14:14:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getYesNO]
	(
	@valueID int
	)
RETURNS varchar(3)/* datatype */
AS
	BEGIN
	DECLARE @return VARCHAR(3)
	
	SELECT     @return = datDescription
	FROM            opt_yesno
	WHERE        (datID = @valueID)
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[UpdateInvAccountPenalty]    Script Date: 08/01/2014 14:12:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateInvAccountPenalty]
(
	@datAmount decimal(20, 2),
	@datID int
)
AS
	SET NOCOUNT OFF;
UPDATE tbl_investment_accounts SET datPenalty = @datAmount WHERE (datID = @datID)
GO
/****** Object:  StoredProcedure [dbo].[GetInvAccount]    Script Date: 08/01/2014 14:09:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetInvAccount]
(
	@InvAccID int
)
AS
	SET NOCOUNT ON;
SELECT     datInvestmentName, datApplicationNumber, datClientID, datInvestmentType, datTerms, datInvestmentAmount, datInterestRatePerAnnum, datFrequencyOfInterestPayment, datModeOfRepayment, 
                      datAdvise, datValueDate, datDaysOver, datAlert, datMatured, datIntAccrued, datPrincipal, datTeamID, datBranchManagerID, datCreditTeamID, datAreaManagerID, datRollOverID, datAccountStatus, 
                      datPaymentStatus, datRolloverAmt, datDisinvestAmt, datAdditionalAmt, datPenalty, datActiveAccountStatus, status, modifiedDate, userID, flag1, flag2, flag3, flag4, flag5, flag6, dat30, dat60, dat91, 
                      dat121, dat151, dat182, dat212, dat242, dat273, dat303, dat333, dat364
FROM         tbl_investment_accounts
WHERE     (datID = @InvAccID)
GO
/****** Object:  StoredProcedure [dbo].[authenticateUser]    Script Date: 08/01/2014 14:09:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[authenticateUser]
	(
	@email varchar(200),
	@password varchar(200)
	)
AS
	/* SET NOCOUNT ON */
	
	SELECT        datTitle, datSurname, datFirstnames, datDateOfBirth, datCellNumber, datDateJoined, datAccesCode, datTeam, datLevel, datPosition, datCreatTeamID, datAvailability, 
	              datEmailAddress, datPassword
	FROM            sys_users
	WHERE        (datPassword = @password) AND (datEmailAddress = @email)
	
	
	RETURN
GO
/****** Object:  StoredProcedure [dbo].[updateUser]    Script Date: 08/01/2014 14:13:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[updateUser]
(
	@title varchar(50),
	@sname varchar(50),
	@fname varchar(50),
	@birthdate datetime,
	@cellNumber varchar(25),
	@email varchar(180),
	@password varchar(150),
	@accesscode varchar(150),
	@team int,
	@level int,
	@position varchar(100)
)
AS
	SET NOCOUNT OFF;
UPDATE       sys_users
SET                datTitle = @title, datSurname = @sname, datFirstnames = @fname, datDateOfBirth = @birthdate, datCellNumber = @cellNumber, datEmailAddress = @email, 
                         datPassword = @password, datAccesCode = @accesscode, datTeam = @team, datLevel = @level, datPosition = @position
GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 08/01/2014 14:11:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUser]
(
	@title varchar(50),
	@sname varchar(50),
	@fname varchar(50),
	@birthdate datetime,
	@email varchar(180),
	@cellNumber varchar(25),
	@dateJoined datetime,
	@password varchar(150),
	@accesscode varchar(150),
	@team int,
	@int int,
	@position varchar(100),
	@availability int
)
AS
	SET NOCOUNT OFF;
INSERT INTO sys_users
                      (datTitle, datSurname, datFirstnames, datDateOfBirth, datEmailAddress, datCellNumber, datDateJoined, datPassword, datAccesCode, datTeam, datLevel, datPosition, 
                      datAvailability, status, dateModified, datLastSignedIn)
VALUES     (@title,@sname,@fname,@birthdate,@email,@cellNumber,@dateJoined,@password,@accesscode,@team,@int,@position,@availability, 1, GETDATE(), GETDATE())
GO
/****** Object:  StoredProcedure [dbo].[GetRptComments]    Script Date: 08/01/2014 14:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptComments]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_comments.datRole, tbl_comments.datStage, tbl_comments.datDescription, tbl_comments.datClientID, tbl_comments.datApplicationID, sys_users.datFirstnames, 
                      sys_users.datSurname
FROM         tbl_comments INNER JOIN
                      sys_users ON tbl_comments.userID = sys_users.datID
WHERE     (tbl_comments.datApplicationID = @AppID) AND (tbl_comments.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetSpecificUser]    Script Date: 08/01/2014 14:10:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSpecificUser]
(
	@UserID int
)
AS
	SET NOCOUNT ON;
SELECT        datID, datTitle, datSurname, datFirstnames, datDateOfBirth, datEmailAddress, datCellNumber, datDateJoined, datPassword, datAccesCode, datTeam, datLevel, 
                         datPosition, datCreatTeamID, datAvailability, datLastSignedIn, datIsSignedIn, status, dateModified
FROM            sys_users
WHERE        (datID = @UserID)
GO
/****** Object:  StoredProcedure [dbo].[UpdatePassword]    Script Date: 08/01/2014 14:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePassword]
(
	@password varchar(150),
	@userID int
)
AS
	SET NOCOUNT OFF;
UPDATE       sys_users
SET                datPassword = @password, dateModified = GETDATE()
WHERE        (datID = @userID)
GO
/****** Object:  StoredProcedure [dbo].[validateUserLogin]    Script Date: 08/01/2014 14:13:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[validateUserLogin]
(
	@email varchar(180),
	@password varchar(150)
)
AS
	SET NOCOUNT ON;
SELECT       datID,datTitle, datSurname, datFirstnames, datDateOfBirth, datEmailAddress, datCellNumber, datTeam, datLevel, datPosition, datCreatTeamID, datAvailability, datLastSignedIn, datIsSignedIn
FROM            sys_users
WHERE        (datEmailAddress = @email) AND (datPassword = @password)
GO
/****** Object:  StoredProcedure [dbo].[GetHistoryByDate]    Script Date: 08/01/2014 14:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetHistoryByDate]
(
	@InvAccID int,
	@datAgingDate datetime
)
AS
	SET NOCOUNT ON;
SELECT     datID, datAccountID, datInvestmentName, datApplicationNumber, datClientID, datInvestmentType, datTerms, datInvestmentAmount, datInterestRatePerAnnum, datFrequencyOfInterestPayment, 
                      datModeOfRepayment, datAdvise, datValueDate, datDaysOver, datAlert, datMatured, datPenalty, datIntAccrued, datPrincipal, datTeamID, datBranchManagerID, datCreditTeamID, datAreaManagerID, 
                      datRollOverID, datAccountStatus, datPaymentStatus, datActiveAccountStatus, datRollOverAmt, datDisinvestAmt, status, recUpdate, recUser, flag1, flag2, flag3, flag4, flag5, flag6, dat30, dat60, dat91, 
                      dat121, dat151, dat182, dat212, dat242, dat273, dat303, dat333, dat364, datAgingDate
FROM         tbl_historic_accounts2
WHERE     (datAccountID = @InvAccID) AND (datAgingDate LIKE @datAgingDate)
GO
/****** Object:  StoredProcedure [dbo].[GetHistoricAccount]    Script Date: 08/01/2014 14:09:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetHistoricAccount]
(
	@haID int,
	@InvAccID int
)
AS
	SET NOCOUNT ON;
SELECT     datID, datAccountID, datInvestmentName, datApplicationNumber, datClientID, datInvestmentType, datTerms, datInvestmentAmount, datInterestRatePerAnnum, datFrequencyOfInterestPayment, 
                      datModeOfRepayment, datAdvise, datValueDate, datDaysOver, datAlert, datMatured, datPenalty, datIntAccrued, datPrincipal, datTeamID, datBranchManagerID, datCreditTeamID, datAreaManagerID, 
                      datRollOverID, datAccountStatus, datPaymentStatus, datActiveAccountStatus, datRollOverAmt, datDisinvestAmt, status, recUpdate, recUser, flag1, flag2, flag3, flag4, flag5, flag6, dat30, dat60, dat91, 
                      dat121, dat151, dat182, dat212, dat242, dat273, dat303, dat333, dat364, datAgingDate
FROM         tbl_historic_accounts2
WHERE     (datID = @haID) AND (datAccountID = @InvAccID)
GO
/****** Object:  StoredProcedure [dbo].[UpdatePenaltyHistory2]    Script Date: 08/01/2014 14:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdatePenaltyHistory2]
(
	@Accrued decimal(20, 2),
	@datAmount decimal(20, 2),
	@daID int,
	@datAccountID int
)
AS
	SET NOCOUNT OFF;
UPDATE tbl_historic_accounts2 SET datPaymentStatus = 4, datDisinvestAmt = @Accrued, datPenalty = @datAmount WHERE (datID = @daID) AND (datAccountID = @datAccountID)
GO
/****** Object:  UserDefinedFunction [dbo].[getNoClientsByCategories]    Script Date: 08/01/2014 14:13:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getNoClientsByCategories]
	(
	@catID int,
	@date nvarchar(10),
	@branchID int =NULL,
	@CMID int = NULL	
	)
RETURNS int
AS
	BEGIN
	DECLARE @return int;
	


	if((@branchid =0) AND ((@CMID =0)))
	BEGIN 
			SELECT @return = COUNT(*)  
			FROM tbl_historic_accounts 
			WHERE (datDaysOver >= dbo.getCatMinDays(@catID) AND datDaysOver <=dbo.getCatMaxDays(@catID) ) AND (datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) 
	END
	else if((@branchid !=0) AND ((@CMID =0)))
	BEGIN
			SELECT   @return =  COUNT(*)
			FROM         tbl_historic_accounts INNER JOIN
								  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID INNER JOIN
								  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID
			WHERE     (tbl_historic_accounts.datDaysOver >= dbo.getCatMinDays(@catID)) AND (tbl_historic_accounts.datDaysOver <= dbo.getCatMaxDays(@catID)) AND 
					  (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND br.datID=@branchID
	END
	else if((@BranchID=0) AND (@CMID !=0))
	BEGIN
		SELECT  @return =  COUNT(*)
		FROM         tbl_historic_accounts INNER JOIN
							  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID
		WHERE     (tbl_historic_accounts.datDaysOver >= dbo.getCatMinDays(@catID)) AND (tbl_historic_accounts.datDaysOver <= dbo.getCatMaxDays(@catID)) AND 
                  (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND ct.datID=@CMID 
	END
	if((@BranchID !=0 )AND( @CMID !=0))
	BEGIN
		SELECT  @return =  COUNT(*)
		FROM         tbl_historic_accounts INNER JOIN
							  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID
		WHERE     (tbl_historic_accounts.datDaysOver >= dbo.getCatMinDays(@catID)) AND (tbl_historic_accounts.datDaysOver <= dbo.getCatMaxDays(@catID)) AND 
							  (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND ct.datID=@CMID AND br.datID=@branchID
	END
	else
	BEGIN
		SELECT @return = COUNT(*)  
			FROM tbl_historic_accounts 
			WHERE (datDaysOver >= dbo.getCatMinDays(@catID) AND datDaysOver <=dbo.getCatMaxDays(@catID) ) AND (datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) 
	END
	
	
	
   
     
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[GetRptPaymentVoucher]    Script Date: 08/01/2014 14:10:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptPaymentVoucher]
	@AppID int,
    @ClientID int

AS
	SET NOCOUNT ON;
SELECT     tbl_final_voucher.datID, tbl_final_voucher.datVoucherName, tbl_final_voucher.datVoucherDate, tbl_final_voucher.datVoucherTotalAmount, 
                      tbl_teams.datDescription AS branch, tbl_final_voucher.datAmountInWords, tbl_final_voucher.datPreparedBy, tbl_final_voucher.datApprovedBy, 
                      tbl_final_voucher.datPreparedDate, tbl_final_voucher.datApproveDate, dbo.getUser(tbl_final_voucher.datPreparedBy) AS preparedby, 
                      dbo.getUser(tbl_final_voucher.datApprovedBy) AS approvedby, tbl_client.datClientName
FROM         tbl_final_voucher INNER JOIN
                      tbl_loan_application ON tbl_final_voucher.datApplicationID = tbl_loan_application.datID INNER JOIN
                      tbl_teams ON tbl_loan_application.datTeamID = tbl_teams.datID INNER JOIN
                      tbl_client ON tbl_final_voucher.datClientID = tbl_client.datID
WHERE     (tbl_final_voucher.datApplicationID = @AppID) AND (tbl_final_voucher.datClientID = @ClientID)
GO
/****** Object:  UserDefinedFunction [dbo].[getAmtByCategories]    Script Date: 08/01/2014 14:13:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getAmtByCategories]
	(
	@catID int,
	@date nvarchar(10),
	@branchID int =NULL,
	@CMID int = NULL	
	)
RETURNS decimal(20,2)
AS
	BEGIN
	DECLARE @return decimal(20,2);
	
	if((@branchid =0) AND ((@CMID =0)))
	BEGIN 
			SELECT @return = SUM(datOutstandingAmount) 
			FROM tbl_historic_accounts 
			WHERE (datDaysOver >= dbo.getCatMinDays(@catID) AND datDaysOver <=dbo.getCatMaxDays(@catID) ) AND (datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) 
	END
	else if((@branchid !=0) AND ((@CMID =0)))
	BEGIN
			SELECT   @return =  SUM(datOutstandingAmount) 
			FROM         tbl_historic_accounts INNER JOIN
								  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID INNER JOIN
								  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID
			WHERE     (tbl_historic_accounts.datDaysOver >= dbo.getCatMinDays(@catID)) AND (tbl_historic_accounts.datDaysOver <= dbo.getCatMaxDays(@catID)) AND 
					  (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND br.datID=@branchID
	END
	else if((@BranchID=0) AND (@CMID !=0))
	BEGIN
		SELECT  @return =  SUM(datOutstandingAmount) 
		FROM         tbl_historic_accounts INNER JOIN
							  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID
		WHERE     (tbl_historic_accounts.datDaysOver >= dbo.getCatMinDays(@catID)) AND (tbl_historic_accounts.datDaysOver <= dbo.getCatMaxDays(@catID)) AND 
                  (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND ct.datID=@CMID 
	END
	if((@BranchID !=0 )AND( @CMID !=0))
	BEGIN
		SELECT  @return =  SUM(datOutstandingAmount) 
		FROM         tbl_historic_accounts INNER JOIN
							  sys_credit_teams AS ct ON tbl_historic_accounts.datCreditTeamID = ct.datID INNER JOIN
							  tbl_teams AS br ON tbl_historic_accounts.datTeamID = br.datID
		WHERE     (tbl_historic_accounts.datDaysOver >= dbo.getCatMinDays(@catID)) AND (tbl_historic_accounts.datDaysOver <= dbo.getCatMaxDays(@catID)) AND 
							  (tbl_historic_accounts.datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) AND ct.datID=@CMID AND br.datID=@branchID
	END
	else
	BEGIN
		SELECT @return =SUM(datOutstandingAmount) 
			FROM tbl_historic_accounts 
			WHERE (datDaysOver >= dbo.getCatMinDays(@catID) AND datDaysOver <=dbo.getCatMaxDays(@catID) ) AND (datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME))) 
	END
--			SELECT @return = SUM(datOutstandingAmount) 
--			FROM tbl_historic_accounts 
--			WHERE (datDaysOver >= dbo.getCatMinDays(@catID) AND datDaysOver <=dbo.getCatMaxDays(@catID) ) AND (datAgingDate BETWEEN CAST(@date AS DATETIME) AND DATEADD(DAY, 1, CAST(@date AS DATETIME)))

	if(@return=null)
	BEGIN
		SET @return=0
	END      
	
	RETURN @return
	END
GO
/****** Object:  StoredProcedure [dbo].[Report_Portfolio_Summary]    Script Date: 08/01/2014 14:12:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Portfolio_Summary]
	
	(
		@BranchID int,
		@CMID int,
		@date nvarchar(10)
	)
	
AS
	/* SET NOCOUNT ON */
	
	SELECT     datDescription, dbo.getNoClientByCAT(datID,@date,@BranchID,@CMID) as NoClient,
		   dbo.getLoanAmountByCAT(datID,@date,@BranchID,@CMID) as LoanAmt,
		   dbo.getExpectedAmountByCAT(@date,datID,@BranchID,@CMID) as ExpectedAmt,
		   dbo.GetWeekByCat(1,@date,datID,@BranchID,@CMID) as Week1,
		   dbo.GetWeekByCat(2,@date,datID,@BranchID,@CMID) as Week2,
		   dbo.GetWeekByCat(3,@date,datID,@BranchID,@CMID) as Week3,
		   dbo.GetWeekByCat(4,@date,datID,@BranchID,@CMID) as Week4,
		   dbo.GetWeekByCat(5,@date,datID,@BranchID,@CMID) as Week5,
		   (dbo.GetWeekByCat(1,@date,datID,@BranchID,@CMID)+
			dbo.GetWeekByCat(2,@date,datID,@BranchID,@CMID)+
			dbo.GetWeekByCat(3,@date,datID,@BranchID,@CMID)+
			dbo.GetWeekByCat(4,@date,datID,@BranchID,@CMID)+
			dbo.GetWeekByCat(5,@date,datID,@BranchID,@CMID)) as totalWeek,
			dbo.getOutstandingByCAT(datID,@date,@BranchID,@CMID) as outstanding
			
FROM         opt_categories 
	
RETURN
GO
/****** Object:  StoredProcedure [dbo].[GetRptCollateral]    Script Date: 08/01/2014 14:10:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptCollateral]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_collaterals.datCollateralTypeID, tbl_collaterals.datDescription, tbl_collaterals.datLocation, tbl_collaterals.datValue, tbl_collaterals.datSurety, 
                      tbl_collaterals.datContactPerson, tbl_collaterals.datContactPersonTelephoneNumber, tbl_collaterals.datPhysicalAddress, tbl_collaterals.datConfirmed, 
                      tbl_collaterals.datPicture, tbl_collaterals.status, tbl_collaterals.modifiedDate, tbl_collaterals.datID, tbl_collaterals.datClientID, 
                      opt_collateral_types.datDescription AS CollateralType, dbo.GetYesNo(tbl_collaterals.datSurety)as surety, dbo.GetYesNo(tbl_collaterals.datConfirmed) as confirmed
FROM         tbl_collaterals INNER JOIN
                      opt_collateral_types ON tbl_collaterals.datCollateralTypeID = opt_collateral_types.datID
WHERE     (tbl_collaterals.datApplicationID = @AppID) AND (tbl_collaterals.datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[GetCollateral1]    Script Date: 08/01/2014 14:09:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCollateral1]
(
	@AppID int,
	@clientID int
)
AS
	SET NOCOUNT ON;
SELECT     tbl_collaterals.datCollateralTypeID, tbl_collaterals.datDescription, tbl_collaterals.datLocation, tbl_collaterals.datValue, tbl_collaterals.datSurety, 
                      tbl_collaterals.datContactPerson, tbl_collaterals.datContactPersonTelephoneNumber, tbl_collaterals.datPhysicalAddress, tbl_collaterals.datConfirmed, 
                      tbl_collaterals.datPicture, tbl_collaterals.status, tbl_collaterals.modifiedDate, tbl_collaterals.datID, tbl_collaterals.datClientID, 
                      opt_collateral_types.datDescription AS CollateralType,dbo.getYesNo(tbl_collaterals.datSurety) AS surety,dbo.getYesNO(tbl_collaterals.datConfirmed) as  confirmed
FROM         tbl_collaterals INNER JOIN
                      opt_collateral_types ON tbl_collaterals.datCollateralTypeID = opt_collateral_types.datID
WHERE     (tbl_collaterals.datApplicationID = @AppID) AND (tbl_collaterals.datClientID = @clientID)
GO
/****** Object:  StoredProcedure [dbo].[getUsers]    Script Date: 08/01/2014 14:10:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getUsers]
AS
	SET NOCOUNT ON;
SELECT     sys_users.datTitle, sys_users.datSurname, sys_users.datFirstnames, sys_users.datEmailAddress, sys_users.datCellNumber, sys_users.datID, 
                      opt_titles.datDescription AS title, dbo.getOptLevel(datLevel) as datLevel,dbo.getOptBranch(datTeam) as datBranch
FROM         sys_users INNER JOIN
                      opt_titles ON sys_users.datTitle = opt_titles.datID
GO
/****** Object:  StoredProcedure [dbo].[GetRptCorporateInformation]    Script Date: 08/01/2014 14:10:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRptCorporateInformation]
(
	@AppID int,
	@ClientID int
)
AS
	SET NOCOUNT ON;
SELECT        tbl_corporate_info.datCompanyName, tbl_corporate_info.datCommencementDate, tbl_corporate_info.datYearsInBusiness, opt_industry.datDescription AS industry, 
                         opt_sector.datDescription AS sector, tbl_corporate_info.datPhysicalAddress, tbl_corporate_info.datTelephoneNumber1, tbl_corporate_info.datTelephoneNumber2, 
                         tbl_corporate_info.datFaxNumber, tbl_corporate_info.datNatureOfBusiness, tbl_corporate_info.datPremissesStatus, 
                         dbo.getYesNO(tbl_corporate_info.datIsRegistered) AS IsRegistered, tbl_corporate_info.datRegistrationDate, tbl_corporate_info.datRegistrationNumber, 
                         tbl_corporate_info.datVATNumber, tbl_corporate_info.datTIN, tbl_corporate_info.datWebsite
FROM            tbl_corporate_info INNER JOIN
                         opt_industry ON tbl_corporate_info.datIndustryType = opt_industry.datID INNER JOIN
                         opt_sector ON tbl_corporate_info.datSector = opt_sector.datID
WHERE        (tbl_corporate_info.datApplicationID = @AppID) AND (tbl_corporate_info.datClientID = @ClientID)
GO
/****** Object:  StoredProcedure [dbo].[GetAccountComment]    Script Date: 08/01/2014 14:09:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAccountComment]
(
	@AccID int
)
AS
	SET NOCOUNT ON;
SELECT datID, datDescription, status, modifiedDate, usersID, dbo.getUser(usersID) as datUser FROM tbl_account_comments 
WHERE (datAccountID = @AccID)
GO
/****** Object:  StoredProcedure [dbo].[GetApplicationTrails]    Script Date: 08/01/2014 14:09:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetApplicationTrails]
(
	@AppID int
)
AS
	SET NOCOUNT ON;
SELECT        datApplicationID, dbo.getUser(datFromUser) AS FromUser, dbo.getUser(datToUser) AS ToUser, datDate, dbo.getStage(datStage) AS Stage, datDuration, datTime
FROM            tbl_loan_history
WHERE        (datApplicationID = @AppID)
GO
/****** Object:  StoredProcedure [dbo].[Report_Provision_Summary]    Script Date: 08/01/2014 14:12:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_Provision_Summary]
	
	(
		@BranchID int,
		@CMID int,
		@date nvarchar(10)
	)
	
AS
	/* SET NOCOUNT ON */
	
	SELECT     datDescription, dbo.getNoClientsByCategories(datID,@date,@BranchID,@CMID) as NoClients,dbo.getAmtByCategories(datID,@date,@BranchID,@CMID)  as TotalAmt ,datProvisionFactor,((dbo.getAmtByCategories(datID,@date,@BranchID,@CMID)*datProvisionFactor)/100) as provision
	FROM         opt_categories
	
RETURN
GO
