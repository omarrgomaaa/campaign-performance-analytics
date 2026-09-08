import random
from datetime import date, timedelta

import pandas as pd


PLATFORMS = ["Meta", "Google Ads", "TikTok", "LinkedIn"]
COUNTRIES = ["Egypt", "Saudi Arabia", "UAE", "UK", "USA"]
OBJECTIVES = ["Conversions", "Traffic", "Awareness", "Lead Generation"]
AD_TYPES = ["Image", "Video", "Carousel", "Story"]

CAMPAIGN_NAMES = [
    "Summer Sale",
    "Back to School",
    "New Product Launch",
    "Ramadan Offers",
    "Black Friday",
    "Winter Collection",
    "Eid Offers",
    "Brand Awareness",
    "Free Shipping",
    "Flash Sale",
]

PLATFORM_MULTIPLIERS = {
    "Meta": 1.0,
    "Google Ads": 1.15,
    "TikTok": 0.9,
    "LinkedIn": 1.3,
}


def generate_campaign_data(num_rows=10000):
    random.seed(42)

    start_date = date(2026, 1, 1)
    rows = []

    for i in range(num_rows):
        platform = random.choice(PLATFORMS)
        country = random.choice(COUNTRIES)
        objective = random.choice(OBJECTIVES)
        ad_type = random.choice(AD_TYPES)
        campaign_name = random.choice(CAMPAIGN_NAMES)

        campaign_id = f"CMP{i + 1:05d}"

        random_days = random.randint(0, 242)
        campaign_date = start_date + timedelta(days=random_days)

        impressions = random.randint(10_000, 500_000)

        ctr = random.uniform(0.005, 0.08)
        clicks = max(1, int(impressions * ctr))

        conversion_rate = random.uniform(0.01, 0.15)
        conversions = max(1, int(clicks * conversion_rate))

        platform_multiplier = PLATFORM_MULTIPLIERS[platform]

        spend = round(
            impressions / 1000
            * random.uniform(15, 80)
            * platform_multiplier,
            2,
        )

        revenue_per_conversion = random.uniform(40, 350)
        revenue = round(
            conversions * revenue_per_conversion * random.uniform(0.7, 1.3),
            2,
        )

        rows.append(
            {
                "campaign_id": campaign_id,
                "campaign_name": campaign_name,
                "platform": platform,
                "date": campaign_date,
                "country": country,
                "campaign_objective": objective,
                "ad_type": ad_type,
                "impressions": impressions,
                "clicks": clicks,
                "conversions": conversions,
                "spend": spend,
                "revenue": revenue,
            }
        )

    return pd.DataFrame(rows)


if __name__ == "__main__":
    df = generate_campaign_data()

    output_path = "data/raw/campaign_data.csv"
    df.to_csv(output_path, index=False)

    print(f"Generated {len(df):,} rows")
    print(f"Saved to: {output_path}")
