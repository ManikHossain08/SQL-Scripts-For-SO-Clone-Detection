--INSERT INTO dbo.Tags SELECT * FROM [StackOverflow].dbo.Tags

select * into AcceptedAnswersClone from (
select *, 'Blocks' Grunality from AcceptedBlocksClone 
UNION ALL 
select *, 'Functions' Grunality from AcceptedFunctionsClone
) a


--## HOW MANY UNIQUE ANSWERS FROM BLOCKS AND FUNCTIONS ##-----
SELECT DISTINCT (PostId) FROM AcceptedBlocksClone --5517
SELECT DISTINCT (PostId) FROM AcceptedFunctionsClone --10799  

--### COMMON NUMBER OF ANSWERS FROM BOTH FUNCTIONS AND ANSWERS = 71
select distinct(f.PostId) from AcceptedBlocksClone b
inner join AcceptedFunctionsClone f
on b.PostId = f.PostId


--### For each Answers (Blocks) how many clones are there OVERALL : 5841 ### ----
select postId EachAnswers_Blocks, count(*) howManyClones from AcceptedAnswersClone 
where Grunality = 'Blocks'
group by postId
order by count(*) desc, PostId DESC 

--### For each Answers (Blocks) how many are there IN SPECIFIC CLONE CLASS TYPE : 6137 ### ----
select postId EachAnswers_Blocks,CloneClassnumber CloneClassType, count(*) howManyClones from AcceptedAnswersClone 
where Grunality = 'Blocks'
group by postId, CloneClassnumber
order by count(*) desc, PostId DESC


--### For each Answers (Functions) how many clones are there OVERALL :12,517 ### ----
select postId EachAnswers_Functions, count(*) howManyClones from AcceptedAnswersClone 
where Grunality = 'Functions'
group by postId
order by count(*) desc, PostId DESC 

--### For each Answers (Functions) how many are there IN SPECIFIC CLONE CLASS TYPE : 14,750 ### ----
select postId EachAnswers_Functions,CloneClassnumber CloneClassType, count(*) howManyClones from AcceptedAnswersClone 
where Grunality = 'Functions'
group by postId, CloneClassnumber
order by count(*) desc, PostId DESC


--### For each Answers posted time interval ### ----
select EachAnswers_,CloneClassnumber cloneClassType, p.CreationDate, howManyClones   from (
select postId EachAnswers_,CloneClassnumber, count(*) howManyClones from AcceptedAnswersClone 
where Grunality = 'Functions'
group by postId, CloneClassnumber
) a 
inner join Posts p
on a.EachAnswers_ = p.Id 
order by CloneClassnumber desc


--### For each Answers posted time interval ### ---- CANCEL
select EachAnswers_,CloneClassnumber cloneClassType, p.CreationDate,howManyClones   from (
select distinct (postId) EachAnswers_,CloneClassnumber, count(*) howManyClones from AcceptedAnswersClone 
where Grunality = 'Blocks'
group by postId, CloneClassnumber
) a 
inner join Posts p
on a.EachAnswers_ = p.Id 
order by CloneClassnumber desc


--### For each Answers(Functions) with group time interval ### ----
select postId EachAcceptedAnswersId,CloneClassnumber CloneType,p.ParentId questionsId, p.CreationDate, p.Score, aac.Grunality from AcceptedAnswersClone aac
inner join Posts p
on aac.postId = p.Id and Grunality = 'Functions'
order by CloneClassnumber asc

--### For each Answers(Blocks) with groups time interval ### ----
select postId EachAcceptedAnswersId,CloneClassnumber CloneType,p.ParentId questionsId, p.CreationDate, p.Score, aac.Grunality from AcceptedAnswersClone aac
inner join Posts p
on aac.postId = p.Id and Grunality = 'Blocks'
order by CloneClassnumber asc

--### Export data For Importing into R ### ----
select postId EachAcceptedAnswersId,CloneClassnumber CloneType,p.ParentId questionsId, p.CreationDate, p.Score, aac.Grunality from AcceptedAnswersClone aac
inner join Posts p
on aac.postId = p.Id --and Grunality = 'Blocks'
order by CloneClassnumber asc

--### Populating data For mix-model in R ### ---- sample data

select answers.*, p.FavoriteCount,p.ViewCount, Len(p.Body) bodyLength, Len(p.Title) titleLength from (
select postId AnswersId,CloneClassnumber CloneType,p.ParentId questionsId, p.CreationDate, p.Score, aac.Grunality
from AcceptedAnswersClone aac
inner join Posts p
on aac.postId = p.Id and CloneClassnumber in (2,3,10,11,12,13,14,15) and Grunality = 'Functions'
--order by CloneClassnumber asc
) answers 
inner join posts p on answers.questionsId = p.id

----########## careate more column to Populate data for answers #########------------

ALTER TABLE AcceptedAnswersClone
ADD A_ownerId int;
ALTER TABLE AcceptedAnswersClone
ADD A_length int;
ALTER TABLE AcceptedAnswersClone
ADD A_CreateDate datetime;
ALTER TABLE AcceptedAnswersClone
ADD A_Score int;
ALTER TABLE AcceptedAnswersClone
ADD A_codeRatio int;
-----
ALTER TABLE AcceptedAnswersClone
ADD A_CodeRatioPercentage int;
ALTER TABLE AcceptedAnswersClone
ADD A_LinkTags int;
ALTER TABLE AcceptedAnswersClone
ADD A_ItalicTags int;
ALTER TABLE AcceptedAnswersClone
ADD A_TotalCodeLength int;
------------
ALTER TABLE AcceptedAnswersClone
ADD A_NoOfBoldTags int;
ALTER TABLE AcceptedAnswersClone
ADD A_NoOfCodeSnippets int;
ALTER TABLE AcceptedAnswersClone
ADD A_NoOfComments int;
ALTER TABLE AcceptedAnswersClone
ADD A_NoOfEditOrRevision int;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_NoOfAnswers int;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_ReputationScore int;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_Upvotes int;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_DownVotes int;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_PostedQuestions int;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_PostedAnswers int;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_MinVotes float null;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_MeanVotes float null;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_MedianVotes float null;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_MaxVotes float null;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_VarianceVotes float null;

ALTER TABLE AcceptedAnswersClone
ADD Answerer_MinDwnVotes float null;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_MeanDwnVotes float null;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_MedianDwnVotes float null;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_MaxDwnVotes float null;
ALTER TABLE AcceptedAnswersClone
ADD Answerer_VarianceDwnVotes float null;

alter table AcceptedAnswersClone
  add Answerer_25PercentileVotes float null
  alter table AcceptedAnswersClone
  add Answerer_25PercentileDwnVotes float null
  alter table AcceptedAnswersClone
  add Answerer_NoOfRevision int null;
    alter table AcceptedAnswersClone
  add Answerer_NoOfRevisionInAnswer int null;


UPDATE t1
  SET 
  t1.A_length = len(t2.body) 
  --t1.A_ownerId = t2.OwnerUserId
  --t1.A_CreateDate = t2.CreationDate
  --t1.A_Score = t2.Score
  --t1.Q_NoOfAnswers = (select count(*) from Posts where ParentId = t2.id), t1.Q_NoOfTags= (select count(*) from dbo.Split(t2.Tags,'<'))

  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.posts AS t2
  ON t1.postid = t2.id

  select * from AcceptedAnswersClone

  ---### extracting data for finding the code ratio #####-------
  select cast(answers.Id as varchar(20))+'<postid>'+answers.Body Body from AcceptedAnswersClone a 
  inner join posts answers
  on a.PostId = answers.Id

  ---## For calculating Mean, median, varinace and so on of  Answerer votes (up & down) 
  ------ extracting it in excel file and importing  this data in R and again import back after calculation all the term
  select p.id, p.OwnerUserId, ac.postid,v.VoteTypeId  from Votes v
  inner join  AcceptedAnswersClone ac
  on  v.PostId = ac.PostId and v.VoteTypeId in (2,3)
  inner join posts p
  on ac.postid = p.id 
  where p.id > 18828813
  order by p.id 

  ---## Comments of each answers
  select * into NoOfCommentsEachAnswers1 from (
  select c.PostId , count(*) CommentCount   from Comments c
  where Year(CreationDate) <= 2018
  group by c.PostId ) a
  
  UPDATE t1
  SET 
  t1.A_NoOfComments = t2.CommentCount 
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.NoOfCommentsEachAnswers1 AS t2
  ON t1.postid = t2.PostId

   ---## posted Questions/Answers of a specific users 
  select * into NoOfPostByUsersAnswer1 from (
  select  p.PostTypeId,p.OwnerUserId, count(*) PostCount  from posts p
  where Year(p.CreationDate) <= 2018
  group by p.PostTypeId, p.OwnerUserId) b

  UPDATE t1
  SET 
  t1.Answerer_PostedQuestions = t2.PostCount 
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.NoOfPostByUsersAnswer1 AS t2
  ON t1.A_ownerId = t2.OwnerUserId and t2.PostTypeId = 1 
 
  UPDATE t1
  SET 
  t1.Answerer_PostedAnswers = t2.PostCount 
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.NoOfPostByUsersAnswer1 AS t2
  ON t1.A_ownerId = t2.OwnerUserId and t2.PostTypeId = 2 

     ---## No of revision of specific answers
  select * into NoOfRevisionOfAnswer1 from (
  select  ph.PostId, count(*) revisionCount  from PostHistory ph
  where Year(ph.CreationDate) <= 2018
  group by ph.PostId) c

  UPDATE t1
  SET 
  t1.A_NoOfEditOrRevision = t2.revisionCount 
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.NoOfRevisionOfAnswer1 AS t2
  ON t1.PostId = t2.PostId 


  select * from AcceptedAnswersClone

  ---## No of revision of a specific users
  select * into NoOfRevisionByUsers1 from (
  select  ph.UserId, count(*) userRevisedCount  from PostHistory ph
  where Year(ph.CreationDate) <= 2018
  group by ph.UserId) d

  UPDATE t1
  SET 
  t1.Answerer_NoOfRevision = t2.userRevisedCount 
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.NoOfRevisionByUsers1 AS t2
  ON t1.A_ownerId = t2.UserId 

    ---## No of revision of a specific users in specific answers 
  select * into NoOfRevisionByUsersInAnswer1 from (
  select  ph.PostId,ph.UserId, count(*) userAnsRevisedCount  from PostHistory ph
  where Year(ph.CreationDate) <= 2018
  group by ph.PostId,ph.UserId) d

  UPDATE t1
  SET 
  t1.Answerer_NoOfRevisionInAnswer = t2.userAnsRevisedCount
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.NoOfRevisionByUsersInAnswer1 AS t2
  ON t1.A_ownerId = t2.UserId and t1.PostId = t2.PostId

  -- ##### Update code postion that extracted from java code ####-----
  select * from AcceptedAnswersClone

  UPDATE t1
  SET 
  t1.A_codeRatio = t2.codeRatio,
  t1.A_CodeRatioPercentage = t2.codeRatioPercentage,
  t1.A_LinkTags = t2.LinkTags,
  t1.A_ItalicTags = t2.ItalicTags,
  t1.A_TotalCodeLength = t2.totalCodeLength,
  t1.A_NoOfCodeSnippets = t2.NoOfcodeSnippet,
  t1.A_NoOfBoldTags = t2.BoldTags
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.AnswersCodeRatioFromTags AS t2
  ON t1.PostId = t2.PostId
  
  ---#### Update users info --- 

  UPDATE t1
  SET 
  t1.Answerer_ReputationScore = t2.Reputation,
  t1.Answerer_Upvotes = t2.UpVotes,
  t1.Answerer_DownVotes = t2.DownVotes
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.Users AS t2
  ON t1.A_ownerId = t2.Id

--- ##### update users Up Vote terms in the factors table
  UPDATE t1
  SET 
  t1.Answerer_MinVotes = t2.minValue,
  t1.Answerer_MeanVotes = t2.EachGroup_Mean,
  t1.Answerer_MedianVotes = t2.EachGroup_Median,
  t1.Answerer_MaxVotes = t2.CloneGroupMax,
  t1.Answerer_VarianceVotes = t2.CloneGroupVariance,
  t1.Answerer_25PercentileVotes = t2.Percentile25
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.CalculatedAnswerersUpvote AS t2
  ON t1.A_ownerId = t2.UserId

  --- ##### update users down Vote terms in the factors table
  alter table AcceptedAnswersClone
  
  
  UPDATE t1
  SET 
  t1.Answerer_MinDwnVotes = t2.minValue,
  t1.Answerer_MeanDwnVotes = t2.EachGroup_Mean,
  t1.Answerer_MedianDwnVotes = t2.EachGroup_Median,
  t1.Answerer_MaxDwnVotes = t2.CloneGroupMax,
  t1.Answerer_VarianceDwnVotes = t2.CloneGroupVariance,
  t1.Answerer_25PercentileDwnVotes = t2.Percentile25
  FROM dbo.AcceptedAnswersClone AS t1
  INNER JOIN dbo.CalculatedAnswerersDownvote AS t2
  ON t1.A_ownerId = t2.UserId



 

















