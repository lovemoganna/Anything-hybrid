# 智能等待,隐式地等待一个元素被发现或者完成,
from config import *
import time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
browser = webdriver.Chrome(WEB_DRIVE_PATH)


def BeginAutoWork(url, key):
    # 开始目标操纵
    browser.get(url)

    # 测试专用
    browser.find_element_by_xpath(INPUT_XPATH_EXPRESS).send_keys(key)
    browser.find_element_by_xpath(BUTTON_XPATH_EXPRESS).click()

    inputObject = browser.find_element_by_xpath(INPUT_XPATH_EXPRESS)
    ButtonObject = browser.find_element_by_xpath(ANOTHER_XPATH_EXPRESS)

    # 清除内容
    inputObject.clear()
    # 模拟键盘输入
    inputObject.send_keys(YOU_SEARCH_WORD)
    # 模拟鼠标点击
    ButtonObject.submit()

    # 执行翻页
    next_page()

    time.sleep(2)

    # browser.quit()


def singlePageParse():
    parent_css_selector = "#bpmodule-main > div.sk-result-list"
    children_css_selector = "div.mod-main > div.mod-header > h2 > a"

    allContent = browser.find_elements_by_css_selector(parent_css_selector)
    for content in allContent:
        href = content.find_elements_by_css_selector(children_css_selector)

        if (href):
            for onehref in href:
                linkResult = onehref.get_attribute("href")
                f = open("result.txt","a")
                f.write(linkResult)
                f.write("\n")
        else:
            print("这个词被禁止搜索了。")

# 进行翻页操作
def next_page():
    # 判断下一页是否存在
    href = browser.find_element_by_css_selector('#bpmodule-main > div.page-nav > ul > li.next > a').get_attribute(
        "href")

    while (href != None):
        browser.find_element_by_css_selector('#bpmodule-main > div.page-nav > ul > li.next > a').send_keys(Keys.ENTER)
        print("翻页成功,并执行页面链接清洗工作！")
        singlePageParse()
        time.sleep(1)


if __name__ == "__main__":
    BeginAutoWork(BASEURL, BEGIN_SEARCH_WORD)
