
# https://airflow.apache.org/docs/apache-airflow/stable/start/local.html
 
# Airflow needs a home. `~/airflow` is the default, but you can put it
# somewhere else if you prefer (optional)
export AIRFLOW_HOME=~/airflow

# Install Airflow using the constraints file
AIRFLOW_VERSION=2.3.3
PYTHON_VERSION="$(python3 --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
# For example: 3.7
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
# For example: https://raw.githubusercontent.com/apache/airflow/constraints-2.3.3/constraints-3.7.txt
pip3 install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

# The Standalone command will initialise the database, make a user,
# and start all components for you.
airflow standalone

# Visit localhost:8080 in the browser and use the admin account details
# shown on the terminal to login.
# Enable the example_bash_operator dag in the home page

# ---------------------------------------------------
# # run your first task instance
# airflow tasks run example_bash_operator runme_0 2015-01-01
# # run a backfill over 2 days
# airflow dags backfill example_bash_operator \
#     --start-date 2015-01-01 \
#     --end-date 2015-01-02


# ---------------------------------------------------
# 
# airflow db init
# 
# airflow users create \
#     --username admin \
#     --firstname Peter \
#     --lastname Parker \
#     --role Admin \
#     --email spiderman@superhero.org
# 
# airflow webserver --port 8080
# 
# airflow scheduler
