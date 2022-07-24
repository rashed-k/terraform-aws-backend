terraform { 

    required providers {
        aws = {
            source      = "hashicorp/aws"
            version     = "~> 3.72" 
        }
    }
}



provider "aws" {
    region = "us-east-2" 
}


resource "aws_s3_bucket" "terraform_state" {
    bucket          = "rashed-terraform-bucket-for-s34"
    force_destroy   = true
    versioning  {
        enabled = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_dyanmodb_table" "terraform_locks" {
    name            = "terraform-state-lockingg"
    billing_mode    = "PAY_PER_REQUEST"
    hash_key        = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}