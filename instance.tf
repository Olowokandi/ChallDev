resource "google_compute_instance_template" "instance_template" {
    name_prefix  = "instance-template-"
    machine_type = "g1-small"
    region       = "us-central1"
  

    disk {
        source_image = "debian-cloud/debian-8"
        auto_delete  = true
        boot         = true
      }
  
    network_interface {
        network = "default"
        access_config {
            // Ephemeral IP
          }
      }
  
  
    metadata_startup_script = "curl -fsSL get.docker.com -o get-docker.sh && sudo sh get-docker.sh && sudo apt-get -y install git"
  }

  resource "google_compute_firewall" "elknet" {
    name    = "elknet"
    network = "default"
  
    allow {
      protocol = "icmp"
    }
  
    allow {
      protocol = "tcp"
      ports    = ["9200", "9300", "5000", "5601", "22", "80", "8080", "443"]
    }
  
    source_ranges = ["0.0.0.0/0"]
  }

  resource "google_compute_instance_group_manager" "instance_group_manager" {
    name               = "instance-group-manager"
    instance_template  = "${google_compute_instance_template.instance_template.self_link}"
    base_instance_name = "instance-group-manager"
    zone               = "us-central1-f"
    target_size        = "3"
  }

 