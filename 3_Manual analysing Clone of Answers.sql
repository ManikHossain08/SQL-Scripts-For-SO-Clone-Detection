select distinct(postId) from AllAnswersBlocksClone
select distinct(postId) from AllAnswersFunctionsClone

--INSERT INTO dbo.Tags SELECT * FROM [StackOverflow].dbo.Tags

select * into AllAnswersClone from (
select *, 'Blocks' Grunality from AllAnswersBlocksClone 
UNION ALL 
select *, 'Functions' Grunality from AllAnswersFunctionsClone
) a

--## HOW MANY UNIQUE ANSWERS FROM BLOCKS AND FUNCTIONS ##-----
SELECT DISTINCT (PostId) FROM AllAnswersClone   --8865
where Grunality = 'Blocks'
SELECT DISTINCT (PostId) FROM AllAnswersClone --51214  
where Grunality = 'Functions'

--### COMMON NUMBER OF ANSWERS FROM BOTH FUNCTIONS AND ANSWERS = 71
select distinct(f.PostId) from AllAnswersBlocksClone b
inner join AllAnswersFunctionsClone f
on b.PostId = f.PostId


--### For each Answers (Blocks) how many clones are there OVERALL : 5841 ### ----
select postId EachQuestions_Blocks, count(*) howManyClones from AllAnswersClone 
where Grunality = 'Blocks'
group by postId
order by count(*) desc, PostId DESC 

--### For each Answers (Blocks) how many clones are there IN SPECIFIC CLONE CLASS TYPE : 6137 ### ----
select postId EachQuestions_Blocks,CloneClassnumber CloneClassType, count(*) howManyClones from AllAnswersClone 
where Grunality = 'Blocks'
group by postId, CloneClassnumber
order by count(*) desc, PostId DESC


--### For each Answers (Functions) how many clones are there OVERALL :12,517 ### ----
select postId EachAnswers_Functions, count(*) howManyClones from AllAnswersClone 
where Grunality = 'Functions'
group by postId
order by count(*) desc, PostId DESC 

--### For each Answers (Functions) how many are there IN SPECIFIC CLONE CLASS TYPE : 14,750 ### ----
select postId EachAnswers_Functions,CloneClassnumber CloneClassType, count(*) howManyClones from AllAnswersClone 
where Grunality = 'Functions'
group by postId, CloneClassnumber
order by count(*) desc, PostId DESC


--### For each Answers posted time interval ### ----
select EachAnswers_,CloneClassnumber cloneClassType, p.CreationDate,howManyClones, p.score   from (
select distinct (postId) EachAnswers_,CloneClassnumber, count(*) howManyClones from AllAnswersClone 
where Grunality = 'Functions'
group by postId, CloneClassnumber
) a 
inner join Posts p
on a.EachAnswers_ = p.Id 
order by CloneClassnumber desc


--### For each Answers group wise answers time interval ### ----
select EachAnswers_,ac.CloneClassnumber cloneClassType, p.CreationDate,howManyClones, p.score   from (
select distinct (postId) EachAnswers_, count(*) howManyClones from AllAnswersClone 
where Grunality = 'Functions'
group by postId 
) a 
inner join Posts p
on a.EachAnswers_ = p.Id 
inner join AllAnswersClone ac
on ac.postid = p.Id
order by CloneClassnumber desc


--### Each Answers(Functions) with group AND THEIR time interval ### ----
select postId EachAnswersId,CloneClassnumber CloneType,p.ParentId questionsId, p.CreationDate, p.Score, aac.Grunality from AllAnswersClone aac
inner join Posts p
on aac.postId = p.Id and Grunality = 'Functions'
order by CloneClassnumber asc

--### Each Answers(Blocks) with groups AND THEIR time interval ### ----
select postId EachAnswersId,CloneClassnumber CloneType,p.ParentId questionsId, p.CreationDate, p.Score, aac.Grunality from AllAnswersClone aac
inner join Posts p
on aac.postId = p.Id and Grunality = 'Blocks'
order by CloneClassnumber asc


