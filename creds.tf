provider "google" {
  credentials = "${file("account.json")}"
  project     = "pro-platform-174312"
  region      = "us-central1"
}