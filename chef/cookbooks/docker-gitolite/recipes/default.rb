# First create the directory to clone the repos into.
bash "create_directory" do
  user "root"
  code "mkdir -p /opt/docker"
end

# Checkout the git repo.
git "/opt/docker/gitolite" do
  repository "https://github.com/philsc/docker-gitolite.git"
  reference "master"
  action :sync
end

# Add the admin's public key to the file system.
cookbook_file "id_rsa.pub" do
  path "/opt/docker/gitolite/id_rsa.pub"
  action :create_if_missing
end

# Install the gitolite docker image.
bash "install_docker_gitolite" do
  cwd "/opt/docker/gitolite"
  user "root"
  group "root"
  code <<-EOH
    ./build.sh
    ./run.sh
    ./install.sh upstart
    EOH
end
