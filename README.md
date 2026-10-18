# Spotify Wrapped Analytics

An end-to-end music chart analytics project built using **Python, Pandas, SQL Server, and Power BI**. This project transforms public Spotify Top 50 chart data into an interactive, Spotify-inspired dashboard that explores song popularity, artist performance, and chart-position trends.

## Project Overview

This project analyzes daily Top 50 music chart data to understand which songs and artists consistently perform well, how chart popularity changes over time, and how chart positions are distributed.

The project follows a data analytics workflow from raw CSV data through Python data preparation and SQL Server storage to interactive Power BI visualizations.

> **Note:** This project analyzes public chart data; it is not based on an individual's personal Spotify listening history.

## Tools & Technologies

- **Python:** data inspection and cleaning
- **Pandas:** data manipulation and transformation
- **SQL Server:** structured data storage, analytical queries, and validation
- **Power BI:** interactive dashboards and visual analytics
- **DAX:** measures and calculated fields
- **Git & GitHub:** project version control and documentation

## Data Overview

The dataset contains daily global Top 50 chart records.

| Attribute | Details |
|---|---|
| Source format | CSV |
| Chart records | 27,800 |
| Chart dates | 556 |
| Entries per chart date | 50 |
| Chart date range | 18 May 2023 – 27 November 2024 |

The dataset includes fields such as chart date, position, song, artist, popularity, duration, album type, release date, explicit-content status, and album cover URL.

## Project Workflow

1. **Data inspection:** examined the raw dataset, column types, date coverage, and chart-position consistency.
2. **Data cleaning:** used Python and Pandas to standardize date fields, create analytical features, and export the processed dataset.
3. **SQL data modeling:** loaded the prepared data into SQL Server and organized it for analysis using a date dimension and chart fact table.
4. **Data validation and analysis:** checked data quality and used SQL aggregations, rankings, and joins to explore songs, artists, albums, and monthly trends.
5. **Power BI development:** connected the warehouse to Power BI, created analytical visuals, and applied a dark Spotify-inspired design.

### Python Data Inspection

The `python/python01_inspection.py` script performs an initial inspection of the raw dataset using Python and Pandas.

- Loads the CSV from the project's `raw/` directory using a project-relative path.
- Converts chart dates and song release dates into datetime formats.
- Checks chart-date continuity and identifies gaps greater than one day.
- Validates the number of unique chart positions recorded for each date.
- Reports dates with fewer than 50 unique chart positions.

The script prints validation results to the console and does not modify the source dataset.

### Python Data Cleaning and Feature Engineering

The `python/python02_cleaning.py` script prepares the raw chart data for SQL analysis and Power BI reporting.

- Loads `raw/spotify-top-50-world.csv` and writes the processed dataset to `processed/spotify_top50_clean.csv`.
- Converts chart dates and release dates into datetime formats.
- Adds release year, chart year, chart month, month name, and month-year fields.
- Calculates song-level metrics: days on chart, average position, peak position, and chart appearances.
- Calculates artist-level chart appearances and average position.
- Creates an `is_top_10` flag for chart positions 10 or better.
- Saves the enriched CSV without the DataFrame index and prints output details for validation.

The script adds analytical features to each chart record; it does not reduce the dataset to one row per song or artist.

### SQL Analysis and Validation

The project includes four SQL scripts in the `sql/` directory. They use the `SpotifyWrapped` SQL Server database and the `stg_Spotify`, `DimDate`, and `FactSpotifyChart` tables.

#### 1. Schema Inspection — `01_inspect_table_schema.sql`

- Inspects the staging table, date dimension, and chart fact table through `INFORMATION_SCHEMA.COLUMNS`.
- Reports column names, data types, nullability, and ordinal positions.

#### 2. Data Quality Validation — `02_data_quality_validation.sql`

- Counts chart entries and distinct songs and artists.
- Checks missing or blank song and artist values.
- Identifies repeated song–artist entries on the same chart date.
- Reports chart date coverage and the number of distinct chart dates.

#### 3. Song and Artist Analysis — `03_song_artist_analysis.sql`

- Ranks songs by chart appearances and reports best and average positions.
- Ranks artists by chart appearances, unique-song counts, and average position.
- Identifies songs with high average and peak popularity.
- Summarizes monthly chart entries, unique songs, and average popularity using the date dimension.

#### 4. Album and Chart Performance — `04_album_and_chart_performance.sql`

- Compares chart entries, unique songs, and average popularity by album type.
- Groups song–artist combinations by best chart position: No. 1, Top 5, Top 10, or Top 50.
- Ranks artists by average chart position and songs by average popularity.

Together, the SQL scripts demonstrate schema inspection, data-quality validation, aggregation, grouping, ranking, CTEs, and joins.

## Dashboard Pages

### 1. Spotify Wrapped

- Summarizes chart entries, unique songs, and unique artists with KPI cards.
- Highlights a selected song's peak position, average position, and chart appearances.
- Shows songs with the most chart appearances and monthly popularity trends.

### 2. Music Trends

- Tracks unique songs by month.
- Compares artists by chart appearances.
- Highlights songs with high average popularity.
- Shows the distribution of chart entries by album type.

### 3. Artist & Song Performance

- Ranks artists by average chart position.
- Shows peak-position bands: No. 1, Top 5, Top 10, and Top 50.
- Compares songs by average popularity.

### Key DAX Measures and Calculated Columns

- `Unique Songs` — counts distinct song titles.
- `Unique Artists` — counts distinct artist names.
- `AlbumType_Display` — provides a display-friendly album-type category for visuals.
- `Peak Position Band` — classifies each song–artist combination using its best chart position.

The report connects `FactSpotifyChart[ChartDate]` to `DimDate[Date]` through an active many-to-one relationship, enabling date-based filtering and trend analysis.

## Dashboard Preview

### Page 1 — Spotify Wrapped

![Spotify Wrapped Dashboard](screenshots/page1_spotify_wrapped.png)

### Page 2 — Music Trends

![Music Trends Dashboard](screenshots/page2_music_trends.png)

### Page 3 — Artist & Song Performance

![Artist & Song Performance Dashboard](screenshots/page3_artist_song_performance.png)

## Key Analytical Areas

- Song popularity comparisons
- Artist chart appearances and performance
- Monthly chart trends
- Peak chart-position distribution
- Album-type distribution
- Data quality and SQL validation

## Repository Structure

```text
Spotify-Wrapped-Analytics/
├── raw/
│   └── spotify-top-50-world.csv
├── processed/
│   └── spotify_top50_clean.csv
├── python/
│   ├── python01_inspection.py
│   └── python02_cleaning.py
├── sql/
│   ├── 01_inspect_table_schema.sql
│   ├── 02_data_quality_validation.sql
│   ├── 03_song_artist_analysis.sql
│   └── 04_album_and_chart_performance.sql
├── powerbi/
│   ├── Icons/
│   └── Spotify_Wrapped_Analytics.pbix
└── screenshots/
    ├── page1_spotify_wrapped.png
    ├── page2_music_trends.png
    └── page3_artist_song_performance.png
```

## How to Explore the Project

1. Review the Python scripts to understand the inspection and cleaning process.
2. Open the SQL scripts to explore data modeling, validation, and analytical queries.
3. Open the Power BI report to explore the three dashboard pages.
4. Review the dashboard screenshots in the `screenshots/` directory.

## Skills Demonstrated

- Data profiling and quality checks
- Python data cleaning with Pandas
- SQL querying and data validation
- Dimensional data modeling
- Power BI dashboard development
- DAX and data visualization
- End-to-end analytics project development

## Project Goal

To demonstrate an end-to-end data analytics workflow by transforming raw music chart data into a validated analytical dataset and an interactive dashboard.

---

*This is an independent analytics project using public chart data and is not affiliated with Spotify.*