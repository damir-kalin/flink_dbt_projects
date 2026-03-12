import requests
import yaml
from datetime import datetime

resp = requests.post('http://flink-sql-gateway:8083/v1/sessions')
session = resp.json()
print('Session:', session)

data = {
    'session_handle': session['sessionHandle'],
    'timestamp': datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
}
with open('/tmp/nsi_dbt_project/.dbt/flink-session.yml', 'w') as f:
    yaml.dump(data, f)
print('Session saved!')