variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "az" {
  type = object({
    first = string
    second = string
  })
}