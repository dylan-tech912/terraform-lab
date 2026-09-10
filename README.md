# Terraform Lab

Welcome to the Terraform basics lab! 🚀

In this lab, you will learn the basic Terraform workflow by managing a local PostgreSQL database.

You **do not need access to AWS, Azure, GCP, or any other cloud provider**. Everything runs locally using Docker and PostgreSQL.

## 🎯 Objectives

The goal of this lab is to become familiar with the basic Terraform workflow:

* `terraform init`
* `terraform plan`
* `terraform apply`
* `terraform destroy`

You will also get familiar with:

* Terraform providers
* Terraform resources
* Terraform variables
* Terraform locals
* Terraform outputs
* Terraform state
* Resource dependencies

The lab uses the [PostgreSQL Terraform provider](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs) to manage a local PostgreSQL database.

---

## 🛠️ Prerequisites

Before starting, make sure you have:

* [Terraform](https://developer.hashicorp.com/terraform/install) installed
* [Docker](https://docs.docker.com/get-docker/) installed and running
* Git installed

You can verify your installations with:

```bash
terraform version
docker version
git --version
```

---

## 🐘 Start PostgreSQL

The lab requires a local PostgreSQL server.

Start one using Docker:

```bash
docker run -d \
  --name db \
  -e POSTGRES_PASSWORD=<password> \
  -p 5432:5432 \
  postgres
```

Replace `<password>` with a password of your choice.

For example:

```bash
docker run -d \
  --name db \
  -e POSTGRES_PASSWORD=mypassword \
  -p 5432:5432 \
  postgres
```

Check that the container is running:

```bash
docker ps
```

You should see the `db` container running.

### PostgreSQL connection information

The default PostgreSQL configuration is:

| Setting  | Value                                           |
| -------- | ----------------------------------------------- |
| Host     | `localhost`                                     |
| Port     | `5432`                                          |
| Username | `postgres`                                      |
| Database | `postgres`                                      |
| Password | The password you specified when starting Docker |

The Terraform configuration uses variables for the PostgreSQL connection settings.

---

## 📥 Get the Lab

Clone the repository:

```bash
git clone https://github.com/GitFabien/terraform-lab.git
```

Move into the repository:

```bash
cd terraform-lab
```

---

# 🚀 Terraform Workflow

Terraform follows a simple workflow:

```text
Write configuration
       │
       ▼
terraform init
       │
       ▼
terraform plan
       │
       ▼
terraform apply
       │
       ▼
Infrastructure
       │
       ▼
terraform destroy
```

You will go through each step during this lab.

---

## 1. Initialize Terraform

The first step is to initialize the Terraform working directory.

Run:

```bash
terraform init
```

Terraform will:

* initialize the working directory
* download the required providers
* prepare the backend
* create the `.terraform` directory

The lab uses the PostgreSQL provider:

```text
cyrilgdn/postgresql
```

You can find the provider configuration in `providers.tf`.

### Question

After running `terraform init`:

* Which provider was downloaded?
* Where can you find the provider information?
* What files/directories were created?

---

## 2. Create a Terraform Plan

Before creating anything, inspect what Terraform intends to do.

Run:

```bash
terraform plan
```

Terraform will compare:

```text
Terraform configuration
        +
Current Terraform state
        +
Real PostgreSQL infrastructure
        │
        ▼
    Execution plan
```

At this stage, Terraform should show resources that it intends to create.

### Questions

Look at the plan carefully.

* How many resources will be created?
* What type of resources are they?
* What is the name of the PostgreSQL database?
* What is the name of the PostgreSQL role?
* Is there anything Terraform plans to destroy?

**Do not skip the plan.** Understanding the plan is one of the most important Terraform skills.

---

## 3. Apply the Configuration

Once you understand the plan, apply it:

```bash
terraform apply
```

Terraform will display the execution plan and ask for confirmation.

Enter:

```text
yes
```

Terraform will then create the PostgreSQL resources.

The current configuration creates a PostgreSQL role and a PostgreSQL database. It also queries the available schemas using a PostgreSQL data source.

---

## 4. Inspect the Output

After `terraform apply`, Terraform displays the configured outputs.

You can also display them at any time with:

```bash
terraform output
```

The lab currently exposes the PostgreSQL schemas through an output named:

```text
schema
```

The output is based on the `postgresql_schemas` data source.

Try:

```bash
terraform output
```

and:

```bash
terraform output schema
```

---

## 5. Inspect Terraform State

Terraform keeps track of the infrastructure it manages using a **state file**.

After applying the configuration, look at the files in the directory:

```bash
ls -la
```

You should find:

```text
terraform.tfstate
```

You can inspect the state with:

```bash
terraform show
```

You can also list the resources Terraform knows about:

```bash
terraform state list
```

### Questions

* What resources are currently managed by Terraform?
* Where is Terraform storing this information?
* What happens to the state when you run `terraform destroy`?

---

# 💥 6. Destroy the Infrastructure

When you are finished, destroy the resources created by Terraform:

```bash
terraform destroy
```

Terraform will display what it intends to remove.

Confirm with:

```text
yes
```

Terraform will remove the resources that it manages.

> ⚠️ `terraform destroy` only destroys resources managed by Terraform. It does **not** remove the PostgreSQL Docker container.

You can verify that the Docker container is still running:

```bash
docker ps
```

If you want to remove the PostgreSQL container after the lab:

```bash
docker rm -f db
```

---

# 🧪 Challenge

Now that you understand the basic workflow, complete the following tasks.

## Task 1 — Terraform initialization

Initialize the Terraform project:

```bash
terraform init
```

---

## Task 2 — Review the plan

Run:

```bash
terraform plan
```

Identify:

1. The PostgreSQL role that will be created.
2. The PostgreSQL database that will be created.
3. The data source used by the configuration.
4. The dependencies between the resources.

---

## Task 3 — Apply

Run:

```bash
terraform apply
```

Verify that the resources have been created successfully.

---

## Task 4 — Outputs

Inspect the Terraform outputs:

```bash
terraform output
```

Then retrieve the `schema` output specifically:

```bash
terraform output schema
```

---

## Task 5 — State

Inspect the Terraform state:

```bash
terraform state list
```

Then inspect the state:

```bash
terraform show
```

---

## Task 6 — Destroy

Finally, destroy the Terraform-managed infrastructure:

```bash
terraform destroy
```

Verify that the Terraform-managed PostgreSQL resources have been removed.

---

# 🧠 Questions to Think About

Before finishing the lab, make sure you can answer these questions:

### Terraform

1. What is the purpose of `terraform init`?
2. What is the difference between `terraform plan` and `terraform apply`?
3. Why is `terraform plan` useful?
4. What is Terraform state?
5. What happens if you modify the Terraform configuration after an `apply`?
6. Why does Terraform know that the PostgreSQL role must exist before the database?

### Providers

7. What is a Terraform provider?
8. Why does this lab require the PostgreSQL provider?
9. Where is the provider configured?

### Resources

10. What is the difference between a Terraform resource and a data source?
11. Which resources are created by this lab?
12. Which PostgreSQL information is only read by Terraform?

### State

13. Where is the Terraform state stored?
14. What would happen if you deleted `terraform.tfstate`?
15. Why should Terraform state generally not be committed to Git?

---

# 📁 Repository Structure

The Terraform configuration is split into several files:

```text
terraform-lab/
├── main.tf
├── providers.tf
├── variables.tf
├── locals.tf
└── outputs.tf
```

Terraform automatically loads all `.tf` files in the current directory.

### `providers.tf`

Defines the Terraform provider and PostgreSQL connection.

### `variables.tf`

Defines the PostgreSQL connection variables such as:

* host
* port
* database
* username
* password

The database password is marked as sensitive.

### `locals.tf`

Contains local values used by the Terraform configuration, including the database and role names.

### `main.tf`

Contains the PostgreSQL resources and data source managed by Terraform.

### `outputs.tf`

Contains values that Terraform exposes after applying the configuration.

---

# 🧹 Cleanup

At the end of the lab:

```bash
terraform destroy
```

Then, if you no longer need PostgreSQL:

```bash
docker rm -f db
```

You can verify that everything has been removed:

```bash
docker ps
```

---

## 🎓 Expected Terraform Workflow

By the end of this lab, you should be comfortable with:

```bash
terraform init
terraform plan
terraform apply
terraform output
terraform state list
terraform show
terraform destroy
```

These commands form the foundation of the Terraform workflow.

Good luck! 🚀
