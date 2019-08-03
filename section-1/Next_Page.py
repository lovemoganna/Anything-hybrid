from config import *
import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys  # 引入selenium中的键盘

browser = webdriver.Chrome(WEB_DRIVE_PATH)

# 下面开始模拟键盘操作
browser.get("https://www.soku.com")


def find_one_element_by_xpath(xpath_express, action=None):
    if not action == None:
        browser.find_element_by_xpath(xpath_express).send_keys(action)


find_one_element_by_xpath('//*[@id="headq"]', "aaaaa")
find_one_element_by_xpath('/html/body/div[1]/div/div[2]/div[2]/div/div/div/form/button', Keys.ENTER)
href = browser.find_element_by_xpath('//*[@id="bpmodule-main"]/div[3]/ul')
print(href.get_attribute("innerHTML"))

"""
- 判断 "下一页是否存在“在于 下一页的 href
- 如果存在，就使用一个单击事件，进入下一页
- 如果不存在的话，就显示一下，这页啥东西也没有就行了。
"""

