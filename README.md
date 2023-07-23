# Hub Mirror Action

简体中文 | [English](./README_en.md)

一个用于在hub间（例如Github，Gitee）账户代码仓库同步的Action 

## 用法

```yaml
name: Gitee repos mirror periodic job

on:
  push:
    # branches:
      # - master
  # 手动事件
  workflow_dispatch:
  # 计划事件
  schedule:
    # 每天北京时间 9点 运行
    - cron:  '0 1 * * *'

# 任务
jobs:
  build:
    # 服务器环境：最新版 Ubuntu
    runs-on: ubuntu-latest
    steps:
      - name: Mirror the Github organization repos to Gitee.
        uses: shimmerjordan/hub-mirror@master
        with:
          # 必选，需要同步的 Github 用户（源）
          src: github/shimmerjordan
          # 必选，需要同步到的 Gitee 用户（目的）
          dst: gitee/shimmerjordan
          # 必选，Gitee公钥对应的私钥，https://gitee.com/profile/sshkeys
          # id_rsa.pub: 公钥，id_rsa: 私钥
          dst_key: ${{ secrets.GITEE_PRIVATE_KEY }}
          # 必选，Gitee对应的用于创建仓库的token，https://gitee.com/profile/personal_access_tokens
          dst_token:  ${{ secrets.GITEE_TOKEN }}
          # 如果是组织，指定组织即可，默认为用户user
          # account_type: org
          # 还有黑、白名单，静态名单机制，可以用于更新某些指定库
          # static_list: "vue-admin-antd"
          # black_list: "repo_name,repo_name2"
          # white_list: "repo_name,repo_name2"
          force_update: true
          # debug: true
          # clone_style: "ssh"
```


## 参数详解
#### 必选参数
- `src` 需要被同步的源端账户名，如github/shimmerjordan，表示Github的shimmerjordan账户。
- `dst` 需要同步到的目的端账户名，如gitee/shimmerjordan，表示Gitee的shimmerjordan账户。
- `dst_key` 用于在目的端上传代码的私钥(默认可以从~/.ssh/id_rsa获取），可参考[生成/添加SSH公钥](https://gitee.com/help/articles/4181)或[generating SSH keys](https://docs.github.com/articles/generating-an-ssh-key/)生成，并确认对应公钥已经被正确配置在目的端。对应公钥，Github可以在[这里](https://github.com/settings/keys)配置，Gitee可以[这里](https://gitee.com/profile/sshkeys)配置。（github的secret配置私钥`id_rsa`，gitee的SSH配置公钥`id_rsa.pub`）
- `dst_token` 创建仓库的API tokens， 用于自动创建不存在的仓库，Github可以在[这里](https://github.com/settings/tokens)找到，Gitee可以在[这里](https://gitee.com/profile/personal_access_tokens)找到。

#### 可选参数
- `account_type` 默认为user，源和目的的账户类型，可以设置为org（组织）或者user（用户），目前仅支持**同类型账户**（即组织到组织，或用户到用户）的同步。
- `clone_style` 默认为https，可以设置为ssh或者https。
- `cache_path` 默认为'', 将代码缓存在指定目录，用于与actions/cache配合以加速镜像过程。
- `black_list` 默认为'', 配置后，黑名单中的repos将不会被同步，如“repo1,repo2,repo3”。
- `white_list` 默认为'', 配置后，仅同步白名单中的repos，如“repo1,repo2,repo3”。
- `static_list` 默认为'', 配置后，仅同步静态列表，不会再动态获取需同步列表（黑白名单机制依旧生效），如“repo1,repo2,repo3”。
- `force_update` 默认为false, 配置后，启用git push -f强制同步，**注意：开启后，会强制覆盖目的端仓库**。
- `debug` 默认为false, 配置后，启用debug开关，会显示所有执行命令。

## 参考
- [Hub mirror template](https://github.com/yi-Xu-0100/hub-mirror): 一个用于展示如何使用这个action的模板仓库. from @yi-Xu-0100
- [自动镜像 GitHub 仓库到 Gitee](https://github.com/ShixiangWang/sync2gitee): 一个关于如何使用这个action的介绍. from @ShixiangWang
- [巧用Github Action同步代码到Gitee](http://shimmerjordan.github.io/2020/01/17/%E5%B7%A7%E7%94%A8Github%E5%90%8C%E6%AD%A5%E4%BB%A3%E7%A0%81%E5%88%B0Gitee/): Github Action第一篇软文
- [https://github.com/Yikun/hub-mirror-action](https://github.com/Yikun/hub-mirror-action)

