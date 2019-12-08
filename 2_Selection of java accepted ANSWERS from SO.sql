--#### select java accepted answer from SO using this SQL

DECLARE @STARTDATE DATETIME = '2008-01-01 00:00:00';
DECLARE @ENDDATE DATETIME = '2018-12-31 23:59:59';
DECLARE @NewLineChar AS CHAR(2) = CHAR(13);
declare @varDATE int = 2018;

with cteQuestions (id, AcceptedAnswerId) as (
SELECT id, AcceptedAnswerId  FROM 
  Posts AS Question 
  where    
  Question.Tags LIKE '%java%' AND 
  --Question.Body LIKE '%<code>%' and 
  posttypeid = 1 
  and question.creationdate BETWEEN @STARTDATE AND @ENDDATE
  and AcceptedAnswerId  is not null
  and id not in (
  SELECT d.id
  FROM Posts d  -- d=duplicate
    LEFT JOIN PostHistory ph ON ph.PostId = d.Id
    LEFT JOIN PostLinks pl ON pl.PostId = d.Id
    LEFT JOIN Posts o ON o.Id = pl.RelatedPostId  -- o=original
  WHERE
    d.PostTypeId = 1  -- 1=Question
    AND pl.LinkTypeId = 3  -- 3=duplicate
    AND ph.PostHistoryTypeId = 10  -- 10 = vote Close the Post
    and datepart(year,d.creationdate) <= @varDATE
  )
)
--## formatted result for exporting into CSV file for java tool where we extarct code snippets
select cast(answeres.Id as varchar(20))+'<postid>'+answeres.Body  
from  posts answeres
inner join ctequestions questions
on answeres.id = questions.AcceptedAnswerId 
and  answeres.posttypeid = 2
where 
datepart(year,answeres.creationdate) <= @varDATE  and 
answeres.Body LIKE '%<code>%' 
order by answeres.Id

