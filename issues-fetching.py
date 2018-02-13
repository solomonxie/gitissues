#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os           # for folder detecting
import json
import shutil       # for zipping files
import requests     # for retrieving web resources
import time
from datetime import date


def main():
    
    fetch_issues()


def fetch_issues():
    """
    FETCH one repo's issues, @2 archive to a local folder
    IF there's no change from internet, then abord fetching and writing to local files
    """

    # @@ load local config file
    with open('config.json', 'r') as f:
        config = json.loads(f.read())

    # @@ loading settings from customized configs (json)
    user         = config['fetch']['user']
    repo         = config['fetch']['repo']
    issues_url   = config['fetch']['issues_url']
    root         = config['local']['root_dir']
    repo_dir     = '%s/%s/%s'%(root,user,repo)
    today        = str(date.today())


    # @@ retrieving data from internet, @ with response validation
    r = requests.get(issues_url,timeout=10)
    if r.status_code is not 200:
        print 'Failed on fetching [%s] due to unexpected response'%issues_url
        return False

    # @@ check if there's change from internet, abord mission if there's no change.
    updates = []
    deletions = []
    if os.path.exists(repo_dir+'/log/issues.json') is True:


        with open(repo_dir+'/log/issues.json', 'r') as f:
            # @@ compare two json files with updated time. (can't directly compare two json files)
            #old = set([d['updated_at'] for d in json.loads(f.read())])
            #new = set([d['updated_at'] for d in r.json()])
            old = [{iss['number']:iss['updated_at']} for iss in json.loads(f.read())]
            new = [{iss['number']:iss['updated_at']} for iss in r.json()]

        for iss in r.json():
            if 

        #ups  = new - old       # udpates and adds
        #dels = old - new       # deletions

        # quit, if no changes at all
        #if len(ups) is 0 and len(dels) is 0: return    

        # filter out updates and deletions
        #updates = [iss for iss in r.json() if iss['updated_at'] in ups]

    else:
        # @@ log issues as original json file, for future restoration or further use
        os.makedirs(repo_dir+'/log')
        with open(repo_dir+'/log/issues.json', 'w') as f:
            f.write(r.content)

        updates = r.json()

    import pdb; pdb.set_trace() # debugging mode
    
    # @@ iterate each issue for further fetching
    for issue in updates:
        title = issue['title']
        info  = issue['body']
        index = issue['number']
        comments_url = issue['comments_url']
        counts = issues['comments']

        # @ pause for awhile before fetch to reduce risk of being banned from server
        time.sleep(1)     # sleep 60sec

        # @@ fetch comments, @ with response validation 
        _r = requests.get(comments_url,timeout=10)
        if _r.status_code is not 200:
            print 'Failed on fetching [%s] due to enexpected response'%comments_url
            return False              # if failed one comment, then restart whole process on this issue

        # @ log comments as original json file, for future restoration or further use
        with open(repo_dir+'/log/issue-%d.json'%index, 'w') as f:
            f.write(_r.content)

        print '%d comments for issue-%d[%s] fetched.'%(len(_r.json())+1,index, title)

    print 'all %d issues for %s fetched.'%(counts,repo)



if __name__ == "__main__":
    main()
