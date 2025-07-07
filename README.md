Cloud Resume Challenge
by Forrest Brazeal

The Cloud Resume Challenge is a project designed to help newcomers gain hands-on experience with key cloud technologies commonly used in the daily operations of DevOps Engineers. Forrest Brazeal provides high-level guidance for completing the challenge, encouraging self-learning through practical tasks. The challenge covers technologies like Frontend Development, HTTPS, DNS, APIs, Testing, Infrastructure as Code (IaC), and CI/CD pipelines.

You can view my website at:** test.razcloudresume.click**

Though the challenge can be completed using different cloud platforms like Azure or GCP, my website is built using AWS services such as S3, CloudFront, Route 53, API Gateway, Lambda, and DynamoDB.

To deploy the architecture, I used Terraform for Infrastructure as Code and GitHub Actions for the CI/CD pipeline.

Challenge Steps
1. Certification
I earned the AWS Solutions Architect – Associate certification before taking on this challenge. The knowledge gained through Stephan Mareek course helped me prepare.

2. HTML
I utilized a free Udemy course to learn HTML basics and created my resume in Visual Studio Code.

3. CSS
Similarly, I used a free Udemy course to learn CSS basics. I then edited a template I found online to fit my needs.

4. Static Website
The web files were stored in an S3 bucket, which I configured as a static website.

5. HTTPS
I enabled HTTPS by using CloudFront to distribute the content and cache it at edge locations for improved performance.

6. DNS
I used Route 53 to set up the domain name for my website razcloudresume.click. I also attached an SSL certificate to CloudFront for secure HTTPS communication.

7. JavaScript
I created a simple script.js that interacts with the API Gateway to retrieve the number of visits to the site.

8. Database
I used DynamoDB to store and track the number of visits to the site. I opted for On-Demand pricing to ensure the database is essentially free for this low-traffic application. It holds a single attribute that is updated by the Lambda function.

9. API
I created a REST API that allows access to a URL endpoint, accepting GET and POST methods. This triggers the Lambda function and fetches data from DynamoDB.

10. Python
The Lambda function is written in Python, utilizing the boto3 library to interact with AWS services.

11. Tests
I tested the Lambda function using JSON in the Lambda dashboard. I also tested the GET and POST methods directly in the API Gateway dashboard.

12. Infrastructure as Code
I used Terraform to manage the infrastructure, split into two configurations: Frontend and Backend. The configuration is set to use S3 as storage for the Terraform state file. All resources are created with Terraform, except for the S3 bucket for the .tfstate file, the Route 53 Hosted Zone, and the SSL certificate.

13. Source Control
I created a GitHub repository to implement version control for this project.

14. CI/CD (Backend)
I created a GitHub Actions workflow that automatically runs terraform apply whenever a file in the backend directory is updated. The workflow tests the Lambda function when there are changes to the Python code and compresses the .py file into a .zip format before uploading it to AWS.

15. CI/CD (Frontend)
A second GitHub Actions workflow was set up to run terraform apply whenever a file in the frontend directory is updated, whether it’s a .tf file or any website-related files (HTML, CSS, JS).
