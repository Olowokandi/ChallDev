  // web (nginx reverse proxies)
  resource "google_compute_instance" "elk" {
    name = "tf-elk"
    machine_type = "n1-standard-1"
    zone = "${var.region_zone}"
    tags = ["web"]
  
    boot_disk {
        initialize_params {
          image = "debian-cloud/debian-8"
        }
      }
    
      // Local SSD disk
      scratch_disk {
      }
  
    network_interface {
      network = "default"
      access_config {
        // Ephemeral
      }
    }
  
    metadata {
      ssh-keys = "gbolahan:${file("${var.public_key_path}")}"
    }
    metadata_startup_script = "curl -fsSL get.docker.com -o get-docker.sh && sudo sh get-docker.sh && sudo apt-get -y install git"
  
    service_account {
      scopes = ["https://www.googleapis.com/auth/compute.readonly"]
    }
  }
  
  // app (Node.js)
  resource "google_compute_instance" "app" {
    name = "tf-app"
    machine_type = "n1-standard-1"
    zone = "${var.region_zone}"
    tags = ["app"]
  
    boot_disk {
        initialize_params {
          image = "debian-cloud/debian-8"
        }
      }
    
      // Local SSD disk
      scratch_disk {
      }
  
    network_interface {
      network = "default"
      access_config {
        // Ephemeral
      }
    }
  
    metadata {
      ssh-keys = "gbolahan:${file("${var.public_key_path}")}"
    }
    metadata_startup_script = "curl -fsSL get.docker.com -o get-docker.sh && sudo sh get-docker.sh && sudo apt-get -y install git"
  
    service_account {
      scopes = ["https://www.googleapis.com/auth/compute.readonly"]
    }
  }
  
  resource "google_compute_instance" "nagios" {
    name = "tf-nagios"
    machine_type = "n1-standard-1"
    zone = "${var.region_zone}"
    tags = ["nagios"]
  
    boot_disk {
        initialize_params {
          image = "debian-cloud/debian-8"
        }
      }
    
      // Local SSD disk
      scratch_disk {
      }
  
    network_interface {
      network = "default"
      access_config {
        // Ephemeral
      }
    }
  
    metadata {
      ssh-keys = "gbolahan:${file("${var.public_key_path}")}"
    }
    metadata_startup_script = "curl -fsSL get.docker.com -o get-docker.sh && sudo sh get-docker.sh && sudo apt-get -y install git"
  
    service_account {
      scopes = ["https://www.googleapis.com/auth/compute.readonly"]
    }
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
