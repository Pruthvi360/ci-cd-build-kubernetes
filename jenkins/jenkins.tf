# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "jenkis-server" {
  boot_disk {
    auto_delete = false
    device_name = "jenkis-server"

    initialize_params {
      image = "projects/centos-cloud/global/images/centos-stream-8-v20230306"
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

  machine_type = "e2-medium"

  metadata = {
    startup-script = "yum install wget -y\n\nsudo wget -O /etc/yum.repos.d/jenkins.repo \\\n    https://pkg.jenkins.io/redhat/jenkins.repo\n    \nsudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key\n\nsudo yum upgrade -y\n\n# Add required dependencies for the jenkins package\nsudo yum install java-11-openjdk -y\n\nsudo yum install jenkins -y\n\nsystemctl start jenkins"
  }

  name = "jenkis-server"

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
