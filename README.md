## Flaskapp-AWS-EC2

This repository hosts a simple web application using Flask 

### Installation

1. **Clone the repository and navigate to the project directory:**

   ```bash
   git clone https://github.com/bassma-khaled14/Flaskapp-AWS-EC2
   cd Flaskapp-AWS-EC2
   ```

2. **Set up a virtual environment:**

   Create and activate a virtual environment to manage dependencies:

   ```bash
   python3 -m venv venv
   ````
   **On Linux:**
   ````bash
   source venv/bin/activate
   ````
   **On Windows:**
   ````bash
   venv\Scripts\activate
   ````

3. **Install dependencies:**

   Use `pip` to install required packages listed in requirements.txt

     ```bash
   pip install -r requirements.txt
     ```
   Set up Docker on your machine
      ```bash
      sudo apt-get update
      sudo apt install docker.io docker-compose docker-buildx
      ```
   Test Docker 
      ```bash
      sudo groupadd docker
      docker run hello-world
      ```
   Make sure that Docker service is enabled 
      ```bash
      sudo systemctl status docker
      ```
   If It's not enabled
      ```bash
      sudo systemctl enable docker
      ```
### Usage
**Run the application:** Start the Flask server to run the application locally

```bash
python app.py 
````
The application will be accessible at `http://localhost:5000`.

### Tests
**Run test:** Use `pytest` to execute the test suite for the application:
````bash
pytest
````
This ensures all functionalities are working correctly.
### Folder Structure
````bash
Flaskapp-AWS-EC2/
     │
     ├── app.py                 # Main Flask application file
     ├── templates/             # HTML templates (separation of concerns)
     │   └── calc.html         # Main page template
     ├── test_app.py            # Test suite for the application
     ├── venv/                  # Virtual environment folder (ignored in .gitignore)
     └── requirements.txt       # List of dependencies
````
### Best Practices Followed
   - **Virtual Environment**: Utilization of `venv` for package management, ensuring a clean environment isolated from system-wide Python packages.
   - **Separation of Concerns**: HTML templates are stored in the `templates/` directory, maintaining separation between front-end and back-end logic.
   - **Testing**: Integration of automated tests (`pytest`) to verify application functionality, ensuring reliability and consistency.

### Running the application in Docker
   1. **Login With Docker**
   ````bash
      docker login username
   ````
  enter your username on dockerhub
   
   2. **Pull Image From DockerHub**
    
   ````bash
      docker pull bassma/flaskappawsec2
   ````
   3. **Run Docker Container**
   ````bash
      docker run -p 5000:5000 --name appcontainer bassma/flaskappawsec2
   ````
  
application will be accessible at http://127.0.0.1:5000
   

## Provisioning Three EC2 Instances on AWS Using Terraform 

**1.** **Create instance using terraform** 

**1.1** **intialize terraform**
```bash
cd terraform

terraform init
```
**1.2** **Plan the Deployement** 
```bash
terraform plan

terraform apply
```

### Setup and Deployment
**1.** **Connect to the EC2 Instance**

Use the vockey.pem key to SSH into your EC2 instance:
```bash
ssh -i vockey.pem ec2-user@<EC2_Public_IP>
```
Replace <EC2_Public_IP> with the public IP address of your EC2 instance.

**2.** **Authenticate Docker with Amazon ECR**

Log in to Amazon ECR using the AWS CLI:

```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com
```
Replace <AWS_ACCOUNT_ID> with your AWS account ID.

**3.** **Check Docker Service***

Ensure the Docker daemon is running:
```bash
sudo systemctl status docker
```
**4.** **Check ECR Repository**

Verify that the Docker image exists in your ECR repository:
```bash
aws ecr describe-images --repository-name flaskapp-awsec2 --region us-east-1
```

**5.** **Verify the Container**

Check if the container is running:

```bash
docker ps
```
**6.** **Accessing the App**

Once the container is running, access the app via your browser:
```bash
http://<EC2_Public_IP>:5000
```
Replace <EC2_Public_IP> with the public IP address of your EC2 instance.







