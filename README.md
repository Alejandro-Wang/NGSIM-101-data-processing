# NGSIM-101-data-processing
通过NGSIM官网https://www.fhwa.dot.gov/publications/research/operations/07030/index.cfm，获取NGSIM-101数据集相关说明。
完整数据从美国交通部公共数据中心处下载：https://data.transportation.gov/Automobiles/Next-Generation-Simulation-NGSIM-Vehicle-Trajector/8ect-6jqj

对数据导入matlab进行一些初步预处理，然后进行流量、空间占有率、时间占有率、密度、时间平均速度、空间平均速度的计算，并改变相关测量参数对比结果。
![lane1_time30](https://user-images.githubusercontent.com/82030590/168518191-418d30ea-1f47-45d4-9765-a22dd03a1ecf.png)

提取各分车道的轨迹数据，可以做出车辆轨迹位移-时间图。
![lane1](https://user-images.githubusercontent.com/82030590/168518098-f22933b5-b125-431e-a99c-39e02fdcb926.png)
并且可以得到有效跟驰车辆绘制跟驰图像来研究跟驰行为过程。
![跟车对](https://user-images.githubusercontent.com/82030590/168518131-a971b9e0-db28-484c-bd67-b382ddcc849a.png)
![跟车对速度-车间距](https://user-images.githubusercontent.com/82030590/168518136-56e55271-f366-477c-b761-f5c75cc4f14b.png)

编程参考使用了如下链接：
获得跟驰车对：https://github.com/arryyao/NGSIM-trajectories
演示车辆行驶的可视化，生成GIF：https://github.com/arryyao/NGSIM-trajectory-animation
