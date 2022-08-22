# de_orchestration_with_airflow
Data Engineering - Orchestration With airflow

## Environments

* ## Running Locally

    Run `sh environments/locally/running.sh` for a environment locally with default values. Navigate to `http://localhost:8080/`. [(docs)](https://airflow.apache.org/docs/apache-airflow/stable/start/local.html)

* ## Running With Docker 

    Run `sh environments/with_docker/running.sh` for a environment with Docker. Navigate to `http://localhost:8080/`. [(docs)](https://airflow.apache.org/docs/apache-airflow/stable/start/docker.html)

    Airflow cli, usage subcommands? [(docs)](https://airflow.apache.org/docs/apache-airflow/stable/usage-cli.html)

    * Run `sh environments/with_docker/running.sh {{subcomand}}`.
    * For Example, Run `sh environments/with_docker/running.sh info`.

* ## Running With GCP Composer 

    <!-- Run `sh environments/gcp_composer/running.sh`  -->
    * Running with **G**oogle **C**loud **P**latform Composer?
        * [What is GCP Composer?](https://cloud.google.com/composer) | [docs](https://cloud.google.com/composer/docs) | [troubleshooting environment creation](https://cloud.google.com/composer/docs/troubleshooting-environment-creation)

    * A deploy with terraform? 
        * [What is terraform?](https://www.terraform.io/docs) | [download](https://www.terraform.io/downloads) | [Terraform Environment Variables](https://www.terraform.io/cli/config/environment-variables)
        * [Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/) | [GCP Composer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/composer_environment)

    * Let's do the Deployment (16min aprox)
        1. Export Google Credentials with: `export GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account-file.json`
        2. First, Check default variables as *project id* in `gcp_composer/environment.tf` and now run `terraform plan`
        3. If want export *project id* as environment variable run: `export TF_VAR_project=unique_google_project_id`
        4. If configuration is correct run `terraform apply`
        5. Now your environment is ready to run (approx 16 min), check your DAGs folder and open the airflow UI.
        6. When you finish your tests of this PoC you can destroy the environment on GCP with `terraform destroy`
    
    