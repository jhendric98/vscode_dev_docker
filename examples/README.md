# Spark Examples

This directory contains example files and configurations to help you get started with Apache Spark development.

## 📁 Contents

### Example Applications

- **`spark-example.scala`** - Scala Spark application demonstrating:
  - RDD operations
  - DataFrame operations
  - SQL queries
  - Word count example

- **`spark-example.py`** - Python (PySpark) application demonstrating:
  - RDD operations
  - DataFrame operations
  - SQL queries
  - Word count example
  - Data I/O with Parquet

### Build Configurations

- **`build.sbt`** - SBT build configuration for Scala projects
- **`pom.xml`** - Maven build configuration for Scala/Java projects
- **`requirements.txt`** - Python dependencies for PySpark projects

## 🚀 Running the Examples

### Scala Example

#### Using spark-submit

```bash
# Compile first if needed
scalac -classpath "$SPARK_HOME/jars/*" spark-example.scala

# Run with Spark
spark-submit \
  --class SparkExample \
  --master local[*] \
  spark-example.scala
```

#### Using Spark Shell

```bash
# Start Spark shell
spark-shell

# Paste the code from spark-example.scala
# Or load it with: :load spark-example.scala
```

### Python Example

```bash
# Run directly with spark-submit
spark-submit examples/spark-example.py

# Or run with Python
python3 examples/spark-example.py

# Or run with PySpark shell
pyspark
# Then in the shell: exec(open('examples/spark-example.py').read())
```

## 🏗️ Building Projects

### SBT Project

```bash
# Create project structure
mkdir -p src/main/scala
mkdir -p src/test/scala

# Copy build.sbt to your project root
cp examples/build.sbt .

# Copy example source
cp examples/spark-example.scala src/main/scala/

# Compile
sbt compile

# Run
sbt run

# Package
sbt package

# Create fat JAR with dependencies
sbt assembly
```

### Maven Project

```bash
# Create Maven project structure
mkdir -p src/main/scala
mkdir -p src/test/scala

# Copy pom.xml to your project root
cp examples/pom.xml .

# Copy example source
cp examples/spark-example.scala src/main/scala/

# Compile
mvn compile

# Package
mvn package

# Run tests
mvn test
```

### Python Project

```bash
# Install dependencies
pip3 install -r examples/requirements.txt

# Or install in a virtual environment
python3 -m venv venv
source venv/bin/activate
pip install -r examples/requirements.txt

# Run the example
python3 examples/spark-example.py
```

## 📦 Project Templates

### Quick SBT Project Setup

```bash
# Create a new SBT project
sbt new scala/scala-seed.g8

# Answer the prompts:
# name: my-spark-app
# organization: com.example

cd my-spark-app

# Replace build.sbt with the example
cp /workspace/examples/build.sbt .
```

### Quick Maven Project Setup

```bash
# Create from archetype
mvn archetype:generate \
  -DgroupId=com.example \
  -DartifactId=spark-app \
  -DarchetypeArtifactId=scala-archetype-simple \
  -DinteractiveMode=false

cd spark-app

# Replace pom.xml with the example
cp /workspace/examples/pom.xml .
```

## 🧪 Testing Your Code

### Scala Tests with SBT

```scala
// src/test/scala/SparkExampleSpec.scala
import org.scalatest.flatspec.AnyFlatSpec
import org.scalatest.matchers.should.Matchers
import org.apache.spark.sql.SparkSession

class SparkExampleSpec extends AnyFlatSpec with Matchers {
  "Spark" should "sum numbers correctly" in {
    val spark = SparkSession.builder()
      .appName("test")
      .master("local[*]")
      .getOrCreate()
    
    val numbers = spark.sparkContext.parallelize(1 to 10)
    val sum = numbers.reduce(_ + _)
    
    sum shouldEqual 55
    
    spark.stop()
  }
}
```

Run tests:

```bash
sbt test
```

### Python Tests with pytest

```python
# test_spark_example.py
import pytest
from pyspark.sql import SparkSession

@pytest.fixture(scope="module")
def spark():
    spark = SparkSession.builder \
        .appName("test") \
        .master("local[*]") \
        .getOrCreate()
    yield spark
    spark.stop()

def test_sum(spark):
    numbers = spark.sparkContext.parallelize(range(1, 11))
    total = numbers.reduce(lambda a, b: a + b)
    assert total == 55
```

Run tests:

```bash
pytest test_spark_example.py
```

## 📝 Development Tips

### Optimizing Spark Applications

1. **Use DataFrame API over RDD** when possible for better performance
2. **Cache data** that will be reused: `df.cache()`
3. **Partition wisely** for better parallelism
4. **Broadcast small datasets** to avoid shuffles
5. **Monitor with Spark UI** at <http://localhost:4040>

### Common Patterns

#### Reading Data

```python
# CSV
df = spark.read.csv("data.csv", header=True, inferSchema=True)

# Parquet
df = spark.read.parquet("data.parquet")

# JSON
df = spark.read.json("data.json")
```

#### Writing Data

```python
# Parquet (recommended for big data)
df.write.mode("overwrite").parquet("output.parquet")

# CSV
df.write.mode("overwrite").csv("output.csv", header=True)

# Partitioned write
df.write.partitionBy("date").parquet("output_partitioned.parquet")
```

#### Performance Tuning

```python
# Set Spark configuration
spark.conf.set("spark.sql.shuffle.partitions", "200")
spark.conf.set("spark.default.parallelism", "100")

# Repartition for better parallelism
df = df.repartition(200)

# Coalesce to reduce partitions
df = df.coalesce(10)
```

## 🔗 Additional Resources

- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [PySpark Documentation](https://spark.apache.org/docs/latest/api/python/)
- [Scala Spark Documentation](https://spark.apache.org/docs/latest/api/scala/)
- [Spark SQL Guide](https://spark.apache.org/docs/latest/sql-programming-guide.html)
- [Spark MLlib Guide](https://spark.apache.org/docs/latest/ml-guide.html)

## 💡 Need Help?

- Check the main [README](../README.md)
- Review [Troubleshooting](../README.md#troubleshooting) section
- Open an [issue](https://github.com/yourusername/vscode_dev_docker/issues)

Happy Spark coding! 🚀
