<h1 id="top" align="center">Github <br/> Repository Backup</h1>

<br>

<div align="center">
    <img width=200 src="assets/favicon.png">
</div>

## 🔍 Table of Contents

- [About Project](#intro)
- [Technologies](#technologies)
- [Demo](#demo)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [System Startup](#system-startup)
- [Contributors](#contributors)

<br/>

<h2 id="intro">📌 About Project</h2>

This project enables automated bare backups of both your personal and organizational GitHub repositories public and private ensuring the safety and reliability of all your code assets.

<br/>

<h2 id="technologies">☄️ Technologies</h2>

[![Git](https://img.shields.io/badge/GIT-E44C30?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/)

[![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ahmettoguz)

[![Bash](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)

[![.Env](https://img.shields.io/badge/.ENV-ECD53F.svg?style=for-the-badge&logo=dotenv&logoColor=black)](https://www.ibm.com/docs/bg/aix/7.2?topic=files-env-file)

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
- **.env configuration:** Easily manage tokens and settings through a `.env` file for clean and secure configuration.

<br/>

<h2 id="prerequisites">🔒 Prerequisites</h2>

- Github access token. (Obtainable from https://github.com/settings/tokens)

<br/>

<h2 id="system-startup">🚀 System Startup</h2>

- Create .env file based on the .env.example file with credentails.

```
cp .env.example .env
```

- Run backup bash script file.

```
bash run.sh
```

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
