import pandas as pd

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
valid_platforms = ["Meta", "Google Ads", "TikTok", "LinkedIn"]


def load_data():
    df = pd.read_csv("data/raw/campaign_data.csv")
    return df



def validate_data(df):
    is_valid = True
    print(f"Number of rows: {df.shape[0]}")
    print(f"Number of columns: {df.shape[1]}")
    print("")
    print(df.head(5))
    print(df.dtypes)
    print(df.isnull().sum())
    duplicated_rows = df.duplicated().sum()
    print(f"Number of duplicated rows: {duplicated_rows}")
    if duplicated_rows > 0:
        is_valid = False
    invalid_platforms = (~df['platform'].isin(valid_platforms)).sum()
    print(f"Invalid platforms: {invalid_platforms}")
    if invalid_platforms > 0:
        is_valid = False
    for i in ["impressions", "clicks", "conversions"]:
        if df[df[i] <= 0].shape[0] > 0:
            print(f"Invalid {i}: {df[df[i] <= 0].shape[0]}")
            is_valid = False
        else:
            print(f"Invalid {i}: 0")
    for i in ["spend", "revenue"]:
        if df[df[i] < 0].shape[0] > 0:
            print(f"Invalid {i}: {df[df[i] < 0].shape[0]}")
            is_valid = False
        else:
            print(f"Invalid {i}: 0")
    date_check = pd.to_datetime(df["date"], errors="coerce")    
    invalid_dates = date_check.isnull().sum()
    print(f"Number of invalid dates: {invalid_dates}")
    if invalid_dates > 0:
        is_valid = False
    missing_columns = set(columns) - set(df.columns)
    print(f"Missing columns: {missing_columns}")
    if missing_columns:
        is_valid = False
    return is_valid



df = load_data()

is_valid = validate_data(df)
print(f"Data valid: {is_valid}")
if not is_valid:
    print("Data validation failed. Pipeline stopped.")
else:
    print("Data validation passed. Continuing pipeline.")

