Install Terraform and Configure AWS CLI on Windows

## Prerequisites

- Windows operating system
- Administrator access

## Install Terraform

1. Download the Terraform setup from the [official website](https://www.terraform.io/downloads.html).
2. Extract the downloaded zip file.
3. Move the `terraform.exe` file to a directory included in your system's PATH.

    ```powershell
    $env:Path += ";C:\path\to\terraform"
    ```

4. Verify the installation by opening a new command prompt and running:

    ```sh
    terraform -v
    ```

## Configure AWS CLI

1. Download the AWS CLI MSI installer from the [official website](https://aws.amazon.com/cli/).
2. Run the downloaded MSI installer and follow the on-screen instructions.
3. Verify the installation by opening a new command prompt and running:

    ```sh
    aws --version
    ```

4. Configure the AWS CLI with your credentials:

    ```sh
    aws configure
    ```

    You will be prompted to enter your AWS Access Key ID, Secret Access Key, region, and output format.