from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Dict
import os

app = FastAPI(title="AegisOps Enterprise Remediation Engine")

class AlertInstance(BaseModel):
    labels: Dict[str, str]
    annotations: Dict[str, str]

class WebhookPayload(BaseModel):
    status: str
    alerts: List[AlertInstance]

def save_remediation_playbook(alert_name: str, yaml_content: str):
    os.makedirs("/tmp/remediation_tasks", exist_ok=True)
    file_path = f"/tmp/remediation_tasks/{alert_name.lower()}_fix.yml"
    with open(file_path, "w") as f:
        f.write(yaml_content)
    return f"Playbook saved to {file_path}"

@app.post("/webhook/alert")
async def handle_monitoring_webhook(payload: WebhookPayload):
    for alert_item in payload.alerts:
        alert_name = alert_item.labels.get("alertname")
        instance_target = alert_item.labels.get("instance", "unknown_node")
        
        if alert_name == "NginxServiceDown":
            playbook_content = """---
- name: Fix Nginx Service Down Alert
  hosts: all
  tasks:
    - name: Restart Nginx container engine using CLI
      ansible.builtin.command: podman start my-web
"""
            action_msg = save_remediation_playbook(alert_name, playbook_content)
            return {
                "status": "remediation_generated",
                "target_node": instance_target,
                "alert": alert_name,
                "action": action_msg
            }
            
    raise HTTPException(status_code=400, detail="No manageable alerts found in payload")
