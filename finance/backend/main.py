from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import mysql.connector

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

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

@app.get("/accounts")
def getAccounts():
    conn = get_connected()
    cursor = conn.cursor(dictionary = True)
    try:
        cursor.execute("select * from accounts;")
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close()
