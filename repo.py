import os
import requests
from datetime import datetime


from credentials import  TOKEN


def get_repositories():
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

def clone_repositories(repositories):
    for repo in repositories:
        repo_name = repo['name']
        repo_url = repo.get('clone_url')
        is_private = repo.get('private', False)
        clone_directory = './private' if is_private else './public'
        os.makedirs(clone_directory, exist_ok=True)
        os.system(f'git clone {repo_url} {os.path.join(clone_directory, repo_name)}')
        print(f"Cloned: {repo_name} into {clone_directory}")
        
def main():
    repositories = get_repositories()

    total_count = len(repositories)
    public_count = sum(1 for repo in repositories if not repo['private'])
    private_count = total_count - public_count

    # check repository count
    if(total_count == 0):
        print("Total repository count is 0. Please check token.")        
        exit(0)

    print(f"Total Repo : {total_count}")
    print(f"Public     : {public_count}")
    print(f"Private    : {private_count}")

    # get approval
    user_input = input("Devam etmek istiyor musunuz? (y/n): ").lower()
    if user_input != "y":
        exit()

    current_date = datetime.now().strftime("%d_%m_%Y")
    summaryOutput = f"Date       : {current_date}\n" \
                  f"Total Repo : {total_count}\n" \
                  f"Public     : {public_count}\n" \
                  f"Private    : {private_count}"



    mainFolderPath = './repositoryBackup' 

    if os.path.exists(mainFolderPath):
        mainFolderPath = mainFolderPath + '_' + current_date
                                      
    os.makedirs(mainFolderPath)

    with open(mainFolderPath + '/summary/summary.txt', 'w') as file:
        file.write(summaryOutput)
        
    # clone_repositories(repositories)

main()
