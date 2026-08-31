from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data" / "operations_requests.csv"
OUT = ROOT / "visualizations"
OUT.mkdir(exist_ok=True)

df = pd.read_csv(DATA)
df["sla_breached"] = df["sla_status"].eq("Breached")

print("Requests:", len(df))
print("SLA attainment:", round((~df.sla_breached).mean()*100, 2), "%")
print("Median TAT:", round(df.tat_hours.median(), 2), "hours")
print("P70 TAT:", round(df.tat_hours.quantile(.70), 2), "hours")
print("P90 TAT:", round(df.tat_hours.quantile(.90), 2), "hours")

team = df.groupby("team").agg(
    cases=("request_id", "count"),
    sla_attainment=("sla_status", lambda x: (x == "Met").mean() * 100),
    avg_queue=("queue_hours", "mean"),
    median_tat=("tat_hours", "median"),
).round(2).sort_values("sla_attainment")

reason = df.loc[df.sla_breached, "breach_reason"].value_counts()
rework = df.groupby("rework_flag")["sla_breached"].mean().mul(100).round(2)

print("\nTeam analysis:\n", team)
print("\nBreach reasons:\n", reason)
print("\nBreach rate by rework:\n", rework)

ax = team["sla_attainment"].plot(kind="bar", figsize=(8, 5))
ax.set_title("SLA Attainment by Team")
ax.set_ylabel("SLA attainment (%)")
ax.set_xlabel("Team")
plt.tight_layout(); plt.savefig(OUT / "sla_attainment_by_team.png", dpi=160); plt.close()

ax = reason.plot(kind="bar", figsize=(8, 5))
ax.set_title("SLA Breaches by Reason")
ax.set_ylabel("Breached requests")
ax.set_xlabel("Breach reason")
plt.tight_layout(); plt.savefig(OUT / "breaches_by_reason.png", dpi=160); plt.close()

ax = rework.plot(kind="bar", figsize=(8, 5))
ax.set_title("SLA Breach Rate by Rework")
ax.set_ylabel("Breach rate (%)")
ax.set_xlabel("Rework flag")
plt.tight_layout(); plt.savefig(OUT / "breach_rate_by_rework.png", dpi=160); plt.close()

df["month"] = pd.to_datetime(df["request_date"]).dt.to_period("M").astype(str)
monthly = df.groupby("month").agg(breach_rate=("sla_breached", "mean"), avg_queue=("queue_hours", "mean"))
monthly["breach_rate"] *= 100
ax = monthly["breach_rate"].plot(kind="line", marker="o", figsize=(9, 5))
ax.set_title("Monthly SLA Breach Rate")
ax.set_ylabel("Breach rate (%)")
ax.set_xlabel("Month")
plt.tight_layout(); plt.savefig(OUT / "monthly_breach_rate.png", dpi=160); plt.close()
