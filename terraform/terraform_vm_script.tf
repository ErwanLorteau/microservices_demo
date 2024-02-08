provider "google" {
  project     = "erwan-microservices-demo"
  region      = "europe-west10"

}


resource "google_compute_instance" "default" {
  count        = 3
  name         = "example-instance-${count.index}"
  machine_type = "e2-standard-2"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }


  network_interface {
    network = "default"
    access_config {
    // Access Config block
  }
 }

 metadata = {
  startup-script = <<-EOS
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io


    sudo apt-get install -y git
    git clone https://github.com/ErwanLorteau/microservices_demo.git
    cd microservices_demo/src/loadgenerator
    sudo docker pull locustio/locust
    docker run -p 8089:8089 -v $PWD:/mnt/locust locustio/locust -f /mnt/locust/locustfile.py
  EOS
}

}

#Allows external lookup to the GUI
resource "google_compute_firewall" "allow_locust" {
  name    = "allow-locust"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8089"]
  }

  source_ranges = ["0.0.0.0/0"]
}

