from pathlib import Path
import pandas as pd

# Find the project folder
project_root = Path(__file__).resolve().parent.parent

# Load Spotify dataset
file_path = project_root / "raw" / "spotify-top-50-world.csv"

df = pd.read_csv(file_path)

# Convert date columns to proper datetime format
df["date"] = pd.to_datetime(
    df["date"],
    format="%d-%m-%Y"
)

df["release_date"] = pd.to_datetime(
    df["release_date"],
    format="mixed",
    dayfirst=True
)

print("\n--- DATE CONTINUITY ---")

sorted_dates = df["date"].drop_duplicates().sort_values()

date_gaps = sorted_dates.diff().dropna()

print("Smallest gap:", date_gaps.min())
print("Largest gap:", date_gaps.max())

print("\nGaps greater than 1 day:")
print(date_gaps[date_gaps > pd.Timedelta(days=1)])

print("\n--- POSITION VALIDATION ---")

position_counts = df.groupby("date")["position"].nunique()

print("Minimum unique positions per day:", position_counts.min())
print("Maximum unique positions per day:", position_counts.max())

print("\nDays without all 50 unique positions:")
print(position_counts[position_counts < 50])