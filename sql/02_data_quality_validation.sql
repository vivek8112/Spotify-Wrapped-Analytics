
USE SpotifyWrapped;
GO

-- 1. Check total chart entries
SELECT
    COUNT(*) AS TotalChartEntries
FROM dbo.FactSpotifyChart;
GO

-- 2. Check unique songs and artists
SELECT
    COUNT(DISTINCT song) AS UniqueSongs,
    COUNT(DISTINCT artist) AS UniqueArtists
FROM dbo.FactSpotifyChart;
GO

-- 3. Check missing song or artist values
SELECT
    SUM(CASE WHEN song IS NULL OR LTRIM(RTRIM(song)) = ''
             THEN 1 ELSE 0 END) AS MissingSongs,
    SUM(CASE WHEN artist IS NULL OR LTRIM(RTRIM(artist)) = ''
             THEN 1 ELSE 0 END) AS MissingArtists
FROM dbo.FactSpotifyChart;
GO

-- 4. Check duplicate chart entries
SELECT
    ChartDate,
    song,
    artist,
    COUNT(*) AS DuplicateCount
FROM dbo.FactSpotifyChart
GROUP BY ChartDate, song, artist
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;
GO

-- 5. Check chart coverage by date
SELECT
    MIN(ChartDate) AS FirstChartDate,
    MAX(ChartDate) AS LastChartDate,
    COUNT(DISTINCT ChartDate) AS ChartDates
FROM dbo.FactSpotifyChart;
GO
