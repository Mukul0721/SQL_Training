

/************ Creating procedure to recalculate column Ordinals *********/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_RecalculateColumnOrdinal_WR6146515]') 
AND type in (N'P', N'PC'))   
Drop Procedure  [dbo].[csp_RecalculateColumnOrdinal_WR6146515] 
GO

CREATE PROCEDURE [dbo].[csp_RecalculateColumnOrdinal_WR6146515]  
@ProjectName NVARCHAR(2000),
@FormOID NVARCHAR(50),
@DT DateTime
As
BEGIN

  Declare @ProjectID INT, @ASCID_Updated int, @ProjectTypeId int

   Select @ProjectID = ProjectID    from Projects  
   where dbo.fnlds(ProjectName,'eng') = @ProjectName    
   Select @ProjectTypeId = objecttypeId from objecttyper 
   where objectname= 'Medidata.Core.Objects.Project'   
   Select @ASCID_Updated = ID from dbo.AuditSubCategoryR 
   where Name = 'Updated'

------ Create the backup table

  if not exists (select null from sys.objects where type = 'U' and name = N'BK_WR_6146515_Fields' 
    and schema_name(schema_ID)='dbo' )      
   BEGIN           
      create table dbo.BK_WR_6146515_Fields(               
       FieldID int,
	   FieldActive bit,
	   FormID int,         
       ColumnOrdinal int, 
	   Updated datetime,
	   BK_timestamp datetime) 
	End

    Create Table #TempFields(ProjectName nvarchar(4000), ProjectID int, CRFVersionID int, FolderName nvarchar(4000),
       FormName nvarchar(4000),
	   FormOid varchar(50),
	   formid int, FieldOid varchar(50),
	   FieldID int,
	   FieldLabel nvarchar(4000),
	   ColumnOrdinal int)

        -----Getting Fields list        
  Insert into #TempFields(ProjectName, ProjectID, CRFVersionID, FormName, FormOid, formid, FieldOid, FieldID,
  FieldLabel, ColumnOrdinal)       
  select @ProjectName, Prj.projectId, CRF.CRFVersionID, dbo.fnlds(fr.FormName,'eng'), fr.oid, f.formid, f.oid,
  f.FieldID, dbo.fnlds(f.pretextid,'eng'), f.ColumnOrdinal        From forms Fr     
  join fields f on f.FormId = Fr.FormId   
  Join CRFversions CRF on CRF.CRFVersionID = Fr.CRFVersionID     
  Join Projects Prj on Prj.projectId = CRF.ProjectID  
  Where dbo.fnlds(projectname,'eng') = @ProjectName   
  and Fr.Oid = @FormOID  

       
  Update t         
  Set t.FolderName = dbo.fnlds(fo.FolderName,'eng')       
  From #TempFields t      
  join Folderforms ff on ff.FormID = t.FormID     
  join Folders fo on fo.FolderID = ff.FolderID

  BEGIN TRANSACTION   
   BEGIN TRY

 -- Insert data into back up     
   Insert into dbo.BK_WR_6146515_Fields (FieldID, ColumnOrdinal, FormID, Updated, BK_timestamp)   
   select  FI.FieldID, FI.ColumnOrdinal, FI.FormID, FI.Updated, @DT  
   from #TempFields T    
   join dbo.Fields FI on FI.FieldID = T.FieldID

 ---- Updating Fields to Set Column Ordinal as NULL     
  Update FI Set ColumnOrdinal = NULL, Updated = @DT        Output        
  '', '', 'Updated ColumnOrdinal to NULL for the FieldID: ' + Cast(t.FieldID as NVarchar(20)) + ', CRFVersionID: ' 
  + Cast(t.CRFVersionID as NVarchar(20)) + ' (WR#6146515)', -2, @DT, t.ProjectID, @ProjectTypeID, @ASCID_Updated 
  into Audits      
  (Property, Value, Readable, AuditUserID, AuditTime, ObjectID, ObjectTypeid, AuditSubCategoryID)  
  from #TempFields T        
  join fields FI on FI.FieldID = T.FieldID


 --------Results

    Select t.ProjectName AS ProjectName,
    t.ProjectID,   
	t.CRFVersionID AS CRFVersionID,   
	t.FolderName,      
	t.FormName AS FormName,     
	t.FormOID AS FormOID,      
	t.FormId,           
	t.FieldOID,        
	t.FieldID AS FieldID,   
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(t.FieldLabel,CHAR(9),' '),CHAR(10),' '),CHAR(11),' '),CHAR(12),' ') 
	,CHAR(13),' ') FieldLabel, 
	t.ColumnOrdinal ColumnOrdinal_Before, 
	FI.ColumnOrdinal ColumnOrdinal_After,   
	v.AuditID,                
	v.readable as AuditMessage,   
	@DT as AuditDateTime      
	From #TempFields T    
	join fields FI on FI.FieldID = T.FieldID   
	join audits v on v.readable like '%'+cast(t.FieldID as varchar(20))+'%' AND V.READABLE LIKE '%'
	+cast(t.CRFVersionID as varchar(20))+'%' AND V.Audittime=@DT

---------Clean Up  
 Drop table #TempFields

   COMMIT TRAN 
   END TRY   
   BEGIN CATCH   
   ROLLBACK TRAN   
     print '   ERNumber: ' + CAST(ERROR_NUMBER() as varchar)  
     print '   Error_Severity: ' + CAST(ERROR_SEVERITY() as varchar) 
     print '   Error_State : ' + CAST(ERROR_STATE() as varchar)    
     print '   Error_Procedure: ' + CAST(ERROR_PROCEDURE() as varchar(500)) 
     print '   Error_Line : ' + CAST(ERROR_LINE() as varchar)   
     print '   Error_Message:' + CAST(ERROR_MESSAGE()as varchar(500))  
     Print '      Roll back completed.'  
   END CATCH

END
GO

/********* Executing Procedure **********/
Declare @DT DateTime
Set @DT = GetUTCDate()

Exec [dbo].[csp_RecalculateColumnOrdinal_WR6146515] 'D933IC00001', 'AE', @DT
GO

---------Clean up-----

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[csp_RecalculateColumnOrdinal_WR6146515]') 
AND type in (N'P', N'PC'))  
Drop Procedure  [dbo].[csp_RecalculateColumnOrdinal_WR6146515] 
GO




