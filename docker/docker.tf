# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "docker" {
  boot_disk {
    auto_delete = true
    device_name = "docker"

    initialize_params {
      image = "projects/centos-cloud/global/images/centos-stream-9-v20230306"
      size  = 30
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    ec-src = "vm_add-tf"
  }

  machine_type = "c3-highcpu-4"

  metadata = {
    startup-script = "#!/usr/bin/env bash\n\n# Install the required packages.\nsudo yum install -y yum-utils \\\ndevice-mapper-persistent-data \\\nlvm2\n\n# Use the following command to set up the stable repository.\n\nsudo yum-config-manager \\\n--add-repo \\\nhttps://download.docker.com/linux/centos/docker-ce.repo\n\n# Install the latest version of Docker CE.\n\nsudo yum install docker-ce -y\n\n# Start Docker.\n\nsudo systemctl start docker\n\n# Run Tomcat docker continer\n\ndocker run -d --name test-tomcat-server -p 8090:8080 tomcat:latest"
  }

  name = "docker"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/new-ansible-354213/regions/us-east1/subnetworks/jenkins-us-east"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "473990003519-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]
  zone = "us-east1-b"
}
