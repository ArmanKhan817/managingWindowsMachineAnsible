# Windows Admin Tasks Using Ansible Playbooks

Ansible is an open-source automation tool that is renowned for its simplicity, flexibility, and power across a wide range of IT automation tasks. One of its standout features is its comprehensive support for managing Windows systems through the Ansible Windows modules. These modules enable seamless automation of Windows-specific tasks, making Ansible a compelling choice for organizations with mixed operating system environments.
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
3.	On the Repositories page, choose Create repository.
4.	On the Create repository page, in Repository name, enter a name for your repository.
5.	Choose Create.

**Step 3: Add sample code to your CodeCommit repository.**
1.	Open putty and connect to ubuntu instances.
2.	Type sudo su, out the password.
3.	Type mkdir to create folder.
4.	Type cd to go inside the folder and use nano filename to create below file.

