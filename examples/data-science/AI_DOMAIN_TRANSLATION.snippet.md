# Data Science - Domain Translation Snippets

## Concept Mappings

| When You Think | We Actually Use | Gotcha |
|----------------|----------------|--------|
| "Load dataset" | pandas.read_csv() with explicit dtype specification | Always specify dtypes to prevent inference errors |
| "Train model" | scikit-learn Pipeline with cross-validation | Never train without pipeline (prevents data leakage) |
| "Visualize" | Plotly Express in notebooks/visuals/ | Don't use matplotlib, we standardize on Plotly |
| "Feature engineering" | sklearn Pipeline transformers | Include in pipeline for reproducibility |
| "Model evaluation" | cross_val_score() with stratified k-fold | Never split manually, use sklearn cross-validation |
| "Save model" | joblib.dump() to models/ directory | Faster than pickle for large numpy arrays |
| "Missing data" | SimpleImputer in pipeline | Handle in pipeline, not manually |
| "Scaling" | StandardScaler in pipeline | Always scale before model training |
| "Categorical encoding" | OneHotEncoder in pipeline | Include in pipeline, not manual encoding |
| "Notebook organization" | Separate notebooks for EDA, training, evaluation | Clear separation of concerns |

## Tool Selection Matrix

| IF (Condition) | USE (Tool/Approach) | WHY (Reasoning) |
|----------------|---------------------|-----------------|
| Need to load data | pandas with dtype specification | Prevents type inference errors, faster loading |
| Need visualization | Plotly Express | Interactive plots, better than matplotlib for exploration |
| Need ML pipeline | sklearn Pipeline | Prevents data leakage, ensures reproducibility |
| Need hyperparameter tuning | GridSearchCV or RandomizedSearchCV | Systematic search with cross-validation |
| Need model persistence | joblib | Faster than pickle for numpy-heavy objects |

## Quick Reference Patterns

### Load CSV with Type Safety
```python
import pandas as pd

# Always specify dtypes
df = pd.read_csv('data.csv', dtype={
    'id': 'int64',
    'name': 'string',
    'amount': 'float64',
    'category': 'category',  # Use category for categorical
    'created_at': 'string'   # Parse dates separately
})

# Parse dates separately for better control
df['created_at'] = pd.to_datetime(df['created_at'], format='%Y-%m-%d')
```

### ML Pipeline with Cross-Validation
```python
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import cross_val_score

# Define preprocessing
numeric_features = ['age', 'income']
categorical_features = ['category', 'region']

preprocessor = ColumnTransformer([
    ('num', StandardScaler(), numeric_features),
    ('cat', OneHotEncoder(handle_unknown='ignore'), categorical_features)
])

# Create pipeline
pipeline = Pipeline([
    ('preprocessor', preprocessor),
    ('classifier', RandomForestClassifier())
])

# Cross-validate (prevents data leakage)
scores = cross_val_score(pipeline, X, y, cv=5, scoring='accuracy')
print(f"Accuracy: {scores.mean():.3f} (+/- {scores.std():.3f})")
```

### Plotly Visualization
```python
import plotly.express as px

# Interactive scatter plot
fig = px.scatter(df, x='age', y='income', color='category',
                 title='Age vs Income by Category',
                 hover_data=['name'])
fig.show()

# Interactive histogram
fig = px.histogram(df, x='amount', color='category',
                   marginal='box',  # Add box plot
                   title='Amount Distribution')
fig.show()
```

### Save/Load Model
```python
import joblib

# Save model
joblib.dump(pipeline, 'models/my_model.joblib')

# Load model
pipeline = joblib.load('models/my_model.joblib')

# Predict
predictions = pipeline.predict(new_data)
```

## Common Anti-Patterns

❌ **Training without pipeline (data leakage)**
```python
# Wrong - data leakage!
X_scaled = StandardScaler().fit_transform(X)
X_train, X_test = train_test_split(X_scaled, y)
model.fit(X_train, y_train)

# Right - no leakage
pipeline = Pipeline([
    ('scaler', StandardScaler()),
    ('model', model)
])
X_train, X_test, y_train, y_test = train_test_split(X, y)
pipeline.fit(X_train, y_train)
```

❌ **Using matplotlib instead of Plotly**
```python
# Wrong
import matplotlib.pyplot as plt
plt.scatter(df['x'], df['y'])
plt.show()

# Right
import plotly.express as px
fig = px.scatter(df, x='x', y='y')
fig.show()
```

❌ **Manual train/test split instead of cross-validation**
```python
# Wrong - single split, no cross-validation
X_train, X_test, y_train, y_test = train_test_split(X, y)
model.fit(X_train, y_train)
score = model.score(X_test, y_test)

# Right - cross-validation for robust estimate
scores = cross_val_score(model, X, y, cv=5)
print(f"Mean score: {scores.mean()}")
```

❌ **Ignoring dtypes when loading CSV**
```python
# Wrong - pandas guesses types (can be wrong)
df = pd.read_csv('data.csv')

# Right - explicit types
df = pd.read_csv('data.csv', dtype={
    'id': 'int64',
    'amount': 'float64'
})
```

❌ **Fitting scaler/encoder on full dataset**
```python
# Wrong - data leakage!
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)  # Uses test data!
X_train, X_test = train_test_split(X_scaled, y)

# Right - fit only on training data
X_train, X_test, y_train, y_test = train_test_split(X, y)
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)  # Only transform
```
