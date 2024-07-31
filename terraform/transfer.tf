resource "aws_transfer_server" "sftp" {
  identity_provider_type = "SERVICE_MANAGED"
  region = "eu-west-1"
  endpoint_type = "PUBLIC"
  tags = {
    Name = "SFTPServer"
  }
}

resource "aws_transfer_user" "sftp_user" {
  count = length(var.agencies)

  user_name   = element(var.agencies, count.index)
  server_id   = aws_transfer_server.sftp.id
  role        = aws_iam_role.sftp_role.arn
  home_directory = "/${var.bucket_name}/${element(var.agencies, count.index)}"
  ssh_public_key_body = element(var.ssh_public_keys, count.index)
}

variable "agencies" {
  description = "List of agencies"
  type        = list(string)
}

variable "ssh_public_keys" {
  description = "List of SSH public keys for agencies"
  type        = list(string)
}

output "transfer_server_id" {
  value = aws_transfer_server.sftp.id
}
