/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [UserID]
      ,[UserPassword]
      ,[RoleID]
      ,[TransactionPassword]
      ,[IsChanged]
  FROM [DB08H98].[dbo].[tblLogin]
  
/* to display Payee details*/
CREATE procedure usp_displayPayeeDetails
(@CustomerID varchar(10)) 
as begin  
	select tpd.PayeeName 'Payee Name', 
		tpd.PayeeAccountNo 'Payee Account', 
		tpd.PBankName 'Bank', 
		tpd.PBranchName 'Branch', 
		tpd.IFSCCode 'IFSC Code',
		tpd.EmailId 'e-Mail',
		tpd.PayeeType 'Payee Type',
		tr.RequestDate 'Request Date',
		tr.RequestStatus 'Status' 
	from tblPayeeDetails tpd join tblRequest tr 
	on tr.RequestID=tpd.RequestID
	where tpd.CustomerID=@CustomerID  
end
  
CREATE procedure usp_LoginFD  
as  
	begin  
		try  
			select * from tbl_Login_667355  
		end try 
		 
		begin catch  
			declare @msg varchar(40)  
			set @msg=error_message()  
		end catch
	end

--Validates UserID and Password and Returns Username
CREATE PROCEDURE usp_LoginUsername    
(@UserID varchar(10),    
@Password varchar(20),    
@RoleID int,    
@UserName varchar(20) out,    
@TransferPwd varchar(20) out,    
@LoginStatus int out    
)    
as begin    
	if exists(select UserID from tblLogin where UserID=@UserID collate SQL_Latin1_General_CP1_CS_AS  and UserPassword=@Password collate SQL_Latin1_General_CP1_CS_AS and RoleID=@RoleID )    
	begin    
		if(@RoleID=1)    
		begin    
			select @TransferPwd=l.TransactionPassword, @UserName=c.CustomerName 
				from tblLogin l join tblCustomer c 
				on c.CustomerID=l.UserID  
				where UserID=@UserID and UserPassword=@Password and RoleID=@RoleID    
			set @LoginStatus=1    
		end    
		else if(@RoleID=4)    
		begin    
			set @UserName='Administrator'    
			set @LoginStatus=4    
		end    
		else    
			set @LoginStatus=0    
	end  
	else  
	begin  
		 set @UserName=''  
		 set @TransferPwd=''  
		 set @LoginStatus=0   
	end    
end

--procedure for funds transfer
create procedure usp_FundsTransfer(@custid int)  
	as begin  
		select TransferDatetime,Amount, PayerAccNo,PayeeAccNo from tblFundsTransfer1 where CustomerId=@custid  
	end
	
--procedure for adding payee details
CREATE procedure usp_addpayeedetails(@PayeeAccountNo numeric(16,0),@PayeeName varchar(20),@CustomerID varchar(10),@PBankName varchar(30),@PBranchName varchar(30),@IFSCCode varchar(11),@EmailId varchar(30),@PayeeType varchar(20))      
	as      
		begin     
			if not exists(select CustomerID,PayeeAccountNo from tblPayeeDetails where CustomerID=@CustomerID and PayeeAccountNo=@PayeeAccountNo)    
				begin     
					declare @x numeric(5,0)      
     
					insert tblRequest(RequestTypeID,CustomerID,RequestDate,PayeeAccountNo) values(1,@CustomerID,GETDATE(),@PayeeAccountNo)    
					select @x=RequestID  from tblRequest where CustomerID=@CustomerID and PayeeAccountNo=@PayeeAccountNo  
      
					insert tblPayeeDetails values      
					(@PayeeAccountNo,@PayeeName,@CustomerID,@PBankName,@PBranchName,@IFSCCode,@EmailId,@PayeeType, @x)     

					return 1    
				end    
			else    
				begin    
					return 0    
				end    
		end 

--procedure for viewing details of payee
create procedure usp_ViewDetails2 (@CustomerID varchar(10))  
as  
	begin  
		select pd.PayeeAccountNo 'Payee Account',
				pd.PayeeName 'Payee Name',
				pd.PBankName 'Bank',
				pd.PBranchName 'Branch',
				pd.IFSCCode 'IFSC Code',
				pd.EmailId 'e-Mail',
				pd.PayeeType 'Payee Type',
				r.RequestDate 'Request Date',
				r.RequestStatus 'Status',
				r.Reason 'Reason'
				from tblPayeeDetails pd join tblRequest r  
				on pd.RequestID=r.RequestID  
				where pd.CustomerID = @CustomerID  
	end  


 --procedure of updating payee details
 CREATE procedure usp_UpdatePayee  
(@PayeeAccountNo numeric(16,0),@CustomerID varchar(10),@PayeeName varchar(30), @EmailId varchar(30),@UpdateStatus int out)  
as begin  
	if exists (select * from tblPayeeDetails where PayeeAccountNo=@PayeeAccountNo and CustomerID=@CustomerID)  
	begin  
		if(LEN(@PayeeName)>2)  
		begin  
			update tblPayeeDetails   
				set PayeeName=@PayeeName,EmailId=@EmailId  
				where PayeeAccountNo=@PayeeAccountNo and CustomerID=@CustomerID  
			set @UpdateStatus=1  
		end  
		else  
			set @UpdateStatus=0    
	end  
	else  
		set @UpdateStatus=0   
end  


--procedure for deleting payee details
CREATE procedure usp_DeletePayee    
(@PayeeAccountNo numeric(16,0),@CustomerID varchar(10),@DeleteStatus int out)    
as begin    
	if exists (select * from tblPayeeDetails where PayeeAccountNo=@PayeeAccountNo and CustomerID=@CustomerID)    
	begin    
		declare @requestId numeric(5,0)  
		select @requestId=RequestID 
			from tblPayeeDetails 
			where PayeeAccountNo=@PayeeAccountNo and CustomerID=@CustomerID  
		delete from tblPayeeDetails 
			where PayeeAccountNo=@PayeeAccountNo and CustomerID=@CustomerID  
		delete from tblRequest 
			where @requestId=RequestID     
		set @DeleteStatus=1    
	end    
	else    
		set @DeleteStatus=0    
end

--procedure for viewing requests
CREATE procedure proc_view_requests  
as   
begin    
	update tblRequest  
		set RequestStatus ='rejected' ,Reason ='24 hours timelimit crossed'  
		from tblRequest  join tblPayeeDetails  
		on tblPayeeDetails.PayeeAccountNo=tblRequest.PayeeAccountNo  
		where (datediff(hour,tblRequest.RequestDate ,getdate())>24 and tblRequest.RequestStatus="Pending")      
	select tblPayeeDetails.CustomerID, PayeeName,   
		tblPayeeDetails.PayeeAccountNo,  
		PBankName, PBranchName, IFSCCode,  
		PayeeType, EmailId, RequestStatus,  
		Reason 
		from tblPayeeDetails JOIN tblRequest  
		ON tblPayeeDetails.PayeeAccountNo=tblRequest.PayeeAccountNo 
		where tblRequest.RequestStatus='Pending'  
 end  

 --procedure for approving status
 create procedure proc_approve_status  
(  
@acnt_no numeric,
@status varchar(20),
@reason varchar(20))  
as begin  
	update tblRequest  
		set RequestStatus = @status , Reason= @reason 
		where PayeeAccountNo=@acnt_no  
end

--procedure for verifying payeed details
create procedure proc_verify_Payee
(@account_No numeric)  
as begin  
	declare @state_account bit  
	if exists(select * from tblAccount where AccountNo=@account_No )  
	begin   
		set @state_account=(select Accountstatus from tblAccount where AccountNo=@account_No)  
		if(@state_account=1)  
		begin  
			return 1  
		end 
		else  
		begin  
			return 2  
		end  
	end  
	else  
	begin  
		return 3  
	end  
end

 --procedure1 for transaction history of funds transfer module
create procedure usp_FTTransactionHistory(@custid varchar(10))
as begin
	select CustomerAccNo 'Debited Account',
		PayeeAccountNo 'Credited Account',TransferDatetime 'Transaction Date' ,
		Amount 'Transferred Amount',Remark 
		from tblFundsTransfer 
		where CustomerID=@custid order by TransferDatetime desc
end

--procedure2 for transaction history fo funds transfer module
create procedure usp_FTTransHisCount(@custid varchar(10),@rows int out)  
as begin  
	select @rows=COUNT (*) from tblFundsTransfer where CustomerID=@custid
end


create procedure usp_GetNameFTn (@custID varchar(10) ) as
begin
select  tblAccount.AccountNo, tblBank.BankName, tblBranch.BranchName
from tblAccount
join tblCustomer on tblAccount.CustomerID = tblCustomer.CustomerID
join tblBranch on tblAccount.BranchID = tblBranch.BranchID
join tblBank on tblBranch.BankID = tblBank.BankID
where @custID=tblCustomer.CustomerID and tblAccount.Accountstatus='true'
end

create procedure usp_GetPayeeFT(@CustID varchar(10)) as
begin
	select  tblPayeeDetails.PayeeName as Name, tblPayeeDetails.PayeeAccountNo 'Account No',tblPayeeDetails.PBankName as Bank ,tblPayeeDetails.PBranchName as Branch
		from tblPayeeDetails
		left join tblRequest
		on tblPayeeDetails.RequestID=tblRequest.RequestID
		where @CustID=tblPayeeDetails.CustomerID and tblRequest.RequestStatus='Approved'
end

create procedure usp_InsertTransfer ( @custID varchar(10) , @CustAccno numeric(16,0) , @PayeeAccno numeric(16,0) , @Amt money ,@rmk varchar(40) ,@txn varchar(10) out) as
begin
	insert tblFundsTransfer (CustomerID , CustomerAccNo , PayeeAccountNo , Amount , Remark) values(@custID,@CustAccno,@PayeeAccno,@Amt,@rmk)
	select @txn=MAX( TransferID) from tblFundsTransfer
	if exists (select * from tblAccount where AccountNo=@CustAccno)
		insert tblGlobalTransaction (PrimaryAccountNo ,TransactionType, TransactionAmount,TransactionDescription ) values (@CustAccno,'Debit',@Amt,'Fund Transfer')
	if exists (select * from tblAccount where AccountNo=@PayeeAccno  )
		insert tblGlobalTransaction (PrimaryAccountNo ,TransactionType, TransactionAmount,TransactionDescription ) values (@PayeeAccno,'Credit',@Amt,'Fund Transfer')
end



create procedure usp_UpdateCAcc ( @CustAcc numeric(16,0) , @Balance money , @Avail int out) as
begin
	if exists(select * from tblAccount where AccountNo=@CustAcc and Balance>@Balance)
		update tblAccount set Balance=Balance-@Balance
			where AccountNo=@CustAcc
	select @Avail=Balance from tblAccount where AccountNo=@CustAcc
end

select * from tblAccount
create procedure usp_UpdatePAcc (@PayeeAcc numeric(16,0) , @Balance money ) as
	if exists (select * from tblAccount where AccountNo=@PayeeAcc )
	begin
		update tblAccount set Balance=Balance+@Balance
			where AccountNo=@PayeeAcc
	end

create procedure usp_CheckTxnPwd(@CustId varchar (10) , @TxnPwd varchar(20), @Check varchar(10) out)as
begin
	if exists( select UserID from tblLogin where TransactionPassword=@TxnPwd and UserID=@CustId)
		set @check='right'
	else
		set @check='wrong'
end

create procedure usp_GetSelfOthers(@custID varchar(10) ) 
as
	if exists (select * from tblAccount,tblPayeeDetails where AccountNo=tblPayeeDetails.PayeeAccountNo) 
	begin
		select  tblPayeeDetails.PayeeName, tblAccount.AccountNo, tblBank.BankName, tblBranch.BranchName 
			from tblAccount 
			join tblCustomer on tblAccount.CustomerID = tblCustomer.CustomerID
			join tblBranch on tblAccount.BranchID = tblBranch.BranchID
			join tblBank on tblBranch.BankID = tblBank.BankID
			join tblPayeeDetails on tblAccount.AccountNo = tblPayeeDetails.PayeeAccountNo
			where @custID=tblCustomer.CustomerID and tblAccount.Accountstatus='true'
	end

create procedure usp_GetThirdParty(@custID varchar(10) ) as
	if not exists (select * from tblAccount,tblPayeeDetails where AccountNo=tblPayeeDetails.PayeeAccountNo)  
	begin
		select  tblPayeeDetails.PayeeName, tblAccount.AccountNo, tblBank.BankName, tblBranch.BranchName
		from tblAccount
		join tblCustomer on tblAccount.CustomerID = tblCustomer.CustomerID
		join tblBranch on tblAccount.BranchID = tblBranch.BranchID
		join tblBank on tblBranch.BankID = tblBank.BankID
		join tblPayeeDetails on tblAccount.CustomerID = tblPayeeDetails.CustomerID
		left join tblRequest
		on tblPayeeDetails.RequestID=tblRequest.RequestID
		where @custID=tblCustomer.CustomerID  and tblRequest.RequestStatus='Approved'
	end

create procedure usp_GetThridPartyFT(@CustID varchar(10)) as
begin
	select distinct tblPayeeDetails.PayeeName, tblPayeeDetails.PayeeAccountNo,tblPayeeDetails.PBankName ,tblPayeeDetails.PBranchName
		from tblPayeeDetails
		join tblRequest on tblPayeeDetails.RequestID=tblRequest.RequestID
		join tblAccount on tblAccount.CustomerID = tblPayeeDetails.CustomerID
		where @CustID=tblPayeeDetails.CustomerID and tblRequest.RequestStatus='Approved' and tblPayeeDetails.PayeeAccountNo != tblAccount.AccountNo
end