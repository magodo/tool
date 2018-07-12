#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#########################################################################
# Author: Zhaoting Weng
# Created Time: Fri 06 Jan 2017 12:12:16 AM CST
# Description:
#########################################################################

import os
from datetime import datetime
import argparse

def new_blog(title, category, tag):
    timestamp = datetime.strftime(datetime.utcnow(), "%Y-%m-%d")
    tag = [t.lower() for t in tag]
    with open(timestamp+"-"+title+".md", 'w') as f:
        f.write('''---
layout: "post"
title: "{0}"
categories: "{1}"
tags: {2}
published: true
comments: true
script: [post.js]
excerpted: |
    A short description...
---

* TOC
{{:toc}}

'''.format(title, category, str(tag)))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("title", help='title')
    parser.add_argument("-t", help='tag', type=str, nargs='+', default=[])
    parser.add_argument("-c", help='category', default='blog')
    args = parser.parse_args()
    new_blog(args.title, args.c, args.t)

