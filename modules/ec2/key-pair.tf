# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Create the Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = "linux-key-pair"
  public_key = tls_private_key.private_key.public_key_openssh
}
# Save file
resource "local_file" "local_ssh_key" {
  filename = "${aws_key_pair.key_pair.key_name}.pem"
  content  = tls_private_key.private_key.private_key_pem
}