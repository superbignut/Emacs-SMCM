![Static Badge](https://img.shields.io/badge/Ubuntu-True-blue)
![Static Badge](https://img.shields.io/badge/Windows-Testing-red)
![Static Badge](https://img.shields.io/badge/Language-Emacs_Lisp-purple)
![Static Badge](https://img.shields.io/badge/For-Novice-brown)
---
## 前言：
+ ### 1. 简介：
    这是一个面向新手 ~~我自己~~ 的渐进式的 Emacs配置文件，并对每一行配置进行必要甚至冗余的解释。

    ~~This is an Emacs configuration file writen line by line，with annotations provided wherever possible.~~
+ ### 2. 建议：
    Emacs具有极其舒适的学习曲线，因此我建议 ~~我自己~~ 好好学习 Emacs，配置出只属于自己的Editor。
+ ### 3. 参考：
    1. Emacs欢迎界面上的Emacs tutorial。包含了Emacs的最基本按键和功能，入门第一看。
    2. B站/知乎上的[《Emacs高手修炼手册》][1]一步一步配置出Emacs的基本功能，入门必备。
    3. NykMa的个人网站上的[《Emacs 自力求生指南》][2]有他对的Emacs配置的详细说明，入门必备。
    4. B站上子龙山人的[《21天学会Emacs》][3]，入门必备。
    5. Github的Awesome系列[awesome-elisp][5]，其中的[Emacs In A Box - Elisp Programming][6]，入门必备。
    6. 没事的时候要去逛一逛的[Emacs-China][4]，没记错的话也是子龙山人创建的。
    7. 最官方的Emacs手册[GNU Emacs manual][7]，但是内容实在太多了。
    8. 最官方的Elisp参考手册[Emacs Lisp Reference Manual][8]，内容也是特别多。
    9. Emacs官网的不那么硬核的[An Introduction to Programming in Emacs Lisp][9]，前几章入门必备。


## 内容：
#### 以下内容为Ubuntu22.04中Emacs27的配置信息和个人理解，不保证他们的正确性和普适性，请选择食用。

        (tool-bar-mode -1)
        (scroll-bar-mode -1)
关闭工具栏、关闭屏幕右侧滚动条，我觉得工具栏(menu-bar)不仅好看而且有用，所以没关。
        
        (show-paren-mode t)
由于Elsp中括号很多，开启这个会将光标处的"("和")"同时高亮。

        (global-display-line-numbers-mode 1)
开启后，为所有窗口显示行号，但似乎还有其他的开启方法，开启的位置也有区别。

        (put 'narrow-to-region 'disabled nil)
使用"C-x n n"后自动生成，与narrow功能相关，新手可忽略。

        (add-to-list 'load-path
                (expand-file-name (concat user-emacs-directory "lisp")))
连续调用三个函数，完成字符串的连接、把~拓展为家目录和把字符串添加到load-path，这么做是为了让配置文件更有结构和条理性，但需要结合require和provide函数使用，分三步：
1. 把写好的abc.el文件放在.emacs.d/lisp/目录下 ~~(当然你的文件的名字可以不是abc)~~
2. 在abc.el文件中加上,(应该是任意位置都可以):
        
        provide('abc)

3. 在init.el中加上:
        
        require('abc)
如果对你也对load，require，package-install感到迷惑，那么请去GNU Emacs manual的第28.8节[Libraries of Lisp Code for Emacs][10]中寻找答案。尤其是最后一段：

    Note that installing a package using package-install (see Package Installation) takes care of placing the package’s Lisp files in a directory where Emacs will find it, and also writes the necessary initialization code into your init files, making the above manual customizations unnecessary.
大致含义就是，对于那些  通过使用package-install安装的包，再对他们require就是unnecessary的了。


[1]:https://zhuanlan.zhihu.com/p/341512250
[2]:https://nyk.ma/posts/emacs-write-your-own/
[3]:https://space.bilibili.com/292659700?spm_id_from=333.337.search-card.all.click
[4]:https://emacs-china.org/
[5]:https://github.com/p3r7/awesome-elisp
[6]:https://caiorss.github.io/Emacs-Elisp-Programming/Elisp_Programming.html#sec-1-1
[7]:https://www.gnu.org/software/emacs/manual/html_node/emacs/index.html
[8]:https://www.gnu.org/software/emacs/manual/html_node/elisp/index.html
[9]:https://www.gnu.org/software/emacs/manual/html_node/eintr/index.html
[10]:https://www.gnu.org/software/emacs/manual/html_node/emacs/Lisp-Libraries.html