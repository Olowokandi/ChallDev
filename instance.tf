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
      }
  
  
    metadata_startup_script = "sudo wget https://download.docker.com/linux/debian/dists/jessie/pool/stable/amd64/docker-ce_17.09.0~ce-0~debian_amd64.deb && sudo dpkg -i docker-ce_17.09.0~ce-0~debian_amd64.deb "
  }

  resource "google_compute_instance_group_manager" "instance_group_manager" {
    name               = "instance-group-manager"
    instance_template  = "${google_compute_instance_template.instance_template.self_link}"
    base_instance_name = "instance-group-manager"
    zone               = "us-central1-f"
    target_size        = "1"
  }