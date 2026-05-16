from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello World from FastAPI 🚀"}

@app.get("/healthz")
def health_check():
    return {"status": "ok"}