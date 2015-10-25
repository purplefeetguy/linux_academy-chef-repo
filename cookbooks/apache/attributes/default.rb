# create attributes for each node to be used with the apache cookbook and its recipes
default["apache"]["sites"]["purplefeetguy4"] = { "site_title" => "Purplefeetguy4's Website coming soon!", "port" => 80, "domain" => "purplefeetguy4.mylabserver.com" }
default["apache"]["sites"]["purplefeetguy4b"] = { "site_title" => "Purplefeetguy4b's Website coming soon!", "port" => 80, "domain" => "purplefeetguy4b.mylabserver.com" }
default["apache"]["sites"]["purplefeetguy5"] = { "site_title" => "Purplefeetguy5's Website coming soon!", "port" => 80, "domain" => "purplefeetguy5.mylabserver.com" }
default["apache"]["sites"]["purplefeetguy5b"] = { "site_title" => "Purplefeetguy5b's Website coming soon!", "port" => 80, "domain" => "purplefeetguy5b.mylabserver.com" }
default["apache"]["sites"]["purplefeetguy6"] = { "site_title" => "Purplefeetguy6's Website coming soon!", "port" => 80, "domain" => "purplefeetguy6.mylabserver.com" }
default["apache"]["sites"]["purplefeetguy6b"] = { "site_title" => "Purplefeetguy6b's Website coming soon!", "port" => 80, "domain" => "purplefeetguy6b.mylabserver.com" }

default["author"]["name"] = "Purplefeetguy"

case node["platform"]
when "centos"
        default["apache"]["package"] = "httpd"
when "ubuntu"
        default["apache"]["package"] = "apache2"
end
