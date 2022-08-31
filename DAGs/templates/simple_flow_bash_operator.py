#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

"""Example DAG demonstrating the usage of the BashOperator."""

import random
import datetime
import pendulum

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator
from airflow.operators.dummy_operator import DummyOperator

# OS paths
folders = ["/tmp", "/home", "/usr/bin", "/var", "/srv"]

with DAG(
    dag_id='simple_flow_bash_operator',
    schedule_interval='0 0 * * *',
    start_date=pendulum.datetime(2022, 8, 30, tz="UTC"),
    catchup=False,
    dagrun_timeout=datetime.timedelta(minutes=60),
    tags=['example', 'example2'],
    params={"example_key": "example_value"},
) as dag:

    # Task Begin
    begin = DummyOperator(
        task_id='begin',
    )
    # Task End
    end = DummyOperator(
        task_id='end',
    )

    # resting Task where other Task converge
    reace_bench = BashOperator(
        task_id='reace_bench',
        bash_command='echo "run_id={{ run_id }} | dag_run={{ dag_run }}"',
    )
    # flow mapping
    reace_bench >> end

    # dynamic tasks
    for folder in folders:
        sleeper = random.randint(10, 50)
        task = BashOperator(
            task_id='runme_' + folder.replace("/", "_"),
            bash_command='df -hT ' + folder + ' && echo "{{ task_instance_key_str }}" && sleep ' + str(sleeper),
        )
        begin >> task >> reace_bench


if __name__ == "__main__":
    dag.cli()