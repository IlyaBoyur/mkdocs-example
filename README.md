# MkDocs Documentation-as-code Template 

## local development
```bash
pipx install mkdocs
mkdocs build
mkdocs serve
```


## Local development: Docker

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

