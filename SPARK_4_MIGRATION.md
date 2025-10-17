# Apache Spark 4.0 Migration Guide

This document provides guidance for upgrading from Spark 3.x to Spark 4.0.1 in this development container.

## 🔄 What Changed

This container has been updated from **Apache Spark 3.5.1** to **Apache Spark 4.0.1**, which includes several breaking changes and new features.

## ⚠️ Breaking Changes

### 1. Java Version Support

- **Minimum Java Version**: Java 11 (unchanged)
- **Recommended**: Java 17 or Java 21
- **Removed**: Java 8 support has been dropped

### 2. Deprecated Features Removed

- **Mesos Support**: Apache Mesos cluster manager support has been removed
- **SparkR Deprecation**: SparkR is deprecated and will be removed in a future version
- **Python 3.8**: Python 3.8 support dropped; minimum is now Python 3.9

### 3. API Changes

#### SQL and DataFrame API

- Some deprecated DataFrame APIs have been removed
- SQL configuration property names may have changed
- Default behavior for certain operations may differ

#### Streaming

- Deprecated streaming APIs removed
- Some checkpoint formats may not be compatible

#### MLlib

- Deprecated ML algorithms removed
- Model serialization format may have changed

### 4. Dependency Updates

- **NumPy**: Requires NumPy 1.21+ (was 1.15+)
- **PyArrow**: Requires PyArrow 10.0+ (was 1.0+)
- **Pandas**: Better compatibility with Pandas 2.0+

## ✨ New Features in Spark 4.0

### Performance Improvements

- Enhanced Adaptive Query Execution (AQE)
- Improved join strategies
- Better memory management

### SQL Enhancements

- New SQL functions and operators
- Improved ANSI SQL compliance
- Better support for complex data types

### Python/PySpark

- Better type hints support
- Improved pandas UDF performance
- Enhanced DataFrame API

### Scala

- Better Scala 2.13 support
- Improved type safety

## 🔧 Migration Steps

### For Existing Applications

1. **Update Dependencies**

   **SBT (build.sbt):**

   ```scala
   libraryDependencies ++= Seq(
     "org.apache.spark" %% "spark-core" % "4.0.1",
     "org.apache.spark" %% "spark-sql" % "4.0.1",
     "org.apache.spark" %% "spark-mllib" % "4.0.1"
   )
   ```

   **Maven (pom.xml):**

   ```xml
   <spark.version>4.0.1</spark.version>
   ```

   **Python (requirements.txt):**

   ```txt
   pyspark==4.0.1
   numpy>=1.21.0
   pandas>=2.0.0
   pyarrow>=10.0.0
   ```

2. **Review Deprecation Warnings**

   Run your application with Spark 3.5.1 first and address all deprecation warnings:

   ```bash
   spark-submit --conf spark.sql.legacy.timeParserPolicy=LEGACY your-app.jar
   ```

3. **Update Configuration**

   Check your Spark configuration for deprecated properties:

   ```scala
   // Old (Spark 3.x)
   spark.sql.adaptive.enabled = true
   
   // New (Spark 4.0) - may have new defaults or options
   // Review Spark 4.0 configuration documentation
   ```

4. **Test Thoroughly**

   - Run your test suite
   - Verify data pipeline outputs
   - Check performance benchmarks
   - Test with production-like data volumes

### Code Migration Examples

#### Example 1: DataFrame Operations

```python
# This may need adjustment in Spark 4.0
# Old way (Spark 3.x)
df.selectExpr("cast(timestamp as string)")

# Spark 4.0 - verify behavior
df.selectExpr("cast(timestamp as string)")
# May need explicit format in some cases
```

#### Example 2: Configuration

```python
# Spark 3.x
spark = SparkSession.builder \
    .config("spark.sql.legacy.timeParserPolicy", "LEGACY") \
    .getOrCreate()

# Spark 4.0 - review legacy configs
spark = SparkSession.builder \
    .config("spark.sql.timestampFormat", "yyyy-MM-dd HH:mm:ss") \
    .getOrCreate()
```

## 📚 Resources

- [Spark 4.0.0 Release Notes](https://spark.apache.org/releases/spark-release-4-0-0.html)
- [Spark 4.0.1 Release Notes](https://spark.apache.org/releases/spark-release-4-0-1.html)
- [Migration Guide - Official](https://spark.apache.org/docs/latest/migration-guide.html)
- [Spark SQL Migration Guide](https://spark.apache.org/docs/latest/sql-migration-guide.html)
- [PySpark Migration Guide](https://spark.apache.org/docs/latest/api/python/migration_guide/pyspark_upgrade.html)

## 🧪 Testing Recommendations

### 1. Unit Tests

Ensure all unit tests pass with Spark 4.0:

```bash
# SBT
sbt test

# Maven
mvn test

# Python
pytest tests/
```

### 2. Integration Tests

Test with real data pipelines:

```bash
spark-submit --master local[*] --deploy-mode client your-app.jar
```

### 3. Performance Testing

Compare performance between Spark 3.5 and 4.0:

```python
import time

start = time.time()
# Your Spark job
end = time.time()
print(f"Execution time: {end - start} seconds")
```

## 🐛 Common Issues

### Issue 1: Import Errors

**Problem:**

```python
ImportError: cannot import name 'SparkContext' from 'pyspark'
```

**Solution:**
Ensure PySpark 4.0.1 is installed:

```bash
pip install --upgrade pyspark==4.0.1
```

### Issue 2: Configuration Errors

**Problem:**

```text
IllegalArgumentException: Unsupported configuration property
```

**Solution:**
Review and update Spark configuration properties. Some legacy configs may no longer be supported.

### Issue 3: Serialization Issues

**Problem:**

```text
SerializationException: Class not found
```

**Solution:**
Recompile your application with Spark 4.0.1 dependencies and ensure all libraries are compatible.

## 🔍 Verification Checklist

Before deploying to production, verify:

- [ ] All dependencies updated to Spark 4.0.1
- [ ] Code compiles without deprecation warnings
- [ ] All tests pass
- [ ] Integration tests with real data succeed
- [ ] Performance is acceptable
- [ ] Configuration is updated
- [ ] Documentation is updated
- [ ] Team is aware of changes

## 💡 Best Practices

1. **Gradual Migration**: Test in development → staging → production
2. **Feature Flags**: Use feature flags to switch between old and new behavior
3. **Monitoring**: Set up comprehensive monitoring during migration
4. **Rollback Plan**: Have a rollback strategy ready
5. **Documentation**: Document all changes made during migration

## 🆘 Getting Help

If you encounter issues:

1. Check the [Spark JIRA](https://issues.apache.org/jira/browse/SPARK) for known issues
2. Search [Stack Overflow](https://stackoverflow.com/questions/tagged/apache-spark) with `[apache-spark]` and `[apache-spark-4.0]` tags
3. Join the [Spark Users Mailing List](https://spark.apache.org/community.html)
4. Open an issue in this repository

---

**Last Updated**: October 2025
**Spark Version**: 4.0.1
**Previous Version**: 3.5.1
