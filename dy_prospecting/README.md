# dy_prospecting / 探勘宝物
> 适配于 ESX 使用，勘探宝物的插件

## 预定功能
* 在预定区域内随机生成的宝藏
* 循环生成宝藏(随机坐标)
* 可多人同时使用探勘
* 物品进入您的背包
#
## 使用指南

插件加载成功后，地图上会标出一个新区域

1. 前往标记区域
2. 使用探测器物品('detector')
3. 边走边使用探测扫描仪
4. 找到并挖出宝藏(鼠标左键)

你必须找到一种方法来为玩家提供探测器，最简单的方法是将它添加到商店中。
#
## 插件依赖
* [Prospecting](https://github.com/glitchdetector/fivem-prospecting) (已包含文件内)
* [ESX](https://github.com/esx-framework/esx_core) (经测试，1.8.5版本适用，其他版本请自行测试)
* [ox_lib](https://github.com/overextended/ox_lib) (适用了ox_lib内的提醒UI，您也可以自行编辑)
#
## 安装指南

### 如您使用 Git
```
cd resources
git clone https://github.com/r3ps4J/r3_pawnshop
```

### 自行下载
- 下载此资源并将其放入您的资源文件夹中。
  
### 增加到 cfg 文件
- 复制下行添加到您的 `server.cfg`:

```
ensure dy_prospecting
```
### 自行导入 sql 文件到您的数据库内
#

## 感谢
插件部分代码调用了 [glitchdetectors example handler](https://github.com/glitchdetector) 的 [prospecting](https://github.com/glitchdetector/fivem-prospecting-example) 插件
