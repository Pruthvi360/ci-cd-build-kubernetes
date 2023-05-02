# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "tomcat-server" {
  boot_disk {
    auto_delete = true
    device_name = "tomcat-server"

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

  machine_type = "n2d-standard-2"

  metadata = {
    startup-script = "#!/usr/bin/env bash\n\ninstall java 11\n\nsudo yum install java-11-openjdk -y\n\n# install wget\nyum install wget -y\n\n# install nano editor\n\nyum install nano -y\n\n# Create tomcat directory\n\ncd /opt\nwget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.7/bin/apache-tomcat-10.1.7.tar.gz\ntar -xvzf /opt/apache-tomcat-10.1.7.tar.gz\n\n## change execution permission\n\nchmod +x /opt/apache-tomcat-10.1.7/bin/startup.sh \nchmod +x /opt/apache-tomcat-10.1.7/bin/shutdown.sh\n\n## Run startup.sh\n\n/opt/apache-tomcat-10.1.7/bin/startup.sh\n\n## Editing context.xml to make sure the it is accessable from outside than local host 127.0.0.0\n\nsed -i '21,22d' /opt/apache-tomcat-10.1.7/webapps/host-manager/META-INF/context.xml\nsed -i '21,22d' /opt/apache-tomcat-10.1.7/webapps/manager/META-INF/context.xml\nsed -i '19,20d' /opt/apache-tomcat-10.1.7/webapps/docs/META-INF/context.xml\n\n## create link files for tomcat startup.sh and shutdown.sh\n\ncd ~\n\necho -e \"PATH=/usr/local/sbin:/usr/local/bin:b\\$PATH:b\\$HOME:bin\\nexport PATH\" >> .bash_profile && source .bash_profile\n\nln -s /opt/apache-tomcat-10.1.7/bin/startup.sh /usr/local/bin/tomcatup\nln -s /opt/apache-tomcat-10.1.7/bin/shutdown.sh /usr/local/bin/tomcatdown\n\n## delete users\n\nsed -i '49,56d' /opt/apache-tomcat-10.1.7/conf/tomcat-users.xml\n\n## Insert users\n\necho \"\n  <role rolename=\"manager-gui\"/>\n  <role rolename=\"manager-script\"/>\n  <role rolename=\"manager-jmx\"/>\n  <role rolename=\"manager-status\"/>\n  <user username=\"admin\" password=\"admin\" roles=\"manager-gui, manager-script, manager-jmx, manager-status\"/>\n  <user username=\"deployer\" password=\"deployer\" roles=\"manager-script\"/>\n  <user username=\"tomcat\" password=\"s3cret\" roles=\"manager-gui\"/>\n  </tomcat-users>\" >> /opt/apache-tomcat-10.1.7/conf/tomcat-users.xml\n\n\n## Starting tomcatserver\n\ntomcatdown\ntomcatup\n"
  }

  name = "tomcat-server"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/new-ansible-354213/regions/us-central1/subnetworks/default"
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
  zone = "us-central1-a"
}
