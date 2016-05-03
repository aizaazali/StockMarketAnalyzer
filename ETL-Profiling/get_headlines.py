'''Script name : get_headlines.py
Author         : Abhishek kadian, Mohammed Aizaaz Ali, Liuming Zhang
Created        : April 8, 2016
Last Modified  : April 27,2016
Version        : 1.0
Description    : download news headlines from yahoo finance!
The headlines|links are used to scrape news articles'''

import requests
import io
import time
import random
from bs4 import BeautifulSoup
from user_agent import generate_user_agent


companyName = raw_input("enter the Stock name : ")
firstlink = ""
prevdatelink = "two"

def getheadline(companyName, day, firstlink, prevdatelink):
    '''
    scrap headlines from finance.yahoo.com
    '''
    #date = '2016-02-'+str(day)
    searchUrl = 'http://finance.yahoo.com/q/h?s='+companyName+'&t=2016-04-'+str(day)
    #use fake useragent
    #ua = generate_user_agent()
    
    head = generate_user_agent().encode('ascii', 'ignore')
    headers = {'useragent':head}
    response = requests.get(searchUrl, headers=headers)
    
    soup = BeautifulSoup(response.content, 'html.parser')
    links = soup.select('div.yfi_quote_headline ul > li > a')
    #write the search results in file, a new file for each day
    filename = 'links'+str(day)+'.txt'

    with io.open(filename, encoding='utf-8', mode='w+') as ns:
        count = 1
        for link in links:
            nextlinks = link.get('href')+'\n'
            if count == 1:
                ns.write(nextlinks)
                firstlink = nextlinks
            elif prevdatelink == nextlinks:
                print "All uniques headlines scraped"
                break
            else:
                ns.write(nextlinks)
            count += 1
        ns.close()
    return firstlink

#run the loop for 29 days: Month of Feburary
day = 1
while day < 31:
    prevlink = getheadline(companyName, day, firstlink, prevdatelink)
    wait = random.randint(10, 15)

    print "completed for day"+str(day)+ " waiting for "+ str(wait) + " seconds"
    time.sleep(wait)
    prevdatelink = prevlink
    day = day+1

print "Successful. All headlines have been saved to disk"
