We have notus_nextjs application I have build the docker image for it and created bitbucket ipeline for it.
you can simply import this in bitbucket pipeline

Bit bucket pipeline to deploy to EKS

Resources required for this task
-	AWS Account
-	Bit bucket Account
-	GitHub Repo- https://github.com/creativetimofficial/notus-nextjs.git
-	

Step 1
-	Created bit Bucket Account and the created the repo
-	Forked and imported the GitHub repository to bit bucket
-	Cloned repo to local machine 
-	git clone https://ashadongre433@bitbucket.org/notus_app/notus-nextjs.git
Step 2
-	Created AWS Account
-	Created IAM user and assigned roles and policies to the user for accessing the AWS services through 3rd party
-	To create IAM user 
-	Go to IAM>User> create user
-	Named user as bitbucket_user
-	Assigned user below permissions
	AdministratorAccess
	AmazonEC2ContainerRegistryFullAccess
	AmazonEKSClusterPolicy
	AmazonEKSServicePolicy
-	Created and stored ACCESS_KEY and SECRET_ACCESS_KEY
-	Created a public container registry to push the image in ECR
-	public.ecr.aws/l6k0x5k3/demo/app

Step 3
-	To deploy the application into EKS
-	Created separate project for terraform called notus-nextjs-cluster
-	git clone https://ashadongre433@bitbucket.org/notus_app/terraform_notus_nextjs.git
-	Created the cluster with the help of Terraform module
	created provider.tf file to provide the details
	created main.tf file for the creation of roles and cluster
-	To implement the changes run below commands
	terraform validate
	terraform plan
	terraform apply
-	Created the Cluster named “notus-nextjs” and created the node group called “node-group-1” 

Step 4
-	Created the DOCKERFILE to build the application
-	Created the bitbucket-pipelines.yml file 
	Created the image called “notus-nextjs” and given the tag as latest
	Declared the Environment variables for authenticating with aws
o	AWS_ACCESS_KEY
o	AWS_SECRET_KEY
o	EKS_CLUSTER_NAME
	Pushed the image to ECR public repo –notus-nextjs-latest
	Created pipeline to build, push and deploy the application to EKS
	Pulled the image from ECR 
	Created the deployment.yml and service.yml file
	Used the image in the deployment.yml file to create pod 
-	Refer- https://github.com/AKD-2022/notus-nextjs_eks.git (you can import this repo in bit bucket)
Step 5
To verify cluster is created and to connect with aws we need run the below commands
-	aws eks --region eu-north-1 update-kubeconfig --name notus-nextjs
-	kubectl get node
NAME                                           STATUS   ROLES    AGE   VERSION
ip-172-31-1-193.eu-north-1.compute.internal    Ready    <none>   73m   v1.31.3-eks-59bf375
ip-172-31-30-219.eu-north-1.compute.internal   Ready    <none>   16h   v1.31.3-eks-59bf375

-	kubectl get deployment
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
notus-nextjs   1/1     1            1           86s

-	kubectl get pod
NAME                            READY   STATUS    RESTARTS   AGE
notus-nextjs-6c48d544dd-pczp7   1/1     Running   0          69s

-	kubectl get services
NAME                   TYPE           CLUSTER-IP       EXTERNAL-IP                                                                PORT(S)        AGE
kubernetes             ClusterIP      10.100.0.1       <none>                                                                     443/TCP        17h
notus-nextjs-service   LoadBalancer   10.100.160.243   a683deb1a6b26478bbf26c6e84cabf49-2134466166.eu-north-1.elb.amazonaws.com   80:31927/TCP   100s

Created service.yml to access the application 
Used a type:LoadBalancer to expose application 

Finally you can access the application with this domain- http://a683deb1a6b26478bbf26c6e84cabf49-2134466166.eu-north-1.elb.amazonaws.com/





 





