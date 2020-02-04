data "ibm_is_vpc" "f5_vpc" {
  name = "${var.vpc_name}"
}

data "ibm_is_subnet" "f5_subnet1"{
   identifier = "${var.subnet_id}"
}

data "ibm_is_ssh_key" "f5_ssh_pub_key" {
  name = "${var.ssh_key_name}"
}

data "ibm_is_instance_profile" "vnf_profile" {
  name = "${var.vnf_profile}"
}

resource "ibm_is_image" "f5_custom_image" {

  href             = "cos://us-south/cos-standard-o6d/CentOS-7-x86_64-GenericCloud-1503.qcow2"
  name             = "sample-centos"
  operating_system = "centos-7-amd64"

  timeouts {
    create = "30m"
    delete = "10m"
  }
}

resource "ibm_is_instance" "f5_vsi" {
  name    = "vsi-pk-centos"
  image   = "${data.ibm_is_image.f5_custom_image.id}"
  profile = "${data.ibm_is_instance_profile.vnf_profile.name}"

  primary_network_interface = {
    subnet = "${data.ibm_is_subnet.f5_subnet1.id}"
  }

  vpc  = "${data.ibm_is_vpc.f5_vpc.id}"
  zone = "${data.ibm_is_zone.zone.name}"
  keys = ["${data.ibm_is_ssh_key.f5_ssh_pub_key.id}"]
  # user_data = "$(replace(file("f5-userdata.sh"), "F5-LICENSE-REPLACEMENT", var.vnf_license)"

  //User can configure timeouts
  timeouts {
    create = "10m"
    delete = "10m"
  }

  # Hack to handle some race condition; will remove it once have root caused the issues.
  provisioner "local-exec" {
    command = "sleep 30"
  }
}
