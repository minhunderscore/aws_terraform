I. Setup credential for terraform

create a .env file at the root folder with this environment:

ACCESS_KEY=<Your Access Key>
SECRET_KEY=<Your Secret Key>

II. To write the terraform code:

1. Create common modules on /common_modules folder
2. Create the main logic handler for all lab in /main_logic folder
3. Create variable file for each lab in /lab_var folder

III. Push your code to the same repo on the your branch follow this naming convention: <YourAccountID> Eg: thangtd18

NOTE: DO NOT USE FPT EMAIL FOR GIT
git config user.email "<your email address>"
git config user.name "your name" (DO NOT USE ACCOUNTID)