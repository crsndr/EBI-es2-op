# EBI-es2-op

## Description
### Before starting

A machine with Docker preinstalled and running is required for the rest of the configuration and to run the Docker containers.

### Obtaining all the files

The solution presented is based on Ganglia. At the end of the setup we'll have two container:
* one running gmetad, a web service with ganglia-web configured, and gmond. This container will collect the data from both container that we will install
* one running gmond only. This container is the one that should run the development software too. As a reference if it needed to reproduce this in a different container or in a VM it's enough to install gmond and start it at boot time using the gmond.conf provided (no need for any additional setup in this exercise)

PLEASE NOTE: To successfully complete the instruction port 80 and 8659 should be available.

To reproduce the setup you need to clone [https://github.com/crsndr/EBI-es2-op.git](https://github.com/crsndr/EBI-es2-op.git) repository:

```
git clone https://github.com/crsndr/EBI-es2-op.git
```


## Create the gmetad instance and start a container

After cloning the repository change directory to gmetad

```
cd EBI-es2-op/gmetad
```

build the new image

```
docker build -t gmetad26:1.0 .
```

and run a container based on this newly created image:

```
docker run --name gmetad -idt -p 80:80 -p 8659:8659 gmetad26:1.0
```

This will start a container and bind port 80 of the host machine to port 80 for the Apache web interface of the container and port 8659 to port 8659 of gmond.


## Create the gmond instance and start a container

After the creation of the gmetad container we'll repeat in a similar way for gmond. From the initial clone directory:

```
cd ../gmond
```

build the new image:

```
docker build -t gmond26:1.0 .
```

and run a container based on this newly created image:

```
docker run --name gmond -idt gmond26:1.0
```

## Checking the configuration

From the host machine it should enough to open a browser to:


```
http://localhost/ganglia
```

you should see an interface similar to the following:

![Alt text](/doc/ganglia.png?raw=true "Ganglia screenshot")

which after a couple of minutes should display the graphs that contains all the detail on CPU, memory and disk requested. To see the details click on the scroll down menu "Select a source" and choose "EBI-es2-op". On the next page click the new scroll down menu "Choose a node". The container being monitored should appear with its IP while the container running gmetad should show it's container ID. When the container IP is selected a page with all the grphs related to that VM is shown. The graph can be selected to se more detail, it's possible to select a specific timespan, etc

## Final consideration

Ganglia affers, out of the box, monitoring for many metrics related to CPU, disk, network, etc. In this specific case for a DB might be useful to monitor disk IO, CPU, etc while for web servers, file transfer, etc other than disk IO might be of interest the network activity as well. All the test for the previous cases are available on Ganglia. In the case of a software that might open many ports it might be of interest to monitor the number of ports and maybe the number of open files. For this a custum monitor could be added as Gangla support the implementation of external monitor defined by the user.
To implement the solution proposed it's enough to run the gmetad docker image as described in the previous steps and, in the development machine/container, install gmond with the configuration gmond.conf provided (in practice replicate the configuration of the gmond container provided) and ensure that gmond is started.

## Optional: Cleanup

Once everything is tested we can stop the containers:

```
docker container stop gmond gmetad
```

and remove them:

```
docker container rm gmond gmetad
```

and delete all three images that should be now present in the machine:

```
docker image rm gmetad26:1.0 gmond26:1.0 docker.io/fedora:26
```
