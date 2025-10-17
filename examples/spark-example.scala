// Simple Apache Spark Example in Scala
// This example demonstrates basic Spark operations

import org.apache.spark.sql.SparkSession

object SparkExample {
  def main(args: Array[String]): Unit = {
    // Create Spark Session
    val spark = SparkSession
      .builder()
      .appName("Spark Example")
      .master("local[*]")
      .getOrCreate()

    // Set log level to reduce console output
    spark.sparkContext.setLogLevel("WARN")

    println("🚀 Spark Example Started!")

    // Example 1: Basic RDD operations
    println("\n=== Example 1: RDD Operations ===")
    val numbers = spark.sparkContext.parallelize(1 to 100)
    val sum = numbers.reduce(_ + _)
    val avg = sum / numbers.count()
    println(s"Sum: $sum, Average: $avg")

    // Example 2: DataFrame operations
    println("\n=== Example 2: DataFrame Operations ===")
    import spark.implicits._
    
    val data = Seq(
      ("Alice", 25, "Engineer"),
      ("Bob", 30, "Data Scientist"),
      ("Charlie", 35, "Manager"),
      ("Diana", 28, "Analyst")
    )
    
    val df = data.toDF("name", "age", "role")
    df.show()
    
    println("Filtering age > 27:")
    df.filter($"age" > 27).show()
    
    println("Average age by role:")
    df.groupBy("role").avg("age").show()

    // Example 3: SQL operations
    println("\n=== Example 3: SQL Operations ===")
    df.createOrReplaceTempView("employees")
    
    val sqlResult = spark.sql("""
      SELECT role, COUNT(*) as count, AVG(age) as avg_age
      FROM employees
      GROUP BY role
      ORDER BY avg_age DESC
    """)
    sqlResult.show()

    // Example 4: Word count (classic Spark example)
    println("\n=== Example 4: Word Count ===")
    val text = spark.sparkContext.parallelize(Seq(
      "Apache Spark is a unified analytics engine",
      "Spark provides high-level APIs in Java Scala Python and R"
    ))
    
    val wordCounts = text
      .flatMap(line => line.split(" "))
      .map(word => (word, 1))
      .reduceByKey(_ + _)
      .sortBy(_._2, ascending = false)
    
    wordCounts.take(10).foreach { case (word, count) =>
      println(s"$word: $count")
    }

    println("\n✅ Spark Example Completed!")
    
    // Stop Spark Session
    spark.stop()
  }
}

