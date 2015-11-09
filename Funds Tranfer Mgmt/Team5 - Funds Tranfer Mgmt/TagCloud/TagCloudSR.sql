
use DB08H98

create table TagCloudSR
(
link varchar(30),
tag int
)
select * from TagCloudSR
delete TagCloudSR

insert TagCloudSR values('Merc' , 2)

alter procedure usp_TGSRInsert(@link varchar(30) , @tag int) as
begin 
update TagCloudSR set tag=((select tag from TagCloudSR where link=@link)+@tag) where link=@link
end

exec usp_TGSRInsert BMW , 1

alter procedure usp_GetTagWeight (@link1 int out , @link2 int out , @link3 int out , @link4 int out) as
begin 
select @link1=tag from TagCloudSR where link='RaiseSR'
select @link2=tag from TagCloudSR where link='UpdateCancelSR'
select @link3=tag from TagCloudSR where link='ReopenCloseSR'
select @link4=tag from TagCloudSR where link='ViewTrackSR'
end

declare @link1 int, @link2 int,@link3 int,@link4 int
exec usp_GetTagWeight @link1 out ,@link2 out ,@link3 out ,@link4 out
print @link1
print @link2
print @link3
print @link4 

select * from TagCloudSR