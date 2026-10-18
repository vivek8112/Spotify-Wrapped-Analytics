
USE SpotifyWrapped;
GO

-- 1. Top 10 songs by chart appearances
SELECT TOP 10
    song,
    artist,
    COUNT(*) AS ChartAppearances,
    MIN(position) AS BestPosition,
    AVG(CAST(position AS DECIMAL(10,2))) AS AveragePosition
FROM dbo.FactSpotifyChart
GROUP BY song, artist
ORDER BY ChartAppearances DESC, BestPosition ASC;
GO

-- 2. Top 10 artists by chart appearances
SELECT TOP 10
    artist,
    COUNT(*) AS ChartAppearances,
    COUNT(DISTINCT song) AS UniqueSongs,
    AVG(CAST(position AS DECIMAL(10,2))) AS AveragePosition
FROM dbo.FactSpotifyChart
GROUP BY artist
ORDER BY ChartAppearances DESC;
GO

-- 3. Top 10 songs by average popularity
SELECT TOP 10
    song,
    artist,
    AVG(CAST(popularity AS DECIMAL(10,2))) AS AveragePopularity,
    MAX(popularity) AS PeakPopularity
FROM dbo.FactSpotifyChart
GROUP BY song, artist
ORDER BY AveragePopularity DESC, PeakPopularity DESC;
GO

-- 4. Monthly chart activity
SELECT
    d.Year,
    d.Month,
    d.MonthName,
    COUNT(*) AS ChartEntries,
    COUNT(DISTINCT f.song) AS UniqueSongs,
    AVG(CAST(f.popularity AS DECIMAL(10,2))) AS AveragePopularity
FROM dbo.FactSpotifyChart AS f
INNER JOIN dbo.DimDate AS d
    ON f.ChartDate = d.[Date]
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;
GO
