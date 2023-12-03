import os
import requests
from datetime import datetime

from credentials import  TOKEN

def getRepositories():
    url = 'https://api.github.com/user/repos'
    headers = {'Authorization': f'Bearer {TOKEN}'}
    params = {'per_page': 100, 'visibility': 'all'}

    repositories = []
    page = 1

    while True:
        params['page'] = page
        response = requests.get(url, headers=headers, params=params)

        if response.status_code == 200:
            page_repos = response.json()
            if not page_repos:
                break
            repositories.extend(page_repos)
            page += 1
        else:
            print(f"Failed to retrieve repositories. Status code: {response.status_code}")
            break

    return repositories

def saveRepositories(repositories, mainFolderPath):
    originalPath = os.getcwd()

    for repo in repositories:
        repo_name = repo['name']
        repo_url = repo.get('clone_url')
        is_private = repo.get('private', False)
        clone_directory = '/private' if is_private else '/public'
        repo_path = mainFolderPath + clone_directory + '/'+ repo_name

        os.chdir(originalPath)
        print()

        # Repository directory exists, perform git pull if not clone
        if os.path.exists(repo_path):
            print(f"Pulling: {repo_name} in {clone_directory}")
            os.chdir(repo_path)
            os.system('git pull --all')
        else:
            print(f"Clonning: {repo_name} into {clone_directory}")
            os.system(f'git clone --recursive {repo_url} {repo_path}')
            
    os.chdir(originalPath)

def createFoldersIfNotExist(mainFolderPath):
    if not os.path.exists(mainFolderPath):
        os.makedirs(mainFolderPath)
        subdirectories = ['summary', 'private', 'public']
        [os.makedirs(os.path.join(mainFolderPath, subdir), exist_ok=True) for subdir in subdirectories]

def countRepositories(repositories):
    total_count = len(repositories)
    public_count = sum(1 for repo in repositories if not repo['private'])
    private_count = total_count - public_count
    return {'total_count': total_count, 'public_count': public_count, 'private_count': private_count}

def getFolderSize(folder_path):
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(folder_path):
        for filename in filenames:
            filepath = os.path.join(dirpath, filename)
            total_size += os.path.getsize(filepath)
    
    return format_size(total_size)

def format_size(size_in_bytes):
    units = ['B', 'KB', 'MB', 'GB', 'TB']
    
    size = size_in_bytes
    unit_index = 0
    
    while size >= 1024 and unit_index < len(units) - 1:
        size /= 1024.0
        unit_index += 1
    
    return f"{size:.2f} {units[unit_index]}"

def writeSumFile(mainFolderPath, repositoryCounts):
    currentDate = datetime.now().strftime("%d/%m/%Y")
    backupFolderSize = getFolderSize('./repositoryBackup')

    summaryOutput = f"Statistics of the repositories:\n\n" \
                f"Last Backup Date: {currentDate}\n" \
                f"Repository Backup Folder Size: {backupFolderSize}\n" \
                f"Total Repositories: {repositoryCounts['total_count']}\n" \
                f"Public Repositories: {repositoryCounts['public_count']}\n" \
                f"Private Repositories: {repositoryCounts['private_count']}"
    
    with open(mainFolderPath + '/summary/summary.txt', 'w') as file:
        file.write(summaryOutput)

def main():
    mainFolderPath = './repositoryBackup'

    # get repositories
    repositories = getRepositories()

    # count types of the repositories
    repositoryCounts = countRepositories(repositories)
    
    # check repository count
    if(repositoryCounts['total_count'] == 0):
        print("Total repository count is 0. Please check token.")        
        exit(0)

    # display summary output and get approval
    approvalOutput = f"\n---\nStatistics of the repositories:\n\n" \
                f"Total Repositories: {repositoryCounts['total_count']}\n" \
                f"Public Repositories: {repositoryCounts['public_count']}\n" \
                f"Private Repositories: {repositoryCounts['private_count']}"
    print(approvalOutput)
    user_input = input("Do you want to backup github repositories? (y/n): ").lower()
    if user_input != "y":
        exit()

    # create folders
    createFoldersIfNotExist(mainFolderPath)

    # clone and update repos
    saveRepositories(repositories, mainFolderPath)

    # write summary file
    writeSumFile(mainFolderPath, repositoryCounts)

    print("\n---")
    print("Backup process is done")
    print("Backup size is :" , getFolderSize('./repositoryBackup'))

main()
