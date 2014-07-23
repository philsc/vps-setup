# Add the repository from docker.com for the latest images.
apt_repository "lxc-docker" do
  uri "https://get.docker.io/ubuntu"
  distribution "docker"
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "36A1D7869245C8950F966E92D8576A8BA88D21E9"
end

# Install the latest docker package.
package "lxc-docker" do
  action :install
end

# Fix up the docker startup options.
cookbook_file "docker" do
    path "/etc/default/docker"
    action :create
end
