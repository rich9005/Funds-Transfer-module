use DB08H98

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

CREATE TABLE tblEmployee
(
EmpID varchar(10) primary key,
EmpName varchar(30) not null,
EmpDOB datetime not null,
EmpAddress varchar(80),
EmpPhoneNo numeric(10,0),
EmpEmail varchar(30)
)

CREATE TABLE tblRole
(
RoleID int primary key,
RoleName varchar(15) check(RoleName in('Customer','Bank','Employee','Administrator'))
)

CREATE TABLE tblLogin
(
UserID varchar(10) primary key,
UserPassword varchar(20),
RoleID int references tblRole(RoleID),
TransactionPassword varchar(20),
IsChanged bit
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

CREATE TABLE tblRequestType
(
RequestTypeID int primary key,
TypeDesc varchar(20) not null
)

CREATE TABLE tblRequest
(
RequestID numeric(5) primary key identity(10001,1),
RequestTypeID int references tblRequestType(RequestTypeID),    
RequestStatus varchar(15) check(RequestStatus in('Approved','rejected','Pending')) default 'Pending',
Reason varchar(30),
BankID varchar(10) foreign key references tblBank(BankID),
CustomerID varchar(10) foreign key references tblCustomer(CustomerID),
AccountNo numeric foreign key references tblAccount(AccountNo),
RequestDate DateTime,
NewPAN varchar(10),
PayeeAccountNo numeric(16)
)

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

create table tblGlobalTransaction
(
TransactionID varchar(20), 
TransactionType varchar(50) ,
PrimaryAccountNo numeric (16,0),
TransactionDateTime datetime default getdate(),
TransactionAmount money,
TransactionDescription varchar(50) 
)