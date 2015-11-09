insert tblLogin values('Cust5001','Cust5001',1,'Cust5001',0)
insert tblLogin values('Cust5002','Cust5002',1,'Cust5002',0)
insert tblLogin values('Cust5003','Cust5003',1,'Cust5003',0)
insert tblLogin values('Admin5001','admin5001',4,'Admin5001',0)

select * from tblCustomer
insert tblCustomer values('Cust5001','Sai Ram Reddy','04-15-1991','','Service',314265,'HJK51PY555','09603215123','sairamreddy.karra@gmail.com')
insert tblCustomer values('Cust5002','Vaishali Dube','12-20-1985','Manjeera Diamond Tower, Hyderabad','Service',550000,'HGF12YU222','0989214849','vaishali.dube@yahoo.com')
insert tblCustomer values('Cust5003','Vidya Roy','05-10-1988','472/Mohan Niwas, Mumbai','Service',700000,'MNB33VC333','09619303633','vidya_roy@hotmail.com')

select * from tblAccount
select * from tblBranch
select * from tblBank

insert tblBank values ('Bank500001','Standard Chartered',1)
insert tblBank values ('Bank500002','Punjab National Bank',1)
insert tblBank values ('Bank500003','Kotak Mahindra',1)
insert tblBank values ('Bank500004','State Bank of India',1)

insert tblBranch values ('Bank500001','500001','Mumbai','STCH5000001','Matunga','Mumbai','Maharashtra','Frenal Gadani',0814397301,'frenal@gmail.com')
insert tblBranch values ('Bank500002','500002','Delhi','PJNB5000002','Chandani Chowk','Delhi','Delhi','Kinjal Sharma',08879166118,'kinjal_shrama@yahoo.com')
insert tblBranch values ('Bank500003','500003','Kolkatta','KOMH5000003','Mahatma Gandhi Chowk','Kolkatta','West Bengal','Anurag Basu',09819814671,'anurag.basu@hotmail.com')
insert tblBranch values ('Bank500004','500004','Hyderabad','SBOI5000004','Lingampally','Hyderabad','Andhra Pradesh','Shamili Voona',09969942104,'shamili@gmail.com')

select * from tblAccount
insert tblAccount values(5001500150015001,'Saving','Cust5001','500001',0,0)
insert tblAccount values(5001500150015002,'Saving','Cust5001','500002',100000,1)
insert tblAccount values(5001500150015003,'Current','Cust5001','500003',10,1)
insert tblAccount values(5002500250025001,'Saving','Cust5002','500002',0,0)
insert tblAccount values(5002500250025002,'Saving','Cust5002','500001',500000,1)
insert tblAccount values(5002500250025003,'Current','Cust5002','500003',1,1)
insert tblAccount values(5003500350035001,'Saving','Cust5003','500003',0,0)
insert tblAccount values(5003500350035002,'Saving','Cust5003','500002',10,1)
insert tblAccount values(5003500350035003,'Current','Cust5003','500001',40000,1)

exec usp_addpayeedetails '5001500150015001','Sai Ram','Cust5002','Standard Chartered','Mumbai','STCH5000001','sairamreddy@gmail.com','third party'
exec usp_addpayeedetails '5003500350035003','Vidya Roy','Cust5002','State Bank of India','Hyderabad','SBOI5000004','vidya_roy@hotmail.com','third party'
exec usp_addpayeedetails '5003500350035002','Vidya Roy','Cust5002','State Bank of India','Hyderabad','SBOI5000004','vidya_roy@hotmail.com','third party'
exec usp_addpayeedetails '5002500250025002','self','Cust5002','Standard Chartered','Mumbai','STCH5000001','vaishali@gmail.com','self'

exec usp_addpayeedetails '5001500150015002','self','Cust5001','State Bank of India','Hyderabad','SBOI5000004','sairamreddy@gmail.com','self'
exec usp_addpayeedetails '5002500250025001','Vaishali','Cust5001','Punjab National Bank','Delhi','PJNB5000002','vaishali@gmail.com','third party'
exec usp_addpayeedetails '5003500350035002','Vidya Roy','Cust5001','State Bank of India','Hyderabad','SBOI5000004','vidya_roy@hotmail.com','third party'
exec usp_addpayeedetails '5001500150015001','self','Cust5001','Punjab National Bank','Delhi','PJNB5000002','sairamreddy@gmail.com','self'

exec usp_addpayeedetails '5003500350035002','self','Cust5003','Standard Chartered','Mumbai','STCH5000001','vaishali@gmail.com','self'
exec usp_addpayeedetails '5003500350035003','self','Cust5003','Standard Chartered','Mumbai','STCH5000001','vaishali@gmail.com','self'
exec usp_addpayeedetails '5002500250025002','Vidya Roy','Cust5003','Punjab National Bank','Delhi','PJNB5000002','vidya_roy@hotmail.com','third party'
exec usp_addpayeedetails '5001500150015002','Sai Ram Reddy','Cust5003','Standard Chartered','Mumbai','STCH5000001','vaishali@gmail.com','third party'


