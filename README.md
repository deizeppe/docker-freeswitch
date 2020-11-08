<h1>docker-freeswitch<h1>

<h2>Based on Debian linux:</h2>

Debian Buster:



<b>Run</b>

    $ docker-compose up -d

<b>Runtime Management</b>
    $ docker container exec -it freeswitch bash

<b>Testing the Server</b>
  FreeSWITCH comes out of the box with a default password for registrations to users 1000-1019 as '1234'. 
  The default password should be changed by setting DEFAULT_PASSWORD with the container run.


