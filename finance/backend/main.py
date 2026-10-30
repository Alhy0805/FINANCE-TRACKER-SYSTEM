from fastapi import FastAPI, HTTPException, status
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import hmac
import mysql.connector

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class LoginRequest(BaseModel):
    email: str = Field(min_length=3, max_length=150)
    password: str = Field(min_length=1, max_length=255)

def get_connected():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="finance_db",
    )

@app.get("/")
def tryConn():
    return "connected"

@app.get("/users")
def getUser():
    conn = get_connected()
    cursor = conn.cursor(dictionary = True)
    try:
        cursor.execute("select * from users;")
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close()

@app.get("/accounts/{user_id}")
def getAccounts(user_id:int):
    conn = get_connected()
    cursor = conn.cursor(dictionary = True)
    cursor.execute(
        "SELECT * FROM accounts WHERE user_id = %s",
        (user_id,)
    )
    accounts = cursor.fetchall()
    cursor.close()
    return accounts

@app.post("/checkCredentials")
def checkAccount(credentials: LoginRequest):
    conn = get_connected()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT user_id, full_name, email, password_hash, profile_image, currency
            FROM users
            WHERE email = %s
            LIMIT 1
            """,
            (credentials.email.strip(),),
        )
        user = cursor.fetchone()

        if user is None:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="This email is not registered.",
            )

        if not hmac.compare_digest(user["password_hash"], credentials.password):
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Incorrect password.",
            )

        # Never return password_hash to the client.
        return {
            "message": "Login successful",
            "user": {
                "user_id": user["user_id"],
                "full_name": user["full_name"],
                "email": user["email"],
                "profile_image": user["profile_image"],
                "currency": user["currency"],
            },
        }
    finally:
        cursor.close()
        conn.close()

    