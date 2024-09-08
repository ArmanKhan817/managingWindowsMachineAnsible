# Windows Admin Tasks Using Ansible Playbooks

**Ansible** is an open-source automation tool that is renowned for its simplicity, flexibility, and power across a wide range of IT automation tasks. One of its standout features is its comprehensive support for managing Windows systems through the **Ansible** Windows modules. These modules enable seamless automation of Windows-specific tasks, making **Ansible** a compelling choice for organizations with mixed operating system environments.
Following I have shown automatically deploy windows applications using Ansible playbook.

**Scope:**
•	The application type should be .msi (Microsoft Windows Installer files)
•	The application should not have any GUI based user input (Keyboard or mouse) during installation.

**Requirements:**
Ubuntu instance up and running.

![image](https://github.com/user-attachments/assets/6db56372-fc47-4994-8db3-80bb99a7a1d5)

Fig 1: High level architecture of managing Windows machine using Ansible.

![image](https://github.com/user-attachments/assets/e43958ba-8ab6-43d0-976e-5b61c3fb360b)

Fig 2: Install Putty to Windows machine using Ansible 

**Step 1: Install SSH Server in all Windows machines**

It is recommended to install SSH Server on Windows machines which allows Linux to establish SSH connections to Windows machines and perform remote management via Ansible. Here the command to install SSH server in Windows.

Download the 'installSSH.ps1' script and run PowerShell as Administrator to execute the script.

**Step 2: Create a CodeCommit repository.**
1.	Open the CodeCommit console.
2.	In the Region selector, choose ap-southeast-2 region.
3.	On the **Repositories page**, choose **Create repository**.
4.	On the **Create repository page**, in **Repository name**, enter a name for your repository.
5.	Choose **Create**.

**Step 3: Add sample code to your CodeCommit repository.**
1. Open PuTTY and connect to your Ubuntu instance.
2. Elevate to superuser by typing **sudo su** and entering your password.
3. Use **mkdir** <folder_name> to create a new folder.
4. Navigate into the folder using cd <folder_name>, then create files using **nano <filename>**.
5. Download and paste the content of the following files: appspec.yml, run_playbook.sh, Win_server.ini, Win_pos.ini, and downloadPutty.yml.

Now perform following git operation

_git init
git add .
git commit -m “ansibletest”_

Got to AWS codecommit repository created above and copy repo link.
Then use git push command to push code to repo.

_git push_

You should see file in AWS codecommit repo.

**Step 4: Create an Amazon EC2 Linux instance and install the CodeDeploy agent.**

To launch an instance
1.	Open the Amazon EC2 console.
2.	From the side navigation, choose **Instances**, and select **Launch instances** from the top of the page.
3.	In **Name**, enter **windowsAnsibleDemo**. This assigns the instance a tag Key of **Name** and a tag Value of **windowsAnsibleDemo**. 
4.	Under **Application and OS Images (Amazon Machine Image)**, locate the **Amazon Linux AMI** option with the AWS logo, and make sure it is selected. 
5.	Under **Instance type**, choose the free tier eligible t2.micro type as the hardware configuration for your instance.
6.	Under **Key pair (login)**, choose a key pair or create one.
7.	Edit **Network settings**, do the following.
Vpc: 
Subnet: 
Select disable **Auto-assign Public IP**
Next to **Assign a security group**, choose Select existing security group.
8.	Expand **Advanced details**. In **IAM instance profile**, choose the IAM role **EC2InstanceRole**.
9.	Under **Summary**, under **Number of instances**, enter 1.
10.	Download the userData.bash scrip and put the content in user data.
11.	Choose Launch instance.

**Step 5: Create an application in CodeDeploy.**

First, you create a role that allows CodeDeploy to perform deployments. Then, you create a CodeDeploy application.
To create an application in CodeDeploy
1.	Open the **CodeDeploy** console
2.	Choose **Create** application.
3.	In Application name, enter **ansibleDemoPutty**.
4.	In Compute Platform, choose **EC2/On-premises**.
5.	Choose **Create** application.

A deployment group is a resource that defines deployment-related settings like which instances to deploy to and how fast to deploy them.
1.	On the page that displays your application, choose **Create deployment group**.
2.	In **Deployment group name**, enter ansibleDeploymentPutty.
3.	In **Service role**, choose the ARN of the service role you created earlier (for example, arn:aws:iam::account_ID:role/CodeDeployRole).
4.	Under **Deployment type**, choose **In-place**.
5.	Under **Environment configuration**, choose **Amazon EC2 Instances**. In the **Key** field, enter Name. In the **Value** field, enter the name you used to tag the instance.
6.	Under **Agent configuration with AWS Systems Manager**, choose **Now and schedule updates**. This installs the agent on the instance. The Linux instance is already configured with the SSM agent and will now be updated with the CodeDeploy agent.
7.	Under **Deployment configuration**, choose CodeDeployDefault.OneAtaTime.
8.	Under **Load Balancer**, make sure **Enable load balancing** is not selected. You do not need to set up a load balancer or choose a target group for this example.
9.	Choose **Create deployment group**.

**Step 6: Create CodePipeline**

You're now ready to create and run your first pipeline. In this step, you create a pipeline that runs automatically when code is pushed to your CodeCommit repository.

To create a CodePipeline pipeline
1.	Open the CodePipeline console at **https://console.aws.amazon.com/codepipeline/**.
2.	Choose **Create pipeline**.
3.	In **Step 1: Choose pipeline settings**, in **Pipeline name**, enter ansiblePuttyPipeline.
4.	In **Pipeline type**, choose **V1** for the purposes of this tutorial. You can also choose **V2**; however, note that pipeline types differ in characteristics and price. For more information, see Pipeline types.
5.	In **Service role**, choose **New service role** to allow CodePipeline to create a service role in IAM.
6.	Leave the settings under **Advanced settings** at their defaults, and then choose **Next**.
7.	In **Step 2: Add source stage**, in **Source provider**, choose **CodeCommit**. In **Repository** name, choose the name of the CodeCommit repository you created in Step 1: Create a CodeCommit repository. In **Branch** name, choose main, and then choose Next step.
After you select the repository name and branch, a message displays the Amazon CloudWatch Events rule to be created for this pipeline.
Under **Change detection options**, leave the defaults. This allows CodePipeline to use Amazon CloudWatch Events to detect changes in your source repository.
Choose **Next**.
8.	In **Step 3: Add build stage**, choose **Skip build stage**, and then accept the warning message by choosing **Skip** again. Choose **Next**.
9.	In **Step 4: Add deploy stage**, in **Deploy provider**, choose **CodeDeploy**. In **Application name**, choose ansibleDemoPutty. In Deployment group, choose ansibleDeploymentPutty, and then choose Next step.
10.	 In **Step 5: Review**, review the information, and then choose Create pipeline.

**Reference**
https://docs.aws.amazon.com/codepipeline/latest/userguide/tutorials-simple-codecommit.html
[ansible.windows.win_shell module – Execute shell commands on target hosts — Ansible Community Documentation](https://docs.ansible.com/ansible/latest/collections/ansible/windows/win_shell_module.html)


