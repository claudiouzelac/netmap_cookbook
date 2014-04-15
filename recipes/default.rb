
git "#{node[:git][:checkout_directory]}" do
  repository "#{node[:git][:repo]}"
  reference "master"
  action :sync
  notifies :run, "bash[install_program]", :immediately
end

bash "install_program" do
  user "root"
  cwd "#{node[:git][:checkout_directory]}"
  code <<-EOH
    ./configure && make && make install
  EOH
  action :nothing
end
