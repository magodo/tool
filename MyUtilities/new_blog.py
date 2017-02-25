#!/usr/bin/env python2
# -*- coding: utf-8 -*-

#########################################################################
# Author: Zhaoting Weng
# Created Time: Fri 06 Jan 2017 12:12:16 AM CST
# Description:
#########################################################################

import os
from datetime import datetime
import argparse

def new_blog(title, category):
    timestamp = datetime.strftime(datetime.utcnow(), "%Y-%m-%d")
    with open(timestamp+"-"+title+".md", 'w') as f:
        f.write('''---
layout: "post"
title: "%s"
categories:
- "%s"
---

<!--more-->

***
Table of Conetent

* TOC
{:toc}
***''' %(title, category))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-t", help='title', required=True)
    parser.add_argument("-c", help='category', required=True)
    args = parser.parse_args()
    new_blog(args.t, args.c)

