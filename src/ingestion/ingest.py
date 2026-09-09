import pandas as pd

df = pd.read_csv("data/raw/campaign_data.csv")
print(f"Number of rows: {df.shape[0]}")
print(f"Number of columns: {df.shape[1]}")
print("")
print(df.head(5))
print(df.dtypes)
print(df.isnull().sum())
print(f"Number of duplicated rows: {df.duplicated().sum()}")
print(f"Number of negative spend values: {df[df['spend'] < 0].shape[0]}")
print(df["platform"].value_counts())
for i in ["impressions", "clicks", "conversions"]:
        print(f"Invalid {i}: {df[df[i] <= 0].shape[0]}")
for i in ["spend", "revenue"]:
        print(f"Invalid {i}: {df[df[i] < 0].shape[0]}")
df["date"] = pd.to_datetime(df["date"], errors="coerce")
print(f"Number of invalid dates: {df['date'].isnull().sum()}")
columns = [
    "campaign_id",
    "campaign_name",
    "platform",
    "date",
    "country",
    "campaign_objective",
    "ad_type",
    "impressions",
    "clicks",
    "conversions",
    "spend",
    "revenue",
]
print(f"Missing columns: {set(columns) - set(df.columns)}")
