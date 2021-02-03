# Hub Mirror Action

English | [简体中文](./README.md)

Action for mirroring repos between Hubs (like Github and Gitee)

## Tutorial

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

## Usage

#### Required
- `src` source account, such as `github/kunpengcompute`, is the Github kunpengcompute account.
- `dst` Destination account, such as `/kunpengcompute`, is the Gitee kunpengcompute account.
- `dst_key` the private key to push code in destination account (default in ~/.ssh/id_rsa), you can see [generating SSH keys](https://docs.github.com/articles/generating-an-ssh-key/) to generate the pri/pub key, and make sure the pub key has been added in destination. You can set Github ssh key in [here](https://github.com/settings/keys)，set the Gitee ssh key in [here](https://gitee.com/profile/sshkeys). (Configure the private key `id_rsa` in github's secret and the public key `id_rsa.pub` in gitee's SSH)
- `dst_token` the API token to create non-existent repo, You can get Github token in [here](https://github.com/settings/tokens), and the Gitee in [here](https://gitee.com/profile/personal_access_tokens).

#### Optional
- `account_type` (optional) default is `user`, the account type of src and dst account, can be set to `org` or `user`，only support mirror between same account type (that is "org to org" or "user to user").
- `clone_style` (optional) default is `https`, can be set to `ssh` or `https`.
- `cache_path` (optional) let code clone in specific path, can be used with actions/cache to speed up mirror.
- `black_list` (optional) the black list, such as “repo1,repo2,repo3”.
- `white_list` (optional) the white list, such as “repo1,repo2,repo3”.
- `static_list` (optional) Only mirror repos in the static list, but don't get list from repo api dynamically (the white/black list is still available). like 'repo1,repo2,repo3'
- `force_update` (optional) Force to update the destination repo, use '-f' flag do 'git push'

## Reference
- [Hub mirror template](https://github.com/yi-Xu-0100/hub-mirror): A template repo to show how to use this action. from @yi-Xu-0100
- [Auto-Sync GitHub Repositories to Gitee](https://github.com/ShixiangWang/sync2gitee): An introduction about how to use this action. from @ShixiangWang
- [Use Github Action to sync reois to Gitee](http://shimmerjordan.github.io/2020/01/17/%E5%B7%A7%E7%94%A8Github-Action%E5%90%8C%E6%AD%A5%E4%BB%A3%E7%A0%81%E5%88%B0Gitee/): The blog for this action.
- [https://github.com/Yikun/hub-mirror-action](https://github.com/Yikun/hub-mirror-action)
