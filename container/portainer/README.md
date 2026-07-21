TO INSTALL YIC IN A DOCKER CONTAINER USING PORTAINER

Make sure there is a postgresql database that yic can connect to.
Create a TAR-ball of entrypoint.sh and the dockerfile.
In Portainer, create a new image called yic:latest and use TAR-ball as basis.
Issue not solved: git clone failes to get all files!

Upon creation, create a Stack using docker-compose and the .env file. 
Before you do, make sure that the values in the env file reflect your situation.

If git clone comes up short, perform git clone at the host volume.
Restart the stack. Go to localhost at the port indicated in the .env file.