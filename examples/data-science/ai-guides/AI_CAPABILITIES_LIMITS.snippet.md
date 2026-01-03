# Data Science - Capability Limits Snippets

## Documented Limits

### Pandas Memory Usage

- **Issue**: read_csv() fails with MemoryError on large files
- **Threshold**: Files approaching 50% of available RAM
- **Workaround**: Use `chunksize` parameter to read in batches
- **Tested**: 2024-11, tested with 2GB, 5GB, 10GB CSV files
- **Workaround Reference**:
```python
# Read large CSV in chunks
chunks = []
for chunk in pd.read_csv('large_file.csv', chunksize=10000):
    # Process chunk
    processed = process_chunk(chunk)
    chunks.append(processed)

df = pd.concat(chunks, ignore_index=True)
```

### Scikit-learn GridSearchCV Memory

- **Issue**: GridSearchCV with large parameter grids can exceed memory
- **Threshold**: >1000 combinations with large datasets
- **Workaround**: Use RandomizedSearchCV instead, or reduce cv folds
- **Tested**: 2024-10, tested with varying grid sizes
- **Workaround Reference**:
```python
from sklearn.model_selection import RandomizedSearchCV

# Instead of GridSearchCV with 1000+ combinations
search = RandomizedSearchCV(
    model, param_distributions, n_iter=50, cv=3
)
```

### Plotly Figure Size

- **Issue**: Very large datasets in Plotly can cause browser to freeze
- **Threshold**: >100k points in scatter plot
- **Workaround**: Downsample or use datashader
- **Tested**: 2024-09, tested with varying dataset sizes
- **Workaround Reference**:
```python
# Downsample for visualization
if len(df) > 100000:
    df_viz = df.sample(n=100000, random_state=42)
else:
    df_viz = df

fig = px.scatter(df_viz, x='x', y='y')
```

## Future Testing Needed

| Test | Hypothesis | Validation Plan | Priority |
|------|-----------|-----------------|----------|
| Joblib file size | Large models may have file size limits | Save models of varying sizes, measure limits | MEDIUM |
| Categorical encoding | OneHotEncoder may fail with high cardinality | Test with varying numbers of categories | HIGH |
| Cross-validation time | May become too slow with large datasets | Measure CV time with varying dataset sizes | MEDIUM |
| Feature selection | May have limits on number of features | Test with datasets of varying dimensionality | LOW |
| Parquet vs CSV | Need to determine when to switch formats | Benchmark read/write performance | LOW |
