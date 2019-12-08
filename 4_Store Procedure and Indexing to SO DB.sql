
Create PROCEDURE [dbo].[procPopulateCloneDataForAnswers]  
AS  
BEGIN 
SET NOCOUNT ON;   
declare @postID int;
declare @Q_length int; 
declare @Q_NooffavouriteCount int;
declare @Q_NoOfTags int;
declare @Q_CreationDate datetime;
declare @Q_NoOfAnswers int;
declare @Q_Score int;
declare @Q_OwnerId int;
declare @Asker_PostedQuestions int;
declare @Asker_PostedAnswers int;
declare @Asker_ReputationScore int;
declare @Asker_upVotes int;
declare @Asker_downVotes int;
declare @StringTags varchar(max);

	DECLARE cloneAnswerss_Cursor CURSOR FOR
	SELECT  postId FROM AcceptedAnswersClone 
	OPEN cloneAnswerss_Cursor
	FETCH NEXT FROM cloneAnswerss_Cursor INTO @postID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		select  @Q_NoOfTags= (select count(*) from dbo.Split(Tags,'<')) from Posts where id = @postID
		select count(*) from dbo.Split('<c#><floating-point><type-conversion><double><decimal>','<')
		select @Asker_ReputationScore = Reputation, @Asker_upVotes = UpVotes, @Asker_downVotes =DownVotes  from Users where id = @Q_OwnerId  
		select @Asker_PostedQuestions = count(*) from Posts where OwnerUserId = @Q_OwnerId and PostTypeId = 1 and datepart(Year,CreationDate) <= 2018
		select @Asker_PostedAnswers = count(*) from Posts where OwnerUserId = @Q_OwnerId and PostTypeId = 2 and datepart(Year,CreationDate) <= 2018
		select @Q_NoOfAnswers = count(*) from Posts where ParentId = @postID

		UPDATE AcceptedAnswersClone  
		Set  A_NoOfBoldTags = @Q_NoOfTags
		,Q_NoOfAnswers = @Q_NoOfAnswers,  Asker_ReputationScore = @Asker_ReputationScore, 
        Asker_Upvotes = @Asker_upVotes, Asker_DownVotes = @Asker_downVotes, Asker_PostedQuestions = @Asker_PostedQuestions, 
		Asker_PostedAnswers = @Asker_PostedAnswers 
		Where postId = @postID  

		--print @Q_length + @postID + @Q_OwnerId

	FETCH NEXT FROM cloneAnswerss_Cursor
	INTO @postID
	END
	CLOSE cloneAnswerss_Cursor
	DEALLOCATE cloneAnswerss_Cursor


END  


select top 1 body,tags, (SELECT count(*) FROM STRING_SPLIT(Body,'<code>')) from posts


CREATE INDEX index_Posts
ON Posts (id, OwnerUserId);

CREATE INDEX index_Comments
ON Comments (postId);

CREATE INDEX index_PostHistory
ON PostHistory (postId, UserId); 


select count(*)  from posts p
  where OwnerUserId = 1449199 
  and posttypeid = 2

   select  p.PostTypeId,p.OwnerUserId, count(p.id) PostCount  from posts p
 where posttypeid = 2
  and OwnerUserId = 1449199 
  group by p.PostTypeId, p.OwnerUserId
  order by p.OwnerUserId