# Install MongoDB

MongoDB is an open-source, document-oriented database designed for ease of development and scaling.  The MongoDB documentation site includes a [tutorial on how to Install MongoDB Community Edition on Ubuntu](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/).

## Goal

Use Chef to successfully install MongoDB on Ubuntu

## Success Criteria Demonstrated

The following is accomplished in this exercise:

* Chef cookbook successfully executes on an Ubuntu node without errors
* Chef cookbook is portable and can be run by Chef to validate your work. Instructions or assumptions needed to successfully execute your cookbook, are included below
* Successful login to MongoDB by typing `mongo` on the target system
* Successful ability to run `chef-client` multiple times without failures
* Your GitHub.com source code repository shows the history of your work

The following is explained:

* Steps taken to achieve the end result
* Build and test process of Chef code
* Tools and resources used in the process

>Note: Chef Server was NOT used for this exercise

## Instructions

* MongoDB installation instructions, `using Chef code`, are contained in `install.rb` to complete the installation
* Chef [Resources Reference](https://docs.chef.io/resources.html) was used to find the most appropriate Chef resources for each task

## Approach

* Develop directly on Ubuntu machine
  * Recipes developed using text editor, uploaded to Ubuntu machine, `chef-client` executed in `--local-mode`
  * ChefDK installed on the Ubuntu machine

## Resources Used

* [Chef Documentation](http://docs.chef.io) was used to identify and use resources to model the desired state of the infrastructure
* [MongoDB Community Edition on Ubuntu Installation Instructions](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)


## Execution Instructions

* Install ChefDK on Ubuntu

* Create cookbook directory in chef repository
  * `mkdir -p /home/walt/chef_repo/cookbooks`

* Create cookbook - chef_workshop
  * `chef generate cookbook cookbooks/chef_workshop`

* Run cookbook - install.rb
  * `sudo chef-client --local-mode --runlist 'recipe[chef_workshop::install]'`

* Confirm mongo db is up
  * `sudo service mongod status`
  * `cat /var/log/mongodb/mongod.log`
  * `grep connections /var/log/mongodb/mongod.log`

* Login to mongodb and list databases
  * `mongo`
  * `show dbs`

