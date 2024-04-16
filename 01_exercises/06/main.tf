provider "archive" {}

data "archive_file" "archive" {
  type        = "zip"
  source_dir = "${path.module}/data/files"
  output_path = "${path.module}/data/files/archive.zip"
}