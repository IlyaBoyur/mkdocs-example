# MkDocs Documentation-as-code Template 

## local development
```bash
pipx install mkdocs
cd frontend
mkdocs build
mkdocs serve --dev-addr localhost:8080
```
Go to `http://localhost:8080` to see results.


## Local development: docker compose

Create `.env` file with configurations in root project directory:
```.env
HTPASSWD_NODE=on
HTPASSWD=admin:{PLAIN}admin
```

Run docker compose 
```bash
docker compose build
docker compose up -d
```

Go to `http://localhost:8080` to see results.

With default environment variables you will see nginx Basic Auth pop-up.  
Enter login and password from `HTPASSWD` env variable.  
After that you will see docs Welcome page.


## Deployment: docker compose
There are two working deployment workflows configured:

- **deploy-docs.yml** - deploy static site content directly to GitHub Pages (no configuration required)

-  **docker-publish.yml** - deploy to a remote server. Following should be done for everething to work:
1. Create SSH key for GitHub actions to connect to remote host:
* go to remote server
* type `ssh-keygen` and hit Enter
* hit Enter several times
* add SSH public key to known hosts:  
```echo ~/.ssh/id_ed25519.pub >> ~/.ssh/known_hosts```
* place SSH private key (`~/.ssh/id_ed25519`) to GitHub secrets as SSH_PRIVATE_KEY

2. Github secrets should be configured: 
```.env
SSH_HOST=<host to configure via SSH>
SSH_USER=<ssh username>
SSH_PRIVATE_KEY=<ssh private key>
SSH_PORT=22

HTPASSWD=<set nginx Basic Auth login with password configuration if needed otherwise ignore>
HTPASSWD_NODE=on # set `off` to disable Basic Auth

SITE_HOST=<remote host full domain name or IP>
```


if you want SSL / TLS certs for HTTPS, do the following:

0. Set domain name for your site IP address

1. Go to remote host, enter nginx docker container with `docker exec`

2. I default directory, create certificate
```bash
acme.sh --issue --server letsencrypt -d [domain name] -w /var/www/local_static --config-home /app/acme.sh
```

3. Install certificate
```bash
acme.sh --install-cert -d [domain name] --config-home /acme.sh --key-file /etc/nginx/certs/key.pem --fullchain-file /etc/nginx/certs/cert.pem --reloadcmd "nginx -s reload"
```

4. Set GitHub actions secret
```.env
TLS_MODE=on
```
5. Run deployment once again, i.e. via dedicated `Run workflow` button in GitHub action

Enjoy your docs with HTTPS!


## Contributions

#### Public pull requests are highly recomended!  
#### If you face any problem with usage - feel free to file an issue. 

## Author

[Ilya Boyur](https://github.com/IlyaBoyur)