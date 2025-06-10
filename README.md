<h1 id="top" align="center">Github <br/> Repository Backup</h1>

<br>

<div align="center">
    <img width=150 src="assets/favicon.png">
</div>

## 🔍 Table of Contents

- [About Project](#intro)
- [Technologies](#technologies)
- [Demo](#demo)
- [Features](#features)
- [Releases](#releases)
- [Prerequisites](#prerequisites)
- [System Startup](#system-startup)
- [Contributors](#contributors)

<br/>

<h2 id="intro">📌 About Project</h2>

This project enables automated bare backups of both your personal and organizational GitHub repositories public and private ensuring the safety and reliability of all your code assets. It includes Docker support for platform independence, allowing you to run backups across different environments. Additionally, it provides a bash script option to perform backups without Docker for users who prefer or require a native setup.

<br/>

<h2 id="technologies">☄️ Technologies</h2>

&nbsp; [![Git](https://img.shields.io/badge/GIT-E44C30?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/)

&nbsp; [![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ahmettoguz)

&nbsp; [![Bash](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)

&nbsp; [![.Env](https://img.shields.io/badge/.ENV-ECD53F.svg?style=for-the-badge&logo=dotenv&logoColor=black)](https://www.ibm.com/docs/bg/aix/7.2?topic=files-env-file)

&nbsp; [![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)

<br/>

<h2 id="demo">🎥 Demo</h2>

<div>
    <img width=1000 src="assets/demo.png">
</div>

<br/>

<h2 id="features">🔥 Features</h2>

- **Private repositories:** Back up both private and public repositories.
- **User and organization support:** Backup repositories from your own account as well as from other users or organizations.
- **Ignore list support:** Exclude specific repositories from the backup process by listing them in an ignore list.
- **.env configuration:** All environment variables including tokens are easily configurable using the `.env` file, simplifying configuration management.
- **Docker Compose Deployment:** Simplifies deployment with Docker Compose configuration, enabling easy setup and service orchestration without complex commands.
- **Docker Containerization:** The application is containerized using Docker to ensure consistent deployment, scalability, and isolation across different environments.
- **Persistent Data:** Binds the data directory from the host machine to the container, ensuring persistent data storage even with container restarts.

<br/>

<h2 id="releases">🚢 Releases</h2>

&nbsp; [![.](https://img.shields.io/badge/docker.v1.0.0-233838?style=flat&label=version&labelColor=111727&color=1181A1)](https://github.com/ahmettoguz/github-backup/tree/docker.v1.0.0)

&nbsp; [![.](https://img.shields.io/badge/linux.v1.0.0-233838?style=flat&label=version&labelColor=111727&color=1181A1)](https://github.com/ahmettoguz/github-backup/tree/linux.v1.0.0)

<br/>

<h2 id="prerequisites">🔒 Prerequisites</h2>

- Github access token. (Obtainable from https://github.com/settings/tokens)

<br/>

<h2 id="system-startup">🚀 System Startup</h2>

- Create `.env` file based on the `.env.example` file with credentails.

```
cp .env.example .env
```

<br/>

### Docker

```
docker stop          github-backup-c
docker rm            github-backup-c
docker compose up -d github-backup
docker logs -f       github-backup-c
```

<br/>

### Bash Script

- Change tag to linux release.

```
git checkout linux.v1.0.0
```

- Run backup bash script file.

```
bash run.sh
```

<br/>

### Restore Repository

- After getting bare clone, to be able to restore repository, run following command.

```
git clone <your-repository-name> ~/Desktop/<your-repository-name>
```

- Associate local repository with remote repository

```
git remote set-url origin https://github.com/<your-user-name>/<your-repository-name>
```

- Check remote url

```
git remote -v
```

<br/>

<h2 id="contributors">👥 Contributors</h2>

<a href="https://github.com/ahmettoguz" target="_blank"><img width=60 height=60 src="https://avatars.githubusercontent.com/u/101711642?v=4"></a>

### [🔝](#top)
