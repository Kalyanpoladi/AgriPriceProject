"""
AgriPrice Project - Load cleaned CSV into MySQL
Reads data/processed/clean_agri_data.csv -> loads into agriprice.agri_prices
"""
import pandas as pd
from sqlalchemy import create_engine
from pathlib import Path

CSV = Path("data/processed/clean_agri_data.csv")

def load():
    print("1. Reading cleaned CSV...")
    df = pd.read_csv(CSV)

    print("2. Preparing date column...")
    df["Month_dt"] = pd.to_datetime(df["Month_dt"]).dt.date

    print("2.5. Aligning column names with MySQL table...")
    df = df.rename(columns={
        "State/UT": "State_UT",
        "Commodity Group": "Commodity_Group",
        "Arrival Unit": "Arrival_Unit",
        "Price Unit": "Price_Unit",
    })

    print("3. Connecting to MySQL...")
    engine = create_engine("mysql+mysqlconnector://root:NewPass123!@localhost:3306/agriprice")

    print("4. Loading rows into agri_prices...")
    df.to_sql("agri_prices", con=engine, if_exists="append", index=False)

    print(f"DONE - {len(df)} rows loaded into agriprice.agri_prices")

if __name__ == "__main__":
    load()
