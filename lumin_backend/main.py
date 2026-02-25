from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from datetime import datetime
import os
import uuid

from dotenv import load_dotenv
from supabase import create_client

load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL")
SUPABASE_KEY = os.getenv("SUPABASE_KEY")

if not SUPABASE_URL or not SUPABASE_KEY:
    raise RuntimeError("Missing SUPABASE_URL or SUPABASE_KEY in .env")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

app = FastAPI(title="LUMIN Backend")


class SensorReadingIn(BaseModel):
    device_id: str
    kwh: float
    recorded_at: datetime | None = None


@app.get("/")
def root():
    return {"message": "Lumin backend is running"}


@app.post("/sensor-readings")
def ingest_sensor_reading(payload: SensorReadingIn):
    try:
        uuid.UUID(payload.device_id)
    except ValueError:
        raise HTTPException(status_code=400, detail="device_id must be a valid UUID")

    device_res = (
        supabase.table("devices")
        .select("user_id")
        .eq("id", payload.device_id)
        .limit(1)
        .execute()
    )

    if not device_res.data:
        raise HTTPException(status_code=404, detail="Device not found")

    user_id = device_res.data[0]["user_id"]

    row = {
        "user_id": user_id,
        "device_id": payload.device_id,
        "kwh": payload.kwh,
        "recorded_at": (payload.recorded_at or datetime.utcnow()).isoformat(),
    }

    result = supabase.table("sensor_data").insert(row).execute()
    return {"status": "stored", "data": result.data}


@app.get("/energy/{user_id}")
def get_energy(user_id: str):
    result = (
        supabase.table("sensor_data")
        .select("kwh, recorded_at, device_id")
        .eq("user_id", user_id)
        .order("recorded_at", desc=True)
        .execute()
    )

    if not result.data:
        raise HTTPException(status_code=404, detail="No energy data found")

    total_today = sum(item["kwh"] for item in result.data)
    total_month = total_today

    latest = result.data[0]

    return {
        "user_id": user_id,
        "total_kwh_today": total_today,
        "total_kwh_month": total_month,
        "latest": latest,
    }