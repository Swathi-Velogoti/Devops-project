from flask import Flask
import os

app = Flask(__name__)

@app.get("/")
def home():
    return {
        "message": "hey,Hello from Python DevOps demo!",
        "env": os.getenv("APP_ENV", "local")
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
