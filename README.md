# 🚀 docker-intellij-vnc-ide

This Docker image provides a minimal Ubuntu-based XFCE desktop environment accessible via VNC, with **IntelliJ IDEA Ultimate** and **OpenJDK 24** pre-installed. Ideal for testing or developing IntelliJ/PhpStorm plugins in isolation.

---

## 🛠️ Preparation

1. Download IntelliJ Ultimate:
   [ideaIU-2025.1.1.1.tar.gz](https://download.jetbrains.com/idea/ideaIU-2025.1.1.1.tar.gz)
2. Extract and rename:

   ```bash
   tar -xzf ideaIU-2025.1.1.1.tar.gz
   mv idea-IU-* idea
   ```
3. Build the Docker image:

   ```bash
   docker-compose build
   ```

---

## ▶️ Starting the Container

```bash
docker-compose up
```

---

## 🔠️ Connect via VNC

1. Install a VNC client (e.g. [TigerVNC](https://tigervnc.org/), [RealVNC](https://www.realvnc.com/), etc.)
2. Connect to `localhost:5900`
3. Use the password: **`password`**

---

## 📌 Notes & Improvements

* Currently runs processes as `root`. For improved security and best practices:
  * Move execution under the non-root `dockeruser`.
  * Adjust VNC and IntelliJ launcher accordingly.
* SSH access is available on port `22` (password: `password`).

---
