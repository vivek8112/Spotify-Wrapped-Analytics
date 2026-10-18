
USE SpotifyWrapped;
GO

-- 1. Chart entries by album type
SELECT
    AlbumType,
    COUNT(*) AS ChartEntries,
    COUNT(DISTINCT Song) AS UniqueSongs,
    AVG(CAST(Popularity AS DECIMAL(10,2))) AS AveragePopularity
FROM dbo.FactSpotifyChart
GROUP BY AlbumType
ORDER BY ChartEntries DESC;
GO

-- 2. Distribution by song's peak chart position
WITH SongPeak AS (
    SELECT
        Song,
        Artist,
        MIN(Position) AS PeakPosition
    FROM dbo.FactSpotifyChart
    GROUP BY Song, Artist
)
SELECT
    CASE
        WHEN PeakPosition = 1 THEN 'No. 1'
        WHEN PeakPosition <= 5 THEN 'Top 5'
        WHEN PeakPosition <= 10 THEN 'Top 10'
        ELSE 'Top 50'
    END AS PeakPositionBand,
    COUNT(*) AS SongCount
FROM SongPeak
GROUP BY
    CASE
        WHEN PeakPosition = 1 THEN 'No. 1'
        WHEN PeakPosition <= 5 THEN 'Top 5'
        WHEN PeakPosition <= 10 THEN 'Top 10'
        ELSE 'Top 50'
    END
ORDER BY MIN(PeakPosition);
GO

-- 3. Top 10 artists by average chart position
SELECT TOP 10
    Artist,
    COUNT(*) AS ChartEntries,
    AVG(CAST(Position AS DECIMAL(10,2))) AS AverageChartPosition,
    MIN(Position) AS BestPosition
FROM dbo.FactSpotifyChart
GROUP BY Artist
ORDER BY AverageChartPosition ASC, ChartEntries DESC;
GO

-- 4. Top 10 songs by average popularity
SELECT TOP 10
    Song,
    Artist,
    AVG(CAST(Popularity AS DECIMAL(10,2))) AS AveragePopularity,
    MIN(Position) AS BestChartPosition,
    COUNT(*) AS ChartAppearances
FROM dbo.FactSpotifyChart
GROUP BY Song, Artist
ORDER BY AveragePopularity DESC;
GO
