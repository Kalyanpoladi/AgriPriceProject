"""
AgriPrice Project - Data Cleaning Script
Reads raw AgMarkNet Excel -> cleans -> saves processed CSV
"""
import pandas as pd
from pathlib import Path

RAW = Path("data/raw/Agnamarket.xlsx")
OUT = Path("data/processed/clean_agri_data.csv")

def clean():
    print("1. Reading raw data...")
    df = pd.read_excel(RAW, header=1)

    print("2. Dropping nulls and duplicates...")
    df = df.dropna().drop_duplicates()

    print("3. Renaming columns...")
    df.columns = [c.strip() for c in df.columns]
    rename_map = {}
    for c in df.columns:
        if c.startswith("Arrival Quantity"):
            rename_map[c] = "Arrival_Quantity"
        if c.startswith("Modal Price"):
            rename_map[c] = "Modal_Price"
    df = df.rename(columns=rename_map)

    print("4. Standardizing commodity names...")
    df["Commodity"] = df["Commodity"].replace({
        "Ladies Finger": "Bhindi(Ladies Finger)"
    })

    print("5. Parsing Month to datetime...")
    df["Month_dt"] = pd.to_datetime(df["Month"], format="%B-%Y")
    df["Month_num"] = df["Month_dt"].dt.month
    df["Year"] = df["Month_dt"].dt.year

    print("6. Saving processed data...")
    OUT.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(OUT, index=False)

    print(f"DONE - {len(df)} rows saved to {OUT}")

if __name__ == "__main__":
    clean()
