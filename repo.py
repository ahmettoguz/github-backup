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
    for repo in repositories:
        repo_name = repo['name']
        repo_url = repo.get('clone_url')
        is_private = repo.get('private', False)
        clone_directory = './private' if is_private else './public'
        repo_path = os.path.join(mainFolderPath, clone_directory, repo_name)

        # Check if the repository directory exists
        if os.path.exists(repo_path):
            # Repository directory exists, perform git pull for all branches
            os.chdir(repo_path)
            os.system('git fetch --all && git pull --all')
            print(f"Updated: {repo_name} in {clone_directory}")
        else:
            # Repository directory does not exist, clone the repository
            os.system(f'git clone --recursive {repo_url} {repo_path}')
            print(f"Cloned: {repo_name} into {clone_directory}")

def createFoldersIfNotExist(mainFolderPath):
    if not os.path.exists(mainFolderPath):
        os.makedirs(mainFolderPath)
        subdirectories = ['summary', 'private', 'public']
        [os.makedirs(os.path.join(mainFolderPath, subdir), exist_ok=True) for subdir in subdirectories]

def countRepositories(repositories):
    total_count = len(repositories)
    public_count = sum(1 for repo in repositories if not repo['private'])
    private_count = total_count - public_count
    return total_count, public_count, private_count

def writeSumFile(mainFolderPath, summaryOutput):
    with open(mainFolderPath + '/summary/summary.txt', 'w') as file:
        file.write(summaryOutput)

def main():
    mainFolderPath = './repositoryBackup'

    # get repositories
    repositories = getRepositories()

    # count types of the repositories
    total_count, public_count, private_count = countRepositories(repositories)
    
    # check repository count
    if(total_count == 0):
        print("Total repository count is 0. Please check token.")        
        exit(0)

    # display summary output and get approval
    currentDate = datetime.now().strftime("%d/%m/%Y")
    summaryOutput = f"Date       : {currentDate.replace('_', '/')}\n" \
                  f"Total Repo : {total_count}\n" \
                  f"Public     : {public_count}\n" \
                  f"Private    : {private_count}"    
    print(summaryOutput)
    user_input = input("Do you want to backup github repositories? (y/n): ").lower()
    if user_input != "y":
        exit()

    # create folders
    createFoldersIfNotExist(mainFolderPath)

    # write summary file
    writeSumFile(mainFolderPath, summaryOutput)

    # clone and update repos
    saveRepositories(repositories, mainFolderPath)

main()
