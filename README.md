# Infrastructure as Code: What Is It, and Why Should You Care?

This project contains all the Terraform files used during the BrightTALK "Infrastructure as Code: What Is It, and Why Should You Care?" found on https://www.brighttalk.com/webcast/18167/398218?utm_source=Nutanix+Middle+East&utm_medium=brighttalk&utm_campaign=398218.

In order to run this code, you will need to:
1. Use Linux, MacOS, or Windows WSL (https://docs.microsoft.com/en-us/windows/wsl/install-win10)
2. Download & install Terraform from https://www.terraform.io/
3. Build a Windows Server 2019 image and do a sysprep
4. Extract the QCOW2 image from the Windows Server 2019 and upload it to Prism Central so it can be used as part of the code. If you need help extracting the QCOW2 image from an existing reference VM that you built, please see my other GitHub project at https://github.com/obay/nutanix-extract-ahv-image.
