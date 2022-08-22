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
    

* ## Running With Kubernetes

    * Running with Kubernetes?
        * [What is Kubernetes?](https://kubernetes.io/) | [docs](https://kubernetes.io/docs/home/) | [Airflow in Kubernetes](https://airflow.apache.org/docs/apache-airflow/stable/kubernetes.html) | [kubectl auth changes in gke](https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke)

    * A deploy with helm? 
        * [What is helm?](https://helm.sh/) | [docs](https://helm.sh/docs/) | [Install](https://helm.sh/docs/intro/install/) | [helm chart parameters](https://airflow.apache.org/docs/helm-chart/stable/parameters-ref.html)

    * Let's do the Deployment with helm in GKE
        1. [optional] Create cluster Kubernetes type [Auto-Pilot](https://cloud.google.com/kubernetes-engine/docs/concepts/autopilot-overview) in GCP (GKE) with: `gcloud container --project __PROJECT_ID__ clusters create-auto __CLUSTER_NAME__ --region __REGION__ --cluster-ipv4-cidr "/17" --services-ipv4-cidr "/22"`
        2. [optional] Get Configuration from Cluster `gcloud container clusters get-credentials __CLUSTER_NAME__ --region __REGION__ --project __PROJECT_ID__`
        3. Add repo to helm `helm repo add apache-airflow https://airflow.apache.org`
        4. Install chart run: `helm upgrade --install airflow apache-airflow/airflow --namespace airflow`
        5. When finish the installation `kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow`
        6. Your credentials are in line "_Default Webserver (Airflow UI) Login credentials:_".
        7. When you finish your tests of this PoC you can destroy the environment on GCP first deleting helm chart `helm delete airflow --namespace airflow`
        8. [optional] Delete Cluster GKE with: `gcloud container --project __PROJECT_ID__ clusters delete __CLUSTER_NAME__ --region __REGION__`
    