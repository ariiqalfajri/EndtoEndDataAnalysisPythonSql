# End-to-End Data Analysis with Python and Sql
This project involves data analytics, starting with file extraction using Python, followed by initial data cleaning, and concluding with analysis using SQL. This is the [dataset](https://www.kaggle.com/datasets/ankitbansal06/retail-orders/) utilized in this project.

The key steps in this project include:
1. Importing datasets from Kaggle to the local environment and loading them into Python using Jupyter Notebook.
2. Load it and Performing data analysis using SQL (I'm using SQL Server).


### Python step
The first step in this process is data extraction. We use external data from Kaggle as the example dataset. The Kaggle library is utilized to download the dataset, and Pandas is employed to `extract` and import it into Jupyter. Following this, we perform basic data cleaning tasks, including handling `null` values, converting column names to `lowercase`, and adjusting `data types`. Once the data is cleaned, we load it into SQL using SQLAlchemy.
You can see the full code [here.](https://github.com/ariiqalfajri/EndtoEndDataAnalysisPythonSql/blob/main/OrderDataAnalysis.ipynb)

### Transition step
When the data is directly loaded into the SQL database, the resulting table lacks a primary key and other proper attributes typically expected in a well-structured table (as explained in the last section of the Python notebook). To address this, we first create an empty table in SQL with the desired structure. Then, we reload the data from Jupyter, but instead of using the `replace` command (which overwrites the table), we use the `append` command to populate the pre-defined empty table.

### SQL step
The second and final step is performing data analysis. We use SQL for this step because it efficiently handles large datasets and supports complex analyses. Here are the five types of analysis we perform:
1. Find top 10 highest revenue generation products
2. Find top 5 highest selling products in each region
3. Show month over month growth comparison for year 2022 and 2023 sales. eg: feb 2022 vs feb 2023
4. Which month had highest sales in each category
5. Which sub category had highest absolute growth by profit in 2023 compared to 2022

We use basic clauses like `WHERE`, `GROUP BY`, and others, along with more advanced techniques such as `ROW_NUMBER` and Common Table Expressions (CTE). I provide detailed explanations directly in the code to help clarify each step and approach used during the analysis.
You can see the full code [here.](https://github.com/ariiqalfajri/EndtoEndDataAnalysisPythonSql/blob/main/OrderQuery.sql)

### Recommendation
There is no data visualization for the analysis conducted. We highly recommend that the next project include data visualization to better illustrate the findings. Tools such as **Power BI**, **Tableau**, or similar platforms can be used for this purpose.

---
### References
[Ankit Bansal](https://www.youtube.com/watch?v=uL0-6kfiH3g)'s video
