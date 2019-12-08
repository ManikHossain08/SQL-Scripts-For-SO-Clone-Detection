--INSERT INTO dbo.Tags SELECT * FROM [StackOverflow].dbo.Tags
select * from AcceptedQuestionsClone
--select * from AcceptedQuestionsClone
select * into AcceptedQuestionsClone from (
select *, 'Blocks' Grunality from QuestionsBlocksClone 
UNION ALL 
select *, 'Functions' Grunality from QuestionsFunctionsClone
) a

--## HOW MANY UNIQUE ANSWERS FROM BLOCKS AND FUNCTIONS ##-----
SELECT DISTINCT (PostId) FROM AcceptedQuestionsClone   --8865
where Grunality = 'Blocks'
SELECT DISTINCT (PostId) FROM AcceptedQuestionsClone --51214  
where Grunality = 'Functions'

--### COMMON NUMBER OF ANSWERS FROM BOTH FUNCTIONS AND ANSWERS = 71
select distinct(f.PostId) from QuestionsBlocksClone b
inner join QuestionsFunctionsClone f
on b.PostId = f.PostId


--### For each Answers (Blocks) how many clones are there OVERALL : 5841 ### ----
select postId EachQuestions_Blocks, count(*) howManyClones from AcceptedQuestionsClone 
where Grunality = 'Blocks'
group by postId
order by count(*) desc, PostId DESC 

--### For each Answers (Blocks) how many are there IN SPECIFIC CLONE CLASS TYPE : 6137 ### ----
select postId EachQuestions_Blocks,CloneClassnumber CloneClassType, count(*) howManyClones from AcceptedQuestionsClone 
where Grunality = 'Blocks'
group by postId, CloneClassnumber
order by count(*) desc, PostId DESC


--### For each Answers (Functions) how many clones are there OVERALL :12,517 ### ----
select postId EachAnswers_Functions, count(*) howManyClones from AcceptedQuestionsClone 
where Grunality = 'Functions'
group by postId
order by count(*) desc, PostId DESC 

--### For each Answers (Functions) how many are there IN SPECIFIC CLONE CLASS TYPE : 14,750 ### ----
select postId EachAnswers_Functions,CloneClassnumber CloneClassType, count(*) howManyClones from AcceptedQuestionsClone 
where Grunality = 'Functions'
group by postId, CloneClassnumber
order by count(*) desc, PostId DESC


--### For each Question posted time interval ### ---- CANCEL
select EachQuestions_,CloneClassnumber cloneClassType, p.CreationDate,howManyClones   from (
select distinct (postId) EachQuestions_,CloneClassnumber, count(*) howManyClones from AcceptedQuestionsClone 
where Grunality = 'Functions'
group by postId, CloneClassnumber
) a 
inner join Posts p
on a.EachQuestions_ = p.Id 
order by CloneClassnumber desc


--### For each Answers group wise answers time interval ### ---- CANCEL
select EachAnswers_,ac.CloneClassnumber cloneClassType, p.CreationDate,howManyClones, p.score   from (
select distinct (postId) EachAnswers_, count(*) howManyClones from AcceptedQuestionsClone 
where Grunality = 'Functions'
group by postId 
) a 
inner join Posts p
on a.EachAnswers_ = p.Id 
inner join AcceptedQuestionsClone ac
on ac.postid = p.Id
order by CloneClassnumber desc


--### Each QUESTIONS(Functions) with group AND THEIR time interval ### ----
select postId EachQuestionsId,CloneClassnumber CloneType,p.AcceptedAnswerId, p.CreationDate, p.Score, aac.Grunality from AcceptedQuestionsClone aac
inner join Posts p
on aac.postId = p.Id and Grunality = 'Functions'
order by CloneClassnumber asc

--### Each QUESTIONS(Blocks) with groups AND THEIR time interval ### ----
select postId EachQuestionId,CloneClassnumber CloneType,p.AcceptedAnswerId, p.CreationDate, p.Score, aac.Grunality from AcceptedQuestionsClone aac
inner join Posts p
on aac.postId = p.Id and Grunality = 'Blocks'
order by CloneClassnumber asc


--### For each Answers(Blocks) with groups time interval ### ----
select postId EachAcceptedAnswersId,CloneClassnumber CloneType,p.ParentId questionsId, p.CreationDate, p.Score, aac.Grunality
 from AcceptedQuestionsClone aac
inner join Posts p
on aac.postId = p.Id --and Grunality = 'Blocks'
order by CloneClassnumber asc


--## populating table done ###-----

ALTER TABLE AcceptedQuestionsClone
ADD Q_ownerId int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_NooffavouriteCount int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_NoofViewCount int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_length int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_CreateDate datetime;
ALTER TABLE AcceptedQuestionsClone
ADD Q_TtleLength int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_Score int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_NoOfAnswers int;ALTER TABLE AcceptedQuestionsClone
ADD Asker_ReputationScore int;ALTER TABLE AcceptedQuestionsClone
ADD Asker_Upvotes int;ALTER TABLE AcceptedQuestionsClone
ADD Asker_DownVotes int;ALTER TABLE AcceptedQuestionsClone
ADD Asker_PostedQuestions int;ALTER TABLE AcceptedQuestionsClone
ADD Asker_PostedAnswers int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_NoOfTags int;




UPDATE t1
  SET 
  --t1.Q_length = len(t2.body) --t1.Q_NooffavouriteCount = t2.FavoriteCount --tags--t1.Q_ownerId = t2.OwnerUserId--t1.Q_CreateDate = t2.CreationDate,
  --t1.Q_TtleLength = len(t2.Title), --t1.Q_NoofViewCount = t2.ViewCount, --t1.Q_Score = t2.Score
  --t1.Q_NoOfAnswers = (select count(*) from Posts where ParentId = t2.id), t1.Q_NoOfTags= (select count(*) from dbo.Split(t2.Tags,'<'))

  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.posts AS t2
  ON t1.postid = t2.id

  SELECT  top 65533 PostId,	SnippetId,	CloneClassnumber,	CloneSize,	Similarity,	CodeLength,	Grunality, 
  isnull(Q_NooffavouriteCount,0) Q_NooffavouriteCount, 
  isnull(Q_length,0) Q_length,Q_CreateDate,	isnull(Q_TtleLength,0) Q_TtleLength,	isnull(Q_NoofViewCount,0) Q_NoofViewCount, 
  isnull(Q_NoOfTags,0) Q_NoOfTags, isnull(Q_Score,0) Q_Score	
   FROM AcceptedQuestionsClone where Q_ownerId is not null and Grunality = 'Blocks' --and Q_NoOfTags>5
   order by CloneClassnumber desc
  --exec procPopulateCloneDataForQuestions
  select top 1 Body from Posts
  select count(*) from dbo.Split((select top 1 Body from Posts),'<pre><code>')

  ----#### Extracting data from the database to calculate code ratio and the different kind of tags for only cloned questions after detections
  select  cast(questions.PostId as varchar(20))+'<postid>'+ p.Body  
  from AcceptedQuestionsClone questions
  inner join Posts p 
  on questions.postid = p.id

  -----### Combine excel result into one table after being inported from the excel
  insert into QuestionsCodeRatioFromTags1 select * from QuestionsCodeRatioFromTags2


  ----########## careate more column to Populate data for answers #########------------

ALTER TABLE AcceptedQuestionsClone
ADD Q_codeRatio int;
-----
ALTER TABLE AcceptedQuestionsClone
ADD Q_CodeRatioPercentage int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_LinkTags int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_ItalicTags int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_TotalCodeLength int;
------------
ALTER TABLE AcceptedQuestionsClone
ADD Q_NoOfBoldTags int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_NoOfCodeSnippets int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_NoOfComments int;
ALTER TABLE AcceptedQuestionsClone
ADD Q_NoOfEditOrRevision int;

ALTER TABLE AcceptedQuestionsClone
ADD Asker_MinVotes float null;
ALTER TABLE AcceptedQuestionsClone
ADD Asker_MeanVotes float null;
ALTER TABLE AcceptedQuestionsClone
ADD Asker_MedianVotes float null;
ALTER TABLE AcceptedQuestionsClone
ADD Asker_MaxVotes float null;
ALTER TABLE AcceptedQuestionsClone
ADD Asker_VarianceVotes float null;

ALTER TABLE AcceptedQuestionsClone
ADD Asker_MinDwnVotes float null;
ALTER TABLE AcceptedQuestionsClone
ADD Asker_MeanDwnVotes float null;
ALTER TABLE AcceptedQuestionsClone
ADD Asker_MedianDwnVotes float null;
ALTER TABLE AcceptedQuestionsClone
ADD Asker_MaxDwnVotes float null;
ALTER TABLE AcceptedQuestionsClone
ADD Asker_VarianceDwnVotes float null;

alter table AcceptedQuestionsClone
  add Asker_25PercentileVotes float null
  alter table AcceptedQuestionsClone
  add Asker_25PercentileDwnVotes float null
  alter table AcceptedQuestionsClone
  add Asker_NoOfRevision int null;
    alter table AcceptedQuestionsClone
  add Asker_NoOfRevisionInAnswer int null;
  alter table AcceptedQuestionsClone
  add Q_NoOfFavCount int null;


  ----#### populate main table with imported data from excel and calculating other factors data from the SO database.
  --- ## update main table of FavoriteCount for questions using joins  
  UPDATE t1
  SET 
  t1.Q_NoOfFavCount = t2.FavoriteCount --(select count(*) from Posts where ParentId = t1.PostId 
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.posts AS t2
  ON t1.postid = t2.id

   -- ##### Update code postion that extracted using java tools ####-----
  select * from QuestionsCodeRatioFromTags1
  select * from AnswersCodeRatioFromTags

  UPDATE t1
  SET 
  t1.Q_codeRatio = t2.column7,
  t1.Q_CodeRatioPercentage = t2.column8,
  t1.Q_LinkTags = t2.column4,
  t1.Q_ItalicTags = t2.column5,
  t1.Q_TotalCodeLength = t2.column9,
  t1.Q_NoOfCodeSnippets = t2.column2,
  t1.Q_NoOfBoldTags = t2.column3
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.QuestionsCodeRatioFromTags1 AS t2
  ON t1.PostId = t2.column1

  ---## Count no of answers of each questions and seperately store in other table 
  select * into NoOfAnswersOfEachQuestions1 from (
  select p.ParentId , count(*) AnswersCount   from Posts p
  inner join AcceptedQuestionsClone Q
  on p.ParentId = Q.PostId
  where Year(CreationDate) <= 2018 and PostTypeId = 2
  group by p.ParentId ) a

  select * from NoOfAnswersOfEachQuestions1

  UPDATE t1
  SET 
  t1.Q_NoOfAnswers = t2.AnswersCount --(select count(*) from Posts where ParentId = t1.PostId 
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.NoOfAnswersOfEachQuestions1 AS t2
  ON t1.postid = t2.ParentId

   ---#### Update users info --- 
  UPDATE t1
  SET 
  t1.Asker_ReputationScore = t2.Reputation,
  t1.Asker_Upvotes = t2.UpVotes,
  t1.Asker_DownVotes = t2.DownVotes
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.Users AS t2
  ON t1.Q_ownerId = t2.Id

  ---## No of revision of a specific users in specific Questions 
  select * from NoOfRevisionByUsersInAnswer1
  select * into NoOfRevisionByUsersInAnswer1 from (
  select  ph.PostId,ph.UserId, count(*) userAnsRevisedCount  from PostHistory ph
  where Year(ph.CreationDate) <= 2018
  group by ph.PostId,ph.UserId) d

  UPDATE t1
  SET 
  t1.Asker_NoOfRevisionInAnswer = t2.userAnsRevisedCount
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.NoOfRevisionByUsersInAnswer1 AS t2
  ON t1.Q_ownerId = t2.UserId and t1.PostId = t2.PostId

  ---## No of revision of a specific users
  select * into NoOfRevisionByUsers1 from (
  select  ph.UserId, count(*) userRevisedCount  from PostHistory ph
  where Year(ph.CreationDate) <= 2018
  group by ph.UserId) d

  UPDATE t1
  SET 
  t1.Asker_NoOfRevision = t2.userRevisedCount 
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.NoOfRevisionByUsers1 AS t2
  ON t1.Q_ownerId = t2.UserId 

   ---## No of revision of specific answers
  select * into NoOfRevisionOfAnswer1 from (
  select  ph.PostId, count(*) revisionCount  from PostHistory ph
  where Year(ph.CreationDate) <= 2018
  group by ph.PostId) c

  UPDATE t1
  SET 
  t1.Q_NoOfEditOrRevision = t2.revisionCount 
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.NoOfRevisionOfAnswer1 AS t2
  ON t1.PostId = t2.PostId 

   ---## Number of posted Questions/Answers of a specific users 
  select * into NoOfPostByUsersAnswer1 from (
  select  p.PostTypeId,p.OwnerUserId, count(*) PostCount  from posts p
  where Year(p.CreationDate) <= 2018
  group by p.PostTypeId, p.OwnerUserId) b

  UPDATE t1
  SET 
  t1.Asker_PostedQuestions = t2.PostCount 
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.NoOfPostByUsersAnswer1 AS t2
  ON t1.Q_ownerId = t2.OwnerUserId and t2.PostTypeId = 1 
 
  UPDATE t1
  SET 
  t1.Asker_PostedAnswers = t2.PostCount 
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.NoOfPostByUsersAnswer1 AS t2
  ON t1.Q_ownerId = t2.OwnerUserId and t2.PostTypeId = 2 

  ---## Comments of each Questions
  select * into NoOfCommentsEachAnswers1 from (
  select c.PostId , count(*) CommentCount   from Comments c
  where Year(CreationDate) <= 2018
  group by c.PostId ) a
  
  UPDATE t1
  SET 
  t1.Q_NoOfComments = t2.CommentCount 
  FROM dbo.AcceptedQuestionsClone AS t1
  INNER JOIN dbo.NoOfCommentsEachAnswers1 AS t2
  ON t1.postid = t2.PostId

   ---## For calculating Mean, median, varinace and so on of  Asker votes (up & down) 
  ------ extracting it in excel file and importing  this data in R and again import back after calculation all the term
  select p.id, p.OwnerUserId, ac.postid,v.VoteTypeId  from Votes v
  inner join  AcceptedQuestionsClone ac
  on  v.PostId = ac.PostId and v.VoteTypeId in (2,3)
  inner join posts p
  on ac.postid = p.id 
  --where p.id > 18828813
  order by p.id 
  --- 209447
  ---------------------
  select * from AcceptedQuestionsClone
  where PostId > 36763880
  order by PostId asc

  Uid,	PostId,	SnippetId,	CloneClassnumber,	CloneSize,	Similarity,	CodeLength,	Grunality,	Q_ownerId,	Q_NooffavouriteCount,	Q_length,	Q_CreationDate,	Q_CreateDate,	Q_TtleLength,	Q_NoofViewCount,	Q_Score	Q_NoOfAnswers,	Asker_ReputationScore,	Asker_Upvotes,	Asker_DownVotes,	Asker_PostedQuestions,	Asker_PostedAnswers,	Q_NoOfTags,	Q_codeRatio,	Q_CodeRatioPercentage