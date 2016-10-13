'''Script name : get_article.py
Author         : Mohammed Aizaaz Ali
Created        : April 12, 2016
Last Modified  : April 27,2016
Version        : 1.0
Description    : scrape news articles from links stored in a file'''

import time
import requests
import io
from newspaper import fulltext
from user_agent import generate_user_agent

def getarticle(readfile):
    ''' get the article and save it in a different file '''
    try:
        fileopen = open(readfile)
    except IOError:
        print "file " + readfile + " not in the location specified"
        return

    i = 1
    for line in fileopen:
        try:
        	ua = generate_user_agent()
        	head = ua.encode('ascii', 'ignore')
        	headers = {'useragent':head}

        	print "reading article :"
        	print line
        	html = requests.get(line, headers = headers).text
        	tex = fulltext(html)
        	writefile = "201604"+str(j)+"_"+str(i)+".txt"
        	with io.open(writefile, encoding='utf-8', mode='w+') as ns:
        		strng = ' '.join(tex.split())
        		ns.write(strng)
        		ns.close()
        	i = i + 1       	
       	except:
       	    pass

j = 1
while j < 22:
    filename = "links"+str(j)+".txt"
    print "extracting data for "+filename
    getarticle(filename)
    j = j + 1

print "successsfull"
