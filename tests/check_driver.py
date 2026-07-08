import pyodbc

print("Installed SQL Server Drivers:\n")

for driver in pyodbc.drivers():
    print(driver)