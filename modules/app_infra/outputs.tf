output "s3_bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = "Name of the S3 bucket"
}

output "ec2_instance_id" {
  value       = aws_instance.this.id
  description = "ID of the EC2 instance"
}

output "ec2_public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IP of the EC2 instance"
}
