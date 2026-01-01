import pandas as pd
import pandasql as ps

orders = pd.read_csv("List of Orders.csv")
order_details = pd.read_csv("Order Details.csv")
targets = pd.read_csv("Sales Target.csv")

orders.columns = orders.columns.str.replace(" ", "_")
order_details.columns = order_details.columns.str.replace(" ", "_")
targets.columns = targets.columns.str.replace(" ", "_")

query_1 = """
SELECT o.State,
       od.Category,
       SUM(od.Amount) AS total_sales,
       SUM(od.Profit) AS total_profit
FROM orders o
JOIN order_details od
ON o.Order_ID = od.Order_ID
GROUP BY o.State, od.Category
ORDER BY o.State, total_sales DESC
"""

result_1 = ps.sqldf(query_1, locals())
print(result_1)
