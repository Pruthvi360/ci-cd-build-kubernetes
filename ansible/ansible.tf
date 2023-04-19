# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "ansible-1" {
  boot_disk {
    auto_delete = true
    device_name = "ansible-1"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20230415"
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
    startup-script = "#!/usr/bin/env bash\n\necho \"ansible-server\" > /etc/hostname\nuseradd ansibleadmin\n#sed -i '/%wheel/a ansibleadmin       ALL=(ALL)     NOPASSWD: ALL' /etc/sudoers\nsed -i '/root/a ansibleadmin       ALL=(ALL)     NOPASSWD: ALL' /etc/sudoers\n\nsed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config\nsed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config\nsed -i 's/PubkeyAuthentication no/PubkeyAuthentication yes/g' /etc/ssh/sshd_config\n\n# Update to latest release\n#\necho \"Update installed software to latest release\"\nsudo apt update\n\n# Install missing packages\n#\necho \"Install needed packages\"\nsudo apt install -y python-setuptools python3-pip ack-grep jq python-is-python3 python3-pip python-yaml python3-httplib2 python3-pysnmp4 tree\n\n# Install Python components\n#\necho \"Install required Python components\"\nsudo pip3 install jinja2 six bracket-expansion netaddr scp\n\n#\necho \"Install optional Python components\"\nsudo pip3 install yamllint\n\n# Install latest stable Ansible version from Ansible repository\n#\necho \"Install stable Ansible\"\nsudo apt install -y software-properties-common\nsudo apt-add-repository -y ppa:ansible/ansible\nsudo apt install -y ansible\nsudo pip3 install paramiko\n\n# Install additional tools for labs\n#\necho \"Install additional tools\"\nsudo apt install -y tree"
  }

  name = "ansible-1"

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
