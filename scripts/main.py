from scripts.extract import get_sheet_names, read_sheet
from scripts.transform import clean_dataframe
from scripts.load import load_dataframe


def clean_table_name(sheet):

    return (
        sheet.lower()
             .replace(" ", "_")
             .replace("-", "_")
             .replace("/", "_")
    )


def main():

    sheets = get_sheet_names()

    print("=" * 50)
    print("ETL STARTED")
    print("=" * 50)

    for sheet in sheets:

        print(f"\nReading {sheet}...")

        df = read_sheet(sheet)

        df = clean_dataframe(df)

        table = clean_table_name(sheet)

        load_dataframe(df, table)

    print("\nETL COMPLETED SUCCESSFULLY")


if __name__ == "__main__":
    main()