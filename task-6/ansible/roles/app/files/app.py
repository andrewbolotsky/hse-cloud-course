from flask import Flask

app = Flask(__name__)

@app.get("/hello")
def index():
    return "Hello"

@app.get("/health")
def health():
    return "OK"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
