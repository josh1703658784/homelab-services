
# Input Source
 
See `input.example` for examples.

This input source is created by executing the following:

```
docker rm -f <CONTAINER_NAME>
docker-compose up -d <CONTAINER_NAME>
docker exec -it <CONTAINER_NAME> bash -c 'curl https://am.i.mullvad.net/connected'
```


# Generating Output

execute "script.sh"


# Preparing output for quick copy/paste of server documentation to a web form

`interactive_copy_paste.sh`



................
