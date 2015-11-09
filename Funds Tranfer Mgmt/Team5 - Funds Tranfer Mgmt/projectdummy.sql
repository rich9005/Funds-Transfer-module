
use DB01H84


create table tblFundsTransfer
(
Tid int primary key identity(100,1),
TransferID as 'TXN#' + right('000'+ cast(Tid as varchar(10)), 6),
CustomerID varchar(10) foreign key references tblCustomer(CustomerID) ,
CustomerAccNo numeric foreign key references tblAccount(AccountNo),
PayeeAccountNo numeric,
TransferDatetime datetime default getdate(),
Amount money,
Remark varchar(40) null,
TransferStatus varchar(20) check (TransferStatus in ('successful','failed')) not null default 'successful'

)
select * from tblFundsTransfer

drop table tblFundsTransfer
create table tblxtx1
(
goog int  identity(100,1) primary key,
txnID as 'TXN#' + right('0000' + Cast(goog as varchar(10)),6)  persisted,
name varchar(10)
)

insert tblxtx values('parikshit')
select * from tblxtx

sp_help tblxtx

create table tblPayeeDetails
(
PayeeAccountNo numeric not null,
PayeeName varchar(20) not null,
CustomerID varchar(10) foreign key references tblCustomer(CustomerID),
PBankName varchar(30) not null,
PBranchName varchar(30) not null,
IFSCCode varchar(11) not null,
EmailId varchar(30),
PayeeType varchar(20) check (PayeeType in ('self','third party')) not null,
RequestID numeric(5) foreign key references tblRequest(RequestID),
constraint pk_tblPayeeDetails primary key(PayeeAccountNo,CustomerId)

)

CREATE TABLE tblAccount
(
AccountNo numeric primary key,
AccountType varchar(10) check(AccountType in('Saving','Current')),
CustomerID varchar(10) references tblCustomer(CustomerID),
BranchID varchar(10) references tblBranch(BranchID),
Balance money,
Accountstatus bit,
)

select * from tblAccount

CREATE TABLE tblBank
(
BankID varchar(10) primary key,
BankName varchar(30) unique not null,
BankStatus bit
)

CREATE TABLE tblBranch
(
BankID varchar(10) references tblBank(BankID),
BranchID varchar(10) primary key,
BranchName varchar(30) not null,
IFSCCode varchar(11) unique not null,
BranchAddress varchar(60) not null,
City varchar(20)not null,
BranchState varchar(25) not null,
ContactPerson varchar(25),
ContactNo numeric(10,0),
BranchEmail varchar(30)
)

drop table tblGlobalTransaction

create table tblGlobalTransaction
(TransactionID varchar(20), 
TransactionType varchar(50) ,
PrimaryAccountNo numeric (16,0),
TransactionDateTime datetime default getdate(),
TransactionAmount money,
TransactionDescription varchar(50) 
)
select * from tblGlobalTransaction
------------------------------


alter procedure usp_GetNameFTn (@custID varchar(10) ) as
begin
select  tblAccount.AccountNo, tblBank.BankName, tblBranch.BranchName
from tblAccount
join tblCustomer on tblAccount.CustomerID = tblCustomer.CustomerID
join tblBranch on tblAccount.BranchID = tblBranch.BranchID
join tblBank on tblBranch.BankID = tblBank.BankID
where @custID=tblCustomer.CustomerID and tblAccount.Accountstatus='true'
end


declare @Accno numeric, @Bank varchar(30) , @Branch varchar(30)
exec usp_GetNameFTn 101 , @Accno output , @Bank output , @Branch output
select @Accno as Account, @Bank as Bank, @Branch as Branch
go
-----

exec usp_GetNameFT [101]
-----
alter procedure usp_GetPayeeFT(@CustID varchar(10)) as
begin
select  tblPayeeDetails.PayeeName, tblPayeeDetails.PayeeAccountNo,tblPayeeDetails.PBankName ,tblPayeeDetails.PBranchName
from tblPayeeDetails
left join tblRequest
on tblPayeeDetails.RequestID=tblRequest.RequestID
where @CustID=tblPayeeDetails.CustomerID and tblRequest.RequestStatus='Approved'
end

-----
exec usp_GetPayeeFT [101]

------
select * from tblFundsTransfer

insert tblFundsTransfer values (101,1111,44444,4000,'TEST')

------------------------------------------------
/*alter procedure usp_InsertTransfer ( @custID int , @CustAccno numeric , @PayeeAccno numeric , @Amt money ,@rmk varchar(40),@txn varchar(10) out) as--
begin
insert tblFundsTransfer (CustomerID , CustomerAccNo , PayeeAccountNo , Amount , Remark) values(@custID,@CustAccno,@PayeeAccno,@Amt,@rmk)
select @txn=MAX( TransferID) from tblFundsTransfer
end
begin
insert tblGlobalTransaction (TransactionId , PrimaryAccNo ,TransactionAmount) values(@custID,@CustAccno,@Amt)

end*/
------------------------------------------------

alter procedure usp_InsertTransfer ( @custID int , @CustAccno numeric , @PayeeAccno numeric , @Amt money ,@rmk varchar(40) ,@txn varchar(10) out) as
begin
insert tblFundsTransfer (CustomerID , CustomerAccNo , PayeeAccountNo , Amount , Remark) values(@custID,@CustAccno,@PayeeAccno,@Amt,@rmk)
select @txn=MAX( TransferID) from tblFundsTransfer
if exists (select * from tblAccount where AccountNo=@CustAccno)
insert tblGlobalTransaction (PrimaryAccountNo ,TransactionType, TransactionAmount,TransactionDescription ) values (@CustAccno,'Debit',@Amt,'Fund Transfer')
if exists (select * from tblAccount where AccountNo=@PayeeAccno  )
insert tblGlobalTransaction (PrimaryAccountNo ,TransactionType, TransactionAmount,TransactionDescription ) values (@PayeeAccno,'Credit',@Amt,'Fund Transfer')
end

declare @txn varchar(10)

exec usp_InsertTransfer[101],[1111],[22222],[400],[ ],[@txn] 
print @txn
----
select * from tblGlobalTransaction
delete from tblGlobalTransaction where TransactionID=108


alter procedure usp_UpdateCAcc ( @CustAcc int , @Balance money , @Avail int out) as
begin
if exists(select * from tblAccount where AccountNo=@CustAcc and Balance>@Balance)
update tblAccount set Balance=Balance-@Balance
where AccountNo=@CustAcc
select @Avail=Balance from tblAccount where AccountNo=@CustAcc
end



declare @Avail int
exec usp_UpdateCAcc 1111 ,8000 , @Avail out
print @Avail
 

select * from tblAccount
select * from tblFundsTransfer

alter procedure usp_UpdatePAcc (@PayeeAcc int , @Balance money ) as
if exists (select * from tblAccount where AccountNo=@PayeeAcc )
begin
update tblAccount set Balance=Balance+@Balance
where AccountNo=@PayeeAcc
end

declare @result1 varchar(20)
exec usp_UpdatePAcc 10111 ,9 , @result1 
print @result1




------------------
CREATE TABLE tblCustomer
(
CustomerID varchar(10) primary key,
CustomerName varchar(20) not null,
DateofBirth datetime not null,
CustomerAddress varchar(80),
Occupation varchar(20),
AnnualSalary money,
PANNo varchar(10) unique not null,
PhoneNo numeric(10,0),
EmailID varchar(30),
) 

CREATE TABLE tblLogin
(
UserID varchar(10) primary key,
UserPassword varchar(20),
RoleID int references tblRole(RoleID),
TransactionPassword varchar(20),
IsChanged bit
)

alter procedure usp_CheckTxnPwd(@CustId varchar (10) , @TxnPwd varchar(20), @Check varchar(10) out)as
begin
if exists( select UserID from tblLogin where TransactionPassword=@TxnPwd and UserID=@CustId)
set @check='right'
else
set @check='wrong'
end

declare @check varchar(10)
exec usp_CheckTxnPwd 101,asdf, @check out
print @check

CREATE TABLE tblRole
(
RoleID int primary key,
RoleName varchar(15) check(RoleName in('Customer','Bank','Employee','Administrator'))
)

CREATE TABLE tblRequest
(
RequestID numeric(5) primary key,
RequestTypeID int references tblRequestType(RequestTypeID),    
RequestStatus varchar(15) check(RequestStatus in('Approved','rejected','Pending')) default 'Pending',
Reason varchar(30),
BankID varchar(10) foreign key references tblBank(BankID),
CustomerID varchar(10) foreign key references tblCustomer(CustomerID),
AccountNo numeric foreign key references tblAccount(AccountNo),
RequestDate DateTime,
NewPAN varchar(10)
)
ALTER table tblRequest
add PayeeAccountNo numeric

select * from tblRequest

CREATE TABLE tblRequestType
(
RequestTypeID int primary key,
TypeDesc varchar(20) not null
)