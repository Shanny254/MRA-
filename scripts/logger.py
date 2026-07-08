import logging
import os
from datetime import datetime

# Create logs folder if it doesn't exist
os.makedirs("logs", exist_ok=True)

# Create log filename
log_filename = os.path.join(
    "logs",
    f"etl_{datetime.now().strftime('%Y-%m-%d_%H-%M-%S')}.log"
)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
    handlers=[
        logging.FileHandler(log_filename, encoding="utf-8"),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger("MRA_ETL")