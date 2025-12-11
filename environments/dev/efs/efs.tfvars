vpc_id     = "vpc-06bc40fbf7fd648cd"
subnet_id1 = "subnet-0aafb2646b47c986e"
subnet_id2 = "subnet-09d8824b9c18a9382"

security_group_id = ""   # Leave blank → Terraform creates SG

kms_key_id = ""          # Optional

enable_automatic_backups = true

performance_mode = "generalPurpose"
throughput_mode  = "bursting"
provisioned_throughput_in_mibps = 0
region = "us-west-2"

