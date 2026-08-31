"""Generate the synthetic NexaVerify operations dataset.

This script creates a reproducible portfolio dataset. It is intentionally synthetic;
no real customer, employee or company data is used.
"""

from pathlib import Path
import numpy as np
import pandas as pd

SEED = 42
N_ROWS = 20000
rng = np.random.default_rng(SEED)

out_dir = Path(__file__).resolve().parent

request_types = ["Identity Verification", "Business Verification", "Document Review", "Address Verification", "Risk Review"]
priorities = ["Low", "Medium", "High", "Critical"]
channels = ["Portal", "API", "Email", "Internal Referral"]
regions = ["West", "North", "South", "East"]
teams = ["Alpha", "Beta", "Gamma", "Delta", "Omega"]

# Six months of synthetic operational history.
dates = pd.date_range("2026-01-01", "2026-06-30", freq="D")
request_date = rng.choice(dates, size=N_ROWS)
request_type = rng.choice(request_types, size=N_ROWS, p=[0.30, 0.20, 0.22, 0.18, 0.10])
priority = rng.choice(priorities, size=N_ROWS, p=[0.18, 0.47, 0.28, 0.07])
team = rng.choice(teams, size=N_ROWS, p=[0.22, 0.24, 0.18, 0.20, 0.16])
channel = rng.choice(channels, size=N_ROWS, p=[0.52, 0.22, 0.18, 0.08])
region = rng.choice(regions, size=N_ROWS, p=[0.38, 0.25, 0.22, 0.15])
customer_segment = rng.choice(["SMB", "Mid-Market", "Enterprise"], size=N_ROWS, p=[0.50, 0.35, 0.15])

# Create a workload index by date: higher during predictable volume spikes.
day_volume = pd.Series(request_date).map(pd.Series(request_date).value_counts()).to_numpy()
workload_index = np.clip(0.65 + (day_volume - day_volume.mean()) / day_volume.std() * 0.16 + rng.normal(0, 0.08, N_ROWS), 0.35, 1.45)

sla_map = {"Low": 48, "Medium": 24, "High": 12, "Critical": 6}
sla_hours = np.array([sla_map[p] for p in priority], dtype=float)

# Request complexity drives active processing time.
complexity = {
    "Identity Verification": 1.0,
    "Business Verification": 1.55,
    "Document Review": 1.30,
    "Address Verification": 0.85,
    "Risk Review": 2.00,
}
base_processing = np.array([complexity[x] for x in request_type])
priority_factor = np.select([priority == "Critical", priority == "High", priority == "Medium"], [0.85, 0.95, 1.05], default=1.15)
processing_hours = np.clip(base_processing * priority_factor + rng.gamma(1.8, 0.9, N_ROWS), 0.4, None)

# Rework is more common for complex requests and adds additional handling time.
rework_prob = np.array([0.08, 0.16, 0.14, 0.07, 0.22])[pd.Categorical(request_type, categories=request_types).codes]
rework_flag = rng.random(N_ROWS) < np.clip(rework_prob + (workload_index - 1) * 0.025, 0.03, 0.30)
rework_hours = np.where(rework_flag, rng.gamma(1.6, 1.2, N_ROWS), 0).round(2)

# Queue time rises with workload and varies by team capacity.
team_capacity = {"Alpha": 0.92, "Beta": 1.00, "Gamma": 1.12, "Delta": 0.96, "Omega": 1.18}
capacity_factor = np.array([team_capacity[t] for t in team])
queue_hours = np.clip(
    rng.gamma(1.7, 1.5, N_ROWS) * (0.65 + workload_index * 0.72) * capacity_factor,
    0.05,
    None,
).round(2)

# Add a modest trend so later months can be investigated for deterioration.
month_number = pd.Series(request_date).dt.month.to_numpy()
queue_hours = (queue_hours + np.maximum(month_number - 1, 0) * 0.12).round(2)

tat_hours = (queue_hours + processing_hours + rework_hours).round(2)

received_offset = rng.integers(0, 24 * 60, N_ROWS)
received_at = pd.to_datetime(request_date) + pd.to_timedelta(received_offset, unit="m")
assigned_at = received_at + pd.to_timedelta(queue_hours * rng.uniform(0.35, 0.65, N_ROWS), unit="h")
processing_started_at = received_at + pd.to_timedelta(queue_hours, unit="h")
completed_at = processing_started_at + pd.to_timedelta(processing_hours + rework_hours, unit="h")

escalation_prob = np.clip(0.025 + (tat_hours > sla_hours * 0.8) * 0.08 + rework_flag * 0.025, 0.01, 0.30)
escalation_flag = rng.random(N_ROWS) < escalation_prob
escalation_reason = np.where(
    escalation_flag,
    rng.choice(["SLA Risk", "Client Escalation", "Complex Case", "Capacity Constraint"], size=N_ROWS, p=[0.42, 0.18, 0.22, 0.18]),
    "None",
)

sla_status = np.where(tat_hours <= sla_hours, "Met", "Breached")
breach_reason = np.where(
    sla_status == "Breached",
    np.select(
        [queue_hours > processing_hours * 1.5, rework_flag, processing_hours > sla_hours * 0.5],
        ["Queue Delay", "Rework", "High Processing Time"],
        default="Combined Factors",
    ),
    "None",
)

agent_numbers = rng.integers(1, 16, N_ROWS)
agent_id = np.array([f"{t}-A{n:02d}" for t, n in zip(team, agent_numbers)])

# Keep timestamps and metrics internally consistent.
df = pd.DataFrame({
    "request_id": [f"NV-{i:06d}" for i in range(1, N_ROWS + 1)],
    "request_date": pd.to_datetime(request_date).date,
    "request_type": request_type,
    "priority": priority,
    "customer_segment": customer_segment,
    "channel": channel,
    "region": region,
    "team": team,
    "agent_id": agent_id,
    "received_at": received_at,
    "assigned_at": assigned_at,
    "processing_started_at": processing_started_at,
    "completed_at": completed_at,
    "sla_hours": sla_hours,
    "tat_hours": tat_hours,
    "queue_hours": queue_hours,
    "processing_hours": np.round(processing_hours, 2),
    "rework_flag": rework_flag,
    "rework_hours": rework_hours,
    "escalation_flag": escalation_flag,
    "escalation_reason": escalation_reason,
    "sla_status": sla_status,
    "breach_reason": breach_reason,
    "workload_index": np.round(workload_index, 2),
})

df = df.sort_values("received_at").reset_index(drop=True)

# Quality checks before export.
assert df["request_id"].is_unique
assert (df["tat_hours"] >= df["queue_hours"]).all()
assert (df["queue_hours"] >= 0).all()
assert (df["processing_hours"] > 0).all()
assert (df.loc[df["rework_flag"] == False, "rework_hours"] == 0).all()  # noqa: E712

output = out_dir / "operations_requests.csv"
df.to_csv(output, index=False)
print(f"Created {len(df):,} records: {output}")
print(f"Date range: {df.request_date.min()} to {df.request_date.max()}")
print(f"SLA compliance: {(df.sla_status == 'Met').mean():.1%}")
