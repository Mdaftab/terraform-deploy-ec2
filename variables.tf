variable "pub_key" {
  description = "Name and or path to your pub key for SSH"
}

variable "your_ip" {
  description = "Your IP for ssh access. Add /32 to the end to make it a cidr."
}

variable "instance_type" {
  description = "The AWS type for your instance"
  default     = "t3.nano"
}
