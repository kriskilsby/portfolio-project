# scripts/get_metadata.py
import sys
import os
import json
from pathlib import Path
from dotenv import load_dotenv

# Add path to import your DB module
# sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'backend', 'app', 'services')))
# import database

# Load env vars
# dotenv_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'backend', '.env'))
# load_dotenv(dotenv_path)

# ----------------------------
# Always load stork-app/backend/.env explicitly
# ----------------------------

# BASE_DIR = Path(__file__).resolve().parents[2]  # stork-app/backend/
# ENV_FILE = BASE_DIR / ".env"

# BASE_DIR = Path(__file__).resolve().parent / 'backend'  # stork-app/backend
# ENV_FILE = BASE_DIR / ".env"

# # load_dotenv(ENV_FILE)
# # Load environment variables, override any existing
# load_dotenv(ENV_FILE, override=True)


# Correct .env path for stork-app backend
BASE_DIR = Path(__file__).resolve().parent.parent / 'backend'
ENV_FILE = BASE_DIR / ".env"
# load_dotenv(dotenv_path=ENV_FILE, override=True)
load_dotenv(dotenv_path=str(ENV_FILE), override=True)

print(f"[DEBUG] Loaded .env from: {ENV_FILE}", file=sys.stderr)
print(f"[DEBUG] DB_NAME: {os.getenv('DB_NAME')}", file=sys.stderr)

# ----------------------------
# Add path to import your DB module
# ----------------------------
# sys.path.append(os.path.abspath(os.path.join(BASE_DIR, 'app', 'services')))
# import database

SERVICES_DIR = BASE_DIR / 'app' / 'services'
sys.path.append(str(SERVICES_DIR))


# import database

# Import database helper (must exist at stork-app/backend/app/services/database.py)
try:
    import database
    print("database.py module loaded.", file=sys.stderr)
except Exception as e:
    print(json.dumps({"error": f"Failed to import database module: {e}"}), file=sys.stderr)
    sys.exit(1)

# ----------------------------
# Function to fetch metadata
# ----------------------------

def get_metadata():
    conn, cur = database.get_db_connection()
    try:
        query = """
        SELECT
            individual_local_identifier AS bird,
            EXTRACT(YEAR FROM timestamp)::int AS year,
            COUNT(*) AS count
        FROM migration_data.stork_data
        GROUP BY bird, year
        ORDER BY bird, year;
        """
        cur.execute(query)
        rows = cur.fetchall()

        birds = {}
        years = {}

        for bird, year, count in rows:
            year = int(year)
            count = int(count)

            # Bird-centric mapping
            if bird not in birds:
                birds[bird] = {}
            birds[bird][year] = count

            # Year-centric mapping
            if year not in years:
                years[year] = {}
            years[year][bird] = count

        print(json.dumps({
            "birds": birds,
            "years": years
        }))
    except Exception as e:
        print(json.dumps({ "error": str(e) }), file=sys.stderr)
        sys.exit(1)
    finally:
        cur.close()
        conn.close()

# ----------------------------
# Run when executed directly
# ----------------------------

if __name__ == "__main__":
    get_metadata()
