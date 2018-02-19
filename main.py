#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import logging

from issue import Issue
from issues import Issues
from config import Config

from repo_mapping import mapping_repo
from remote_syncing import remote_sync


def main():
    """
    Main entry of this project.
    Basically just to connect 3 parts in a row as a workflow: Fetching -> mapping -> uploading
    """

    #import pdb;pdb.set_trace()

    # @@ load local config file
    cfg = Config()

    # define global logger throughout all sub module files
    log = define_logger('gitissues', cfg.log)
    log.info('Start fetching issues from Github...')

    issues = Issues(cfg)
    if os.path.exists(cfg.issues_path) is False:
        os.system('rm -rf %s' % cfg.repo_dir)
        issues.first_run()
    else:
        tasks = issues.update()
        if tasks > 0:
            mapping_repo(cfg)
            remote_sync(cfg)

    log.info('Finished fetching issues from Github.\n')


def define_logger(name, path):
    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)

    # create the logging file handler
    fh = logging.FileHandler(path)

    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    fh.setFormatter(formatter)

    # add handler to logger object
    logger.addHandler(fh)

    return logger


if __name__ == "__main__":

    main()

