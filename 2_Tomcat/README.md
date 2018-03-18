# Install and Configure Apache Tomcat

[Apache Tomcat](http://tomcat.apache.org/) is an open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies. The Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket specifications are developed under the Java Community Process

## Goal

Use Chef to successfully install Apache Tomcat on [Ubuntu](https://www.ubuntu.com/download/desktop)

## Success Criteria Demonstrated

The following is accomplished in this exercise:

* Chef cookbook successfully executes on an Ubuntu node without errors
* Chef cookbook is portable and can be run by Chef to validate work. Instructions or assumptions needed to successfully execute your cookbook, are included below
* Successful interaction with the default tomcat site in a browser or executing `curl localhost` on the target system
* Successful ability to run `chef-client` multiple times without failures
* GitHub.com source code repository shows the history of work

The following is explained:

* Steps taken to achieve the end result
* Build and test process of Chef code
* Tools and resources used in the process

>Note: Chef Server was NOT used for this exercise

## Instructions

* tomcat installation instructions, `using Chef code`, are contained in `install_tomcat.rb` to complete the installation
* Chef [Resources Reference](https://docs.chef.io/resources.html) were used to find the most appropriate Chef resources for each task

## Approach

* Develop directly on Ubuntu machine
  * Recipes developed using text editor, uploaded to Ubuntu machine, `chef-client` executed in `--local-mode`
  * ChefDK installed on the Ubuntu machine

## Resources Used

* [Chef Documentation](http://docs.chef.io) was used to identify and use resources to model the desired state of the infrastructure
* [tomcat Installation Instructions](https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-8-on-ubuntu-16-04)


## Execution Instructions

* Install ChefDK on Ubuntu

* Create cookbook directory in chef repository
  * `mkdir -p ~/chef_repo/cookbooks`

* Create cookbook - chef_workshop
  * `chef generate cookbook cookbooks/chef_workshop`

* Run cookbook - install_tomcat.rb
  * `sudo chef-client --local-mode --runlist 'recipe[chef_workshop::install_tomcat]'`

* Login to tomcat
  * `curl http://your_ubuntu_tomcat_hostname_here:8080`

