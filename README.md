# Dream Vacation Destinations: A Full-Stack Application with Automated CI/CD and IaC

This project showcases a complete, production-ready CI/CD and Infrastructure as Code (IaC) pipeline for a full-stack web application. It goes beyond the application's features to demonstrate a fully automated workflow for building, testing, and deploying to Google Cloud Platform (GCP).

## Core Features

### Application Features
- **Add Countries**: Users can add countries to their dream vacation list.
- **View Country Details**: Displays capital, population, and region information for each country fetched from an external API.
- **Remove Countries**: Users can remove countries from their list.

### DevOps & Platform Features
- **Automated CI/CD Pipeline**: Utilizes **GitHub Actions** to automatically build, push, and deploy the application. The pipeline is efficient, using path filtering to only build and deploy services that have changed.
- **Infrastructure as Code (IaC)**: The entire cloud infrastructure, including the GCE instance, Cloud SQL database, firewall rules, and service accounts, is managed declaratively using **Terraform**.
- **Containerization**: The frontend and backend are containerized using **Docker** with multi-stage builds to create lean, production-ready images. Images are stored in **Google Container Registry (GCR)**, backed by Artifact Registry.
- **GitOps Workflow**: The repository follows GitOps principles:
    - **Infrastructure Changes**: A pull request triggers a `terraform plan`, and the plan's output is automatically posted as a comment for review. Merging to `main` automatically applies the changes.
    - **Application Changes**: A push to `main` automatically builds a new Docker image and deploys it to the GCE instance.
- **Secure Secret Management**: All sensitive information is handled securely. Application and infrastructure secrets are managed with **Google Secret Manager** and **GitHub Secrets**, with no hardcoded credentials in the codebase.

---
## Architecture Overview

The entire system is designed for automation. A push to the `main` branch triggers a GitHub Actions workflow that handles the entire build and deployment process, updating the live application running on a Google Compute Engine instance.



---
## Tech Stack

| Category | Technology |
| :--- | :--- |
| **Cloud Platform** | Google Cloud Platform (GCP) |
| **Frontend** | React |
| **Backend** | Node.js with Express |
| **Database** | Cloud SQL for MySQL |
| **CI/CD** | GitHub Actions |
| **Infrastructure as Code** | Terraform |
| **Containerization** | Docker, Google Container Registry (GCR) |
| **Process Management** | PM2 |

---
## How it Works: The GitOps Flow

The repository is the single source of truth. The pipelines respond to changes in the code:

- **To deploy an application change**: Simply push a commit to the `main` branch. The `docker-publish.yml` workflow will handle the rest.
- **To change the infrastructure**: Open a pull request with your Terraform changes. The `terraform-ci.yml` workflow will run a plan for review. Once approved and merged, the changes are automatically applied.

---
<details>
<summary><strong>Local Development Setup</strong></summary>

### Backend
1. Navigate to the `backend` directory.
2. Run `npm install` to install dependencies.
3. Set up a local MySQL database and update a `.env` file with your database credentials.
4. Run `npm run dev` to start the development server.

### Frontend
1. Navigate to the `frontend` directory.
2. Run `npm install` to install dependencies.
3. Update a `.env` file with your API URL (e.g., `REACT_APP_API_URL=http://localhost:3001`).
4. Run `npm start` to start the React development server.

</details>

---
## Future Roadmap

This project serves as the foundation for a more advanced, cloud-native architecture. The next planned iterations include:

- **Migrate to Kubernetes (GKE)**: Evolve the deployment from a single GCE instance to a scalable GKE (Google Kubernetes Engine) cluster, managed by Terraform.
- **Implement GitOps with ArgoCD**: Use ArgoCD to continuously sync the state of the Kubernetes cluster with the configurations defined in this Git repository.
- **Package with Helm**: Manage the Kubernetes application deployments using Helm charts for better versioning, templating, and dependency management.
- **Implement Observability**: Integrate a full observability stack. This will include:
    - **Logging**: Use **Promtail** to ship logs to **Loki**.
    - **Metrics**: Use **Prometheus** for application and cluster monitoring.
    - **Visualization**: Use **Grafana** to create dashboards for logs and metrics.
- **Automated Testing**: Add unit and integration testing stages to the CI pipeline to improve code quality and reliability before deployment.