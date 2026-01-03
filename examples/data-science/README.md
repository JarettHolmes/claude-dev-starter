# Data Science Example

This example shows how to customize the AI guides for a **Python data science project**.

## Technology Stack

- **Language**: Python 3.10+
- **Notebooks**: Jupyter
- **Data**: Pandas, NumPy
- **ML**: Scikit-learn
- **Visualization**: Plotly Express
- **Model Persistence**: Joblib
- **Testing**: pytest

## What's Included

**10 concept mappings**:
1. Load dataset → pandas.read_csv() with dtype
2. Train model → sklearn Pipeline
3. Visualize → Plotly Express
4. Feature engineering → Pipeline transformers
5. Model evaluation → cross_val_score()
6. Save model → joblib.dump()
7. Missing data → SimpleImputer
8. Scaling → StandardScaler in pipeline
9. Categorical encoding → OneHotEncoder
10. Notebook organization → Separate EDA/training/eval

**5 anti-patterns**:
1. ❌ Training without pipeline (data leakage)
2. ❌ Using matplotlib (we standardize on Plotly)
3. ❌ Manual train/test split (use cross-validation)
4. ❌ Ignoring dtypes on CSV load
5. ❌ Fitting scaler on full dataset (data leakage)

**4 quick reference patterns**:
- Load CSV with type safety
- ML pipeline with cross-validation
- Plotly visualization
- Save/load model with joblib

## How to Use

Same process as other examples:
1. Copy snippets to guides
2. Customize for your tools (e.g., TensorFlow instead of scikit-learn)
3. Add domain-specific patterns (time series, NLP, computer vision)
4. Validate

## Expansion Ideas

Add mappings for:
- **Deep learning**: PyTorch, TensorFlow/Keras
- **Time series**: statsmodels, Prophet
- **NLP**: spaCy, Transformers
- **Computer vision**: OpenCV, torchvision
- **Deployment**: FastAPI, Docker
- **Monitoring**: MLflow, Weights & Biases
