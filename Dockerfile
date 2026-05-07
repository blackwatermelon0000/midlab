FROM python:3.10-slim
WORKDIR /app
RUN pip install fastapi uvicorn scikit-learn joblib pandas numpy
COPY app.py .
COPY model.pkl .
COPY metrics.json .
EXPOSE 8000
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
