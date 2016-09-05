# How  to build Arachni rpcd server in a docker container

The first thing you’d want to do is to install Docker. It’s an amazing tool to quickly spin-up fresh environments. It could be compared to the VM-like system, but it’s actually much more lightweight and faster. Well you can check out by yourself here (www.docker.com)

#### Now to the building process

You will need a Dockerfile, from which to build an image. I was using Ubuntu base. Also had a few trial-and-error moments finding out how to properly run it and have it binded to the IP address. Therefore my Docker file looks like the file here.

#### Now to what it actually does.

Basically the first block has environment variables for version. It’s for maintaining the file and easier editing with the current version. The following part is the actual system update and installing necessary dependencies. As you can see the workdir is also created. Later on we expose the default 7331 port, it is needed for the Arachni RPCD server.

The last two lines are actually tricky. As you can see I’ve commented out the execution of the actual Arachni instance and just left it as bash. In the latter stages we will just attach to the container and run the server with the needed IP.

So, we have our file, let’s build it (don’t forget the dot at the end!!)

`docker build -t arachni .`

If everything goes well, you should see that your image appeared under 

`docker images`

We can actually run it, but in a way to grab the IP address of the container

`docker inspect –format ’{{ .NetworkSettings.IPAddress }}’  $(docker run -it -d -p 7331:7331 arachni)`

Now we have the IP of our container. Great, now we know what the IP we’ll give to the rpcd server. Let’s attach to the container

`docker attach %container_name%`

In there we have our plain bash, so let’s navigate to the arachni folder: /opt/arachni/bin

Now we can launch the rpcd server:

`./arachni_rpcd –address the_IP_we_got_earlier:7331`

That’s it. It’s on, you should see that Arachni is listening to the port on your IP. Now comes the part where you detach from the container. You need to press TWO keyboard combinations one after other

`CTRL+p` `CTRL+q`

You’re running Arachni as rpcd. 

>Enjoy! 
