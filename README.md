1. `docker build -t my-app .`  

---
  
2. `docker run -d -p 8888:80 -v "$PWD/src":/var/www/html my-app` 

---  

3. http://localhost:8888