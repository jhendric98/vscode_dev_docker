#!/usr/bin/env python3
"""
Simple Apache Spark Example in Python (PySpark)
This example demonstrates basic Spark operations
"""

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, avg, count

def main():
    # Create Spark Session
    spark = SparkSession.builder \
        .appName("PySpark Example") \
        .master("local[*]") \
        .getOrCreate()
    
    # Set log level to reduce console output
    spark.sparkContext.setLogLevel("WARN")
    
    print("🚀 PySpark Example Started!")
    
    # Example 1: Basic RDD operations
    print("\n=== Example 1: RDD Operations ===")
    numbers = spark.sparkContext.parallelize(range(1, 101))
    total = numbers.reduce(lambda a, b: a + b)
    average = total / numbers.count()
    print(f"Sum: {total}, Average: {average}")
    
    # Example 2: DataFrame operations
    print("\n=== Example 2: DataFrame Operations ===")
    data = [
        ("Alice", 25, "Engineer"),
        ("Bob", 30, "Data Scientist"),
        ("Charlie", 35, "Manager"),
        ("Diana", 28, "Analyst")
    ]
    
    df = spark.createDataFrame(data, ["name", "age", "role"])
    df.show()
    
    print("Filtering age > 27:")
    df.filter(col("age") > 27).show()
    
    print("Average age by role:")
    df.groupBy("role").agg(avg("age").alias("avg_age")).show()
    
    # Example 3: SQL operations
    print("\n=== Example 3: SQL Operations ===")
    df.createOrReplaceTempView("employees")
    
    sql_result = spark.sql("""
        SELECT role, COUNT(*) as count, AVG(age) as avg_age
        FROM employees
        GROUP BY role
        ORDER BY avg_age DESC
    """)
    sql_result.show()
    
    # Example 4: Word count (classic Spark example)
    print("\n=== Example 4: Word Count ===")
    text = spark.sparkContext.parallelize([
        "Apache Spark is a unified analytics engine",
        "Spark provides high-level APIs in Java Scala Python and R"
    ])
    
    word_counts = text \
        .flatMap(lambda line: line.split(" ")) \
        .map(lambda word: (word, 1)) \
        .reduceByKey(lambda a, b: a + b) \
        .sortBy(lambda x: x[1], ascending=False)
    
    for word, count in word_counts.take(10):
        print(f"{word}: {count}")
    
    # Example 5: Reading and writing data
    print("\n=== Example 5: Data I/O ===")
    # Create sample data
    sample_df = spark.createDataFrame([
        (1, "Product A", 100.0),
        (2, "Product B", 150.0),
        (3, "Product C", 200.0)
    ], ["id", "name", "price"])
    
    print("Sample data:")
    sample_df.show()
    
    # Write to parquet (in-memory)
    sample_df.write.mode("overwrite").parquet("/tmp/sample_output.parquet")
    print("Data written to /tmp/sample_output.parquet")
    
    # Read back
    read_df = spark.read.parquet("/tmp/sample_output.parquet")
    print("Data read back from parquet:")
    read_df.show()
    
    print("\n✅ PySpark Example Completed!")
    
    # Stop Spark Session
    spark.stop()

if __name__ == "__main__":
    main()

