DECLARE @TABLENAME AS VARCHAR(255)
SET @TABLENAME = 'AcceptedQuestionsClone'
SELECT 'UPDATE ' + @TableName  + ' SET ' + CAST(Name AS VARCHAR(255)) + ' = 0 
 WHERE ' + CAST(Name AS VARCHAR(255)) + ' IS NULL'
FROM sys.columns 
WHERE object_id = OBJECT_ID(@TABLENAME)
    --AND system_type_id = 56 -- int's only



UPDATE AcceptedQuestionsClone SET Uid = 0    WHERE Uid IS NULL
UPDATE AcceptedQuestionsClone SET PostId = 0    WHERE PostId IS NULL
UPDATE AcceptedQuestionsClone SET SnippetId = 0    WHERE SnippetId IS NULL
UPDATE AcceptedQuestionsClone SET CloneClassnumber = 0    WHERE CloneClassnumber IS NULL
UPDATE AcceptedQuestionsClone SET CloneSize = 0    WHERE CloneSize IS NULL
UPDATE AcceptedQuestionsClone SET Similarity = 0    WHERE Similarity IS NULL
UPDATE AcceptedQuestionsClone SET CodeLength = 0    WHERE CodeLength IS NULL
UPDATE AcceptedQuestionsClone SET Grunality = 0    WHERE Grunality IS NULL
UPDATE AcceptedQuestionsClone SET Q_ownerId = 0    WHERE Q_ownerId IS NULL
UPDATE AcceptedQuestionsClone SET Q_NooffavouriteCount = 0    WHERE Q_NooffavouriteCount IS NULL
UPDATE AcceptedQuestionsClone SET Q_length = 0    WHERE Q_length IS NULL
UPDATE AcceptedQuestionsClone SET Q_CreationDate = 0    WHERE Q_CreationDate IS NULL
UPDATE AcceptedQuestionsClone SET Q_CreateDate = 0    WHERE Q_CreateDate IS NULL
UPDATE AcceptedQuestionsClone SET Q_TtleLength = 0    WHERE Q_TtleLength IS NULL
UPDATE AcceptedQuestionsClone SET Q_NoofViewCount = 0    WHERE Q_NoofViewCount IS NULL
UPDATE AcceptedQuestionsClone SET Q_Score = 0    WHERE Q_Score IS NULL
UPDATE AcceptedQuestionsClone SET Q_NoOfAnswers = 0    WHERE Q_NoOfAnswers IS NULL
UPDATE AcceptedQuestionsClone SET Asker_ReputationScore = 0    WHERE Asker_ReputationScore IS NULL
UPDATE AcceptedQuestionsClone SET Asker_Upvotes = 0    WHERE Asker_Upvotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_DownVotes = 0    WHERE Asker_DownVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_PostedQuestions = 0    WHERE Asker_PostedQuestions IS NULL
UPDATE AcceptedQuestionsClone SET Asker_PostedAnswers = 0    WHERE Asker_PostedAnswers IS NULL
UPDATE AcceptedQuestionsClone SET Q_NoOfTags = 0    WHERE Q_NoOfTags IS NULL
UPDATE AcceptedQuestionsClone SET Q_codeRatio = 0    WHERE Q_codeRatio IS NULL
UPDATE AcceptedQuestionsClone SET Q_CodeRatioPercentage = 0    WHERE Q_CodeRatioPercentage IS NULL
UPDATE AcceptedQuestionsClone SET Q_LinkTags = 0    WHERE Q_LinkTags IS NULL
UPDATE AcceptedQuestionsClone SET Q_ItalicTags = 0    WHERE Q_ItalicTags IS NULL
UPDATE AcceptedQuestionsClone SET Q_TotalCodeLength = 0    WHERE Q_TotalCodeLength IS NULL
UPDATE AcceptedQuestionsClone SET Q_NoOfBoldTags = 0    WHERE Q_NoOfBoldTags IS NULL
UPDATE AcceptedQuestionsClone SET Q_NoOfCodeSnippets = 0    WHERE Q_NoOfCodeSnippets IS NULL
UPDATE AcceptedQuestionsClone SET Q_NoOfComments = 0    WHERE Q_NoOfComments IS NULL
UPDATE AcceptedQuestionsClone SET Q_NoOfEditOrRevision = 0    WHERE Q_NoOfEditOrRevision IS NULL
UPDATE AcceptedQuestionsClone SET Asker_MinVotes = 0    WHERE Asker_MinVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_MeanVotes = 0    WHERE Asker_MeanVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_MedianVotes = 0    WHERE Asker_MedianVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_MaxVotes = 0    WHERE Asker_MaxVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_VarianceVotes = 0    WHERE Asker_VarianceVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_MinDwnVotes = 0    WHERE Asker_MinDwnVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_MeanDwnVotes = 0    WHERE Asker_MeanDwnVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_MedianDwnVotes = 0    WHERE Asker_MedianDwnVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_MaxDwnVotes = 0    WHERE Asker_MaxDwnVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_VarianceDwnVotes = 0    WHERE Asker_VarianceDwnVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_25PercentileVotes = 0    WHERE Asker_25PercentileVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_25PercentileDwnVotes = 0    WHERE Asker_25PercentileDwnVotes IS NULL
UPDATE AcceptedQuestionsClone SET Asker_NoOfRevision = 0    WHERE Asker_NoOfRevision IS NULL
UPDATE AcceptedQuestionsClone SET Asker_NoOfRevisionInAnswer = 0    WHERE Asker_NoOfRevisionInAnswer IS NULL
UPDATE AcceptedQuestionsClone SET Q_NoOfFavCount = 0    WHERE Q_NoOfFavCount IS NULL


delete from AcceptedQuestionsClone where CloneClassnumber in (select X1 from ZeroVarAnswersFunctions)
and Grunality = 'Functions'

delete from AcceptedQuestionsClone where CloneClassnumber in (select X1 from ZeroVarAnswerBlocks)
and Grunality = 'Blocks'