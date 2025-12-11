#cloud-config
package_update: true
packages:
  - amazon-cloudwatch-agent
runcmd:
  - systemctl enable amazon-ssm-agent && systemctl start amazon-ssm-agent
