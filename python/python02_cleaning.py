from pathlib import Path
import pandas as pd

# ============================================================
# 1. PROJECT PATHS
# ============================================================

project_root = Path(__file__).resolve().parent.parent

input_file = project_root / "raw" / "spotify-top-50-world.csv"
output_file = project_root / "processed" / "spotify_top50_clean.csv"


# ============================================================
# 2. LOAD RAW DATA
# ============================================================

df = pd.read_csv(input_file)

print("\n--- RAW DATA ---")
print("Rows:", len(df))
print("Columns:", len(df.columns))


# ============================================================
# 3. CONVERT DATE COLUMNS
# ============================================================

df["date"] = pd.to_datetime(
    df["date"],
    format="%d-%m-%Y"
)

df["release_date"] = pd.to_datetime(
    df["release_date"],
    format="mixed",
    dayfirst=True
)


# ============================================================
# 4. CREATE DATE ANALYSIS COLUMNS
# ============================================================

# Release year of the song
df["release_year"] = df["release_date"].dt.year

# Year in which the song appeared on the chart
df["chart_year"] = df["date"].dt.year

# Month number
df["chart_month"] = df["date"].dt.month

# Full month name
df["chart_month_name"] = df["date"].dt.strftime("%B")

# Month + Year label
df["chart_month_year"] = df["date"].dt.strftime("%b %Y")


# ============================================================
# 5. SONG PERFORMANCE METRICS
# ============================================================

# Number of unique days the song appeared on the chart
df["days_on_chart"] = (
    df.groupby("song")["date"]
    .transform("nunique")
)

# Average chart position for the song
df["avg_position"] = (
    df.groupby("song")["position"]
    .transform("mean")
)

# Best chart position achieved by the song
df["peak_position"] = (
    df.groupby("song")["position"]
    .transform("min")
)

# Total number of chart appearances
df["chart_appearances"] = (
    df.groupby("song")["song"]
    .transform("count")
)


# ============================================================
# 6. ARTIST PERFORMANCE METRICS
# ============================================================

# Total chart appearances for the artist
df["artist_chart_appearances"] = (
    df.groupby("artist")["artist"]
    .transform("count")
)

# Average chart position for the artist
df["artist_avg_position"] = (
    df.groupby("artist")["position"]
    .transform("mean")
)


# ============================================================
# 7. TOP 10 FLAG
# ============================================================

# True if the song was in the Top 10
df["is_top_10"] = df["position"] <= 10


# ============================================================
# 8. SAVE CLEAN DATASET
# ============================================================

df.to_csv(
    output_file,
    index=False
)


# ============================================================
# 9. FINAL VALIDATION
# ============================================================

print("\n--- CLEAN DATA ---")
print("Rows:", len(df))
print("Columns:", len(df.columns))

print(df.columns.tolist())

print("\nSaved to:")
print(output_file)

print("\nCleaning completed successfully.")